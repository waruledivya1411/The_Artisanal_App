import 'package:flutter/material.dart';

import '../../domain/entities/technique_preset.dart';
import '../../l10n/app_copy.dart';
import 'click_social_frames.dart';

export 'click_social_frames.dart' show FrameArch;

/// One quiz answer. Geometry only — the copy lives in [LocalizedFramingArch].
class FramingOption {
  const FramingOption({required this.rects, required this.correct});

  /// Rects in a 120×64 coordinate space.
  final List<Rect> rects;
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
      FramingOption(
        rects: [Rect.fromLTWH(50, 22, 20, 20)],
        correct: false,
      ),
      FramingOption(
        rects: [Rect.fromLTWH(70, 32.6, 20, 20)],
        correct: true,
      ),
      FramingOption(
        rects: [Rect.fromLTWH(1, 1, 20, 20)],
        correct: false,
      ),
    ],
  ),
  FrameArch.center: FramingArchDef(
    gridPath: 'M40 12h40v40h-40zM60 0v12M60 52v64',
    options: [
      FramingOption(
        rects: [Rect.fromLTWH(4, 4, 16, 16)],
        correct: false,
      ),
      FramingOption(
        rects: [Rect.fromLTWH(42, 14, 36, 36)],
        correct: true,
      ),
      FramingOption(
        rects: [Rect.fromLTWH(104, 40, 20, 20)],
        correct: false,
      ),
    ],
  ),
  FrameArch.diag: FramingArchDef(
    gridPath: 'M0 64L120 0M0 40L45 0',
    options: [
      FramingOption(
        rects: [
          Rect.fromLTWH(18, 24, 16, 16),
          Rect.fromLTWH(52, 24, 16, 16),
          Rect.fromLTWH(86, 24, 16, 16),
        ],
        correct: false,
      ),
      FramingOption(
        rects: [
          Rect.fromLTWH(18, 42, 16, 16),
          Rect.fromLTWH(52, 25, 16, 16),
          Rect.fromLTWH(86, 8, 16, 16),
        ],
        correct: true,
      ),
      FramingOption(
        rects: [
          Rect.fromLTWH(2, 44, 16, 16),
          Rect.fromLTWH(14, 30, 16, 16),
        ],
        correct: false,
      ),
    ],
  ),
  FrameArch.detail: FramingArchDef(
    gridPath: 'M0 42h120M62 6h46v26h-46z',
    options: [
      FramingOption(
        rects: [Rect.fromLTWH(0, 56, 120, 6)],
        correct: false,
      ),
      FramingOption(
        rects: [
          Rect.fromLTWH(0, 44, 120, 20),
          Rect.fromLTWH(64, 8, 42, 22),
        ],
        correct: true,
      ),
      FramingOption(
        rects: [Rect.fromLTWH(50, 22, 20, 20)],
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
