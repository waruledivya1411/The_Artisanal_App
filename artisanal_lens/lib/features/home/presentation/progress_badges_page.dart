import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/motion/motion.dart';
import '../click_social_store.dart';
import '../../../data/services/click_social_sync_service.dart';

/// PROGRESS tab — badges screen from Click & Social HTML.
class ProgressBadgesPage extends StatefulWidget {
  const ProgressBadgesPage({super.key});

  @override
  State<ProgressBadgesPage> createState() => _ProgressBadgesPageState();
}

class _ProgressBadgesPageState extends State<ProgressBadgesPage> {
  static const _prefsOnboarded = 'click_social_onboarded';
  static const _prefsProfileDone = 'click_social_lesson_profile_done';
  static const _prefsContentDone = 'click_social_lesson_content_done';
  static const _prefsStrategyDone = 'click_social_lesson_strategy_done';
  static const _prefsAnalyticsDone = 'click_social_lesson_analytics_done';
  static const _prefsPhotoDone = 'click_social_lesson_photo_done';
  static const _prefsPublishedCaption = 'click_social_published_caption';
  static const _prefsPublishedTags = 'click_social_published_tags';
  static const _prefsPublishedUser = 'click_social_published_user';
  static const _prefsUsername = 'click_social_ig_username';
  static const _prefsBio = 'click_social_ig_bio';
  static const _prefsCategory = 'click_social_ig_category';

  bool _loading = true;
  bool _photoDone = false;
  bool _profileDone = false;
  bool _contentDone = false;
  bool _strategyDone = false;
  bool _analyticsDone = false;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final photo = prefs.getBool(_prefsPhotoDone) ?? false;
    final profile = prefs.getBool(_prefsProfileDone) ?? false;
    final content = prefs.getBool(_prefsContentDone) ?? false;
    final strategy = prefs.getBool(_prefsStrategyDone) ?? false;
    final analytics = prefs.getBool(_prefsAnalyticsDone) ?? false;
    if (!mounted) return;
    if (!_loading &&
        photo == _photoDone &&
        profile == _profileDone &&
        content == _contentDone &&
        strategy == _strategyDone &&
        analytics == _analyticsDone) {
      return;
    }
    setState(() {
      _photoDone = photo;
      _profileDone = profile;
      _contentDone = content;
      _strategyDone = strategy;
      _analyticsDone = analytics;
      _loading = false;
    });
  }

  Future<void> _editProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsOnboarded, false);
    if (!mounted) return;
    context.goNamed(AppRoute.home);
  }

  Future<void> _resetAll() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.csStartOverTitle),
        content: Text(l10n.csStartOverBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.csCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.csClear),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsOnboarded, false);
    await prefs.remove(_prefsPhotoDone);
    await prefs.remove(_prefsProfileDone);
    await prefs.remove(_prefsContentDone);
    await prefs.remove(_prefsStrategyDone);
    await prefs.remove(_prefsAnalyticsDone);
    await prefs.remove(_prefsPublishedCaption);
    await prefs.remove(_prefsPublishedTags);
    await prefs.remove(_prefsPublishedUser);
    await prefs.remove(_prefsUsername);
    await prefs.remove(_prefsBio);
    await prefs.remove(_prefsCategory);
    await ClickSocialStore.touch(prefs);
    ClickSocialSync.schedulePush();
    if (!mounted) return;
    context.goNamed(AppRoute.home);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final l10n = AppLocalizations.of(context);
    final badges = <_BadgeData>[
      _BadgeData(name: l10n.csBadgePhotographer, earned: _photoDone),
      _BadgeData(name: l10n.csBadgePageBuilder, earned: _profileDone),
      _BadgeData(name: l10n.csBadgeStoryteller, earned: _contentDone),
      _BadgeData(name: l10n.csBadgePlanner, earned: _strategyDone),
      _BadgeData(name: l10n.csBadgeAnalyst, earned: _analyticsDone),
    ];
    final doneCount = badges.where((b) => b.earned).length;
    final progress = doneCount / 5.0;

    return ColoredBox(
      color: const Color(0xFFF7FAFD),
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          children: [
            FadeSlideIn(
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: AppTypography.labelLarge.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                          letterSpacing: -0.2,
                        ),
                        children: [
                          TextSpan(text: l10n.csClickAndSocialInline),
                          const TextSpan(text: '.'),
                        ],
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Antaran Tool',
                          style: AppTypography.navLabel.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            FadeSlideIn(
              delay: const Duration(milliseconds: 40),
              child: Text(
                l10n.csYourProgress.toUpperCase(),
                style: AppTypography.navLabel.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  color: AppColors.textMuted,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FadeSlideIn(
              delay: const Duration(milliseconds: 60),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$doneCount',
                      style: AppTypography.displayLarge.copyWith(
                        fontSize: 48,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text: ' ${l10n.csBadgesOfFive}',
                      style: AppTypography.displayMedium.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            FadeSlideIn(
              delay: const Duration(milliseconds: 80),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: SizedBox(
                  height: 8,
                  child: Stack(
                    children: [
                      Container(color: AppColors.surfaceMuted),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: progress),
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
              ),
            ),
            const SizedBox(height: 22),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.05,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var i = 0; i < badges.length; i++)
                  FadeSlideIn.staggered(
                    index: i,
                    child: _BadgeCard(badge: badges[i]),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            FadeSlideIn(
              delay: const Duration(milliseconds: 160),
              child: _ActionButton(
                label: l10n.csEditNameLanguageCluster,
                onTap: _editProfile,
                filled: false,
              ),
            ),
            const SizedBox(height: 10),
            FadeSlideIn(
              delay: const Duration(milliseconds: 180),
              child: _ActionButton(
                label: l10n.csAccountCloudBackup,
                onTap: () async {
                  await context.pushNamed(AppRoute.account);
                  if (mounted) await _restore();
                },
                filled: false,
              ),
            ),
            const SizedBox(height: 10),
            FadeSlideIn(
              delay: const Duration(milliseconds: 200),
              child: _ActionButton(
                label: l10n.csStartOverClearProgress,
                onTap: _resetAll,
                muted: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeData {
  const _BadgeData({required this.name, required this.earned});
  final String name;
  final bool earned;
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge});

  final _BadgeData badge;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final earned = badge.earned;
    return Opacity(
      opacity: earned ? 1 : 0.72,
      child: Material(
        color: AppColors.white,
        elevation: earned ? 2 : 0,
        shadowColor: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: earned ? AppColors.borderLight : AppColors.divider,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: earned ? AppColors.primary : AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.military_tech_rounded,
                  size: 22,
                  color: earned ? AppColors.white : AppColors.textMuted,
                ),
              ),
              const Spacer(),
              Text(
                badge.name,
                style: AppTypography.labelLarge.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: earned ? AppColors.textPrimary : AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  if (!earned) ...[
                    Icon(
                      Icons.lock_rounded,
                      size: 12,
                      color: AppColors.textMuted.withValues(alpha: 0.8),
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    earned ? l10n.csBadgeEarned : l10n.csBadgeLocked,
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                      color: earned ? AppColors.primary : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.onTap,
    this.filled = false,
    this.muted = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final bg = muted
        ? AppColors.backgroundAlt
        : filled
            ? AppColors.primary
            : AppColors.white;
    final fg = muted
        ? AppColors.textMuted
        : filled
            ? AppColors.white
            : AppColors.textPrimary;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: muted
                ? null
                : Border.all(color: AppColors.borderLight, width: 1.2),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.labelLarge.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: muted ? 11 : 12,
              letterSpacing: muted ? 0.4 : 0.2,
              color: fg,
            ),
          ),
        ),
      ),
    );
  }
}
