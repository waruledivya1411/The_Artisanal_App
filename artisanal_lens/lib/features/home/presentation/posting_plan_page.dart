import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';

/// Lesson 04 — Posting Plan (matches Click & Social HTML).
class PostingPlanPage extends StatefulWidget {
  const PostingPlanPage({super.key});

  @override
  State<PostingPlanPage> createState() => _PostingPlanPageState();
}

class _PostingPlanPageState extends State<PostingPlanPage> {
  static const _prefsStrategyDone = 'click_social_lesson_strategy_done';

  String? _timeId; // m / e / a
  final Set<int> _days = {};

  bool get _timeCorrect => _timeId == 'e';

  String _timeMsg(AppLocalizations l10n) {
    if (_timeId == null) return '';
    return _timeCorrect ? l10n.csTimeCorrectMsg : l10n.csTimeWrongMsg;
  }

  bool get _planReady => _timeCorrect && _days.length == 3;

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsStrategyDone, true);
    if (!mounted) return;
    context.goNamed(AppRoute.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final timeMsg = _timeMsg(l10n);
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
                    l10n.csWhenDoBuyersScroll,
                    style: AppTypography.displayMedium.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 14),
                  for (final opt in [
                    _TimeOpt(id: 'm', label: l10n.csTimeMorning, icon: '◔'),
                    _TimeOpt(id: 'e', label: l10n.csTimeNight, icon: '●'),
                    _TimeOpt(id: 'a', label: l10n.csTimeAfternoon, icon: '◑'),
                  ]) ...[
                    _TimeButton(
                      label: opt.label,
                      icon: opt.icon,
                      selected: _timeId == opt.id,
                      correctSelection: _timeId == opt.id && opt.id == 'e',
                      wrongSelection: _timeId == opt.id && opt.id != 'e',
                      onTap: () => setState(() => _timeId = opt.id),
                    ),
                    const SizedBox(height: 10),
                  ],
                  if (timeMsg.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      color: _timeCorrect
                          ? AppColors.surfaceSelected
                          : const Color(0xFFFFE5E5),
                      child: Text(
                        timeMsg,
                        style: AppTypography.labelLarge.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _timeCorrect
                              ? AppColors.primary
                              : const Color(0xFF9B2C2C),
                        ),
                      ),
                    ),
                  ],
                  if (_timeCorrect) ...[
                    const SizedBox(height: 24),
                    Text(
                      l10n.csPlanYourWeek,
                      style:
                          AppTypography.displayMedium.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.csSpreadThemOut,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        for (var i = 0; i < 7; i++) ...[
                          if (i > 0) const SizedBox(width: 6),
                          Expanded(
                            child: _DayButton(
                              label: dayLabels[i],
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
                    if (_planReady) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        color: AppColors.surfaceSelected,
                        child: Text(
                          l10n.csGoodRhythm,
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeOpt {
  const _TimeOpt({
    required this.id,
    required this.label,
    required this.icon,
  });
  final String id;
  final String label;
  final String icon;
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 8, 12, 8),
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
                  l10n.csLesson04Overline,
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  l10n.csLesson04Title,
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
  final String icon;
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
            : AppColors.textPrimary;

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 52),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTypography.labelLarge.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(icon, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class _DayButton extends StatelessWidget {
  const _DayButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : AppColors.white,
          border: Border.all(color: AppColors.textPrimary, width: 2),
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: selected ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
