import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/common.dart';
import '../../../shared/motion/motion.dart';
import '../click_social_frames.dart';
import '../../home/click_social_store.dart';
import '../../../data/services/click_social_sync_service.dart';
import 'photo_lesson_chrome.dart';

/// HTML photoStep 4 — Pick your frames (at least two).
///
/// Both reference mock screens (core 4 + extra shots) live on this one
/// scrollable page.
class PickFramesPage extends StatefulWidget {
  const PickFramesPage({
    required this.setId,
    required this.categoryId,
    this.materialId,
    this.technique,
    this.productLabel,
    super.key,
  });

  final String setId;
  final String categoryId;
  final String? materialId;
  final String? technique;
  final String? productLabel;

  @override
  State<PickFramesPage> createState() => _PickFramesPageState();
}

class _PickFramesPageState extends State<PickFramesPage> {
  final Set<int> _picks = {};
  String? _clusterId;

  bool get _isPanel => clickSocialIsPanel(
        categoryId: widget.categoryId,
        technique: widget.technique,
      );

  List<ClickSocialFrame> get _frames => framesForSelection(isPanel: _isPanel);

  /// Core shots (0–3) stay last in the grid — same list, no separate section.
  static const _coreIndexes = {0, 1, 2, 3};

  List<ClickSocialFrame> get _orderedFrames {
    final extras = <ClickSocialFrame>[];
    final core = <ClickSocialFrame>[];
    for (final frame in _frames) {
      if (_coreIndexes.contains(frame.index)) {
        core.add(frame);
      } else {
        extras.add(frame);
      }
    }
    return [...extras, ...core];
  }

  bool get _ready => _picks.length >= 2;

  @override
  void initState() {
    super.initState();
    _loadCluster();
  }

  Future<void> _loadCluster() async {
    final String? clusterId;
    try {
      final prefs = await SharedPreferences.getInstance();
      clusterId = prefs.getString(clickSocialClusterKey);
    } catch (_) {
      return;
    }
    if (!mounted) return;
    setState(() => _clusterId = clusterId);
  }

  void _goBack() {
    // Technique/product use context.go into this page, so there is often
    // nothing to pop — return to the previous lesson step explicitly.
    if (_isPanel) {
      context.goNamed(AppRoute.productSetup);
      return;
    }

    final product = widget.productLabel;
    context.goNamed(
      AppRoute.technique,
      queryParameters: {
        'category': widget.categoryId,
        if (widget.materialId != null && widget.materialId!.isNotEmpty)
          'material': widget.materialId!,
        if (product != null && product.isNotEmpty) ...{
          'name': product,
          'product': product,
        },
      },
    );
  }

  void _toggle(int index) {
    setState(() {
      if (_picks.contains(index)) {
        _picks.remove(index);
      } else {
        _picks.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return PhotoLessonChrome(
      stepIndex: 3,
      isPanel: _isPanel,
      onBack: _goBack,
      footer: PhotoContinueBar(
        enabled: _ready,
        label: l10n.continueAction,
        onBack: _goBack,
        onContinue: _continue,
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
        children: [
          Text(
            l10n.csPickYourFrames,
            style: AppTypography.displayMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.csPickFramesSub,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 14),
          _FramePickGrid(
            frames: _orderedFrames,
            picks: _picks,
            clusterId: _clusterId,
            categoryId: widget.categoryId,
            technique: widget.technique,
            onToggle: _toggle,
            staggerOffset: 0,
          ),
        ],
      ),
    );
  }

  Future<void> _continue() async {
    if (!_ready) return;
    final picks = _picks.toList()..sort();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      clickSocialFramePicksKey(widget.setId),
      picks.join(','),
    );
    await prefs.setString(
      clickSocialTechniqueKey(widget.setId),
      widget.technique ?? '',
    );
    await ClickSocialStore.touch(prefs);
    ClickSocialSync.schedulePush();
    if (!mounted) return;

    final q = <String>[
      'category=${widget.categoryId}',
      'frames=${picks.join(',')}',
      if (widget.materialId != null && widget.materialId!.isNotEmpty)
        'material=${widget.materialId}',
      if (widget.technique != null && widget.technique!.isNotEmpty)
        'technique=${widget.technique}',
      if (widget.productLabel != null && widget.productLabel!.isNotEmpty)
        'product=${Uri.encodeComponent(widget.productLabel!)}',
    ].join('&');
    context.go('/product/${widget.setId}/framing-quiz?$q');
  }
}

class _FramePickGrid extends StatelessWidget {
  const _FramePickGrid({
    required this.frames,
    required this.picks,
    required this.clusterId,
    required this.categoryId,
    required this.technique,
    required this.onToggle,
    required this.staggerOffset,
  });

  final List<ClickSocialFrame> frames;
  final Set<int> picks;
  final String? clusterId;
  final String categoryId;
  final String? technique;
  final void Function(int index) onToggle;
  final int staggerOffset;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: frames.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, i) {
        final frame = frames[i];
        final on = picks.contains(frame.index);
        return FadeSlideIn.staggered(
          index: staggerOffset + i,
          child: _FramePickCard(
            name: frame.name,
            content: frame.content,
            selected: on,
            imageAsset: frame.thumbAssetFor(
              clusterId: clusterId,
              categoryId: categoryId,
              technique: technique,
            ),
            onTap: () => onToggle(frame.index),
          ),
        );
      },
    );
  }
}

class _FramePickCard extends StatelessWidget {
  const _FramePickCard({
    required this.name,
    required this.content,
    required this.selected,
    required this.imageAsset,
    required this.onTap,
  });

  final String name;
  final String content;
  final bool selected;
  final String imageAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      elevate: true,
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: AppColors.white,
        elevation: selected ? 3 : 1,
        shadowColor: AppColors.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppMotion.select,
            curve: AppMotion.curve,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.borderLight,
                width: selected ? 2 : 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(14),
                        ),
                        child: GuideImage(
                          asset: imageAsset,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (selected)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Selected',
                              style: AppTypography.navLabel.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 8, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelLarge.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelSmall.copyWith(
                                fontSize: 10.5,
                                height: 1.25,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      AnimatedContainer(
                        duration: AppMotion.select,
                        curve: AppMotion.curve,
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : AppColors.border,
                            width: 1.6,
                          ),
                        ),
                        child: AnimatedCheck(
                          visible: selected,
                          color: AppColors.white,
                          size: 13,
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
    );
  }
}
