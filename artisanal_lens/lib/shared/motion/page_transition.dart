import 'package:flutter/material.dart';

import 'app_motion.dart';

/// The transition every screen arrives with: a fade, with the last few pixels
/// of an upward slide.
///
/// Installed once through [ThemeData.pageTransitionsTheme], so it reaches
/// every route without the router having to spell out a page builder per
/// screen — and so a route added later gets it for free.
///
/// The slide is deliberately small. Flutter's own [FadeUpwardsPageTransitionsBuilder]
/// starts a quarter of a screen down, which on a phone reads as a shove; this
/// starts 3% down, so the screen settles rather than launches.
class AppPageTransitionsBuilder extends PageTransitionsBuilder {
  const AppPageTransitionsBuilder();

  @override
  Duration get transitionDuration => AppMotion.screen;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: AppMotion.curve,
      reverseCurve: AppMotion.curve.flipped,
    );

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.03),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}

/// The same transition for every platform this app runs on.
///
/// Set explicitly rather than left to the platform default, because the brief
/// asks for one consistent feel — the Material zoom on Android and the
/// instant swap on web would otherwise be three different apps.
const PageTransitionsTheme appPageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: AppPageTransitionsBuilder(),
    TargetPlatform.iOS: AppPageTransitionsBuilder(),
    TargetPlatform.fuchsia: AppPageTransitionsBuilder(),
    TargetPlatform.linux: AppPageTransitionsBuilder(),
    TargetPlatform.macOS: AppPageTransitionsBuilder(),
    TargetPlatform.windows: AppPageTransitionsBuilder(),
  },
);
