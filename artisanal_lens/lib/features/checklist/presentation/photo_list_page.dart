import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../domain/entities/shot_guidance.dart';
import '../../../domain/entities/shot_set.dart';
import '../../../domain/entities/shot_type.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/widgets/common.dart';
import '../../home/shot_sets_controller.dart';
import '../../instruction/instruction_flow.dart';
import '../click_social_frames.dart';

/// The required-photo checklist — the hub of the photography journey.
///
/// After product details, and again after each accepted photograph, the
/// artisan lands here so they can see what is done, what remains, and which
/// photograph to take next.
///
/// A shoot started through the Click & Social lesson lists the frames the
/// learner picked (HTML `fiveShots`), each with its own multi-step guide. A
/// shoot started outside the lesson keeps the BTP template list.
class PhotoListPage extends ConsumerStatefulWidget {
  const PhotoListPage({required this.setId, super.key});

  final String setId;

  @override
  ConsumerState<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends ConsumerState<PhotoListPage> {
  /// Null when this shoot did not come through the Click & Social lesson.
  List<int>? _picks;
  String? _clusterId;
  String? _technique;

  @override
  void initState() {
    super.initState();
    _loadPicks();
  }

  Future<void> _loadPicks() async {
    final String? raw;
    final String? technique;
    final String? clusterId;
    try {
      final prefs = await SharedPreferences.getInstance();
      raw = prefs.getString(clickSocialFramePicksKey(widget.setId));
      technique = prefs.getString(clickSocialTechniqueKey(widget.setId));
      clusterId = prefs.getString(clickSocialClusterKey);
    } catch (_) {
      // No store to read: keep the template list rather than an empty screen.
      return;
    }
    if (!mounted || raw == null) return;

    final set = ref.read(shotSetProvider(widget.setId));
    setState(() {
      _clusterId = clusterId;
      _technique = technique;
      _picks = resolveFramePicks(
        raw!
            .split(',')
            .map((e) => int.tryParse(e.trim()))
            .whereType<int>()
            .toList(),
        isPanel: clickSocialIsPanel(
          categoryId: set?.categoryId,
          technique: technique,
        ),
      );
    });
  }

  /// The frames this shoot is shooting, or null when it is not a lesson shoot.
  List<ClickSocialFrame>? get _frames {
    final picks = _picks;
    if (picks == null) return null;
    return [for (final i in picks) ?frameByIndex(i)];
  }

  /// Click & Social slots: one per picked frame, indexed by HTML frame index.
  List<ShotSlot> _frameSlots(ShotSet set, List<ClickSocialFrame> frames) {
    return [
      for (final frame in frames)
        ShotSlot(
          shotType: ShotType.photography,
          index: frame.index,
          label: frame.name,
          shot: _shotFor(set, frame.index),
          template: asTemplate(
            frame,
            thumbAsset: frame.thumbAssetFor(
              clusterId: _clusterId,
              categoryId: set.categoryId,
              technique: _technique,
            ),
          ),
        ),
    ];
  }

  CapturedShot? _shotFor(ShotSet set, int index) {
    for (final shot in set.shots) {
      if (shot.shotType == ShotType.photography && shot.slotIndex == index) {
        return shot;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final set = ref.watch(shotSetProvider(widget.setId));

    if (set == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: Text(l10n.photos)),
        body: Center(
          child: Text(l10n.productUnavailable, style: AppTypography.bodyMedium),
        ),
      );
    }

    final frames = _frames;
    return frames == null
        ? _buildTemplateList(context, l10n, set)
        : _buildFrameList(context, l10n, set, frames);
  }

  // ---------------------------------------------------------------- lesson

  Widget _buildFrameList(
    BuildContext context,
    AppLocalizations l10n,
    ShotSet set,
    List<ClickSocialFrame> frames,
  ) {
    final slots = _frameSlots(set, frames);
    final done = slots.where((slot) => slot.isFilled).length;
    final next = slots.where((slot) => !slot.isFilled).firstOrNull;
    final ratio = slots.isEmpty ? 1.0 : done / slots.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(set.productName),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimens.pagePadding,
          AppDimens.space20,
          AppDimens.pagePadding,
          AppDimens.space32,
        ),
        children: [
          Text(l10n.photosToCapture, style: AppTypography.displayLarge),
          const SizedBox(height: AppDimens.space8),
          Text(
            'Open the guide, take the shot, drop it in, tick it off.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppDimens.space16),
          Row(
            children: [
              Expanded(child: AppProgressBar(value: ratio)),
              const SizedBox(width: AppDimens.space12),
              Text(
                '$done / ${slots.length}',
                style: AppTypography.labelLargeBold.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.space24),
          for (var i = 0; i < slots.length; i++) ...[
            _FrameSlotCard(
              slot: slots[i],
              frame: frames[i],
              tip: frames[i].tipFor(clusterId: _clusterId),
              isNext: next != null && next.index == slots[i].index,
              onOpenGuide: () => _openGuide(set, frames[i].index),
              onCapture: () => beginCaptureForSlot(
                context,
                ref,
                setId: widget.setId,
                slot: slots[i],
              ),
            ),
            if (i != slots.length - 1) const SizedBox(height: AppDimens.space12),
          ],
        ],
      ),
      bottomNavigationBar: BottomAction(
        child: next == null
            ? FilledButton.icon(
                onPressed: () => context.pushNamed(
                  AppRoute.completion,
                  pathParameters: {'setId': widget.setId},
                ),
                icon: const Icon(Icons.check, size: 20),
                label: Text(l10n.viewCompletedSet),
              )
            : FilledButton.icon(
                // The lesson teaches the frame before the shutter, so the
                // primary action is the guide, not the camera.
                onPressed: () => _openGuide(set, next.index),
                icon: const Icon(Icons.menu_book_outlined, size: 20),
                label: Text('OPEN THE GUIDE — ${next.label.toUpperCase()}'),
              ),
      ),
    );
  }

  void _openGuide(ShotSet set, int frameIndex) {
    context.pushNamed(
      AppRoute.frameGuide,
      pathParameters: {'setId': widget.setId},
      queryParameters: {
        'frame': '$frameIndex',
        'category': set.categoryId,
        'cluster': ?_clusterId,
        if (_technique != null && _technique!.isNotEmpty)
          'technique': _technique!,
      },
    );
  }

  // ---------------------------------------------------------------- legacy

  Widget _buildTemplateList(
    BuildContext context,
    AppLocalizations l10n,
    ShotSet set,
  ) {
    final slots = _orderedSlots(set);
    final next = set.nextSlot;
    final usesTemplates = set.usesPhotographyTemplates;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(set.productName),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimens.pagePadding,
          AppDimens.space20,
          AppDimens.pagePadding,
          AppDimens.space32,
        ),
        children: [
          Text(
            usesTemplates
                ? (set.usesSareePhotographyTemplates
                    ? l10n.sareePhotographyTemplatesTitle
                    : l10n.photographyTemplatesTitle)
                : l10n.photosToCapture,
            style: AppTypography.displayLarge,
          ),
          const SizedBox(height: AppDimens.space8),
          Text(
            usesTemplates
                ? (set.usesSareePhotographyTemplates
                    ? l10n.sareePhotographyTemplatesBody
                    : l10n.photographyTemplatesBody)
                : l10n.photosToCaptureBody,
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppDimens.space16),
          Row(
            children: [
              Expanded(child: AppProgressBar(value: set.completionRatio)),
              const SizedBox(width: AppDimens.space12),
              Text(
                '${set.completedCount} / ${set.requiredCount}',
                style: AppTypography.labelLargeBold.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.space24),
          for (var i = 0; i < slots.length; i++) ...[
            _PhotoSlotCard(
              slot: slots[i],
              categoryId: set.categoryId,
              isNext: next != null &&
                  next.shotType == slots[i].shotType &&
                  next.index == slots[i].index,
              onTap: (!slots[i].isFilled || usesTemplates)
                  ? () => beginCaptureForSlot(
                        context,
                        ref,
                        setId: widget.setId,
                        slot: slots[i],
                      )
                  : null,
            ),
            if (i != slots.length - 1) const SizedBox(height: AppDimens.space12),
          ],
        ],
      ),
      bottomNavigationBar: BottomAction(
        child: set.isFinished
            ? FilledButton.icon(
                onPressed: () => context.pushNamed(
                  AppRoute.completion,
                  pathParameters: {'setId': widget.setId},
                ),
                icon: const Icon(Icons.check, size: 20),
                label: Text(l10n.viewCompletedSet),
              )
            : FilledButton.icon(
                onPressed: next == null
                    ? null
                    : () => beginCaptureForSlot(
                          context,
                          ref,
                          setId: widget.setId,
                          slot: next,
                        ),
                icon: const Icon(Icons.photo_camera_outlined, size: 20),
                label: Text(
                  next == null
                      ? l10n.allPhotosCaptured
                      : l10n.takeNext(AppCopy.shotSlotLabel(l10n, next)),
                ),
              ),
      ),
    );
  }
}

/// Checklist order follows the recommended shooting order, not enum order,
/// so the next photograph sits where the artisan expects it.
List<ShotSlot> _orderedSlots(ShotSet set) {
  if (set.usesPhotographyTemplates) return set.slots;
  final lookup = {
    for (final slot in set.slots) '${slot.shotType.id}-${slot.index}': slot,
  };
  return [
    for (final type in ShotType.recommendedOrder)
      for (var i = 0; i < type.requiredCount; i++)
        lookup['${type.id}-$i']!,
  ];
}

/// HTML `fiveShots` row: thumbnail, name, tip, and a GUIDE button.
class _FrameSlotCard extends StatelessWidget {
  const _FrameSlotCard({
    required this.slot,
    required this.frame,
    required this.tip,
    required this.isNext,
    required this.onOpenGuide,
    required this.onCapture,
  });

  final ShotSlot slot;
  final ClickSocialFrame frame;
  final String tip;
  final bool isNext;
  final VoidCallback onOpenGuide;
  final VoidCallback onCapture;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filled = slot.isFilled;
    final borderColor = isNext
        ? AppColors.primary
        : filled
            ? AppColors.successBorder
            : AppColors.border;
    final background = isNext
        ? AppColors.surfaceSelected
        : filled
            ? AppColors.background
            : AppColors.surface;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: borderColor, width: isNext ? 2 : 1),
      ),
      // Intrinsic height so the GUIDE button and its divider run the full
      // height of the row, as they do in the HTML.
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: InkWell(
                // HTML flow: open the guide, then take the shot.
                onTap: filled ? onCapture : onOpenGuide,
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.space12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 56,
                        height: 52,
                        child: filled
                            ? PhotoThumb(path: slot.shot!.filePath)
                            : GuideImage(
                                asset: slot.template!.referenceImageAsset!,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(6),
                              ),
                      ),
                      const SizedBox(width: AppDimens.space12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              frame.name,
                              style: AppTypography.bodyLarge.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              frame.content,
                              style: AppTypography.labelSmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              tip,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelSmall.copyWith(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                            if (isNext) ...[
                              const SizedBox(height: AppDimens.space8),
                              AppPill(
                                label: l10n.nextPill,
                                background: AppColors.primary,
                                foreground: AppColors.textOnPrimary,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDimens.space8),
                      if (filled)
                        const CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.success,
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: AppColors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              width: 2,
              thickness: 2,
              color: AppColors.divider,
            ),
            SizedBox(
              width: 64,
              child: TextButton(
                onPressed: onOpenGuide,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(),
                  foregroundColor: AppColors.primary,
                ),
                child: Text(
                  'GUIDE',
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoSlotCard extends StatelessWidget {
  const _PhotoSlotCard({
    required this.slot,
    required this.categoryId,
    required this.isNext,
    required this.onTap,
  });

  final ShotSlot slot;
  final String categoryId;
  final bool isNext;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final filled = slot.isFilled;
    final template = slot.template;
    final l10n = AppLocalizations.of(context);
    final guidance = template != null
        ? ShotGuidance.fromTemplate(template)
        : slot.shotType.skipsStyleStep
            ? ShotGuidance.forSlot(
                slot.shotType,
                slot.index,
                categoryId: categoryId,
              )
            : null;
    final borderColor = isNext
        ? AppColors.primary
        : filled
            ? AppColors.successBorder
            : AppColors.border;
    final background = isNext
        ? AppColors.surfaceSelected
        : filled
            ? AppColors.background
            : AppColors.surface;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppDimens.space12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(
              color: borderColor,
              width: isNext ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 72,
                height: 88,
                child: filled
                    ? PhotoThumb(path: slot.shot!.filePath)
                    : PhotoThumb(
                        path: template?.referenceImageAsset ?? '',
                      ),
              ),
              const SizedBox(width: AppDimens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template != null
                          ? l10n.templateOverline
                          : AppCopy.shotTypeLabel(l10n, slot.shotType)
                              .toUpperCase(),
                      style: AppTypography.overline,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppCopy.shotSlotLabel(l10n, slot),
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (guidance != null && guidance.hasContent) ...[
                      Text(
                        l10n.contentPrefixed(
                          AppCopy.displayedContent(
                            l10n,
                            templateId: template?.id,
                            templateName: guidance.templateName,
                            fallback: guidance.content,
                          ),
                        ),
                        style: AppTypography.labelSmall,
                      ),
                      if (guidance.hasNeeds) ...[
                        const SizedBox(height: 2),
                        Text(
                          l10n.needsPrefixed(
                            AppCopy.displayedNeeds(
                                  l10n,
                                  templateId: template?.id,
                                  templateName: guidance.templateName,
                                  fallback: guidance.needs,
                                ) ??
                                guidance.needs!,
                          ),
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ] else
                      Text(
                        AppCopy.shotTypeChecklist(l10n, slot.shotType),
                        style: AppTypography.labelSmall,
                      ),
                    if (isNext) ...[
                      const SizedBox(height: AppDimens.space8),
                      AppPill(
                        label: l10n.nextPill,
                        background: AppColors.primary,
                        foreground: AppColors.textOnPrimary,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.space8),
              if (filled)
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.success,
                  child: Icon(Icons.check, size: 16, color: AppColors.white),
                )
              else
                Icon(
                  Icons.photo_camera_outlined,
                  color: isNext ? AppColors.primary : AppColors.textMuted,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
