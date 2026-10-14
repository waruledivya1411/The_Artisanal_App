/// The twelve shared photography frames of the Click & Social lesson.
///
/// Ported from the HTML prototype (`shotDefs`, `frameDescs`, `frameImgs`,
/// `archOf`, `guideDefs`). Unlike the BTP photography templates, this list is
/// the same for every category — what changes is which frames the learner
/// picks, and which reference photographs the guide shows for their cluster.
library;

import 'package:flutter/widgets.dart';

import '../../domain/entities/fabric_property.dart';
import '../../domain/entities/photography_guideline.dart';
import '../../domain/entities/photography_template.dart';
import '../../domain/entities/technique_preset.dart';
import '../../l10n/app_localizations.dart';

/// Where the extracted HTML reference photographs live.
const String _guides = 'assets/images/guides';

/// Listing-frame filenames shared by Kamrup, Maniabandha, Srikalahasti, and Venkatgiri sari/mekhela.
/// Filenames match [ClickSocialFrame.name]; photos match that pose.
const _clusterListingFrameImgs = <int, String>{
  0: 'full_display.jpg', // Full display
  1: 'close-up_texture.jpg', // Close-up texture
  2: 'draped_look.jpg', // Draped look
  3: 'embroidery_and_border.jpg', // Embroidery & border
  4: 'folded_stack.jpg', // Folded stack
  8: 'hanging_display.jpg', // Hanging display
};

/// Camera-grid archetypes from Click & Social HTML (`archOf`).
enum FrameArch { thirds, center, diag, detail }

/// One page of a frame's multi-step guide (HTML `guideDefs` entry).
///
/// A step draws either a [diagram], a single [imageAsset], or a [gallery] —
/// never more than one — and may add a [caption] underneath.
///
/// When [diagram] is set, [referenceAsset] is the real photo shown beside it
/// and must match the instruction (hang → hung on a rod, fold → folded stack…).
class GuideStep {
  const GuideStep({
    required this.title,
    required this.subtitle,
    this.diagram,
    this.imageAsset,
    this.gallery,
    this.caption,
    this.referenceAsset,
  });

  /// HTML `t`.
  final String title;

  /// HTML `s`.
  final String subtitle;

  /// HTML `d`: hang, drape, grid, gridmotif, scale, gridthirds, flatprops,
  /// diagline, dist, rake, close, border, foldmid, folddiag.
  final String? diagram;

  /// HTML `img`.
  final String? imageAsset;

  /// HTML `gal`.
  final List<String>? gallery;

  /// HTML `cap`.
  final String? caption;

  /// Real photograph shown beside [diagram] — must match the instruction.
  final String? referenceAsset;

  bool get hasGallery => gallery != null && gallery!.isNotEmpty;
}

/// One of the twelve Click & Social frames.
class ClickSocialFrame {
  const ClickSocialFrame({
    required this.index,
    required this.name,
    required this.content,
    required this.thumbAsset,
    required this.arch,
    required this.tipDetail,
    required this.gridPath,
  });

  /// Position in the HTML frame list, 0..11. Persisted, so it is the identity.
  final int index;

  /// HTML `shotDefs[i][0]`.
  final String name;

  /// HTML `frameDescs[i]`.
  final String content;

  /// HTML `frameImgs[i]` for a non-Kalamkari cluster.
  final String thumbAsset;

  /// HTML `archOf[i]`.
  final FrameArch arch;

  /// Second half of HTML `shotDefs[i][1]` — the grid the frame teaches.
  final String tipDetail;

  /// HTML `gridPaths[i]` in a 100×100 viewBox — unique per frame, not per arch.
  final String gridPath;

  /// Coarse overlay type for the analyser; drawing prefers [gridPath].
  GridOverlayType get grid => switch (index) {
        0 || 2 || 5 || 7 || 10 => GridOverlayType.ruleOfThirds,
        1 || 6 || 8 || 11 => GridOverlayType.centerFocus,
        9 => GridOverlayType.leadingLines,
        3 => GridOverlayType.detailFrame,
        4 => GridOverlayType.horizontalFolds,
        _ => switch (arch) {
            FrameArch.thirds => GridOverlayType.ruleOfThirds,
            FrameArch.center => GridOverlayType.centerFocus,
            FrameArch.diag => GridOverlayType.leadingLines,
            FrameArch.detail => GridOverlayType.detailFrame,
          },
      };

  /// HTML `shotDefs[i][1]` — content plus the grid, as shown on the checklist.
  String tipFor({String? clusterId, required AppLocalizations l10n}) {
    // Frame 3 leads with the cluster's own detail tip instead of the content.
    final head = index == 3 ? clickSocialDetailTip(clusterId, l10n) : content;
    return '$head · $tipDetail';
  }

  /// HTML `frameImgs[i]` — Kalamkari clusters swap in their own reference set.
  String thumbAssetFor({
    String? clusterId,
    String? categoryId,
    String? technique,
    String? productLabel,
    String? materialId,
  }) {
    // Cluster listing folders first. There is no woven / hand-painted picker,
    // so every listing thumb uses the woven set.
    final listing = _clusterListingFrameImgs[index];
    final clusterDir = clickSocialListingClusterDir(clusterId);
    if (listing != null && clusterDir != null) {
      final product = kamrupProductKey(
        productLabel: productLabel,
        categoryId: categoryId,
      );
      final material = clickSocialMaterialFolder(
        materialId,
        product: product,
        clusterId: clusterId,
      );
      return 'assets/images/clusters/$clusterDir/$product/$material/woven/$listing';
    }
    if (clickSocialIsKal(clusterId: clusterId, technique: technique)) {
      final set = _kalFrameImgs[_kalProduct(categoryId, technique)]!;
      return '$_guides/${set[index]}';
    }
    // Frame 10 is "the making", so its thumbnail follows the cluster.
    if (index == 10) return clickSocialMakingGallery(clusterId).first;
    return thumbAsset;
  }

  /// The frame's guide pages, with the cluster's inserts and galleries applied.
  ///
  /// Mirrors the HTML: Assam gets two extra "like this" pages, and a Kalamkari
  /// learner's "Good examples" gallery is replaced by their own product's set.
  List<GuideStep> guideSteps({
    required AppLocalizations l10n,
    required bool isAssam,
    required bool isKal,
    required String? clusterId,
    required String? productLabel,
    required String? technique,
  }) {
    final steps = <GuideStep>[
      ..._baseGuideSteps(
        index,
        l10n: l10n,
        isAssam: isAssam,
        isMekhela: clickSocialDrapeOnChair(
          clusterId: clusterId,
          productLabel: productLabel,
        ),
        isSari: clickSocialSariChairDrape(
          clusterId: clusterId,
          productLabel: productLabel,
        ),
        detailTip: clickSocialDetailTip(clusterId, l10n),
        making: clickSocialMakingGallery(clusterId),
      ),
    ];
    if (!isKal) return steps;

    final replacement = _kalGalleries[_kalProduct(productLabel, technique)]
        ?[index];
    if (replacement == null) return steps;

    final gallery = [for (final name in replacement) '$_guides/$name'];
    final at = steps.indexWhere((step) => step.hasGallery);
    if (at == -1) {
      steps.add(
        GuideStep(
          title: l10n.csGoodExamples,
          subtitle: l10n.csKalExSub,
          gallery: gallery,
        ),
      );
    } else {
      final existing = steps[at];
      steps[at] = GuideStep(
        title: existing.title,
        subtitle: existing.subtitle,
        gallery: gallery,
        caption: existing.caption,
        referenceAsset: existing.referenceAsset,
      );
    }
    return steps;
  }
}

/// The twelve frames, in HTML order. Index is the persisted identity.
/// The twelve frames, in HTML order. Index is the persisted identity.
///
/// Each [ClickSocialFrame.gridPath] is the matching HTML `gridPaths[i]` string
/// (100×100 viewBox) — kept inline so this list stays a compile-time constant.
const clickSocialFrames = <ClickSocialFrame>[
  ClickSocialFrame(
    index: 0,
    name: 'Full display',
    content: 'Colour, pattern, material',
    thumbAsset: '$_guides/ex-full-form.jpg',
    arch: FrameArch.thirds,
    tipDetail: 'rule of thirds grid',
    gridPath: 'M33.3 0v100M66.6 0v100M0 33.3h100M0 66.6h100',
  ),
  ClickSocialFrame(
    index: 1,
    name: 'Close-up texture',
    content: 'Texture, thickness, material',
    thumbAsset: '$_guides/ex-close-motif.jpg',
    arch: FrameArch.center,
    tipDetail: 'center focus grid',
    gridPath: 'M30 28h40v44h-40zM50 0v28M50 72v100',
  ),
  ClickSocialFrame(
    index: 2,
    name: 'Draped look',
    content: 'Flimsiness, sheen, flow, weight',
    thumbAsset: '$_guides/cs_cam_ref_2.jpg',
    arch: FrameArch.thirds,
    tipDetail: 'rule of thirds · full-length person',
    gridPath: 'M33.3 0v100M66.6 0v100M0 33.3h100M0 66.6h100',
  ),
  ClickSocialFrame(
    index: 3,
    name: 'Embroidery & border',
    content: 'Embroidery and quality',
    thumbAsset: '$_guides/ex-border-folds.jpg',
    arch: FrameArch.detail,
    tipDetail: 'detail frame grid',
    gridPath: 'M52 8h36v34h-36zM0 100L100 34',
  ),
  ClickSocialFrame(
    index: 4,
    name: 'Folded stack',
    content: 'Thickness and material',
    thumbAsset: '$_guides/ex-folded-layers.jpg',
    arch: FrameArch.detail,
    tipDetail: 'horizontal & diagonal grid',
    gridPath: 'M0 33h100M0 66h100M0 82L100 22',
  ),
  ClickSocialFrame(
    index: 5,
    name: 'Scale reference',
    content: 'Size, proportion, length',
    thumbAsset: '$_guides/ex-drape-chair-pink.jpg',
    arch: FrameArch.thirds,
    tipDetail: 'rule of thirds + reference',
    gridPath:
        'M33.3 0v100M66.6 0v100M0 33.3h100M0 66.6h100M74 66.6a8 10 0 1 1-.1 0',
  ),
  ClickSocialFrame(
    index: 6,
    name: 'Styled flat lay',
    content: 'Styling, colour, use-case',
    thumbAsset: '$_guides/stole-flatlay.png',
    arch: FrameArch.center,
    tipDetail: 'symmetric grid + props',
    gridPath: 'M50 0v100M0 50h100M18 14h64v72h-64z',
  ),
  ClickSocialFrame(
    index: 7,
    name: 'In-context lifestyle',
    content: 'Application, ambience',
    thumbAsset: '$_guides/ex-drape-chair.jpg',
    arch: FrameArch.thirds,
    tipDetail: 'eye-level rule of thirds',
    gridPath:
        'M33.3 0v100M66.6 0v100M0 33.3h100M0 66.6h100M22 26h56v48h-56z',
  ),
  ClickSocialFrame(
    index: 8,
    name: 'Hanging display',
    content: 'Drape, symmetry, fringe',
    thumbAsset: '$_guides/stole-hung.webp',
    arch: FrameArch.center,
    tipDetail: 'center vertical axis',
    gridPath: 'M50 0v100M0 50h100',
  ),
  ClickSocialFrame(
    index: 9,
    name: 'Macro fringe detail',
    content: 'Hand-finishing, craft',
    thumbAsset: '$_guides/ex-border-flat.jpg',
    arch: FrameArch.diag,
    tipDetail: 'diagonal close-up grid',
    gridPath: 'M0 100L100 0M0 70L70 0M30 100L100 30',
  ),
  ClickSocialFrame(
    index: 10,
    name: 'The making',
    content: 'Process, hands, tools',
    thumbAsset: '$_guides/making-assam.jpg',
    arch: FrameArch.thirds,
    tipDetail: 'rule of thirds',
    gridPath: 'M33.3 0v100M66.6 0v100M0 33.3h100M0 66.6h100',
  ),
  ClickSocialFrame(
    index: 11,
    name: 'Framed display',
    content: 'Presentation, wall-ready',
    thumbAsset: '$_guides/kal-panel-tree.jpg',
    arch: FrameArch.center,
    tipDetail: 'square-on, no glare · symmetric grid',
    gridPath: 'M12 10h76v80h-76zM22 20h56v60h-56z',
  ),
];

/// Listing frames shown on Pick your frames (the six we keep).
const clickSocialOfferedFrames = <int>[0, 1, 2, 3, 4, 8];

/// Mekhela sador draped look is two unstitched cloths over a chair, not worn.
/// Sari draped look is the sari over a chair, with a fold on the seat.
bool clickSocialDrapeOnChair({
  String? clusterId,
  String? productLabel,
  String? categoryId,
}) {
  final key = clickSocialFrameProductKey(
    clusterId: clusterId,
    productLabel: productLabel,
    categoryId: categoryId,
  );
  return key == 'mekhela' || key == 'sari';
}

/// Sari chair drape (fold on the seat, pallu falling), not mekhela's two cloths.
bool clickSocialSariChairDrape({
  String? clusterId,
  String? productLabel,
  String? categoryId,
}) =>
    clickSocialFrameProductKey(
      clusterId: clusterId,
      productLabel: productLabel,
      categoryId: categoryId,
    ) ==
    'sari';

/// Camera-layout reference shown after Capture, before the live shutter.
String clickSocialCameraRefAsset(
  int index, {
  bool chairDrape = false,
  bool sariChair = false,
}) {
  if (index == 2 && sariChair) return '$_guides/cs_cam_ref_2_sari_chair.jpg';
  if (index == 2 && chairDrape) return '$_guides/cs_cam_ref_2_chair.jpg';
  if (index == 4 && sariChair) return '$_guides/cs_cam_ref_4_sari.jpg';
  return '$_guides/cs_cam_ref_$index.jpg';
}

/// Where each part of the product sits on that camera grid.
List<String> clickSocialCameraPlacementLines(
  int index, {
  bool chairDrape = false,
}) =>
    switch (index) {
      0 => const [
          'Whole piece inside the dashed box',
          'Spread it on the floor or a table — do not hang it',
          'Keep edges parallel to the grid',
        ],
      1 => const [
          'Fill the centre box with the weave',
          'Keep the motif in the middle',
          'Hold the phone 15–30 cm away',
        ],
      2 => chairDrape
          ? const [
              'Drape both cloths over the chair inside the dashed box',
              'Folds fall to the floor · border readable',
              'Chair back near the top third · hem near the bottom',
            ]
          : const [
              'Person wearing the sari stands in the dashed box',
              'Pallu over the shoulder · pleats to the floor',
              'Head near the top third · feet near the bottom',
            ],
      3 => const [
          'Put the motif in the small window',
          'Border fills the rest of the frame',
          'A slight fold gives the border depth',
        ],
      4 => const [
          'Stack sits inside the dashed box',
          'Layers rest on the horizontal lines',
          'Folded edge faces the camera',
        ],
      8 => const [
          'Hang on the centre vertical line',
          'Rod at the top of the box',
          'Fringes even at the bottom',
        ],
      _ => const [
          'Keep the product inside the dashed box',
        ],
    };

/// Kept for older panel call sites — same six as everyone else.
const clickSocialPanelFrames = clickSocialOfferedFrames;

/// Fallback when the learner picked nothing at the checklist.
const clickSocialDefaultFrames = clickSocialOfferedFrames;

/// Frames offered on Pick your frames — only the six listing shots.
List<ClickSocialFrame> framesForSelection({required bool isPanel}) => [
      for (final frame in clickSocialFrames)
        if (clickSocialOfferedFrames.contains(frame.index)) frame,
    ];

ClickSocialFrame? frameByIndex(int i) {
  for (final frame in clickSocialFrames) {
    if (frame.index == i) return frame;
  }
  return null;
}

/// HTML `archOf` — which camera grid a frame uses.
FrameArch archForFrameIndex(int i) =>
    frameByIndex(i)?.arch ?? FrameArch.thirds;

/// The frames actually shot for a set: the learner's picks, or the HTML default.
List<int> resolveFramePicks(List<int> picks, {required bool isPanel}) {
  if (picks.isEmpty) return List<int>.from(clickSocialOfferedFrames);
  final sorted = picks.where(clickSocialOfferedFrames.contains).toList()
    ..sort();
  if (sorted.isEmpty) return List<int>.from(clickSocialOfferedFrames);
  return sorted;
}

/// SharedPreferences key holding the picked frame indexes for one shoot.
///
/// Presence of this key is what puts a shoot's checklist into Click & Social
/// mode; a shoot started outside the lesson keeps the BTP template list.
String clickSocialFramePicksKey(String setId) =>
    'click_social_frame_picks_$setId';

/// SharedPreferences key holding how the piece was made, for one shoot.
///
/// The checklist and the guide need it to tell a Kalamkari panel apart from a
/// woven piece, and the shoot itself does not record technique.
String clickSocialTechniqueKey(String setId) =>
    'click_social_technique_$setId';

/// SharedPreferences key holding the learner's chosen cluster.
const String clickSocialClusterKey = 'click_social_cluster_id';

/// Fibres that should use the silk photo set and silk lighting.
const clickSocialSilkMaterials = {
  'silk',
  'mulberry',
  'zari',
  'eri',
  'tussar',
  'tussar-gheecha',
  'muga',
  'muga-gheecha',
  'spun-silk',
  'spun-tussar',
  'korea-tussar',
  'noil',
  'liva-viscose',
};

bool clickSocialMaterialIsSilk(String? materialId) =>
    clickSocialSilkMaterials.contains((materialId ?? '').trim().toLowerCase());

const _kamrupNamedFibreFolders = {
  'mulberry',
  'zari',
  'eri',
  'tussar',
  'tussar-gheecha',
  'muga',
  'muga-gheecha',
  'spun-silk',
  'spun-tussar',
  'liva-viscose',
};

String clickSocialMaterialFolder(
  String? materialId, {
  String? product,
  String? clusterId,
}) {
  final id = (materialId ?? '').trim().toLowerCase();
  if (clusterId == 'assam' &&
      (product == 'shawl' ||
          product == 'gamusa' ||
          product == 'sari' ||
          product == 'mekhela') &&
      _kamrupNamedFibreFolders.contains(id)) {
    return id;
  }
  return clickSocialMaterialIsSilk(materialId) ? 'silk' : 'cotton';
}

/// HTML `isPanel` — a hand-painted Kalamkari panel.
bool clickSocialIsPanel({String? categoryId, String? technique}) =>
    categoryId == 'cushion_cover' &&
    (technique ?? '').toUpperCase() == 'HAND-PAINTED';

/// HTML `isKal` — hand-painted work, or anyone from Srikalahasti.
bool clickSocialIsKal({String? clusterId, String? technique}) =>
    (technique ?? '').toUpperCase() == 'HAND-PAINTED' ||
    clusterId == 'srikalahasti';

bool clickSocialIsAssam(String? clusterId) => clusterId == 'assam';

bool clickSocialIsManiabandha(String? clusterId) => clusterId == 'maniabandha';

/// Asset folder under `assets/images/clusters/` for listing-frame thumbs.
String? clickSocialListingClusterDir(String? clusterId) => switch (clusterId) {
      'assam' => 'kamrup',
      'maniabandha' => 'maniabandha',
      'srikalahasti' => 'srikalahasti',
      'venkatgiri' => 'venkatgiri',
      _ => null,
    };

/// Kamrup folder: mekhela / sari / stole / shawl / gamusa. Mekhela shares category
/// `saree`, so the product label must win.
String kamrupProductKey({String? productLabel, String? categoryId}) {
  final p = (productLabel ?? '').toLowerCase();
  if (p.contains('mekhela') || p.contains('jod') || p.contains('wrap')) {
    return 'mekhela';
  }
  if (p.contains('shawl')) return 'shawl';
  if (p.contains('gamusa') || p.contains('gamosa')) return 'gamusa';
  if (p.contains('furnish') ||
      p.contains('cushion') ||
      p.contains('runner') ||
      p.contains('mat') ||
      p.contains('stole') ||
      p.contains('dupatta') ||
      p.contains('muffler') ||
      p.contains('chadar') ||
      p.contains('uttar') ||
      p.contains('handker') ||
      p.contains('angvastram') ||
      p.contains('cloth') ||
      p.contains('bag')) {
    return 'stole';
  }
  if (p.contains('yardage') ||
      p.contains('dhoti') ||
      p.contains('sari') ||
      p.contains('saree')) {
    return 'sari';
  }
  final c = (categoryId ?? '').toLowerCase();
  if (c == 'stole' || c == 'shawl') return 'stole';
  return 'sari';
}

String clickSocialFrameProductKey({
  String? clusterId,
  String? productLabel,
  String? categoryId,
}) {
  if (clickSocialIsAssam(clusterId) &&
      (productLabel == null || productLabel.trim().isEmpty) &&
      (categoryId ?? '') == 'saree') {
    return 'mekhela';
  }
  return kamrupProductKey(productLabel: productLabel, categoryId: categoryId);
}

/// HTML `cluster.detailTip`, with the Assam wording as the fallback.
String clickSocialDetailTip(String? clusterId, AppLocalizations l10n) =>
    switch (clusterId) {
      'srikalahasti' => l10n.csDetailTipKal,
      'maniabandha' => l10n.csDetailTipManiabandha,
      'venkatgiri' => l10n.csDetailTipVenkatgiri,
      'gopalpur' => l10n.csDetailTipGopalpur,
      'nagaland' => l10n.csDetailTipNagaland,
      _ => l10n.csDetailTipAssam,
    };

/// HTML `makingByCluster` — the making photographs for frame 10.
List<String> clickSocialMakingGallery(String? clusterId) {
  final names = switch (clusterId) {
    'srikalahasti' => const [
        'kal-making-pen.jpg',
        'kal-making-outline.jpg',
        'kal-making-painting.jpg',
      ],
    'assam' || 'nagaland' => const [
        'making-assam.jpg',
        'making-jamdani-1.jpg',
      ],
    _ => const [
        'making-jamdani-1.jpg',
        'making-jamdani-2.jpg',
        'making-assam.jpg',
      ],
  };
  return [for (final name in names) '$_guides/$name'];
}

/// Adapts a frame to the capture flow's template contract.
///
/// The camera, lighting screen and grid overlay all read a
/// [PhotographyTemplate], so a picked frame has to become one. [skipsStyleStep]
/// is always true: the Click & Social guide replaces the fold step, so
/// `beginCaptureForSlot` opens the camera-layout reference, then the shutter.
PhotographyTemplate asTemplate(
  ClickSocialFrame f, {
  String? thumbAsset,
  bool chairDrape = false,
  bool sariChair = false,
  AppLocalizations? l10n,
}) {
  final loc = l10n ?? lookupAppLocalizations(const Locale('en'));
  final steps = _baseGuideSteps(
    f.index,
    l10n: loc,
    isAssam: false,
    isMekhela: chairDrape,
    isSari: sariChair,
    detailTip: clickSocialDetailTip(null, loc),
    making: clickSocialMakingGallery(null),
  );
  final setup = [
    for (final step in steps.take(3)) '${step.title} — ${step.subtitle}',
  ];

  return PhotographyTemplate(
    id: 'cs_frame_${f.index}',
    name: f.name,
    content: f.content,
    grid: f.grid,
    gridPath: f.gridPath,
    composition: switch (f.arch) {
      FrameArch.thirds => CompositionRule.ruleOfThirds,
      FrameArch.center => CompositionRule.centerFocus,
      FrameArch.diag => CompositionRule.leadingFabricLines,
      FrameArch.detail => CompositionRule.detailFrame,
    },
    angle: switch (f.index) {
      1 || 9 => CameraAngle.macroCloseUp,
      4 || 6 => CameraAngle.overheadFlatLay,
      _ => CameraAngle.eyeLevel,
    },
    lighting: switch (f.index) {
      1 || 3 || 9 => LightingSetup.softWindowLight,
      _ => LightingSetup.diffusedDaylight,
    },
    placement: steps.isEmpty ? f.content : steps.first.subtitle,
    guidance: setup,
    overlayCaption: steps.isEmpty ? f.name : steps.first.title,
    // Checklist thumbs use the listing photo the learner picked. Camera
    // layout still reads [clickSocialCameraRefAsset] on the capture screen.
    referenceImageAsset: thumbAsset ??
        (clickSocialOfferedFrames.contains(f.index)
            ? clickSocialCameraRefAsset(
                f.index,
                chairDrape: chairDrape,
                sariChair: sariChair,
              )
            : f.thumbAsset),
    skipsStyleStep: true,
    highlightedProperties: switch (f.arch) {
      FrameArch.thirds => const [
          FabricProperty.colour,
          FabricProperty.pattern,
          FabricProperty.material,
        ],
      FrameArch.center => const [
          FabricProperty.texture,
          FabricProperty.thickness,
          FabricProperty.material,
        ],
      FrameArch.diag => const [
          FabricProperty.flimsiness,
          FabricProperty.sheen,
        ],
      FrameArch.detail => const [
          FabricProperty.embroidery,
          FabricProperty.quality,
        ],
    },
    guidelines: switch (f.arch) {
      FrameArch.thirds => const [
          PhotographyGuideline.variousAngles,
          PhotographyGuideline.complementaryBackgrounds,
        ],
      FrameArch.center => const [
          PhotographyGuideline.closeUpShots,
          PhotographyGuideline.diverseLighting,
        ],
      FrameArch.diag => const [
          PhotographyGuideline.weightAndFlow,
          PhotographyGuideline.naturalCreases,
        ],
      FrameArch.detail => const [
          PhotographyGuideline.closeUpShots,
          PhotographyGuideline.highlightFabricEdges,
        ],
    },
  );
}

/// HTML `kalProd` — which Kalamkari reference set the learner's product uses.
String _kalProduct(String? productLabel, String? technique) {
  final value = (productLabel ?? '').toLowerCase();
  if (value.contains('panel') ||
      clickSocialIsPanel(categoryId: productLabel, technique: technique)) {
    return 'panel';
  }
  if (value.contains('stole') ||
      value.contains('dupatta') ||
      value.contains('shawl')) {
    return 'stole';
  }
  return 'sari';
}

/// HTML `kalFrameImgs` — checklist thumbnails for a Kalamkari learner.
const _kalFrameImgs = <String, List<String>>{
  'sari': [
    'kal-sari-room-full.jpg',
    'kal-fish-close.jpg',
    'kal-sari-yali.jpg',
    'kal-radha-krishna.jpg',
    'kal-folded-zari.jpg',
    'kal-saree-back.jpg',
    'kal-fish-close-2.jpg',
    'kal-model-outdoor.jpg',
    'kal-hung-rod.jpg',
    'kal-drape-close.jpg',
    'kal-making-painting.jpg',
    'kal-panel-tree.jpg',
  ],
  'stole': [
    'kal-pen-bw.jpg',
    'kal-fish-close.jpg',
    'kal-stole-blue.jpg',
    'kal-pen-bw.jpg',
    'kal-folded-zari.jpg',
    'kal-runway.jpg',
    'kal-fish-close-2.jpg',
    'kal-model-dupatta.jpg',
    'kal-stole-blue.jpg',
    'kal-drape-close.jpg',
    'kal-making-painting.jpg',
    'kal-panel-tree.jpg',
  ],
  'panel': [
    'kal-panel-tree.jpg',
    'kal-panel-fish.jpg',
    'kal-panel-tree.jpg',
    'kal-panel-fish.jpg',
    'kal-panel-tree.jpg',
    'kal-panel-fish.jpg',
    'kal-panel-fish.jpg',
    'kal-panel-tree.jpg',
    'kal-panel-tree.jpg',
    'kal-panel-fish.jpg',
    'kal-making-painting.jpg',
    'kal-framed-sofa.jpg',
  ],
};

/// HTML `makingGal` — the Kalamkari making sequence.
const _kalMakingGallery = <String>[
  'kal-making-pen.jpg',
  'kal-making-intro.jpg',
  'kal-making-sketch.jpg',
  'kal-making-outline.jpg',
  'kal-making-painting.jpg',
];

/// HTML `kalGalsByProd` — replaces a frame's "Good examples" gallery.
const _kalGalleries = <String, Map<int, List<String>>>{
  'sari': {
    0: ['kal-sari-room-full.jpg', 'kal-hung-rod.jpg', 'kal-saree-back.jpg'],
    1: [
      'kal-sari-room-close.jpg',
      'kal-fish-close.jpg',
      'kal-radha-krishna.jpg',
    ],
    2: ['kal-sari-yali.jpg', 'kal-kanchi-drape.jpg', 'kal-saree-spread.jpg'],
    3: ['kal-fish-close-2.jpg', 'kal-folded-zari.jpg'],
    5: ['kal-saree-back.jpg'],
    6: ['kal-fish-close-2.jpg', 'kal-folded-zari.jpg'],
    7: [
      'kal-sari-room-full.jpg',
      'kal-model-outdoor.jpg',
      'kal-saree-spread.jpg',
    ],
    8: ['kal-hung-rod.jpg'],
    9: ['kal-drape-close.jpg', 'kal-radha-krishna.jpg'],
    10: _kalMakingGallery,
  },
  'stole': {
    0: ['kal-pen-bw.jpg', 'kal-stole-blue.jpg'],
    1: ['kal-pen-bw.jpg', 'kal-drape-close.jpg', 'kal-fish-close.jpg'],
    2: ['kal-stole-blue.jpg', 'kal-model-dupatta.jpg'],
    3: ['kal-pen-bw.jpg', 'kal-drape-close.jpg'],
    7: ['kal-model-dupatta.jpg', 'kal-runway.jpg'],
    8: ['kal-stole-blue.jpg'],
    9: ['kal-drape-close.jpg'],
    10: _kalMakingGallery,
  },
  'panel': {
    0: ['kal-panel-tree.jpg', 'kal-panel-fish.jpg'],
    10: _kalMakingGallery,
    11: ['kal-framed-sofa.jpg', 'kal-framed-dining.jpg'],
  },
};

/// HTML `guideDefs[i]` before the Kalamkari gallery swap.
///
/// Every diagram step either pairs a [GuideStep.referenceAsset] that matches
/// the instruction, or leaves it null (diagram-only) when no process photo
/// exists — never a random shot thumb.
List<GuideStep> _baseGuideSteps(
  int index, {
  required AppLocalizations l10n,
  required bool isAssam,
  required bool isMekhela,
  bool isSari = false,
  required String detailTip,
  required List<String> making,
}) {
  switch (index) {
    case 0:
      return [
        GuideStep(
          title: l10n.csG0HangTitle,
          subtitle: l10n.csG0HangSub,
          diagram: 'hang',
          referenceAsset: '$_guides/kal-hung-rod.jpg',
        ),
        if (isAssam)
          GuideStep(
            title: l10n.csG0ThreeTitle,
            subtitle: l10n.csG0ThreeSub,
            imageAsset: '$_guides/mekhela-drapes.png',
            caption: l10n.csG0ThreeCaption,
          ),
        GuideStep(
          title: l10n.csG0AlignTitle,
          subtitle: l10n.csG0AlignSub,
          diagram: 'grid',
          referenceAsset: '$_guides/kal-hung-rod.jpg',
        ),
        GuideStep(
          title: l10n.csGoodExamples,
          subtitle: l10n.csG0ExSub,
          gallery: const [
            '$_guides/ex-full-form.jpg',
            '$_guides/ex-full-dark.jpg',
            '$_guides/ex-full-spread.jpg',
          ],
        ),
      ];
    case 1:
      return [
        GuideStep(
          title: l10n.csG1SpanTitle,
          subtitle: l10n.csG1SpanSub,
          diagram: 'dist',
          referenceAsset: '$_guides/stole-flatlay.png',
        ),
        GuideStep(
          title: l10n.csG1RakeTitle,
          subtitle: l10n.csG1RakeSub,
          diagram: 'rake',
          referenceAsset: '$_guides/stole-flatlay.png',
        ),
        GuideStep(
          title: l10n.csG1WindowTitle,
          subtitle: l10n.csG1WindowSub,
          imageAsset: '$_guides/stole-flatlay.png',
          caption: l10n.csG1WindowCaption,
        ),
        GuideStep(
          title: l10n.csG1FrameTitle,
          subtitle: l10n.csG1FrameSub,
          diagram: 'close',
          referenceAsset: '$_guides/ex-close-motif.jpg',
        ),
        GuideStep(
          title: l10n.csGoodExamples,
          subtitle: l10n.csG1ExSub,
          gallery: const [
            '$_guides/ex-close-motif.jpg',
            '$_guides/ex-border-flat.jpg',
          ],
        ),
      ];
    case 2:
      if (isSari) {
        return [
          GuideStep(
            title: l10n.csG2ChairTitle,
            subtitle: l10n.csG2SariChairSub,
            diagram: 'chair',
            referenceAsset: '$_guides/cs_cam_ref_2_sari_chair.jpg',
          ),
          if (isAssam)
            GuideStep(
              title: l10n.csG2ChairLikeTitle,
              subtitle: l10n.csG2SariChairLikeSub,
              imageAsset: '$_guides/cs_cam_ref_2_sari_chair.jpg',
              caption: l10n.csG2SariChairCaption,
            ),
          GuideStep(
            title: l10n.csGoodExamples,
            subtitle: l10n.csG2SariChairExSub,
            gallery: const [
              '$_guides/cs_cam_ref_2_sari_chair.jpg',
              'assets/images/clusters/kamrup/sari/cotton/woven/draped_look.jpg',
              'assets/images/clusters/kamrup/sari/mulberry/woven/draped_look.jpg',
            ],
          ),
        ];
      }
      if (isMekhela) {
        return [
          GuideStep(
            title: l10n.csG2ChairTitle,
            subtitle: l10n.csG2ChairSub,
            diagram: 'chair',
            referenceAsset: '$_guides/cs_cam_ref_2_chair.jpg',
          ),
          if (isAssam)
            GuideStep(
              title: l10n.csG2ChairLikeTitle,
              subtitle: l10n.csG2ChairLikeSub,
              imageAsset: '$_guides/cs_cam_ref_2_chair.jpg',
              caption: l10n.csG2ChairCaption,
            ),
          GuideStep(
            title: l10n.csGoodExamples,
            subtitle: l10n.csG2ChairExSub,
            gallery: const [
              '$_guides/cs_cam_ref_2_chair.jpg',
              '$_guides/ex-drape-chair.jpg',
              '$_guides/ex-drape-chair-pink.jpg',
            ],
          ),
        ];
      }
      return [
        GuideStep(
          title: l10n.csG2PersonTitle,
          subtitle: l10n.csG2PersonSub,
          diagram: 'worn',
          referenceAsset: '$_guides/cs_cam_ref_2.jpg',
        ),
        if (isAssam)
          GuideStep(
            title: l10n.csG2PersonLikeTitle,
            subtitle: l10n.csG2PersonLikeSub,
            imageAsset: '$_guides/ex-drape-worn.jpg',
            caption: l10n.csG2PersonCaption,
          ),
        GuideStep(
          title: l10n.csGoodExamples,
          subtitle: l10n.csG2PersonExSub,
          gallery: const [
            '$_guides/cs_cam_ref_2.jpg',
            '$_guides/ex-drape-worn.jpg',
            '$_guides/ex-drape-pleats.jpg',
          ],
        ),
      ];
    case 3:
      return [
        GuideStep(
          title: l10n.csG3FindTitle,
          subtitle: detailTip,
          diagram: 'border',
          referenceAsset: '$_guides/ex-border-folds.jpg',
        ),
        GuideStep(
          title: l10n.csG3MotifTitle,
          subtitle: l10n.csG3MotifSub,
          diagram: 'gridmotif',
          referenceAsset: '$_guides/ex-close-motif.jpg',
        ),
        GuideStep(
          title: l10n.csGoodExamples,
          subtitle: l10n.csG3ExSub,
          gallery: const [
            '$_guides/ex-border-folds.jpg',
            '$_guides/ex-border-flat.jpg',
          ],
        ),
      ];
    case 4:
      if (isSari) {
        return [
          GuideStep(
            title: l10n.csG4SariTitle,
            subtitle: l10n.csG4SariSub,
            diagram: 'foldmid',
            referenceAsset: '$_guides/cs_cam_ref_4_sari.jpg',
          ),
          GuideStep(
            title: l10n.csG4SariBorderTitle,
            subtitle: l10n.csG4SariBorderSub,
            imageAsset: '$_guides/cs_cam_ref_4_sari.jpg',
            caption: l10n.csG4SariCaption,
          ),
          GuideStep(
            title: l10n.csGoodExamples,
            subtitle: l10n.csG4SariExSub,
            gallery: const [
              '$_guides/cs_cam_ref_4_sari.jpg',
              'assets/images/clusters/kamrup/sari/cotton/woven/folded_stack.jpg',
              'assets/images/clusters/kamrup/sari/mulberry/woven/folded_stack.jpg',
            ],
          ),
        ];
      }
      return [
        GuideStep(
          title: l10n.csG4MidTitle,
          subtitle: l10n.csG4MidSub,
          diagram: 'foldmid',
        ),
        GuideStep(
          title: l10n.csG4CornerTitle,
          subtitle: l10n.csG4CornerSub,
          diagram: 'folddiag',
          referenceAsset: '$_guides/ex-folded-layers.jpg',
        ),
        GuideStep(
          title: l10n.csGoodExamples,
          subtitle: l10n.csG4ExSub,
          gallery: const [
            '$_guides/ex-folded-layers.jpg',
            '$_guides/ex-folded-basket.jpg',
          ],
        ),
      ];
    case 5:
      return [
        GuideStep(
          title: l10n.csG5ObjTitle,
          subtitle: l10n.csG5ObjSub,
          diagram: 'scale',
          referenceAsset: '$_guides/ex-folded-basket.jpg',
        ),
        GuideStep(
          title: l10n.csG5CrossTitle,
          subtitle: l10n.csG5CrossSub,
          diagram: 'gridthirds',
          referenceAsset: '$_guides/ex-folded-basket.jpg',
        ),
      ];
    case 6:
      return [
        GuideStep(
          title: l10n.csG6FlatTitle,
          subtitle: l10n.csG6FlatSub,
          diagram: 'flatprops',
          referenceAsset: '$_guides/ex-folded-basket.jpg',
        ),
        GuideStep(
          title: l10n.csG6AboveTitle,
          subtitle: l10n.csG6AboveSub,
          diagram: 'grid',
          referenceAsset: '$_guides/ex-folded-basket.jpg',
        ),
        GuideStep(
          title: l10n.csGoodExample,
          subtitle: l10n.csG6ExSub,
          gallery: const [
            '$_guides/ex-folded-basket.jpg',
            '$_guides/stole-flatlay.png',
          ],
        ),
      ];
    case 7:
      return [
        GuideStep(
          title: l10n.csG7UseTitle,
          subtitle: l10n.csG7UseSub,
          diagram: 'drape',
          referenceAsset: '$_guides/ex-drape-chair.jpg',
        ),
        GuideStep(
          title: l10n.csG7EyeTitle,
          subtitle: l10n.csG7EyeSub,
          diagram: 'gridthirds',
          referenceAsset: '$_guides/ex-drape-chair.jpg',
        ),
        GuideStep(
          title: l10n.csGoodExamples,
          subtitle: l10n.csG7ExSub,
          gallery: const [
            '$_guides/ex-drape-chair.jpg',
            '$_guides/ex-drape-chair-pink.jpg',
          ],
        ),
      ];
    case 8:
      return [
        GuideStep(
          title: l10n.csG8HangTitle,
          subtitle: l10n.csG8HangSub,
          diagram: 'hang',
          referenceAsset: '$_guides/kal-hung-rod.jpg',
        ),
        GuideStep(
          title: l10n.csG8FringeTitle,
          subtitle: l10n.csG8FringeSub,
          diagram: 'drape',
          referenceAsset: '$_guides/stole-hung.webp',
        ),
      ];
    case 9:
      return [
        GuideStep(
          title: l10n.csG9MacroTitle,
          subtitle: l10n.csG9MacroSub,
          diagram: 'close',
          referenceAsset: '$_guides/kal-drape-close.jpg',
        ),
        GuideStep(
          title: l10n.csG9DiagTitle,
          subtitle: l10n.csG9DiagSub,
          diagram: 'diagline',
          referenceAsset: '$_guides/kal-pen-bw.jpg',
        ),
        GuideStep(
          title: l10n.csGoodExample,
          subtitle: l10n.csG9ExSub,
          gallery: const [
            '$_guides/kal-drape-close.jpg',
            '$_guides/kal-pen-bw.jpg',
          ],
        ),
      ];
    case 10:
      return [
        GuideStep(
          title: l10n.csG10HandsTitle,
          subtitle: l10n.csG10HandsSub,
          diagram: 'close',
          referenceAsset: '$_guides/making-assam.jpg',
        ),
        GuideStep(
          title: l10n.csG10StoryTitle,
          subtitle: l10n.csG10StorySub,
          gallery: making,
        ),
      ];
    case 11:
      return [
        GuideStep(
          title: l10n.csG11WallTitle,
          subtitle: l10n.csG11WallSub,
          diagram: 'hang',
          referenceAsset: '$_guides/kal-scroll-hang.jpg',
        ),
        GuideStep(
          title: l10n.csG11SquareTitle,
          subtitle: l10n.csG11SquareSub,
          diagram: 'grid',
          referenceAsset: '$_guides/kal-panel-tree.jpg',
        ),
        GuideStep(
          title: l10n.csG11RoomTitle,
          subtitle: l10n.csG11RoomSub,
          gallery: const [
            '$_guides/kal-framed-sofa.jpg',
            '$_guides/kal-framed-dining.jpg',
            '$_guides/kal-scroll-hang.jpg',
            '$_guides/kal-gallery-wall.jpg',
          ],
        ),
      ];
    default:
      return const [];
  }
}
