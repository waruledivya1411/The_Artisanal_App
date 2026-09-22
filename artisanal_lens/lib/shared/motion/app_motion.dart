import 'package:flutter/material.dart';

/// Timings and curves for the whole app, so every screen moves the same way.
///
/// The brief is "tactile, not bouncy": everything here decelerates into place
/// with [Curves.easeOutCubic] and nothing overshoots. There is deliberately no
/// elastic or bounce curve in this file.
abstract final class AppMotion {
  /// The press-down and release on a button.
  static const Duration press = Duration(milliseconds: 160);

  /// A selection being acknowledged — background, border, checkmark.
  static const Duration select = Duration(milliseconds: 200);

  /// A card or row arriving on screen.
  static const Duration card = Duration(milliseconds: 280);

  /// One screen or step replacing another.
  static const Duration screen = Duration(milliseconds: 300);

  /// A section opening or closing.
  static const Duration expand = Duration(milliseconds: 250);

  /// A progress bar travelling to a new value.
  static const Duration progress = Duration(milliseconds: 600);

  /// The single easing used for entrances and state changes.
  static const Curve curve = Curves.easeOutCubic;

  /// Symmetric easing, for something that both grows and shrinks.
  static const Curve curveInOut = Curves.easeInOutCubic;

  /// How far a card travels while fading in.
  static const double enterOffset = 8;

  /// How far a button scales down while held.
  static const double pressScale = 0.97;

  /// Stagger between neighbouring items in a list.
  static const Duration stagger = Duration(milliseconds: 45);

  /// The stagger delay for item [index], capped so a long list does not leave
  /// the last row waiting.
  static Duration staggerFor(int index, {int max = 6}) =>
      stagger * (index > max ? max : index);
}
