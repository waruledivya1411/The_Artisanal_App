import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/providers.dart';
import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../domain/entities/shot_guidance.dart';
import '../../../domain/entities/shot_set.dart';
import '../../../domain/entities/shot_type.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/painting/svg_path.dart';
import '../../../shared/widgets/common.dart';
import '../../home/shot_sets_controller.dart';
import '../../instruction/instruction_flow.dart';
import '../../home/click_social_lessons.dart';
import '../click_social_frames.dart';
import 'photo_lesson_chrome.dart';

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

  /// HTML `expandedShot` — which frame's drop zone is open.
  int? _expandedShot;

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
    final allDone = done == slots.length && slots.isNotEmpty;
    final left = slots.length - done;
    final isPanel = clickSocialIsPanel(
      categoryId: set.categoryId,
      technique: _technique,
    );

    return PhotoLessonChrome(
      stepIndex: isPanel ? 4 : 6,
      isPanel: isPanel,
      onBack: () => _goBackToLightQuiz(set),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${l10n.csPhotosToCaptureHeading} ',
                  style: AppTypography.displayMedium.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextSpan(
                  text: '$done/${slots.length}',
                  style: AppTypography.displayMedium.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.csOpenGuideDropTick,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < slots.length; i++) ...[
            _FrameSlotCard(
              slot: slots[i],
              frame: frames[i],
              tip: frames[i].tipFor(clusterId: _clusterId),
              expanded: _expandedShot == frames[i].index,
              onToggle: () => setState(() {
                final id = frames[i].index;
                _expandedShot = _expandedShot == id ? null : id;
              }),
              onOpenGuide: () => _openGuide(set, frames[i].index),
              onDropZone: () => _pickAndSaveShot(slots[i]),
              onMark: () => _markFrame(slots[i]),
            ),
            if (i != slots.length - 1) const SizedBox(height: 8),
          ],
          if (!allDone && left > 0) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              color: AppColors.surfaceMuted,
              child: Text(
                left == slots.length
                    ? l10n.csDropFirstShot
                    : l10n.csShotsLeft(left),
                style: AppTypography.labelSmall.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: allDone ? () => _finishPhotoLesson(l10n) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.surfaceMuted,
                foregroundColor: AppColors.white,
                disabledForegroundColor: AppColors.textMuted,
                shape: const RoundedRectangleBorder(),
              ),
              child: Text(
                l10n.csFinishEarnBadge,
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: allDone ? AppColors.white : AppColors.textMuted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// HTML `completePhoto`: badge toast → home (not the BTP completion screen).
  Future<void> _finishPhotoLesson(AppLocalizations l10n) {
    return ClickSocialLessons.complete(
      context,
      prefsKey: ClickSocialLessons.photoDoneKey,
      badgeLabel: l10n.csBadgePhotographer,
      routeName: AppRoute.home,
    );
  }

  /// HTML `image-slot`: pick a photo from the library (no in-app camera).
  Future<void> _pickAndSaveShot(ShotSlot slot) async {
    if (slot.isFilled) return;

    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 92,
    );
    if (picked == null || !mounted) return;

    try {
      final stored = await ref.read(photoStorageProvider).persist(
            picked.path,
            setId: widget.setId,
          );
      final savedToGallery =
          await ref.read(photoStorageProvider).saveToDeviceGallery(stored);

      final shot = CapturedShot(
        id: 'shot_${DateTime.now().microsecondsSinceEpoch}',
        setId: widget.setId,
        shotType: ShotType.photography,
        slotIndex: slot.index,
        filePath: stored,
        capturedAt: DateTime.now(),
        savedToDeviceGallery: savedToGallery,
      );

      await ref
          .read(shotSetsProvider.notifier)
          .addShot(setId: widget.setId, shot: shot);

      if (!mounted) return;
      final latest = ref.read(shotSetProvider(widget.setId));
      final frames = _frames;
      final remaining = latest == null || frames == null
          ? 0
          : frames.where((f) => _shotFor(latest, f.index) == null).length;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            remaining == 0
                ? AppLocalizations.of(context).csAllShotsSaved
                : AppLocalizations.of(context).csShotSavedLeft(remaining),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save photo: $error')),
      );
    }
  }

  /// HTML `mark`: tick by dropping a shot, or undo a filled slot.
  Future<void> _markFrame(ShotSlot slot) async {
    final shot = slot.shot;
    if (shot != null) {
      await ref.read(shotSetsProvider.notifier).removeShot(
            setId: widget.setId,
            shotId: shot.id,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).csTickedUndo),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }
    await _pickAndSaveShot(slot);
  }

  void _goBackToLightQuiz(ShotSet set) {
    // Opened via context.go from the light quiz — pop often has nowhere to go.
    final frames = _picks?.join(',') ?? '';
    final q = <String>[
      'category=${set.categoryId}',
      if (frames.isNotEmpty) 'frames=$frames',
      if (set.materialId != null && set.materialId!.isNotEmpty)
        'material=${set.materialId}',
      if (_technique != null && _technique!.isNotEmpty)
        'technique=$_technique',
    ].join('&');
    context.go('/product/${widget.setId}/light-quiz?$q');
  }

  Future<void> _openGuide(ShotSet set, int frameIndex) async {
    final result = await context.pushNamed<int>(
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
    if (!mounted) return;
    // HTML TAKE THE SHOT closes the guide and expands that shot's drop zone.
    if (result != null) {
      setState(() => _expandedShot = result);
    }
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

/// HTML `fiveShots` row: checkbox, thumb, name+tip, GUIDE, expandable drop zone.
class _FrameSlotCard extends StatelessWidget {
  const _FrameSlotCard({
    required this.slot,
    required this.frame,
    required this.tip,
    required this.expanded,
    required this.onToggle,
    required this.onOpenGuide,
    required this.onDropZone,
    required this.onMark,
  });

  final ShotSlot slot;
  final ClickSocialFrame frame;
  final String tip;
  final bool expanded;
  final VoidCallback onToggle;
  final VoidCallback onOpenGuide;
  final VoidCallback onDropZone;
  final VoidCallback onMark;

  @override
  Widget build(BuildContext context) {
    final filled = slot.isFilled;
    final boxBorder = filled ? AppColors.primary : AppColors.textPrimary;
    final boxBg = filled ? AppColors.primary : Colors.transparent;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onToggle,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Row(
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: boxBg,
                              border: Border.all(color: boxBorder, width: 2),
                            ),
                            child: filled
                                ? const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: AppColors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 48,
                            height: 44,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: filled
                                  ? PhotoThumb(path: slot.shot!.filePath)
                                  : GuideImage(
                                      asset:
                                          slot.template!.referenceImageAsset!,
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  frame.name,
                                  style: AppTypography.bodyLarge.copyWith(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
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
                              ],
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
          if (expanded) ...[
            const Divider(height: 2, thickness: 2, color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onDropZone,
                      child: SizedBox(
                        height: 150,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (filled)
                              ClipRRect(
                                child: PhotoThumb(path: slot.shot!.filePath),
                              )
                            else
                              ColoredBox(
                                color: AppColors.surfaceMuted
                                    .withValues(alpha: 0.35),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.image_outlined,
                                        size: 28,
                                        color: AppColors.textMuted
                                            .withValues(alpha: 0.7),
                                      ),
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .csDropYourShotHere(
                                            frame.name.toLowerCase(),
                                          ),
                                          textAlign: TextAlign.center,
                                          style: AppTypography.labelSmall
                                              .copyWith(
                                            fontSize: 12,
                                            color: AppColors.textMuted,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            CustomPaint(
                              painter: _DashedDropZonePainter(
                                gridPath: frame.gridPath,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: onMark,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(
                          color: AppColors.border,
                          width: 1.5,
                        ),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: Text(
                        filled
                            ? AppLocalizations.of(context).csTickedUndo
                            : AppLocalizations.of(context).csMarkAsTaken,
                        style: AppTypography.labelLarge.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Drop-zone dashed border + per-frame HTML `gridPath` overlay.
class _DashedDropZonePainter extends CustomPainter {
  const _DashedDropZonePainter({required this.gridPath});

  final String gridPath;

  @override
  void paint(Canvas canvas, Size size) {
    final border = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    _dashedRect(canvas, Offset.zero & size, border, dash: 6, gap: 4);

    final grid = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.square;
    paintSvgPath(canvas, size, gridPath, grid);
  }

  void _dashedRect(
    Canvas canvas,
    Rect rect,
    Paint paint, {
    required double dash,
    required double gap,
  }) {
    void line(Offset from, Offset to) {
      final delta = to - from;
      final length = delta.distance;
      if (length == 0) return;
      final step = delta / length;
      var travelled = 0.0;
      while (travelled < length) {
        final segment = (travelled + dash).clamp(0.0, length);
        canvas.drawLine(from + step * travelled, from + step * segment, paint);
        travelled += dash + gap;
      }
    }

    line(rect.topLeft, rect.topRight);
    line(rect.topRight, rect.bottomRight);
    line(rect.bottomRight, rect.bottomLeft);
    line(rect.bottomLeft, rect.topLeft);
  }

  @override
  bool shouldRepaint(covariant _DashedDropZonePainter oldDelegate) =>
      oldDelegate.gridPath != gridPath;
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
