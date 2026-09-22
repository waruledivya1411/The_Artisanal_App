import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/motion/motion.dart';

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
    this.footer,
    super.key,
  });

  /// Index into the active photo sequence (0-based).
  final int stepIndex;
  final bool isPanel;
  final Widget child;
  final VoidCallback? onBack;
  final Widget? footer;

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
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7FAFD),
              Color(0xFFEEF5FB),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 16, 4),
                child: Row(
                  children: [
                    Material(
                      color: AppColors.white,
                      elevation: 2,
                      shadowColor: AppColors.primary.withValues(alpha: 0.12),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: onBack ?? () => _defaultBack(context),
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.chevron_left_rounded,
                            size: 26,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
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
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSelected,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        '${at + 1}/${seq.length}',
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                child: Row(
                  children: [
                    for (final stepId in seq) ...[
                      Expanded(
                        child: AnimatedContainer(
                          duration: AppMotion.select,
                          height: 5,
                          decoration: BoxDecoration(
                            color: stepId <= currentStepId
                                ? AppColors.primary
                                : AppColors.surfaceMuted,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ),
                      if (stepId != seq.last) const SizedBox(width: 4),
                    ],
                  ],
                ),
              ),
              Expanded(child: child),
              ? footer,
            ],
          ),
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
    return Pressable(
      elevate: false,
      child: InkWell(
        onTap: onTap,
        child: AnimatedScale(
          scale: selected ? 1.02 : 1,
          duration: AppMotion.select,
          curve: AppMotion.curve,
          child: AnimatedContainer(
            duration: AppMotion.select,
            curve: AppMotion.curve,
            constraints: BoxConstraints(minHeight: minHeight),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? AppColors.textPrimary : AppColors.white,
              border: Border.all(color: AppColors.textPrimary, width: 2),
            ),
            child: AnimatedDefaultTextStyle(
              duration: AppMotion.select,
              curve: AppMotion.curve,
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
              child: Text(label, textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }
}

/// Image + title selection card used on product / material photo steps.
class PhotoImageCard extends StatelessWidget {
  const PhotoImageCard({
    required this.label,
    required this.selected,
    required this.onTap,
    this.imageAsset,
    super.key,
  });

  final String label;
  final String? imageAsset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      elevate: true,
      borderRadius: BorderRadius.circular(18),
      child: Material(
        color: AppColors.white,
        elevation: selected ? 3 : 1,
        shadowColor: AppColors.primary.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppMotion.select,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.borderLight,
                width: selected ? 2 : 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: imageAsset == null
                            ? Container(color: AppColors.surfaceMuted)
                            : Image.asset(
                                imageAsset!,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: AnimatedContainer(
                          duration: AppMotion.select,
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary
                                : AppColors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.white,
                              width: 1.5,
                            ),
                          ),
                          child: selected
                              ? const Icon(
                                  Icons.check_rounded,
                                  size: 14,
                                  color: AppColors.white,
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Text(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      height: 1.15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Floating back circle + wide CONTINUE pill.
class PhotoContinueBar extends StatelessWidget {
  const PhotoContinueBar({
    required this.enabled,
    required this.label,
    required this.onBack,
    required this.onContinue,
    super.key,
  });

  final bool enabled;
  final String label;
  final VoidCallback onBack;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          Pressable(
            elevate: true,
            borderRadius: BorderRadius.circular(24),
            child: Material(
              color: AppColors.white,
              elevation: 2,
              shadowColor: AppColors.primary.withValues(alpha: 0.15),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onBack,
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.textPrimary,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Pressable(
              enabled: enabled,
              elevate: true,
              borderRadius: BorderRadius.circular(28),
              child: AnimatedOpacity(
                duration: AppMotion.select,
                opacity: enabled ? 1 : 0.45,
                child: Material(
                  color: AppColors.primary,
                  elevation: 4,
                  shadowColor: AppColors.primary.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(28),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: enabled ? onContinue : null,
                    child: SizedBox(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label.toUpperCase(),
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              letterSpacing: 0.6,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
