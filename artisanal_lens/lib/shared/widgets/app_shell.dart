import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';
import '../motion/motion.dart';

/// Bottom navigation matching Click & Social HTML: LEARN · PRACTICE · PROGRESS.
///
/// Wired to existing app routes:
/// - LEARN → home lesson path
/// - PRACTICE → gallery (practice feed)
/// - PROGRESS → settings (badges + edit profile)
class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: child,
      bottomNavigationBar: _BottomNav(location: _locationOf(context)),
    );
  }

  String _locationOf(BuildContext context) =>
      GoRouterState.of(context).uri.path;
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.divider, width: 2)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.bottomNavPadding,
            ),
            child: Row(
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  label: l10n.csNavLearn,
                  isActive: location == '/home',
                  onTap: () => context.goNamed(AppRoute.home),
                ),
                _NavItem(
                  icon: Icons.photo_camera_outlined,
                  label: l10n.csNavPractice,
                  isActive: location == '/gallery',
                  onTap: () => context.goNamed(AppRoute.gallery),
                ),
                _NavItem(
                  icon: Icons.military_tech_outlined,
                  label: l10n.csNavProgress,
                  isActive: location == '/settings',
                  onTap: () => context.goNamed(AppRoute.settings),
                ),
              ],
            ),
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
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.textPrimary;

    return Expanded(
      child: Pressable(
        elevate: false,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // The active tab's icon sits fractionally larger and its colour
              // eases across, so switching tabs reads as a move rather than a
              // repaint.
              AnimatedScale(
                scale: isActive ? 1.1 : 1,
                duration: AppMotion.select,
                curve: AppMotion.curve,
                child: TweenAnimationBuilder<Color?>(
                  tween: ColorTween(end: color),
                  duration: AppMotion.select,
                  curve: AppMotion.curve,
                  builder: (context, value, _) =>
                      Icon(icon, size: 22, color: value ?? color),
                ),
              ),
              const SizedBox(height: 3),
              AnimatedDefaultTextStyle(
                duration: AppMotion.select,
                curve: AppMotion.curve,
                style: AppTypography.navLabel.copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                  color: color,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
