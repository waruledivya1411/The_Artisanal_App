import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../domain/entities/placement_kind.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/motion/motion.dart';
import '../../checklist/click_social_frames.dart';
import '../../home/shot_sets_controller.dart';
import '../capture_session_controller.dart';
import 'widgets/guide_overlay.dart';

/// Shown after Capture on a Click & Social frame, before the live shutter.
///
/// The photo is a correctly placed product. The grid is the same overlay as
/// the live camera. Placement tips are Flutter text — never baked into the
/// JPEG — so they stay readable.
class CaptureReferencePage extends ConsumerWidget {
  const CaptureReferencePage({required this.setId, super.key});

  final String setId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppCopy.of(context);
    final session = ref.watch(captureSessionProvider);
    final set = ref.watch(shotSetProvider(setId));
    final template = session.template;
    final frameIndex = _frameIndex(template?.id);
    final title = (frameIndex == null
            ? (template?.name ?? l10n.csFrameFallback)
            : AppCopy.csFrameName(l10n, frameIndex))
        .toUpperCase();
    final asset = frameIndex == null
        ? template?.referenceImageAsset
        : clickSocialCameraRefAsset(frameIndex);
    final placement = frameIndex == null
        ? PlacementKind.fromTemplateId(template?.id)
        : PlacementKind.fromFrameIndex(frameIndex);
    final hint = AppCopy.csPlacementHint(l10n, placement);
    final lines = frameIndex == null
        ? const <String>[]
        : AppCopy.csCameraLines(l10n, frameIndex);

    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.cameraScrim,
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: AppDimens.appBarHeight,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.white),
                      onPressed: () => context.pop(),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.csPlaceItLikeThis,
                            style: AppTypography.overline.copyWith(
                              color: AppColors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.displayMedium.copyWith(
                              color: AppColors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: asset == null
                ? const SizedBox.shrink()
                : ColoredBox(
                    color: AppColors.textPrimary,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              asset,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              filterQuality: FilterQuality.high,
                              isAntiAlias: true,
                            ),
                            if (template != null)
                              GuideOverlay(
                                grid: template.grid,
                                placement: placement,
                                gridPath: template.gridPath,
                                caption: hint,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          Container(
            color: const Color(0xFF1A202C),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.space20,
                  AppDimens.space16,
                  AppDimens.space20,
                  AppDimens.space16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if ((set?.productName ?? '').isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          set == null
                              ? ''
                              : AppCopy.csProductLabel(l10n, set.productName),
                          textAlign: TextAlign.center,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.white.withValues(alpha: 0.75),
                          ),
                        ),
                      ),
                    for (var i = 0; i < lines.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor: AppColors.primary,
                                  child: Text(
                                    '${i + 1}',
                                    style: AppTypography.labelLarge.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    lines[i],
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Pressable(
                      child: FilledButton(
                        onPressed: () => context.pushNamed(
                          AppRoute.capture,
                          pathParameters: {'setId': setId},
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          minimumSize: const Size.fromHeight(48),
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: Text(
                          l10n.csOpenCameraCta,
                          style: AppTypography.labelLarge.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static int? _frameIndex(String? templateId) {
    const prefix = 'cs_frame_';
    if (templateId == null || !templateId.startsWith(prefix)) return null;
    return int.tryParse(templateId.substring(prefix.length));
  }
}
