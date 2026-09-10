import 'package:artisanal_lens/app/router.dart';
import 'package:artisanal_lens/domain/entities/shot_set.dart';
import 'package:artisanal_lens/domain/entities/shot_type.dart';
import 'package:artisanal_lens/features/capture/capture_session_controller.dart';
import 'package:artisanal_lens/features/checklist/click_social_frames.dart';
import 'package:artisanal_lens/features/checklist/presentation/frame_guide_page.dart';
import 'package:artisanal_lens/features/checklist/presentation/photo_list_page.dart';
import 'package:artisanal_lens/features/home/shot_sets_controller.dart';
import 'package:artisanal_lens/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _setId = 'cs_1';

ShotSet _set({List<CapturedShot> shots = const []}) => ShotSet(
      id: _setId,
      productName: 'Golden Mekhela',
      categoryId: 'saree',
      createdAt: DateTime(2026, 9, 1),
      shots: shots,
    );

/// Router with the two lesson screens plus a stub for the capture handover.
Widget _harness({required ShotSet set, required String initialLocation}) {
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/product/:setId/list',
        name: AppRoute.photoList,
        builder: (context, state) => PhotoListPage(setId: _setId),
      ),
      GoRoute(
        path: '/product/:setId/frame-guide',
        name: AppRoute.frameGuide,
        builder: (context, state) => FrameGuidePage(
          setId: _setId,
          frameIndex:
              int.tryParse(state.uri.queryParameters['frame'] ?? '') ?? 0,
          clusterId: state.uri.queryParameters['cluster'],
          categoryId: state.uri.queryParameters['category'],
          technique: state.uri.queryParameters['technique'],
        ),
      ),
      GoRoute(
        path: '/product/:setId/lighting',
        name: AppRoute.lightingSetup,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('LIGHTING STUB'))),
      ),
      GoRoute(
        path: '/product/:setId/shot',
        name: AppRoute.shotAndStyle,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('STYLE STUB'))),
      ),
    ],
  );

  return ProviderScope(
    overrides: [shotSetProvider.overrideWith((ref, id) => set)],
    child: MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
    ),
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({
      clickSocialFramePicksKey(_setId): '0,2,7',
      clickSocialTechniqueKey(_setId): 'WOVEN',
      clickSocialClusterKey: 'assam',
    });
  });

  testWidgets('checklist lists the picked frames, not the BTP templates',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _harness(set: _set(), initialLocation: '/product/$_setId/list'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Full display'), findsOneWidget);
    expect(find.text('Draped look'), findsOneWidget);
    expect(find.text('In-context lifestyle'), findsOneWidget);
    expect(find.text('Full Saree Display'), findsNothing);
    expect(find.text('Colour, pattern, material'), findsOneWidget);
    expect(find.text('GUIDE'), findsNWidgets(3));
    expect(find.text('0 / 3'), findsOneWidget);
    expect(
      find.text('Open the guide, take the shot, drop it in, tick it off.'),
      findsOneWidget,
    );
  });

  testWidgets('GUIDE opens the frame guide and walks to Take the shot',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _harness(set: _set(), initialLocation: '/product/$_setId/list'),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('GUIDE').first);
    await tester.pumpAndSettle();

    // Assam inserts the drape-styles page, so frame 0 has four steps.
    expect(find.text('FULL DISPLAY — SHOT 1 OF 3'), findsOneWidget);
    expect(find.text('Hang the whole piece'), findsOneWidget);
    expect(find.text('1 / 4'), findsOneWidget);

    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    expect(find.text('Three ways to style it'), findsOneWidget);

    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    expect(find.text('Align with the gridlines'), findsOneWidget);

    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    expect(find.text('Good examples'), findsOneWidget);
    expect(find.text('4 / 4'), findsOneWidget);
    expect(find.text('TAKE THE SHOT'), findsOneWidget);
  });

  testWidgets('Take the shot hands the frame to the capture flow',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _harness(
        set: _set(),
        initialLocation: '/product/$_setId/frame-guide?frame=7',
      ),
    );
    await tester.pumpAndSettle();

    while (find.text('TAKE THE SHOT').evaluate().isEmpty) {
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('TAKE THE SHOT'));
    await tester.pumpAndSettle();

    // Frames skip the fold step, so the flow goes straight to Lighting.
    expect(find.text('LIGHTING STUB'), findsOneWidget);
    expect(find.text('STYLE STUB'), findsNothing);

    final session =
        ProviderScope.containerOf(tester.element(find.text('LIGHTING STUB')))
            .read(captureSessionProvider);
    expect(session.setId, _setId);
    expect(session.shotType, ShotType.photography);
    expect(session.slotIndex, 7);
    expect(session.skipsStyle, isTrue);
    expect(session.template?.id, 'cs_frame_7');
    expect(session.template?.name, 'In-context lifestyle');
  });

  testWidgets('a shoot outside the lesson keeps the BTP template list',
      (tester) async {
    SharedPreferences.setMockInitialValues(const {});
    await tester.binding.setSurfaceSize(const Size(420, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _harness(set: _set(), initialLocation: '/product/$_setId/list'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Full Saree Display'), findsOneWidget);
    expect(find.text('GUIDE'), findsNothing);
  });
}
