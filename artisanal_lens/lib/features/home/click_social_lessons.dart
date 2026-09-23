import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/services/click_social_sync_service.dart';
import 'click_social_store.dart';
import 'presentation/widgets/badge_celebration.dart';

/// Shared prefs + finish behaviour for Click & Social lessons.
///
/// Marks the lesson done, plays a badge celebration, then navigates.
abstract final class ClickSocialLessons {
  static const photoDoneKey = 'click_social_lesson_photo_done';
  static const profileDoneKey = 'click_social_lesson_profile_done';
  static const contentDoneKey = 'click_social_lesson_content_done';
  static const strategyDoneKey = 'click_social_lesson_strategy_done';
  static const analyticsDoneKey = 'click_social_lesson_analytics_done';

  /// Marks the lesson complete, celebrates the badge, then navigates.
  static Future<void> complete(
    BuildContext context, {
    required String prefsKey,
    required String badgeLabel,
    required String routeName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefsKey, true);
    await ClickSocialStore.touch(prefs);
    ClickSocialSync.schedulePush();
    if (!context.mounted) return;

    await showBadgeCelebration(context, badgeLabel: badgeLabel);
    if (!context.mounted) return;
    context.goNamed(routeName);
  }
}
