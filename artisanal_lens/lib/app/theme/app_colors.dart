import 'package:flutter/material.dart';

/// Colour tokens extracted directly from the Figma file "Artisans lens".
///
/// Every value here was read out of the design's fills and strokes rather than
/// eyeballed, so the app matches the source of truth exactly. Do not introduce
/// a colour that is not in this list.
abstract final class AppColors {
  // ----------------------------------------------------------------- brand
  /// Primary brand terracotta — serif titles, primary buttons, active states.
  static const Color primary = Color(0xFF2B6CB0);

  /// Lighter terracotta used for large filled surfaces such as the
  /// "New Product" card and the capture shutter.
  static const Color primaryLight = Color(0xFF4A86C8);

  // ------------------------------------------------------------ background
  /// App background.
  static const Color background = Color(0xFFF3F5F8);

  /// Slightly warmer background used behind app bars and grouped sections.
  static const Color backgroundAlt = Color(0xFFEFF3F8);

  // --------------------------------------------------------------- surface
  /// Default card surface.
  static const Color surface = Color(0xFFFFFFFF);

  /// Raised / selected card surface.
  static const Color surfaceSelected = Color(0xFFEEF4FB);

  /// Neutral surface for inactive icon tiles.
  static const Color surfaceMuted = Color(0xFFD9E6F6);

  /// Pale sand used by the pro-tip banner.
  static const Color surfaceSand = Color(0xFFE9EFF7);

  static const Color white = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------- border
  /// Default card and input border.
  static const Color border = Color(0xFFB8C6D8);

  /// Subtle divider between sections.
  static const Color divider = Color(0xFFD0D8E2);

  static const Color borderLight = Color(0xFFDDE6F2);

  // ------------------------------------------------------------------ text
  /// Headings — near-black.
  static const Color textPrimary = Color(0xFF3B3F47);

  /// Body copy — warm brown, the most used colour in the file.
  static const Color textSecondary = Color(0xFF565A63);

  /// Muted captions.
  static const Color textMuted = Color(0xFF6B7280);

  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // --------------------------------------------------------------- support
  /// Sage green for the "Angle: OK" chip and success states.
  static const Color success = Color(0xFF2F855A);

  /// Light sage border used with [success].
  static const Color successBorder = Color(0xFFC6F6D5);

  /// Amber used by the live "Light" warning chip on the capture screen.
  static const Color warning = Color(0xFFD69E2E);

  // --------------------------------------------------------- camera overlay
  /// Scrim behind the capture screen chrome.
  static const Color cameraScrim = Color(0xCC1A202C);

  /// Ghost-frame guide stroke.
  static const Color guideStroke = Color(0xB3FFFFFF);
}
