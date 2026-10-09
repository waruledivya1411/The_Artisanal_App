# The Artisanal Lens

A guided photography app for Indian handloom artisans, built in Flutter.

The Click & Social path (Lesson 01–05) teaches which product photos to take,
how to frame them, and how to post. Live capture checks light, distance and
placement on device — not a cloud vision API.

> Before you take the photo, The Artisanal Lens prepares the piece and shows
> you what a good photograph should look like.

Flutter app: [`artisanal_lens/`](artisanal_lens/). Package id:
`com.artisanallens.artisanal_lens`.

Repository: [github.com/waruledivya1411/The_Artisanal_App](https://github.com/waruledivya1411/The_Artisanal_App)

---

## Where it comes from

| Source | Supplies |
|---|---|
| Figma file *Artisans lens* | Colour, type, spacing, screen structure and copy. Nothing visual is invented. |
| BTP report — *Product Photography Guide for Handloom Artisans* (IIT Guwahati) | Eight photography guidelines, fabric-property mapping, five Saree photography templates, and findings from testing with artisans in the Kamrup cluster, Assam. |
| *Artisanal Lens* solution deck | Category-first flow and the fold / styling preset lists. |

Research shaped the product, not just the copy. Text instructions failed in
testing, so the UI is icon-led with one decision per screen. Artisans could not
judge lighting reliably, so the app measures it rather than describing it.

---

## Running it

```bash
cd artisanal_lens
flutter pub get
flutter run
```

Requires Flutter with Dart SDK `^3.12.0`. Use a physical Android phone to judge
live capture guidance — it reads real camera frames and the accelerometer.

For the web build, fetch the sqlite WASM worker first (it is gitignored):

```bash
dart run sqflite_common_ffi_web:setup
flutter run -d chrome
```

```bash
flutter analyze
flutter test
```

**Use a release build to judge the opening animation.** Debug builds JIT-compile
Dart at startup, which buries that sequence behind a long splash:

```bash
flutter build apk --release
```

The release APK is written to
`artisanal_lens/build/app/outputs/flutter-apk/app-release.apk`.

More device notes: [`artisanal_lens/RUNNING.md`](artisanal_lens/RUNNING.md).

### Supabase (cloud backup & sync)

**Pre-configured for this repo** — `flutter run` connects to the shared Supabase
project. Credentials live in `artisanal_lens/supabase.local.json` and
`lib/app/supabase_config.dart` (anon key only; safe for client apps).

```bash
cd artisanal_lens
flutter run
```

For release APKs, pass the same file so keys are baked into the build:

```bash
flutter build apk --release --dart-define-from-file=supabase.local.json
```

On Windows: `.\run_app.ps1` also picks up `supabase.local.json`.

Open **Settings → Account & backup** to sign in and sync photos.

New collaborators: paste the prompt in
[`COLLABORATOR_CURSOR_PROMPT.md`](COLLABORATOR_CURSOR_PROMPT.md) into Cursor.

Full backend setup (migrations, tutorial uploads): [`supabase/SUPABASE_SETUP.md`](supabase/SUPABASE_SETUP.md).

---

## The flow

The learner path is **Click & Social** (Lesson 01–05). Bottom tabs are
**Learn · Practice · Progress**.

```
Sutra splash  (tap to skip)
  └─ Learn (home)
        │
        ├─ Lesson 01  Photography
        │     Product (Mekhela / Sari / Stole / Accessories)
        │       └─ Material
        │            └─ Pick your frames
        │                 └─ Photo list
        │                                GUIDE → per-frame steps
        │                                CAPTURE → live camera (placement marks + light/distance)
        │                                GALLERY → upload from the library
        │                                     └─ Review (Use photo / Retake)
        │
        ├─ Lesson 02  Set Up Your Page on Instagram
        ├─ Lesson 03  Create a Post  (+ practice feed)
        ├─ Lesson 04  Posting Plan
        └─ Lesson 05  Read the Numbers
  Practice  — practice feed of posts
  Progress  — badges; Account & backup from here
```

Lesson 01 photo list opens the **guided camera** for that frame (same placement
box the analyser measures). Gallery upload stays as a second option.

### Pick your frames

The twelve frames (same list for every product; guides change by cluster):

Full display · Close-up texture · Draped look · Embroidery & border ·
Folded stack · Scale reference · Styled flat lay · In-context lifestyle ·
Hanging display · Macro fringe detail · The making · Framed display
(framed is offered for wall panels).

Thumbs live in `artisanal_lens/assets/images/guides/`. Core shots sit at the
**bottom** of Pick frames as one grid — not a separate section.

### Live capture

On Android the camera reads preview frames and shows light, distance, and a
placement marking per shot (`PlacementKind` in
`artisanal_lens/lib/domain/entities/placement_kind.dart`). This is
**rule-based luma analysis**, not ML. How it works:
[`docs/live-camera-guidance.md`](docs/live-camera-guidance.md).

On Chrome there is a preview but **no** live light/distance stream (`camera_web`).

---

## Photography templates (non-lesson sets)

Sets that are **not** started from Lesson 01 can still use the Product
Photography Guide templates (five per category). Thumbnails:
`assets/images/templates/`. Close-up templates skip **How should it look?**

| Category | Templates |
|---|---|
| **Saree** | Full Saree Display · Texture & Weave · Draped Look · Embroidery & Border · Folded Stack |
| **Cushion Cover** | Full Cover Display · Texture & Weave · Stacked Pair / Thickness · Corner & Stitching · In Use on Seating |
| **Shawl** | Full Design Display · Texture & Weave · Draped on Shoulder · Border & Corner · Folded Stack |
| **Stole** | Full Length Display · Texture & Weave · Neck Wrap · Edge Thickness · Softness Knot |

Each material and fibre type has thumbnails in
`assets/images/materials/`, `silk_types/`, `cotton_types/`, `wool_types/`
and `jute_types/`.

---

## Live capture guidance

In `artisanal_lens/lib/domain/services/` plus the capture overlay. This is real
image analysis, not a scripted animation and not a cloud vision API.

There is no setup slideshow. The camera opens, reads frames, and says one
thing about the cloth in front of the lens. Click & Social frames skip Lighting
& setup and go **photo list → shutter**, with a dashed placement box per shot.

**`FrameAnalyzer`** reads the luma (Y) plane of each YUV420 preview frame and
measures brightness, texture, and where the product sits relative to the ghost
inset (`PlacementKind.ghostInsetX/Y`).

**`CaptureGuidanceService`** turns those readings plus device pitch into light
and distance chips and one prompt. Guidance advises; the shutter stays enabled.

**`LiveGuidanceStabiliser`** holds a message until a new verdict repeats so
chips do not flicker.

`camera_web` has no image stream, so live chips run on **Android** only.

Write-up of the current behaviour (not a roadmap):
[`docs/live-camera-guidance.md`](docs/live-camera-guidance.md).

---

## Architecture

Layered, dependencies pointing inward. `domain/` imports no Flutter and knows
nothing about storage.

```
artisanal_lens/lib/
├── app/                  MaterialApp, router, DI, locale, theme tokens
├── domain/
│   ├── entities/         ShotSet, ShotType, FoldPreset, PhotographyTemplate,
│   │                     PlacementKind, FabricMaterial, …
│   ├── repositories/     abstract interfaces
│   └── services/         FrameAnalyzer, FrameMetricsSmoother,
│                         CaptureGuidanceService, LiveGuidanceStabiliser
├── data/
│   ├── datasources/      preset_catalog · app_database · photo_storage
│   └── repositories/     implementations
├── features/<feature>/   presentation + its controller
└── shared/widgets/
```

**State** — Riverpod. `shotSetsProvider` is the source of truth for shoots.
`captureSessionProvider` carries choices across the one-decision-per-screen
flow.

**Navigation** — `go_router`. Tabs sit in a `ShellRoute`; capture runs above
the shell so the bottom bar is hidden mid-shoot.

**Storage** — sqflite, local only, offline-first. A shoot survives being closed
mid-set. Photographs are copied into app storage and, on Android, into the
device gallery album *The Artisanal Lens*.

**Languages** — Assamese, Odia, Telugu and English. Switch in Account / backup
(`lib/l10n/`).

---

## Platform support

| | Android | Web |
|---|---|---|
| Full navigation flow | yes | yes |
| Camera preview and capture | yes | yes |
| **Live light / angle / framing guidance** | **yes** | **no** |
| Photos survive a restart | yes | records yes, images no |
| Save to device gallery | yes | no |

**Judge the guidance on Android.**

---

## Adding a category

Categories and folds are data in
`artisanal_lens/lib/data/datasources/preset_catalog.dart`. Add a
`ProductCategory` and its `FoldPreset`s. `test/catalog_coverage_test.dart`
checks that every category × shot type can reach the camera.

Photography templates live in
`artisanal_lens/lib/domain/entities/photography_template.dart`.

---

## Known gaps

- **Tutorial videos.** The catalog references a `.mp4` per fold. Videos stream
  from Supabase Storage (`tutorial-videos` bucket) — they are not bundled in
  the APK. Upload each key via the Supabase Dashboard until all 15 are live;
  missing uploads show a placeholder in the app.
- **Step illustrations in the app bundle.** How-to cards for **Saree roll display**
  (5 steps) are bundled. Other folds still have source art in
  [`tutorial-videos-images/`](tutorial-videos-images/) that is not yet copied into `assets/images/steps/`.
- **Localisation polish.** UI switches between Assamese, Odia, Telugu and
  English. Catalog transcript lines and a few long setup sentences are still
  English; a native speaker should review the translations.

---

## Repository layout

```
.
├── artisanal_lens/     Flutter application
│   └── assets/images/  presets, templates, materials, fibre types, steps
├── supabase/           SQL migrations, tutorial video bucket, setup guide
├── tutorial-videos-images/  how-to step card source art for tutorial videos
├── docs/               live-camera-guidance.md, audit notes, source PDFs
└── README.md
```

Architecture notes: [`artisanal_lens/README.md`](artisanal_lens/README.md).
