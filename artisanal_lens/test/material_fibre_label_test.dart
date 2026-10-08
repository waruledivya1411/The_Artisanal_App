import 'package:artisanal_lens/features/checklist/click_social_frames.dart';
import 'package:artisanal_lens/features/checklist/presentation/material_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/test_l10n.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('Kamrup and Nalbari list cotton eri mulberry tussar and muga',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      clickSocialClusterKey: 'assam',
    });
    await tester.binding.setSurfaceSize(const Size(400, 3600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        child: l10nApp(home: const MaterialSelectionPage()),
      ),
    );
    await tester.pumpAndSettle();

    for (final name in [
      'Cotton',
      'Eri',
      'Mulberry',
      'Tussar',
      'Muga',
    ]) {
      expect(find.text(name), findsOneWidget);
    }
    expect(find.text('Silk'), findsNothing);
    expect(find.text('Zari'), findsNothing);
  });

  for (final cluster in ['maniabandha', 'gopalpur']) {
  testWidgets('$cluster lists its fibres with cotton and silk',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      clickSocialClusterKey: cluster,
    });
    await tester.binding.setSurfaceSize(const Size(400, 3600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        child: l10nApp(home: const MaterialSelectionPage()),
      ),
    );
    await tester.pumpAndSettle();

    for (final name in [
      'Cotton',
      'Silk',
      'Korea Tussar',
      'Mulberry',
      'Eri',
      'Liva/Viscose',
      'Linen',
      'Spun Tussar',
      'Noil',
    ]) {
      expect(find.text(name), findsOneWidget);
    }
  });
  }

  for (final product in ['Sari', 'Stole / Dupatta', 'Mekhela sador']) {
    testWidgets('material cards for $product name cotton and silk only',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        ProviderScope(
          child: l10nApp(
            home: MaterialSelectionPage(productLabel: product),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Cotton'), findsOneWidget);
      expect(find.text('Silk'), findsOneWidget);
      expect(find.textContaining('sari'), findsNothing);
      expect(find.textContaining('Saree'), findsNothing);
      expect(find.textContaining('stole'), findsNothing);
      expect(find.textContaining('dupatta'), findsNothing);
      expect(find.textContaining('mekhela'), findsNothing);
    });
  }
}
