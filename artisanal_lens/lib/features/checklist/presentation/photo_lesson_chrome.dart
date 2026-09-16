import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';

/// HTML photography lesson chrome: LESSON 01 header + 7 segment bar.
///
/// Non-panel sequence: product → material → technique → frames → framing →
/// light → shoot (steps 0,1,2,4,5,6,7). Panel skips material + technique.
class PhotoLessonChrome extends StatelessWidget {
  const PhotoLessonChrome({
    required this.stepIndex,
    required this.child,
    this.isPanel = false,
    this.onBack,
    super.key,
  });

  /// Index into the active photo sequence (0-based).
  final int stepIndex;
  final bool isPanel;
  final Widget child;
  final VoidCallback? onBack;

  /// HTML `photoSegs` step ids.
  List<int> get _seq =>
      isPanel ? const [0, 4, 5, 6, 7] : const [0, 1, 2, 4, 5, 6, 7];

  void _defaultBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.goNamed(AppRoute.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final seq = _seq;
    final at = stepIndex.clamp(0, seq.length - 1);
    final currentStepId = seq[at];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.divider, width: 2),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBack ?? () => _defaultBack(context),
                    icon: const Icon(Icons.chevron_left, size: 28),
                    color: AppColors.textPrimary,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.csLesson01Overline,
                          style: AppTypography.navLabel.copyWith(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          l10n.csLesson01Title,
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${at + 1}/${seq.length}',
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  for (final stepId in seq) ...[
                    Expanded(
                      child: Container(
                        height: 5,
                        color: stepId <= currentStepId
                            ? AppColors.primary
                            : AppColors.surfaceMuted,
                      ),
                    ),
                    if (stepId != seq.last) const SizedBox(width: 4),
                  ],
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

/// HTML-style selectable text chip (no images).
class PhotoChoiceChip extends StatelessWidget {
  const PhotoChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.minHeight = 60,
    this.fontSize = 12,
    this.letterSpacing = 0,
    this.fontWeight = FontWeight.w600,
    this.useHeadingFont = false,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double minHeight;
  final double fontSize;
  final double letterSpacing;
  final FontWeight fontWeight;
  final bool useHeadingFont;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : AppColors.white,
          border: Border.all(color: AppColors.textPrimary, width: 2),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: (useHeadingFont
                  ? AppTypography.displayMedium
                  : AppTypography.labelLarge)
              .copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            color: selected ? AppColors.white : AppColors.textPrimary,
            height: 1.15,
          ),
        ),
      ),
    );
  }
}
