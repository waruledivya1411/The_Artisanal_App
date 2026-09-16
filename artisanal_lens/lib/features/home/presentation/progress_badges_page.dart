import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
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

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.divider, width: 2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.csYourProgress,
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$doneCount',
                      style: AppTypography.displayLarge.copyWith(
                        fontSize: 56,
                        height: 1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.csBadgesOfFive,
                      style: AppTypography.displayMedium.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 8,
                  child: Stack(
                    children: [
                      Container(color: AppColors.surfaceMuted),
                      FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            children: [
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.05,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (final badge in badges) _BadgeCard(badge: badge),
                ],
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _editProfile,
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textPrimary, width: 2),
                    color: AppColors.white,
                  ),
                  child: Text(
                    l10n.csEditNameLanguageCluster,
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  await context.pushNamed(AppRoute.account);
                  if (mounted) await _restore();
                },
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border, width: 1.5),
                    color: AppColors.white,
                  ),
                  child: Text(
                    l10n.csAccountCloudBackup,
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _resetAll,
                child: Container(
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    l10n.csStartOverClearProgress,
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
      decoration: BoxDecoration(
        color: earned ? AppColors.white : Colors.transparent,
        border: Border.all(
          color: earned ? AppColors.textPrimary : AppColors.surfaceMuted,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            color: earned ? AppColors.primary : AppColors.surfaceMuted,
            child: Icon(
              Icons.workspace_premium_outlined,
              size: 22,
              color: earned ? AppColors.white : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            badge.name,
            style: AppTypography.labelLarge.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: earned ? AppColors.textPrimary : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            earned ? l10n.csBadgeEarned : l10n.csBadgeLocked,
            style: AppTypography.navLabel.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: earned ? AppColors.primary : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
