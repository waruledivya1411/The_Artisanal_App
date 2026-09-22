import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../shared/motion/motion.dart';
import '../../../l10n/app_localizations.dart';
import '../click_social_lessons.dart';

/// Lesson 05 — Read the Numbers (matches Click & Social HTML analytics).
class ReadTheNumbersPage extends StatefulWidget {
  const ReadTheNumbersPage({super.key});

  @override
  State<ReadTheNumbersPage> createState() => _ReadTheNumbersPageState();
}

class _ReadTheNumbersPageState extends State<ReadTheNumbersPage> {
  int? _best; // 0, 1, 2

  bool get _bestCorrect => _best == 2;

  String _bestMsg(AppLocalizations l10n) {
    if (_best == null) return '';
    return _bestCorrect ? l10n.csBestCorrectMsg : l10n.csBestWrongMsg;
  }

  Future<void> _finish() async {
    final l10n = AppLocalizations.of(context);
    await ClickSocialLessons.complete(
      context,
      prefsKey: ClickSocialLessons.analyticsDoneKey,
      badgeLabel: l10n.csBadgeAnalyst,
      routeName: AppRoute.home,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bestMsg = _bestMsg(l10n);
    final results = [
      _ResultOpt(id: 0, label: l10n.csResultPhotoOnly, reach: 42, width: 0.09),
      _ResultOpt(
        id: 1,
        label: l10n.csResultPhotoStory,
        reach: 210,
        width: 0.44,
      ),
      _ResultOpt(
        id: 2,
        label: l10n.csResultPhotoStoryTags,
        reach: 480,
        width: 1.0,
      ),
    ];

    const weekHeights = [0.15, 0.55, 0.20, 0.90, 0.25, 0.70, 0.30];
    final dayLabels = [
      l10n.csDayMon,
      l10n.csDayTue,
      l10n.csDayWed,
      l10n.csDayThu,
      l10n.csDayFri,
      l10n.csDaySat,
      l10n.csDaySun,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(onBack: () => context.goNamed(AppRoute.home)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    l10n.csThreePostsOneWinner,
                    style: AppTypography.displayMedium.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.csReachExplainer,
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  for (final opt in results) ...[
                    _ResultButton(
                      label: opt.label,
                      reach: opt.reach,
                      widthFactor: opt.width,
                      selected: _best == opt.id,
                      correct: _best == opt.id && opt.id == 2,
                      wrong: _best == opt.id && opt.id != 2,
                      onTap: () => setState(() => _best = opt.id),
                    ),
                    const SizedBox(height: 10),
                  ],
                  if (bestMsg.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      color: _bestCorrect
                          ? AppColors.surfaceSelected
                          : const Color(0xFFFFE5E5),
                      child: Text(
                        bestMsg,
                        style: AppTypography.labelLarge.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _bestCorrect
                              ? AppColors.primary
                              : const Color(0xFF9B2C2C),
                        ),
                      ),
                    ),
                  ],
                  if (_bestCorrect) ...[
                    const SizedBox(height: 20),
                    const Divider(height: 2, thickness: 2),
                    const SizedBox(height: 14),
                    Text(
                      l10n.csYourWeekReached,
                      style: AppTypography.navLabel.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 90,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (var i = 0; i < 7; i++) ...[
                            if (i > 0) const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FractionallySizedBox(
                                        heightFactor: weekHeights[i],
                                        widthFactor: 1,
                                        child: Container(
                                          color: weekHeights[i] >= 0.55
                                              ? AppColors.primary
                                              : AppColors.textMuted,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    dayLabels[i],
                                    style: AppTypography.navLabel.copyWith(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.csTallBarsNote,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: _finish,
                      child: Container(
                        height: 52,
                        alignment: Alignment.center,
                        color: AppColors.primary,
                        child: Text(
                          l10n.csFinishEarnBadge,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultOpt {
  const _ResultOpt({
    required this.id,
    required this.label,
    required this.reach,
    required this.width,
  });

  final int id;
  final String label;
  final int reach;
  final double width;
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 2)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.chevron_left, size: 28),
            color: AppColors.textPrimary,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.csLesson05Overline,
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  l10n.csLesson05Title,
                  style: AppTypography.labelLarge.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultButton extends StatelessWidget {
  const _ResultButton({
    required this.label,
    required this.reach,
    required this.widthFactor,
    required this.selected,
    required this.correct,
    required this.wrong,
    required this.onTap,
  });

  final String label;
  final int reach;
  final double widthFactor;
  final bool selected;
  final bool correct;
  final bool wrong;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = correct
        ? AppColors.primary
        : wrong
            ? AppColors.textMuted
            : AppColors.textPrimary;

    return ShakeOnChange(
      trigger: wrong ? label : null,
      child: Pressable(
      elevate: false,
      child: InkWell(
      onTap: onTap,
      child: AnimatedScale(
        scale: correct ? 1.02 : 1,
        duration: AppMotion.select,
        curve: AppMotion.curve,
        child: AnimatedContainer(
        duration: AppMotion.select,
        curve: AppMotion.curve,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '$reach',
                  style: AppTypography.labelLarge.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                AnimatedCheck(
                  visible: correct,
                  color: AppColors.primary,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 10,
              child: Stack(
                children: [
                  Container(color: AppColors.surfaceMuted),
                  // The reach bar fills rather than appearing at length.
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: widthFactor),
                    duration: AppMotion.progress,
                    curve: AppMotion.curveInOut,
                    builder: (context, value, _) => FractionallySizedBox(
                      widthFactor: value,
                      child: Container(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
      ),
      ),
    );
  }
}
