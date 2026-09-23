import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/motion/motion.dart';
import '../click_social_lessons.dart';

/// Lesson 05 — Read the Numbers (matches Click & Social mock).
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

    // Tue / Thu / Sat are posting days (tall blue bars).
    const weekHeights = [0.18, 0.62, 0.22, 0.95, 0.28, 0.78, 0.32];
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
      backgroundColor: Colors.transparent,
      bottomNavigationBar: _LessonBottomNav(
        onLearn: () => context.goNamed(AppRoute.home),
        onPractice: () => context.goNamed(AppRoute.gallery),
        onProgress: () => context.goNamed(AppRoute.settings),
      ),
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
          bottom: false,
          child: Column(
            children: [
              _Header(onBack: () => context.goNamed(AppRoute.home)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                  children: [
                    Text(
                      l10n.csThreePostsOneWinner,
                      style: AppTypography.displayMedium.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.csReachExplainer,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 13,
                        height: 1.4,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                      const SizedBox(height: 12),
                    ],
                    if (bestMsg.isNotEmpty) ...[
                      FadeSlideIn(
                        key: ValueKey('msg-$_best'),
                        child: _FeedbackBanner(
                          message: bestMsg,
                          correct: _bestCorrect,
                        ),
                      ),
                    ],
                    if (_bestCorrect) ...[
                      const SizedBox(height: 22),
                      Text(
                        l10n.csYourWeekReached,
                        style: AppTypography.navLabel.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 12),
                      FadeSlideIn(
                        key: const ValueKey('week-chart'),
                        child: Material(
                          color: AppColors.white,
                          elevation: 2,
                          shadowColor:
                              AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(14, 16, 14, 12),
                            child: SizedBox(
                              height: 110,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  for (var i = 0; i < 7; i++) ...[
                                    if (i > 0) const SizedBox(width: 8),
                                    Expanded(
                                      child: _WeekBar(
                                        heightFactor: weekHeights[i],
                                        label: dayLabels[i],
                                        highlight: weekHeights[i] >= 0.55,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.csTallBarsNote,
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 13,
                          height: 1.4,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 18),
                      FadeSlideIn(
                        key: const ValueKey('finish'),
                        child: Pressable(
                          elevate: true,
                          borderRadius: BorderRadius.circular(28),
                          child: Material(
                            color: AppColors.primary,
                            elevation: 4,
                            shadowColor:
                                AppColors.primary.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(28),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(28),
                              onTap: _finish,
                              child: SizedBox(
                                height: 52,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      l10n.csFinishEarnBadge,
                                      style:
                                          AppTypography.labelLarge.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13,
                                        letterSpacing: 0.5,
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
                    ],
                  ],
                ),
              ),
            ],
          ),
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
    return Padding(
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
              onTap: onBack,
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
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.surfaceSelected,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              '3 / 3',
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
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
    return ShakeOnChange(
      trigger: wrong ? label : null,
      child: Pressable(
        elevate: true,
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: correct ? AppColors.surfaceSelected : AppColors.white,
          elevation: selected ? 3 : 1,
          shadowColor: AppColors.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: AnimatedScale(
              scale: correct ? 1.02 : 1,
              duration: AppMotion.select,
              curve: AppMotion.curve,
              child: AnimatedContainer(
                duration: AppMotion.select,
                curve: AppMotion.curve,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: correct
                        ? AppColors.primary
                        : wrong
                            ? AppColors.textMuted
                            : AppColors.borderLight,
                    width: selected ? 2.2 : 1.2,
                  ),
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
                              fontWeight:
                                  correct ? FontWeight.w700 : FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Text(
                          '$reach',
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (correct) ...[
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.check_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: SizedBox(
                        height: 10,
                        child: Stack(
                          children: [
                            Container(color: AppColors.surfaceMuted),
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: widthFactor),
                              duration: AppMotion.progress,
                              curve: AppMotion.curveInOut,
                              builder: (context, value, _) =>
                                  FractionallySizedBox(
                                widthFactor: value,
                                child: Container(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  const _FeedbackBanner({
    required this.message,
    required this.correct,
  });

  final String message;
  final bool correct;

  @override
  Widget build(BuildContext context) {
    final parts = message.split(' — ');
    final splitCorrect = correct && parts.length >= 2;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: correct ? const Color(0xFFEBF8FF) : const Color(0xFFFFE5E5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(
              correct ? Icons.check_circle_rounded : Icons.cancel_rounded,
              size: 20,
              color: correct ? AppColors.primary : const Color(0xFF9B2C2C),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: splitCorrect
                ? Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: parts.first,
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(
                          text: ' — ${parts.skip(1).join(' — ')}',
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2A4365),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    message,
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: correct
                          ? const Color(0xFF2A4365)
                          : const Color(0xFF9B2C2C),
                      height: 1.35,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _WeekBar extends StatelessWidget {
  const _WeekBar({
    required this.heightFactor,
    required this.label,
    required this.highlight,
  });

  final double heightFactor;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: heightFactor),
              duration: AppMotion.progress,
              curve: AppMotion.curveInOut,
              builder: (context, value, _) => FractionallySizedBox(
                heightFactor: value.clamp(0.05, 1),
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: highlight
                        ? AppColors.primary
                        : AppColors.textMuted.withValues(alpha: 0.55),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: AppTypography.navLabel.copyWith(
            fontSize: 11,
            fontWeight: highlight ? FontWeight.w800 : FontWeight.w600,
            color: highlight ? AppColors.textPrimary : AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _LessonBottomNav extends StatelessWidget {
  const _LessonBottomNav({
    required this.onLearn,
    required this.onPractice,
    required this.onProgress,
  });

  final VoidCallback onLearn;
  final VoidCallback onPractice;
  final VoidCallback onProgress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      color: AppColors.white,
      elevation: 8,
      shadowColor: AppColors.primary.withValues(alpha: 0.1),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.menu_book_rounded,
                label: l10n.csNavLearn,
                active: true,
                onTap: onLearn,
              ),
              _NavItem(
                icon: Icons.photo_camera_outlined,
                label: l10n.csNavPractice,
                active: false,
                onTap: onPractice,
              ),
              _NavItem(
                icon: Icons.emoji_events_outlined,
                label: l10n.csNavProgress,
                active: false,
                onTap: onProgress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : AppColors.textMuted;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTypography.navLabel.copyWith(
                fontSize: 10,
                fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
