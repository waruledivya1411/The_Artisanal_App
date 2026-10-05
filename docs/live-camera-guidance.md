# Live Camera Guidance — How We Built It

## What this feature is

On the capture screen, the artisan gets live help while framing a product photo:

- Light chips (e.g. Too dark / OK)
- Distance chips (e.g. Move closer / OK)
- A main prompt (e.g. Too dark, Move closer, Ready to capture)
- On-screen grid / ghost-frame guidelines

This is **not** a machine-learning model and **not** a cloud vision API. It is **custom rule-based analysis** of camera preview frames, running on device.

---

## High-level flow

```
User opens capture
        ↓
Flutter `camera` package streams live CameraImage frames
        ↓
Skip early “black” warmup frames after the camera opens
        ↓
FrameAnalyzer measures brightness + texture from the luma (Y) plane
        ↓
CaptureGuidanceService applies thresholds → light / distance / prompt
        ↓
LiveGuidanceStabiliser smooths changes so chips don’t flicker
        ↓
Capture UI shows grid + guidance pills + main prompt
        ↓
When prompt is Ready → user can capture
```

---

## Main code pieces

| Piece | File | Job |
|--------|------|-----|
| Camera + frame loop | `artisanal_lens/lib/features/capture/camera_controller.dart` | Listens to frames, runs analysis, updates feedback state |
| Measurements | `artisanal_lens/lib/domain/services/frame_analyzer.dart` | Reads luma plane → luminance, detail, fill, edges, etc. |
| Decision rules | `artisanal_lens/lib/domain/services/capture_guidance_service.dart` | Thresholds → LightQuality, DistanceQuality, CapturePrompt |
| Stabiliser | `artisanal_lens/lib/domain/services/live_guidance_stabiliser.dart` | Avoids jumping chips every frame; ignores one-off bad reads |
| Feedback / copy | `artisanal_lens/lib/domain/entities/capture_feedback.dart` | Prompt messages and quality enums |
| Capture UI | `artisanal_lens/lib/features/capture/presentation/capture_page.dart` | Draws guide + `_LiveGuidancePill` chips |
| Technique profile | `artisanal_lens/lib/domain/entities/preset_capture_guidance.dart` | Per-technique guidance settings used with evaluation |

**Camera dependency:** Flutter `camera` package in `pubspec.yaml`.

---

## How a frame is analysed

1. Take the first plane of `CameraImage` (luma / Y).
2. Pass bytes + width/height + bytes-per-row into `FrameAnalyzer.analyseLumaPlane`.
3. Use the same **ghost-frame inset** as the on-screen guide (`insetX` / `insetY` from the technique grid), so “fill the box” matches what the user sees.
4. Produce `FrameMetrics`, including roughly:
   - **meanLuminance** — overall brightness (0..1)
   - **centreLuminance / borderLuminance** — inside vs outside the guide
   - **centreDetail / borderDetail** — texture (woven fabric vs empty floor/wall)
   - **subjectCoverage / targetCoverage** — how much of the frame / guide looks product-like
   - **subjectEdgeContact** — product spilling into picture edges
   - focus / fine-detail style ratios for blur-ish checks
5. Metrics are lightly smoothed over time before evaluation.

Nothing here “recognises a saree” with a neural net. It measures **brightness** and **texture/fill** and applies rules.

---

## Decision logic (guidance)

`CaptureGuidanceService.evaluate(...)` takes:

- current `FrameMetrics`
- technique / guidance profile
- phone pitch (from accelerometer)
- previous distance/centre quality (for hysteresis)

It sets:

### Light quality

Driven mainly by mean luminance (and related highlight/backlight checks), with thresholds such as:

- too dark below ~`0.24`
- low light below ~`0.40`
- too bright above ~`0.82`

Examples:

- Dark room → **Too dark**
- Blown sun / clipped highlights → **Too bright**

### Distance / framing quality

Driven by how much textured “subject” sits inside the ghost frame vs overflow:

- Little product in the guide → **Move closer** (too far)
- Product overflowing / edge contact high → **too close** / step back style feedback
- Enough fill and placement → distance **OK**

### Main prompt

One primary instruction (priority-style checks), e.g.:

- Too dark / too bright
- Move closer
- Hold the phone steady (blur-ish)
- Ready to capture

### Tilt

Pitch from the accelerometer is folded into evaluation (phone angle), separate from image analysis.

---

## Stabiliser behaviour

`LiveGuidanceStabiliser`:

- Stops a single bad frame from locking chips on **Too dark** / **Move in**
- Especially important right after the camera opens (often black frames while auto-exposure settles)
- Requires more consistent readings before changing the shown feedback

`camera_controller` also:

- Skips analysis during a short **warmup** after open
- Skips a limited number of **unexposed** (near-black) frames
- Throttles analysis so it doesn’t run every single frame on low-end phones

---

## What the user sees

| UI | Meaning |
|----|---------|
| Grid / ghost rectangle | Target area for the product |
| Light chip | Current light quality |
| Distance chip | Current distance / fill quality |
| Main prompt text | The action to take now |

When everything is acceptable → **Ready to capture** and shutter is allowed.

---

## Concrete examples

**Example A — Too dark**  
Indoor, far from window. Mean luminance low → prompt: *Too dark — move near a window or outside*.

**Example B — Move closer**  
Product small in the middle of the floor; guide mostly empty/low texture → *Move closer*.

**Example C — Ready**  
Brightness in range, product fills the guide reasonably, tilt OK → *Ready to capture*.

---

## One-line summary

> Live guidance = **camera frames → luma brightness/texture metrics → threshold rules → stabilised chips + grid UI**. No trained vision model in this path.
