import 'package:artisanal_lens/features/settings/presentation/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/test_l10n.dart';

void main() {
  testWidgets('Odia settings copy replaces English', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: l10nApp(
          locale: const Locale('or'),
          home: const Scaffold(body: SettingsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Language'), findsNothing);
    expect(find.text('Settings'), findsNothing);
    expect(find.text('ଭାଷା'), findsWidgets);
  });

  testWidgets('Assamese settings copy replaces English', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: l10nApp(
          locale: const Locale('as'),
          home: const Scaffold(body: SettingsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ছেটিংছ'), findsOneWidget);
    expect(find.text('ভাষা'), findsOneWidget);
    expect(find.text('Settings'), findsNothing);
  });

  testWidgets('Telugu settings copy replaces English', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: l10nApp(
          locale: const Locale('te'),
          home: const Scaffold(body: SettingsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsNothing);
    expect(find.text('Language'), findsNothing);
    expect(find.text('భాష'), findsWidgets);
  });
}
