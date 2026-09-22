import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/services/click_social_sync_service.dart';
import '../../shared/motion/motion.dart';
import 'click_social_store.dart';

/// Shared prefs + finish behaviour for Click & Social lessons.
///
/// HTML `complete(id, badge)`: mark done, toast `BADGE EARNED — …`, then
/// navigate — home for every lesson except content, which opens the practice
/// feed (`gram`).
abstract final class ClickSocialLessons {
  static const photoDoneKey = 'click_social_lesson_photo_done';
  static const profileDoneKey = 'click_social_lesson_profile_done';
  static const contentDoneKey = 'click_social_lesson_content_done';
  static const strategyDoneKey = 'click_social_lesson_strategy_done';
  static const analyticsDoneKey = 'click_social_lesson_analytics_done';

  /// Marks the lesson complete, shows the HTML toast, then navigates.
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

    // The reward for finishing a lesson: the same toast as before, with a
    // tick that grows in beside it. Deliberately small — no dialog, no
    // confetti, and the lesson still navigates on immediately.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const _EarnedTick(),
            const SizedBox(width: 10),
            Expanded(
              child: Text('BADGE EARNED — ${badgeLabel.toUpperCase()}'),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 2600),
      ),
    );
    context.goNamed(routeName);
  }
}

/// The tick in the badge toast, which scales up once as the toast arrives.
class _EarnedTick extends StatefulWidget {
  const _EarnedTick();

  @override
  State<_EarnedTick> createState() => _EarnedTickState();
}

class _EarnedTickState extends State<_EarnedTick>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.select,
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: _controller, curve: AppMotion.curve),
      child: const Icon(Icons.check_circle_outline, size: 20),
    );
  }
}
