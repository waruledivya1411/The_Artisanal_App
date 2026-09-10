/// The twelve shared photography frames of the Click & Social lesson.
///
/// Ported from the HTML prototype (`shotDefs`, `frameDescs`, `frameImgs`,
/// `archOf`, `guideDefs`). Unlike the BTP photography templates, this list is
/// the same for every category — what changes is which frames the learner
/// picks, and which reference photographs the guide shows for their cluster.
library;

import '../../domain/entities/fabric_property.dart';
import '../../domain/entities/photography_guideline.dart';
import '../../domain/entities/photography_template.dart';
import '../../domain/entities/technique_preset.dart';
import '../home/click_social_clusters.dart';

/// Where the extracted HTML reference photographs live.
const String _guides = 'assets/images/guides';

/// Framing-quiz archetypes from Click & Social HTML (`archOf`).
enum FrameArch { thirds, center, diag, detail }

/// One page of a frame's multi-step guide (HTML `guideDefs` entry).
///
/// A step draws either a [diagram], a single [imageAsset], or a [gallery] —
/// never more than one — and may add a [caption] underneath.
class GuideStep {
  const GuideStep({
    required this.title,
    required this.subtitle,
    this.diagram,
    this.imageAsset,
    this.gallery,
    this.caption,
  });

  /// HTML `t`.
  final String title;

  /// HTML `s`.
  final String subtitle;

  /// HTML `d`: hang, drape, grid, dist, rake, close, border, foldmid, folddiag.
  final String? diagram;

  /// HTML `img`.
  final String? imageAsset;

  /// HTML `gal`.
  final List<String>? gallery;

  /// HTML `cap`.
  final String? caption;

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

  GridOverlayType get grid => switch (arch) {
        FrameArch.thirds => GridOverlayType.ruleOfThirds,
        FrameArch.center => GridOverlayType.centerFocus,
        FrameArch.diag => GridOverlayType.leadingLines,
        FrameArch.detail => GridOverlayType.detailFrame,
      };

  /// HTML `shotDefs[i][1]` — content plus the grid, as shown on the checklist.
  String tipFor({String? clusterId}) {
    // Frame 3 leads with the cluster's own detail tip instead of the content.
    final head = index == 3 ? clickSocialDetailTip(clusterId) : content;
    return '$head · $tipDetail';
  }

  /// HTML `frameImgs[i]` — Kalamkari clusters swap in their own reference set.
  String thumbAssetFor({
    String? clusterId,
    String? categoryId,
    String? technique,
  }) {
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
    required bool isAssam,
    required bool isKal,
    required String? clusterId,
    required String? productLabel,
    required String? technique,
  }) {
    final steps = <GuideStep>[
      ..._baseGuideSteps(
        index,
        isAssam: isAssam,
        detailTip: clickSocialDetailTip(clusterId),
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
          title: 'Good examples',
          subtitle: 'Kalamkari, photographed well',
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
      );
    }
    return steps;
  }
}

/// The twelve frames, in HTML order. Index is the persisted identity.
const clickSocialFrames = <ClickSocialFrame>[
  ClickSocialFrame(
    index: 0,
    name: 'Full display',
    content: 'Colour, pattern, material',
    thumbAsset: '$_guides/ex-full-form.jpg',
    arch: FrameArch.thirds,
    tipDetail: 'rule of thirds grid',
  ),
  ClickSocialFrame(
    index: 1,
    name: 'Close-up texture',
    content: 'Texture, thickness, material',
    thumbAsset: '$_guides/ex-close-motif.jpg',
    arch: FrameArch.center,
    tipDetail: 'center focus grid',
  ),
  ClickSocialFrame(
    index: 2,
    name: 'Draped look',
    content: 'Flimsiness, sheen, flow, weight',
    thumbAsset: '$_guides/ex-drape-pleats.jpg',
    arch: FrameArch.diag,
    tipDetail: 'leading lines grid',
  ),
  ClickSocialFrame(
    index: 3,
    name: 'Embroidery & border',
    content: 'Embroidery and quality',
    thumbAsset: '$_guides/ex-border-folds.jpg',
    arch: FrameArch.detail,
    tipDetail: 'detail frame grid',
  ),
  ClickSocialFrame(
    index: 4,
    name: 'Folded stack',
    content: 'Thickness and material',
    thumbAsset: '$_guides/ex-folded-layers.jpg',
    arch: FrameArch.detail,
    tipDetail: 'horizontal & diagonal grid',
  ),
  ClickSocialFrame(
    index: 5,
    name: 'Scale reference',
    content: 'Size, proportion, length',
    thumbAsset: '$_guides/ex-drape-chair-pink.jpg',
    arch: FrameArch.thirds,
    tipDetail: 'rule of thirds + reference',
  ),
  ClickSocialFrame(
    index: 6,
    name: 'Styled flat lay',
    content: 'Styling, colour, use-case',
    thumbAsset: '$_guides/stole-flatlay.png',
    arch: FrameArch.center,
    tipDetail: 'symmetric grid + props',
  ),
  ClickSocialFrame(
    index: 7,
    name: 'In-context lifestyle',
    content: 'Application, ambience',
    thumbAsset: '$_guides/ex-drape-chair.jpg',
    arch: FrameArch.thirds,
    tipDetail: 'eye-level rule of thirds',
  ),
  ClickSocialFrame(
    index: 8,
    name: 'Hanging display',
    content: 'Drape, symmetry, fringe',
    thumbAsset: '$_guides/stole-hung.webp',
    arch: FrameArch.center,
    tipDetail: 'center vertical axis',
  ),
  ClickSocialFrame(
    index: 9,
    name: 'Macro fringe detail',
    content: 'Hand-finishing, craft',
    thumbAsset: '$_guides/ex-border-flat.jpg',
    arch: FrameArch.diag,
    tipDetail: 'diagonal close-up grid',
  ),
  ClickSocialFrame(
    index: 10,
    name: 'The making',
    content: 'Process, hands, tools',
    thumbAsset: '$_guides/making-assam.jpg',
    arch: FrameArch.thirds,
    tipDetail: 'rule of thirds',
  ),
  ClickSocialFrame(
    index: 11,
    name: 'Framed display',
    content: 'Presentation, wall-ready',
    thumbAsset: '$_guides/kal-panel-tree.jpg',
    arch: FrameArch.center,
    tipDetail: 'square-on, no glare · symmetric grid',
  ),
];

/// HTML `panelFrames` — a Kalamkari panel only offers these three.
const clickSocialPanelFrames = <int>[0, 11, 10];

/// HTML fallback when the learner picked nothing at the checklist.
const clickSocialDefaultFrames = <int>[0, 1, 2, 3, 4];

/// Frames offered on Pick your frames.
///
/// HTML: a panel is limited to [clickSocialPanelFrames]; everything else hides
/// frame 11, which only makes sense for a wall-hung painting.
List<ClickSocialFrame> framesForSelection({required bool isPanel}) => [
      for (final frame in clickSocialFrames)
        if (isPanel
            ? clickSocialPanelFrames.contains(frame.index)
            : frame.index != 11)
          frame,
    ];

ClickSocialFrame? frameByIndex(int i) {
  for (final frame in clickSocialFrames) {
    if (frame.index == i) return frame;
  }
  return null;
}

/// HTML `archOf` — which framing quiz a frame belongs to.
FrameArch archForFrameIndex(int i) =>
    frameByIndex(i)?.arch ?? FrameArch.thirds;

/// The frames actually shot for a set: the learner's picks, or the HTML default.
List<int> resolveFramePicks(List<int> picks, {required bool isPanel}) {
  if (picks.isEmpty) {
    return isPanel ? clickSocialPanelFrames : clickSocialDefaultFrames;
  }
  final sorted = picks.where((i) => frameByIndex(i) != null).toList()..sort();
  if (sorted.isEmpty) {
    return isPanel ? clickSocialPanelFrames : clickSocialDefaultFrames;
  }
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

/// HTML `isPanel` — a hand-painted Kalamkari panel.
bool clickSocialIsPanel({String? categoryId, String? technique}) =>
    categoryId == 'cushion_cover' &&
    (technique ?? '').toUpperCase() == 'HAND-PAINTED';

/// HTML `isKal` — hand-painted work, or anyone from Srikalahasti.
bool clickSocialIsKal({String? clusterId, String? technique}) =>
    (technique ?? '').toUpperCase() == 'HAND-PAINTED' ||
    clusterId == 'srikalahasti';

bool clickSocialIsAssam(String? clusterId) => clusterId == 'assam';

/// HTML `cluster.detailTip`, with the Assam wording as the fallback.
String clickSocialDetailTip(String? clusterId) =>
    clusterById(clusterId)?.detailTip ??
    'Close on the border — that is where the handwork shows';

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
/// `beginCaptureForSlot` goes straight from here to Lighting, then the camera.
PhotographyTemplate asTemplate(ClickSocialFrame f, {String? thumbAsset}) {
  final steps = _baseGuideSteps(
    f.index,
    isAssam: false,
    detailTip: clickSocialDetailTip(null),
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
    referenceImageAsset: thumbAsset ?? f.thumbAsset,
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
List<GuideStep> _baseGuideSteps(
  int index, {
  required bool isAssam,
  required String detailTip,
  required List<String> making,
}) {
  switch (index) {
    case 0:
      return [
        const GuideStep(
          title: 'Hang the whole piece',
          subtitle: 'Bamboo rod or dress form · plain wall behind',
          diagram: 'hang',
        ),
        if (isAssam)
          const GuideStep(
            title: 'Three ways to style it',
            subtitle: 'Pick one look and keep it for every product',
            imageAsset: '$_guides/mekhela-drapes.png',
            caption:
                'Mekhela sador on a dress form — full display, three drape '
                'styles.',
          ),
        const GuideStep(
          title: 'Align with the gridlines',
          subtitle: 'Edges along the lines · borders straight',
          diagram: 'grid',
        ),
        const GuideStep(
          title: 'Good examples',
          subtitle: 'Whole piece in frame — on a form, a chair, or spread flat',
          gallery: [
            '$_guides/ex-full-form.jpg',
            '$_guides/ex-full-dark.jpg',
            '$_guides/ex-full-spread.jpg',
          ],
        ),
      ];
    case 1:
      return const [
        GuideStep(
          title: 'One hand-span away',
          subtitle: 'Hold the phone 15–30 cm above the fabric — close enough '
              'to count threads',
          diagram: 'dist',
        ),
        GuideStep(
          title: 'Rake the light across',
          subtitle: 'Light from one side, low at about 30° — the tiny shadows '
              'make the weave stand up',
          diagram: 'rake',
        ),
        GuideStep(
          title: 'Like this — window light',
          subtitle: 'Flat on a mat · light raking in from one side',
          imageAsset: '$_guides/stole-flatlay.png',
          caption: 'See the shadows in the tassels and motifs — that is the '
              '30° raking light doing the work.',
        ),
        GuideStep(
          title: 'Frame the detail',
          subtitle: 'Fill the centre box · edges parallel',
          diagram: 'close',
        ),
        GuideStep(
          title: 'Good examples',
          subtitle: 'So close you can count the threads',
          gallery: [
            '$_guides/ex-close-motif.jpg',
            '$_guides/ex-border-flat.jpg',
          ],
        ),
      ];
    case 2:
      return [
        const GuideStep(
          title: 'Throw one end over',
          subtitle: 'Let it fall in natural folds',
          diagram: 'drape',
        ),
        if (isAssam)
          const GuideStep(
            title: 'Like this — on a form',
            subtitle: 'A dark background makes pale silk glow',
            imageAsset: '$_guides/stole-hung.webp',
            caption: 'Stole draped on a dress form against black.',
          ),
        const GuideStep(
          title: 'Good examples',
          subtitle: 'Pleats falling free — or over the back of a chair',
          gallery: [
            '$_guides/ex-drape-pleats.jpg',
            '$_guides/ex-drape-chair.jpg',
            '$_guides/ex-drape-chair-pink.jpg',
          ],
        ),
      ];
    case 3:
      return [
        GuideStep(
          title: 'Find the border',
          subtitle: detailTip,
          diagram: 'border',
        ),
        const GuideStep(
          title: 'Motif on a crossing point',
          subtitle: 'Use the grid — motif where lines cross',
          diagram: 'grid',
        ),
        const GuideStep(
          title: 'Good examples',
          subtitle: 'Border filling the frame, folds giving it depth',
          gallery: [
            '$_guides/ex-border-folds.jpg',
            '$_guides/ex-border-flat.jpg',
          ],
        ),
      ];
    case 4:
      return const [
        GuideStep(
          title: 'Fold from the middle',
          subtitle: 'Flat on the floor · fold in half',
          diagram: 'foldmid',
        ),
        GuideStep(
          title: 'Fold a corner back',
          subtitle: 'The folded edge shows the thickness',
          diagram: 'folddiag',
        ),
        GuideStep(
          title: 'Good examples',
          subtitle: 'Folded stacks — layers show body and weight',
          gallery: [
            '$_guides/ex-folded-layers.jpg',
            '$_guides/ex-folded-basket.jpg',
          ],
        ),
      ];
    case 5:
      return const [
        GuideStep(
          title: 'Add a familiar object',
          subtitle: 'A bangle, coin or pen beside the piece shows true size',
          diagram: 'grid',
        ),
        GuideStep(
          title: 'Object on a crossing point',
          subtitle: 'Piece fills the frame · reference on a thirds line',
          diagram: 'grid',
        ),
      ];
    case 6:
      return const [
        GuideStep(
          title: 'Lay it flat, style around it',
          subtitle: 'Fold neatly · add 1–2 props: flowers, a cup, thread',
          diagram: 'foldmid',
        ),
        GuideStep(
          title: 'Shoot from directly above',
          subtitle: 'Keep the piece centred and edges parallel to the frame',
          diagram: 'grid',
        ),
        GuideStep(
          title: 'Good example',
          subtitle: 'Flat lay in window light',
          gallery: [
            '$_guides/stole-flatlay.png',
            '$_guides/ex-folded-basket.jpg',
          ],
        ),
      ];
    case 7:
      return const [
        GuideStep(
          title: 'Show it in use',
          subtitle: 'Worn, on a bed, on a table — where it lives',
          diagram: 'drape',
        ),
        GuideStep(
          title: 'Eye level, thirds grid',
          subtitle: 'Camera at eye height · subject on a thirds line',
          diagram: 'grid',
        ),
        GuideStep(
          title: 'Good examples',
          subtitle: 'Draped over a chair — at home in a room',
          gallery: [
            '$_guides/ex-drape-chair.jpg',
            '$_guides/ex-drape-chair-pink.jpg',
          ],
        ),
      ];
    case 8:
      return const [
        GuideStep(
          title: 'Hang it dead centre',
          subtitle: 'Rod or hanger · piece on the center vertical axis',
          diagram: 'hang',
        ),
        GuideStep(
          title: 'Let the fringe hang free',
          subtitle: 'Straighten the tassels · keep both edges symmetric',
          diagram: 'drape',
        ),
      ];
    case 9:
      return const [
        GuideStep(
          title: 'Go macro on the fringe',
          subtitle: 'As close as your phone will focus · tassels and knots',
          diagram: 'close',
        ),
        GuideStep(
          title: 'Use the diagonal',
          subtitle: 'Run the fringe along the diagonal line',
          diagram: 'folddiag',
        ),
        GuideStep(
          title: 'Good example',
          subtitle: 'Border and finishing, thread-close',
          gallery: [
            '$_guides/ex-border-flat.jpg',
            '$_guides/ex-close-motif.jpg',
          ],
        ),
      ];
    case 10:
      return [
        const GuideStep(
          title: 'Show your hands at work',
          subtitle: 'Kalam, brush or shuttle in motion · window light on the '
              'work',
          diagram: 'close',
        ),
        GuideStep(
          title: 'Buyers pay for the story',
          subtitle: 'A making photo proves it is handmade — post one for every '
              'piece',
          gallery: making,
        ),
      ];
    case 11:
      return const [
        GuideStep(
          title: 'Hang it straight, eye height',
          subtitle: 'On a plain wall · daylight from the side of the room, '
              'never flash',
          diagram: 'hang',
        ),
        GuideStep(
          title: 'Shoot square-on',
          subtitle: 'Phone parallel to the wall · panel edges parallel to the '
              'frame lines',
          diagram: 'grid',
        ),
        GuideStep(
          title: 'Show it in a room',
          subtitle: 'Framed, or on a scroll rod — buyers see it in their own '
              'home',
          gallery: [
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
