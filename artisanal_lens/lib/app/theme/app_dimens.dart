/// Spacing and radius tokens measured from the Figma file.
abstract final class AppDimens {
  // Radii observed in the design: 4, 6, 8, 12 and fully rounded pills.
  static const double radiusXs = 4;
  static const double radiusSm = 6;
  static const double radiusMd = 8;
  static const double radiusLg = 12;
  static const double radiusPill = 9999;

  // Spacing scale.
  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space32 = 32;
  static const double space40 = 40;

  /// Horizontal page padding used across the screens.
  static const double pagePadding = 20;

  /// Widest a primary action is allowed to grow.
  ///
  /// On a phone the action still fills the column, but on a wide handset or a
  /// browser window it stops here and centres, so it never stretches into a
  /// banner. The CSS equivalent is `width: 100%; max-width: 360px; margin:
  /// 0 auto`; `ActionWidth` in shared/widgets/common.dart applies it.
  static const double maxActionWidth = 360;

  /// Vertical gap between stacked actions.
  static const double actionGap = 12;

  /// Horizontal inset for the bottom navigation bar, so the outer tap targets
  /// keep their distance from the screen edges.
  static const double bottomNavPadding = 12;

  /// Height of the top app bar in the design.
  static const double appBarHeight = 56;

  /// Height of the bottom navigation shell.
  static const double bottomNavHeight = 80;

  /// Minimum tap target — the design brief calls for large targets because the
  /// audience has low digital literacy.
  static const double minTapTarget = 48;
}
