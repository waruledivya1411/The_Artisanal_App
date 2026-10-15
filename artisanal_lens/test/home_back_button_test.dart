import 'package:artisanal_lens/features/home/presentation/click_social_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/test_l10n.dart';

/// Phone widths the header has to hold at, matching `layout_spacing_test`.
const _small = Size(320, 640);
const _large = Size(430, 932);

/// Prefs for a learner who has finished the setup questions, so the page
/// opens on the lesson list rather than on onboarding.
void _seedOnboarded() {
  SharedPreferences.setMockInitialValues({
    'click_social_onboarded': true,
    'click_social_name': 'Divya',
    'click_social_cluster_id': 'kamrup_nalbari',
    'click_social_language': 'en',
  });
}

Future<void> _pumpHome(WidgetTester tester, {Size size = _large}) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    const ProviderScope(child: _HostApp()),
  );
  await tester.pumpAndSettle();
}

class _HostApp extends StatelessWidget {
  const _HostApp();

  @override
  Widget build(BuildContext context) =>
      l10nApp(home: const ClickSocialHomePage());
}

void main() {
  setUp(_seedOnboarded);

  Finder backButton() => find.byIcon(Icons.chevron_left_rounded);

  testWidgets('the lesson list carries a back button', (tester) async {
    await _pumpHome(tester);

    expect(find.text('Hello, Divya'), findsOneWidget);
    expect(backButton(), findsOneWidget);
  });

  testWidgets('back sits at the top of the page, not the bottom',
      (tester) async {
    await _pumpHome(tester);

    final back = tester.getCenter(backButton());
    final greeting = tester.getCenter(find.text('Hello, Divya'));

    // Above the greeting, and well inside the top half of the screen — the
    // bottom navigation is the thing it must not be mistaken for.
    expect(back.dy, lessThan(greeting.dy));
    expect(back.dy, lessThan(_large.height / 2));
  });

  testWidgets('tapping back returns to the setup questions', (tester) async {
    await _pumpHome(tester);
    expect(find.text('Hello, Divya'), findsOneWidget);

    await tester.tap(backButton());
    await tester.pumpAndSettle();

    // The lesson list is gone and the setup questions are showing in its
    // place, with the saved name still in the field.
    expect(find.text('Hello, Divya'), findsNothing);
    expect(find.text('Type your name'), findsOneWidget);
  });

  for (final size in [_small, _large]) {
    testWidgets('header holds at ${size.width.toInt()}', (tester) async {
      await _pumpHome(tester, size: size);

      expect(backButton(), findsOneWidget);
      // A row that runs off the side reports it through the exception
      // handler rather than by failing the pump.
      expect(tester.takeException(), isNull);
    });
  }
}
