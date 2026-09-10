import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/capture/presentation/capture_page.dart';
import '../features/checklist/presentation/frame_guide_page.dart';
import '../features/checklist/presentation/framing_quiz_page.dart';
import '../features/checklist/presentation/light_quiz_page.dart';
import '../features/checklist/presentation/material_selection_page.dart';
import '../features/checklist/presentation/photo_list_page.dart';
import '../features/checklist/presentation/pick_frames_page.dart';
import '../features/checklist/presentation/product_setup_page.dart';
import '../features/checklist/presentation/technique_selection_page.dart';
import '../features/completion/presentation/completion_page.dart';
import '../features/gallery/presentation/product_viewer_page.dart';
import '../features/home/presentation/click_social_home_page.dart';
import '../features/home/presentation/create_post_page.dart';
import '../features/home/presentation/instagram_setup_page.dart';
import '../features/home/presentation/posting_plan_page.dart';
import '../features/home/presentation/practice_feed_page.dart';
import '../features/home/presentation/progress_badges_page.dart';
import '../features/home/presentation/read_the_numbers_page.dart';
import '../features/instruction/presentation/lighting_setup_page.dart';
import '../features/instruction/presentation/tutorial_page.dart';
import '../features/onboarding/presentation/opening_sequence_page.dart';
import '../features/review/presentation/review_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../features/shot_type/presentation/shot_and_style_page.dart';
import '../shared/widgets/app_shell.dart';
import 'theme/app_colors.dart';

/// Route names, referenced by screens rather than raw path strings.
abstract final class AppRoute {
  static const String splash = 'splash';
  static const String home = 'home';
  static const String gallery = 'gallery';
  static const String settings = 'settings';
  static const String account = 'account';
  static const String instagramSetup = 'instagramSetup';
  static const String createPost = 'createPost';
  static const String postingPlan = 'postingPlan';
  static const String readTheNumbers = 'readTheNumbers';
  static const String productSetup = 'productSetup';
  static const String technique = 'technique';
  static const String framingQuiz = 'framingQuiz';
  static const String pickFrames = 'pickFrames';
  static const String frameGuide = 'frameGuide';
  static const String lightQuiz = 'lightQuiz';
  static const String material = 'material';
  static const String photoList = 'photoList';
  static const String shotAndStyle = 'shotAndStyle';
  static const String lightingSetup = 'lightingSetup';
  static const String tutorial = 'tutorial';
  static const String capture = 'capture';
  static const String review = 'review';
  static const String completion = 'completion';
  static const String productViewer = 'productViewer';
}

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.splash,
        builder: (context, state) => const OpeningSequencePage(),
      ),

      // The three tabs that share the bottom navigation shell.
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: AppRoute.home,
            builder: (context, state) => const ClickSocialHomePage(),
          ),
          GoRoute(
            path: '/gallery',
            name: AppRoute.gallery,
            builder: (context, state) => const PracticeFeedPage(),
          ),
          GoRoute(
            path: '/settings',
            name: AppRoute.settings,
            builder: (context, state) => const ProgressBadgesPage(),
          ),
        ],
      ),

      // Account / cloud backup (former Settings tab), opened from Progress.
      GoRoute(
        path: '/account',
        name: AppRoute.account,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const Scaffold(
          backgroundColor: AppColors.background,
          body: SettingsPage(),
        ),
      ),

      // Lesson screens sit above the shell (no bottom bar), like capture.
      GoRoute(
        path: '/lesson/instagram',
        name: AppRoute.instagramSetup,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const InstagramSetupPage(),
      ),
      GoRoute(
        path: '/lesson/create-post',
        name: AppRoute.createPost,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CreatePostPage(),
      ),
      GoRoute(
        path: '/lesson/posting-plan',
        name: AppRoute.postingPlan,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const PostingPlanPage(),
      ),
      GoRoute(
        path: '/lesson/read-the-numbers',
        name: AppRoute.readTheNumbers,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ReadTheNumbersPage(),
      ),

      // The capture flow runs above the shell so the bottom bar is out of the
      // way once a shoot has started.
      // Capture setup: product → material → technique → variety → quizzes → list.
      GoRoute(
        path: '/product/setup',
        name: AppRoute.productSetup,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ProductSetupPage(
          setId: state.uri.queryParameters['setId'],
          materialId: state.uri.queryParameters['material'],
        ),
      ),
      GoRoute(
        path: '/product/material',
        name: AppRoute.material,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => MaterialSelectionPage(
          categoryId: state.uri.queryParameters['category'],
          productName: state.uri.queryParameters['name'],
          productLabel: state.uri.queryParameters['product'],
        ),
      ),
      GoRoute(
        path: '/product/technique',
        name: AppRoute.technique,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => TechniqueSelectionPage(
          categoryId: state.uri.queryParameters['category'],
          productName: state.uri.queryParameters['name'],
          materialId: state.uri.queryParameters['material'],
          productLabel: state.uri.queryParameters['product'],
        ),
      ),
      GoRoute(
        path: '/product/:setId/pick-frames',
        name: AppRoute.pickFrames,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => PickFramesPage(
          setId: state.pathParameters['setId']!,
          categoryId: state.uri.queryParameters['category'] ?? 'saree',
          materialId: state.uri.queryParameters['material'],
          technique: state.uri.queryParameters['technique'],
        ),
      ),
      GoRoute(
        path: '/product/:setId/framing-quiz',
        name: AppRoute.framingQuiz,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final framesRaw = state.uri.queryParameters['frames'] ?? '';
          final frames = framesRaw
              .split(',')
              .map((e) => int.tryParse(e.trim()))
              .whereType<int>()
              .toList();
          return FramingQuizPage(
            setId: state.pathParameters['setId']!,
            categoryId: state.uri.queryParameters['category'] ?? 'saree',
            frameIndexes: frames,
            materialId: state.uri.queryParameters['material'],
            technique: state.uri.queryParameters['technique'],
          );
        },
      ),
      GoRoute(
        path: '/product/:setId/frame-guide',
        name: AppRoute.frameGuide,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => FrameGuidePage(
          setId: state.pathParameters['setId']!,
          frameIndex:
              int.tryParse(state.uri.queryParameters['frame'] ?? '') ?? 0,
          clusterId: state.uri.queryParameters['cluster'],
          categoryId: state.uri.queryParameters['category'],
          technique: state.uri.queryParameters['technique'],
        ),
      ),
      GoRoute(
        path: '/product/:setId/light-quiz',
        name: AppRoute.lightQuiz,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => LightQuizPage(
          setId: state.pathParameters['setId']!,
          categoryId: state.uri.queryParameters['category'],
          materialId: state.uri.queryParameters['material'],
          technique: state.uri.queryParameters['technique'],
        ),
      ),
      GoRoute(
        path: '/product/:setId/list',
        name: AppRoute.photoList,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => PhotoListPage(
          setId: state.pathParameters['setId']!,
        ),
      ),
      GoRoute(
        path: '/product/:setId/shot',
        name: AppRoute.shotAndStyle,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ShotAndStylePage(
          setId: state.pathParameters['setId']!,
        ),
      ),
      GoRoute(
        path: '/product/:setId/lighting',
        name: AppRoute.lightingSetup,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => LightingSetupPage(
          setId: state.pathParameters['setId']!,
        ),
      ),
      GoRoute(
        path: '/product/:setId/tutorial',
        name: AppRoute.tutorial,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => TutorialPage(
          setId: state.pathParameters['setId']!,
        ),
      ),
      // Alignment is no longer a screen of its own: the grid, the alignment
      // instruction and the live checks all live on the camera.
      GoRoute(
        path: '/product/:setId/capture',
        name: AppRoute.capture,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => CapturePage(
          setId: state.pathParameters['setId']!,
        ),
      ),
      GoRoute(
        path: '/product/:setId/review',
        name: AppRoute.review,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ReviewPage(
          setId: state.pathParameters['setId']!,
        ),
      ),
      GoRoute(
        path: '/product/:setId/complete',
        name: AppRoute.completion,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => CompletionPage(
          setId: state.pathParameters['setId']!,
        ),
      ),
      GoRoute(
        path: '/product/:setId/photos',
        name: AppRoute.productViewer,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ProductViewerPage(
          setId: state.pathParameters['setId']!,
        ),
      ),
    ],
  );
}
