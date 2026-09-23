import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../shared/motion/motion.dart';
import '../../../l10n/app_localizations.dart';
import '../click_social_lessons.dart';

/// Lesson 04 — Posting Plan (matches Click & Social mock).
class PostingPlanPage extends StatefulWidget {
  const PostingPlanPage({super.key});

  @override
  State<PostingPlanPage> createState() => _PostingPlanPageState();
}

class _PostingPlanPageState extends State<PostingPlanPage> {
  String? _timeId; // m / e / a
  final Set<int> _days = {};

  static const _dayMeta = [
    (letter: 'M', abbr: 'MON', full: 'Monday'),
    (letter: 'T', abbr: 'TUE', full: 'Tuesday'),
    (letter: 'W', abbr: 'WED', full: 'Wednesday'),
    (letter: 'T', abbr: 'THU', full: 'Thursday'),
    (letter: 'F', abbr: 'FRI', full: 'Friday'),
    (letter: 'S', abbr: 'SAT', full: 'Saturday'),
    (letter: 'S', abbr: 'SUN', full: 'Sunday'),
  ];

  bool get _timeCorrect => _timeId == 'e';

  String _timeMsg(AppLocalizations l10n) {
    if (_timeId == null) return '';
    return _timeCorrect ? l10n.csTimeCorrectMsg : l10n.csTimeWrongMsg;
  }

  bool get _planReady => _timeCorrect && _days.length == 3;

  String get _scheduleDays {
    final sorted = _days.toList()..sort();
    return sorted.map((i) => _dayMeta[i].full).join(', ');
  }

  Future<void> _finish() async {
    final l10n = AppLocalizations.of(context);
    await ClickSocialLessons.complete(
      context,
      prefsKey: ClickSocialLessons.strategyDoneKey,
      badgeLabel: l10n.csBadgePlanner,
      routeName: AppRoute.home,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final timeMsg = _timeMsg(l10n);

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
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  children: [
                    Text(
                      l10n.csWhenDoBuyersScroll,
                      style: AppTypography.displayMedium.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tap the primary active browsing window for craft lovers.',
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 13,
                        height: 1.4,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _TimeButton(
                      label: l10n.csTimeMorning,
                      icon: Icons.schedule_rounded,
                      selected: _timeId == 'm',
                      correctSelection: false,
                      wrongSelection: _timeId == 'm',
                      onTap: () => setState(() => _timeId = 'm'),
                    ),
                    const SizedBox(height: 10),
                    _TimeButton(
                      label: l10n.csTimeNight,
                      icon: Icons.nightlight_round,
                      selected: _timeId == 'e',
                      correctSelection: _timeId == 'e',
                      wrongSelection: false,
                      onTap: () => setState(() => _timeId = 'e'),
                    ),
                    const SizedBox(height: 10),
                    _TimeButton(
                      label: l10n.csTimeAfternoon,
                      icon: Icons.wb_twilight_rounded,
                      selected: _timeId == 'a',
                      correctSelection: false,
                      wrongSelection: _timeId == 'a',
                      onTap: () => setState(() => _timeId = 'a'),
                    ),
                    if (timeMsg.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        decoration: BoxDecoration(
                          color: _timeCorrect
                              ? AppColors.surfaceSelected
                              : const Color(0xFFFFE5E5),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: _timeCorrect
                                ? AppColors.borderLight
                                : const Color(0xFFF5C2C2),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              _timeCorrect
                                  ? Icons.info_rounded
                                  : Icons.error_outline_rounded,
                              size: 18,
                              color: _timeCorrect
                                  ? AppColors.primary
                                  : const Color(0xFF9B2C2C),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                timeMsg,
                                style: AppTypography.labelLarge.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  height: 1.4,
                                  color: _timeCorrect
                                      ? AppColors.primary
                                      : const Color(0xFF9B2C2C),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (_timeCorrect) ...[
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.csPlanYourWeek,
                              style: AppTypography.displayMedium.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceSelected,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              '${_days.length} of 3 days',
                              style: AppTypography.labelSmall.copyWith(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.csSpreadThemOut,
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          for (var i = 0; i < 7; i++) ...[
                            if (i > 0) const SizedBox(width: 6),
                            Expanded(
                              child: _DayButton(
                                letter: _dayMeta[i].letter,
                                abbr: _dayMeta[i].abbr,
                                selected: _days.contains(i),
                                onTap: () {
                                  setState(() {
                                    if (_days.contains(i)) {
                                      _days.remove(i);
                                    } else if (_days.length < 3) {
                                      _days.add(i);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                    if (_planReady) ...[
                      const SizedBox(height: 18),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.success,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'YOUR POSTING SCHEDULE:',
                                  style: AppTypography.navLabel.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.4,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundAlt,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _scheduleDays,
                                      style: AppTypography.labelLarge.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
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
                                      '7:00 – 10:00 PM',
                                      style: AppTypography.labelSmall.copyWith(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Artisan Tip: Consistency beats volume. 3 quality posts a week builds trust with genuine buyers.',
                              style: AppTypography.labelSmall.copyWith(
                                fontSize: 12.5,
                                height: 1.4,
                                fontStyle: FontStyle.italic,
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
              _Footer(
                canContinue: _planReady,
                onBack: () => context.goNamed(AppRoute.home),
                onContinue: _finish,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
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
          Expanded(
            child: Column(
              children: [
                Text(
                  l10n.csLesson04Overline,
                  textAlign: TextAlign.center,
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.csLesson04Title,
                  textAlign: TextAlign.center,
                  style: AppTypography.displayMedium.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class _TimeButton extends StatelessWidget {
  const _TimeButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.correctSelection,
    required this.wrongSelection,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final bool correctSelection;
  final bool wrongSelection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = correctSelection
        ? AppColors.primary
        : wrongSelection
            ? AppColors.textMuted
            : selected
                ? AppColors.primary
                : AppColors.borderLight;

    return ShakeOnChange(
      trigger: wrongSelection ? label : null,
      child: Pressable(
        elevate: false,
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: AnimatedContainer(
              duration: AppMotion.select,
              curve: AppMotion.curve,
              constraints: const BoxConstraints(minHeight: 54),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: borderColor,
                  width: correctSelection || selected ? 1.8 : 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (correctSelection) ...[
                    const Icon(
                      Icons.check_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: correctSelection
                          ? AppColors.primary
                          : AppColors.surfaceMuted.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 16,
                      color: correctSelection
                          ? AppColors.white
                          : AppColors.textMuted,
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

class _DayButton extends StatelessWidget {
  const _DayButton({
    required this.letter,
    required this.abbr,
    required this.selected,
    required this.onTap,
  });

  final String letter;
  final String abbr;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      elevate: false,
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: selected ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppMotion.select,
            curve: AppMotion.curve,
            height: 58,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.borderLight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  letter,
                  style: AppTypography.labelLarge.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: selected ? AppColors.white : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  abbr,
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                    color: selected
                        ? AppColors.white.withValues(alpha: 0.9)
                        : AppColors.textMuted,
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

class _Footer extends StatelessWidget {
  const _Footer({
    required this.canContinue,
    required this.onBack,
    required this.onContinue,
  });

  final bool canContinue;
  final VoidCallback onBack;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          Material(
            color: AppColors.white,
            shape: const CircleBorder(),
            elevation: 1,
            shadowColor: AppColors.primary.withValues(alpha: 0.1),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onBack,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.chevron_left_rounded,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Pressable(
              enabled: canContinue,
              elevate: true,
              borderRadius: BorderRadius.circular(28),
              child: Opacity(
                opacity: canContinue ? 1 : 0.45,
                child: Material(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(28),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: canContinue ? onContinue : null,
                    child: SizedBox(
                      height: 52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SAVE & CONTINUE',
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
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
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
