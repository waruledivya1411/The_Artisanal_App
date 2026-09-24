import 'package:flutter/material.dart';

import '../../domain/entities/technique_preset.dart';
import '../../l10n/app_copy.dart';
import 'click_social_frames.dart';

export 'click_social_frames.dart' show FrameArch;

/// One quiz answer — where the product sits in the camera viewfinder.
///
/// Same product photo in every option; only [alignment] + [sizeFactor] change
/// so the learner can see wrong vs right framing at a glance.
class FramingOption {
  const FramingOption({
    required this.alignment,
    required this.sizeFactor,
    required this.correct,
  });

  /// Where the product sits inside the frame (−1..1).
  final Alignment alignment;

  /// How much of the viewfinder the product object fills (~0.3–0.5).
  /// Keep it under ~half the frame so grid placement is readable.
  final double sizeFactor;

  final bool correct;
}

class FramingArchDef {
  const FramingArchDef({required this.gridPath, required this.options});

  /// HTML `archDefs.*.grid` in a 120×64 viewBox.
  final String gridPath;

  final List<FramingOption> options;
}

const framingArchDefs = <FrameArch, FramingArchDef>{
  FrameArch.thirds: FramingArchDef(
    gridPath: 'M40 0v64M80 0v64M0 21.3h120M0 42.6h120',
    options: [
      // Dead centre — common mistake
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.62,
        correct: false,
      ),
      // On the lower-right thirds intersection
      FramingOption(
        alignment: Alignment(0.52, 0.4),
        sizeFactor: 0.58,
        correct: true,
      ),
      // Cramped in the top-left corner
      FramingOption(
        alignment: Alignment(-0.82, -0.78),
        sizeFactor: 0.4,
        correct: false,
      ),
    ],
  ),
  FrameArch.center: FramingArchDef(
    gridPath: 'M40 12h40v40h-40zM60 0v12M60 52v64',
    options: [
      // Too small / far in a corner
      FramingOption(
        alignment: Alignment(-0.82, -0.75),
        sizeFactor: 0.36,
        correct: false,
      ),
      // Fills the centre box
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.68,
        correct: true,
      ),
      // Half cut off at the edge
      FramingOption(
        alignment: Alignment(1.0, 0.35),
        sizeFactor: 0.55,
        correct: false,
      ),
    ],
  ),
  FrameArch.diag: FramingArchDef(
    gridPath: 'M0 64L120 0M0 40L45 0',
    options: [
      // Flat / centred — no leading line
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.6,
        correct: false,
      ),
      // Angled through the frame along the diagonal
      FramingOption(
        alignment: Alignment(0.18, -0.12),
        sizeFactor: 0.56,
        correct: true,
      ),
      // Crowded into one corner
      FramingOption(
        alignment: Alignment(-0.82, 0.75),
        sizeFactor: 0.38,
        correct: false,
      ),
    ],
  ),
  FrameArch.detail: FramingArchDef(
    gridPath: 'M0 42h120M62 6h46v26h-46z',
    options: [
      // Only a thin strip at the bottom
      FramingOption(
        alignment: Alignment(0, 0.92),
        sizeFactor: 0.36,
        correct: false,
      ),
      // Detail sits in the focus box with room around it
      FramingOption(
        alignment: Alignment(0.48, -0.22),
        sizeFactor: 0.52,
        correct: true,
      ),
      // Random mid blob — neither border nor story
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.45,
        correct: false,
      ),
    ],
  ),
};

/// Localized view over a [FramingArchDef]: the const data holds the geometry,
/// this resolves every string against the active locale.
class LocalizedFramingArch {
  const LocalizedFramingArch(this._l10n, this.arch, this._def);

  final AppLocalizations _l10n;
  final FrameArch arch;
  final FramingArchDef _def;

  List<FramingOption> get options => _def.options;

  String get gridPath => _def.gridPath;

  String get title => switch (arch) {
        FrameArch.thirds => _l10n.csFramingThirdsTitle,
        FrameArch.center => _l10n.csFramingCenterTitle,
        FrameArch.diag => _l10n.csFramingDiagTitle,
        FrameArch.detail => _l10n.csFramingDetailTitle,
      };

  String get sub => switch (arch) {
        FrameArch.thirds => _l10n.csFramingThirdsSub,
        FrameArch.center => _l10n.csFramingCenterSub,
        FrameArch.diag => _l10n.csFramingDiagSub,
        FrameArch.detail => _l10n.csFramingDetailSub,
      };

  /// Feedback shown after tapping option [optionIndex].
  String messageAt(int optionIndex) => switch ((arch, optionIndex)) {
        (FrameArch.thirds, 0) => _l10n.csFramingThirdsMsg0,
        (FrameArch.thirds, 1) => _l10n.csFramingThirdsMsg1,
        (FrameArch.thirds, _) => _l10n.csFramingThirdsMsg2,
        (FrameArch.center, 0) => _l10n.csFramingCenterMsg0,
        (FrameArch.center, 1) => _l10n.csFramingCenterMsg1,
        (FrameArch.center, _) => _l10n.csFramingCenterMsg2,
        (FrameArch.diag, 0) => _l10n.csFramingDiagMsg0,
        (FrameArch.diag, 1) => _l10n.csFramingDiagMsg1,
        (FrameArch.diag, _) => _l10n.csFramingDiagMsg2,
        (FrameArch.detail, 0) => _l10n.csFramingDetailMsg0,
        (FrameArch.detail, 1) => _l10n.csFramingDetailMsg1,
        (FrameArch.detail, _) => _l10n.csFramingDetailMsg2,
      };
}

/// Localized copy plus geometry for [arch].
LocalizedFramingArch localizedFramingArch(
  AppLocalizations l10n,
  FrameArch arch,
) =>
    LocalizedFramingArch(l10n, arch, framingArchDefs[arch]!);

/// Maps a photography-template grid to the HTML framing-quiz archetype.
FrameArch frameArchForGrid(GridOverlayType grid) => switch (grid) {
      GridOverlayType.ruleOfThirds => FrameArch.thirds,
      GridOverlayType.centerFocus => FrameArch.center,
      GridOverlayType.leadingLines => FrameArch.diag,
      GridOverlayType.detailFrame => FrameArch.detail,
      GridOverlayType.horizontalFolds => FrameArch.detail,
    };

/// Unique framing quizzes for the frames the learner picked (HTML `fqArchs`).
///
/// Frame indexes are Click & Social frame indexes (0..11), mapped through the
/// HTML `archOf` table — not positions in a BTP template list.
List<FrameArch> framingSequenceForPicks({
  required String categoryId,
  required List<int> pickedIndexes,
}) {
  final indexes = pickedIndexes.isEmpty
      ? clickSocialDefaultFrames
      : pickedIndexes;

  final seen = <FrameArch>{};
  final out = <FrameArch>[];
  for (final i in indexes) {
    if (frameByIndex(i) == null) continue;
    final arch = archForFrameIndex(i);
    if (seen.add(arch)) out.add(arch);
  }
  return out.isEmpty ? [FrameArch.thirds] : out;
}

/// The picked frames that belong to [arch], for the quiz overline.
String frameNamesForArch({
  required AppLocalizations l10n,
  required String categoryId,
  required List<int> pickedIndexes,
  required FrameArch arch,
}) {
  final indexes = pickedIndexes.isEmpty
      ? clickSocialDefaultFrames
      : pickedIndexes;
  final names = <String>[];
  for (final i in indexes) {
    final frame = frameByIndex(i);
    if (frame != null && frame.arch == arch) names.add(frame.name);
  }
  return names.join(' · ').toUpperCase();
}
