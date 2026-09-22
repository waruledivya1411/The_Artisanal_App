import 'package:artisanal_lens/app/theme/app_theme.dart';
import 'package:artisanal_lens/shared/motion/motion.dart';
import 'package:artisanal_lens/shared/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The horizontal scale currently applied to [finder] by the Transforms above
/// it.
///
/// Reads `storage[0]` — the x scale — rather than `getMaxScaleOnAxis()`, which
/// reports 1.0 for a 2D shrink because the untouched z axis is the largest.
double scaleOf(WidgetTester tester, Finder finder) {
  final transforms = tester.widgetList<Transform>(
    find.ancestor(of: finder, matching: find.byType(Transform)),
  );
  var scale = 1.0;
  for (final t in transforms) {
    scale *= t.transform.storage[0];
  }
  return scale;
}

Future<void> pumpIn(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(theme: AppTheme.light, home: Scaffold(body: Center(child: child))),
  );
}

void main() {
  group('Pressable', () {
    testWidgets('does not swallow the tap it wraps', (tester) async {
      // The whole design rests on this: press feedback is layered over
      // controls that already work, so it must never win the gesture arena.
      var taps = 0;
      await pumpIn(
        tester,
        Pressable(
          child: ElevatedButton(
            onPressed: () => taps++,
            child: const Text('Go'),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();

      expect(taps, 1);
    });

    testWidgets('shrinks while held and returns when released',
        (tester) async {
      await pumpIn(
        tester,
        Pressable(
          elevate: false,
          child: ElevatedButton(onPressed: () {}, child: const Text('Go')),
        ),
      );

      final target = find.byType(ElevatedButton);
      expect(scaleOf(tester, target), closeTo(1, 0.001));

      final gesture = await tester.startGesture(tester.getCenter(target));
      await tester.pumpAndSettle();
      expect(
        scaleOf(tester, target),
        closeTo(AppMotion.pressScale, 0.001),
        reason: 'held button should settle at the press scale',
      );

      await gesture.up();
      await tester.pumpAndSettle();
      expect(scaleOf(tester, target), closeTo(1, 0.001));
    });

    testWidgets('releases when the finger slides away, so scrolling is clean',
        (tester) async {
      await pumpIn(
        tester,
        Pressable(
          elevate: false,
          child: ElevatedButton(onPressed: () {}, child: const Text('Go')),
        ),
      );

      final target = find.byType(ElevatedButton);
      final gesture = await tester.startGesture(tester.getCenter(target));
      await tester.pumpAndSettle();
      expect(scaleOf(tester, target), closeTo(AppMotion.pressScale, 0.001));

      await gesture.moveBy(const Offset(0, 60));
      await tester.pumpAndSettle();
      expect(
        scaleOf(tester, target),
        closeTo(1, 0.001),
        reason: 'dragging off should not leave the row stuck pressed',
      );

      await gesture.up();
      await tester.pumpAndSettle();
    });

    testWidgets('stays still when disabled', (tester) async {
      await pumpIn(
        tester,
        const Pressable(
          enabled: false,
          elevate: false,
          child: SizedBox(width: 100, height: 40, child: Text('x')),
        ),
      );

      final target = find.text('x');
      final gesture = await tester.startGesture(tester.getCenter(target));
      await tester.pumpAndSettle();
      expect(scaleOf(tester, target), closeTo(1, 0.001));
      await gesture.up();
      await tester.pumpAndSettle();
    });
  });

  group('FadeSlideIn', () {
    testWidgets('starts hidden and low, ends opaque and in place',
        (tester) async {
      await pumpIn(tester, const FadeSlideIn(child: Text('card')));

      // First frame: the controller has not advanced yet.
      await tester.pump();
      final start = tester.widget<Opacity>(
        find.ancestor(of: find.text('card'), matching: find.byType(Opacity)),
      );
      expect(start.opacity, lessThan(0.2));

      await tester.pumpAndSettle();
      final end = tester.widget<Opacity>(
        find.ancestor(of: find.text('card'), matching: find.byType(Opacity)),
      );
      expect(end.opacity, 1);
    });

    testWidgets('a staggered item waits its turn but still arrives',
        (tester) async {
      await pumpIn(
        tester,
        FadeSlideIn.staggered(index: 3, child: const Text('late')),
      );
      await tester.pump();

      final early = tester.widget<Opacity>(
        find.ancestor(of: find.text('late'), matching: find.byType(Opacity)),
      );
      expect(early.opacity, 0, reason: 'still waiting out its delay');

      await tester.pumpAndSettle();
      final settled = tester.widget<Opacity>(
        find.ancestor(of: find.text('late'), matching: find.byType(Opacity)),
      );
      expect(settled.opacity, 1);
    });
  });

  group('ShakeOnChange', () {
    testWidgets('moves sideways on a new trigger and comes back to rest',
        (tester) async {
      Widget build(Object? trigger) => MaterialApp(
            home: Scaffold(
              body: Center(
                child: ShakeOnChange(
                  trigger: trigger,
                  child: const Text('wrong'),
                ),
              ),
            ),
          );

      await tester.pumpWidget(build(null));
      final resting = tester.getCenter(find.text('wrong'));

      await tester.pumpWidget(build(1));
      await tester.pump(const Duration(milliseconds: 60));
      expect(
        tester.getCenter(find.text('wrong')).dx,
        isNot(closeTo(resting.dx, 0.5)),
        reason: 'should be mid-shake',
      );

      await tester.pumpAndSettle();
      expect(
        tester.getCenter(find.text('wrong')).dx,
        closeTo(resting.dx, 0.01),
        reason: 'shake must end exactly where it started',
      );
    });

    testWidgets('stays still when the trigger is null', (tester) async {
      await pumpIn(
        tester,
        const ShakeOnChange(trigger: null, child: Text('right')),
      );
      final resting = tester.getCenter(find.text('right'));
      await tester.pump(const Duration(milliseconds: 60));
      expect(tester.getCenter(find.text('right')).dx, closeTo(resting.dx, 0.01));
    });
  });

  group('AnimatedCheck', () {
    testWidgets('grows in when it becomes visible', (tester) async {
      Widget build(bool visible) => MaterialApp(
            home: Scaffold(
              body: Center(
                child: AnimatedCheck(visible: visible, color: Colors.black),
              ),
            ),
          );

      await tester.pumpWidget(build(false));
      await tester.pumpAndSettle();
      expect(
        tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
        0,
      );

      await tester.pumpWidget(build(true));
      await tester.pumpAndSettle();
      expect(
        tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
        1,
      );
    });
  });

  group('AppProgressBar', () {
    testWidgets('travels to the new value instead of jumping', (tester) async {
      Widget build(double v) => MaterialApp(
            home: Scaffold(body: Center(child: AppProgressBar(value: v))),
          );

      await tester.pumpWidget(build(0));
      await tester.pumpAndSettle();

      await tester.pumpWidget(build(1));
      await tester.pump(const Duration(milliseconds: 100));

      final mid = tester
          .widget<LinearProgressIndicator>(
            find.byType(LinearProgressIndicator),
          )
          .value!;
      expect(
        mid,
        allOf(greaterThan(0.0), lessThan(1.0)),
        reason: 'should be part-way there, not already full',
      );

      await tester.pumpAndSettle();
      final end = tester
          .widget<LinearProgressIndicator>(
            find.byType(LinearProgressIndicator),
          )
          .value!;
      expect(end, closeTo(1, 0.001));
    });
  });

  group('house style', () {
    test('the screen transition is installed for every platform', () {
      final theme = AppTheme.light;
      for (final platform in TargetPlatform.values) {
        final builder = theme.pageTransitionsTheme.builders[platform];
        expect(
          builder,
          isA<AppPageTransitionsBuilder>(),
          reason: '$platform should use the app transition',
        );
      }
    });

    test('durations sit in the bands the brief asks for', () {
      int ms(Duration d) => d.inMilliseconds;

      expect(ms(AppMotion.press), inInclusiveRange(150, 200));
      expect(ms(AppMotion.screen), inInclusiveRange(250, 350));
      expect(ms(AppMotion.progress), inInclusiveRange(500, 700));
      expect(
        ms(const AppPageTransitionsBuilder().transitionDuration),
        inInclusiveRange(250, 350),
      );
    });

    test('nothing overshoots — the brief asks for tactile, not bouncy', () {
      // A curve that overshoots returns values outside 0..1 partway through.
      for (final curve in [AppMotion.curve, AppMotion.curveInOut]) {
        for (var i = 0; i <= 100; i++) {
          final v = curve.transform(i / 100);
          expect(
            v,
            inInclusiveRange(0.0, 1.0),
            reason: '$curve overshoots at t=${i / 100}',
          );
        }
      }
    });
  });
}
