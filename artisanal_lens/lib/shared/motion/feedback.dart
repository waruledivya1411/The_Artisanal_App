import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'app_motion.dart';

/// A checkmark that scales and fades in when [visible] turns true.
///
/// The acknowledgement for a selection or a completed step. It occupies no
/// space while hidden, so it can sit in a Row without shifting the layout.
class AnimatedCheck extends StatelessWidget {
  const AnimatedCheck({
    required this.visible,
    required this.color,
    this.background,
    this.size = 15,
    this.radius = 13,
    super.key,
  });

  final bool visible;
  final Color color;

  /// When set, the tick is drawn on a filled circle of this colour.
  final Color? background;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final mark = background == null
        ? Icon(Icons.check, size: size, color: color)
        : CircleAvatar(
            radius: radius,
            backgroundColor: background,
            child: Icon(Icons.check, size: size, color: color),
          );

    return AnimatedScale(
      scale: visible ? 1 : 0.6,
      duration: AppMotion.select,
      curve: AppMotion.curve,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: AppMotion.select,
        curve: AppMotion.curve,
        child: mark,
      ),
    );
  }
}

/// Shakes its child sideways once, each time [trigger] changes to a new
/// non-null value.
///
/// Used for a wrong answer. The movement is small and damped — it reads as a
/// head-shake, not an alarm — and the screen keeps its normal colours, so the
/// existing feedback message stays the thing the learner reads.
class ShakeOnChange extends StatefulWidget {
  const ShakeOnChange({
    required this.trigger,
    required this.child,
    this.distance = 7,
    this.duration = const Duration(milliseconds: 380),
    super.key,
  });

  /// Change this to a new value to run the shake; set it to null for a state
  /// that should stay still, such as a correct answer.
  final Object? trigger;
  final Widget child;
  final double distance;
  final Duration duration;

  @override
  State<ShakeOnChange> createState() => _ShakeOnChangeState();
}

class _ShakeOnChangeState extends State<ShakeOnChange>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void didUpdateWidget(ShakeOnChange old) {
    super.didUpdateWidget(old);
    if (widget.trigger != old.trigger && widget.trigger != null) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        // Three decaying swings, ending exactly at rest.
        final offset =
            math.sin(t * math.pi * 3) * widget.distance * (1 - t);
        return Transform.translate(offset: Offset(offset, 0), child: child);
      },
      child: widget.child,
    );
  }
}

/// A brief accent pulse over its child, run once when [trigger] changes.
///
/// The small reward for finishing something — a wash of the accent colour that
/// fades out over half a second. No popup, no confetti.
class SuccessPulse extends StatefulWidget {
  const SuccessPulse({
    required this.trigger,
    required this.color,
    required this.child,
    super.key,
  });

  final Object? trigger;
  final Color color;
  final Widget child;

  @override
  State<SuccessPulse> createState() => _SuccessPulseState();
}

class _SuccessPulseState extends State<SuccessPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 520),
  );

  @override
  void didUpdateWidget(SuccessPulse old) {
    super.didUpdateWidget(old);
    if (widget.trigger != old.trigger && widget.trigger != null) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final t = _controller.value;
                if (t == 0 || t == 1) return const SizedBox.shrink();
                // In quickly, out slowly.
                final strength = t < 0.3 ? t / 0.3 : 1 - ((t - 0.3) / 0.7);
                return ColoredBox(
                  color: widget.color.withValues(alpha: 0.16 * strength),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
