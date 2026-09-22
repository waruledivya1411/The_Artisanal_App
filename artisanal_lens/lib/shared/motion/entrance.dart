import 'package:flutter/material.dart';

import 'app_motion.dart';

/// Fades a card in and lifts it the last 8px into place.
///
/// Used for content that arrives — lesson cards, option rows, guide panels.
/// It runs once per widget instance; give it a [key] tied to the content if a
/// rebuild should replay it, and leave the key off if it should not.
///
/// Deliberately not applied to every widget on a screen: the brief asks for
/// cards to appear gently, not for everything to move at once.
class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    required this.child,
    this.delay = Duration.zero,
    this.offset = AppMotion.enterOffset,
    this.duration = AppMotion.card,
    super.key,
  });

  /// Convenience for a list: staggers item [index] behind the ones above it.
  factory FadeSlideIn.staggered({
    required int index,
    required Widget child,
    Key? key,
  }) =>
      FadeSlideIn(
        key: key,
        delay: AppMotion.staggerFor(index),
        child: child,
      );

  final Widget child;
  final Duration delay;
  final double offset;
  final Duration duration;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  // The stagger is folded into the controller as a leading Interval rather
  // than a delayed callback: one controller, no stray Timer to outlive the
  // widget, and a stagger that a widget test can pump straight through.
  late final Duration _total = widget.delay + widget.duration;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _total,
  )..forward();

  late final Animation<double> _progress = CurvedAnimation(
    parent: _controller,
    curve: Interval(
      _total == Duration.zero
          ? 0
          : widget.delay.inMicroseconds / _total.inMicroseconds,
      1,
      curve: AppMotion.curve,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      builder: (context, child) => Opacity(
        opacity: _progress.value,
        child: Transform.translate(
          offset: Offset(0, widget.offset * (1 - _progress.value)),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}

/// Fades and lifts new content in whenever [child] changes identity.
///
/// Used for a step replacing the one before it inside a screen that stays
/// put — the quiz questions and the photography guide steps. Give the child a
/// [ValueKey] for the step so the switcher knows when to run.
class StepSwitcher extends StatelessWidget {
  const StepSwitcher({
    required this.child,
    this.duration = AppMotion.screen,
    super.key,
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: AppMotion.curve,
      switchOutCurve: AppMotion.curve,
      // The outgoing step fades under the incoming one rather than the two
      // sharing space, which would make the list jump.
      layoutBuilder: (current, previous) => Stack(
        alignment: Alignment.topCenter,
        children: [
          ...previous.map(
            (child) => Positioned(left: 0, right: 0, top: 0, child: child),
          ),
          ?current,
        ],
      ),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
