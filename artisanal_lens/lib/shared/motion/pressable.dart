import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'app_motion.dart';

/// Gives a control the feel of being pressed: it settles to 0.97 and comes
/// back, with a very slight lift that flattens under the finger.
///
/// This listens to raw pointer events rather than adding a gesture recogniser,
/// so it never competes in the gesture arena with the `InkWell`,
/// `GestureDetector` or material button already inside it. Taps keep working
/// exactly as before — wrapping a control changes how it feels, never what it
/// does.
///
/// The press releases if the finger slides away (past [kTouchSlop]), so
/// dragging to scroll a list does not leave a row stuck in its pressed state.
class Pressable extends StatefulWidget {
  const Pressable({
    required this.child,
    this.enabled = true,
    this.elevate = true,
    this.borderRadius = BorderRadius.zero,
    this.scale = AppMotion.pressScale,
    super.key,
  });

  final Widget child;

  /// Set false for a disabled control, so it stays still under the finger.
  final bool enabled;

  /// Whether to carry the very slight resting shadow that flattens on press.
  ///
  /// The selection chips in this app are deliberately flat — square corners
  /// and a 2px border — so they pass false and rely on scale alone, which
  /// keeps the Click & Social look intact.
  final bool elevate;

  /// Shape of the shadow, which must match the shape the child paints, or the
  /// shadow shows at the corners of a rounded control.
  final BorderRadius borderRadius;

  final double scale;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _down = false;
  Offset? _origin;

  void _set(bool value) {
    if (_down == value || !mounted) return;
    setState(() => _down = value);
  }

  void _onDown(PointerDownEvent event) {
    if (!widget.enabled) return;
    _origin = event.position;
    _set(true);
  }

  void _onMove(PointerMoveEvent event) {
    final origin = _origin;
    if (origin == null || !_down) return;
    if ((event.position - origin).distance > kTouchSlop) {
      _origin = null;
      _set(false);
    }
  }

  void _onUp([PointerEvent? _]) {
    _origin = null;
    _set(false);
  }

  @override
  Widget build(BuildContext context) {
    final pressed = _down && widget.enabled;

    Widget child = widget.child;

    if (widget.elevate) {
      // Drawn behind the child, so a control with its own background simply
      // sits on it. Kept faint on purpose: this is a flat design and the
      // shadow is a hint of depth, not a raised card.
      child = AnimatedContainer(
        duration: AppMotion.press,
        curve: AppMotion.curve,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: pressed ? 0.03 : 0.09),
              blurRadius: pressed ? 2 : 6,
              offset: Offset(0, pressed ? 1 : 2),
            ),
          ],
        ),
        child: child,
      );
    }

    return Listener(
      behavior: HitTestBehavior.deferToChild,
      onPointerDown: _onDown,
      onPointerMove: _onMove,
      onPointerUp: _onUp,
      onPointerCancel: _onUp,
      child: AnimatedScale(
        scale: pressed ? widget.scale : 1,
        duration: AppMotion.press,
        curve: AppMotion.curve,
        child: child,
      ),
    );
  }
}
