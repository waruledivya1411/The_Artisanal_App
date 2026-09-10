import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/common.dart';
import '../click_social_frames.dart';
import 'photo_lesson_chrome.dart';

/// HTML photoStep 4 — Pick your frames (at least two).
class PickFramesPage extends StatefulWidget {
  const PickFramesPage({
    required this.setId,
    required this.categoryId,
    this.materialId,
    this.technique,
    super.key,
  });

  final String setId;
  final String categoryId;
  final String? materialId;
  final String? technique;

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

  @override
  Widget build(BuildContext context) {
    final frames = _frames;
    final l10n = AppLocalizations.of(context);

    return PhotoLessonChrome(
      stepIndex: 3,
      isPanel: _isPanel,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          Text(
            l10n.csPickYourFrames,
            style: AppTypography.displayMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.csPickFramesSub,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: frames.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, i) {
              final frame = frames[i];
              final on = _picks.contains(frame.index);
              return InkWell(
                onTap: () => setState(() {
                  if (on) {
                    _picks.remove(frame.index);
                  } else {
                    _picks.add(frame.index);
                  }
                }),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: on ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GuideImage(
                          asset: frame.thumbAssetFor(
                            clusterId: _clusterId,
                            categoryId: widget.categoryId,
                            technique: widget.technique,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    frame.name,
                                    style: AppTypography.labelLarge.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    frame.content,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.labelSmall.copyWith(
                                      fontSize: 10.5,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color:
                                    on ? AppColors.primary : Colors.transparent,
                                border: Border.all(
                                  color: on
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                  width: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (_ready) ...[
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: const RoundedRectangleBorder(),
                ),
                child: Text(
                  l10n.csNextFrameIt,
                  style: AppTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _continue() async {
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
    if (!mounted) return;

    final q = <String>[
      'category=${widget.categoryId}',
      'frames=${picks.join(',')}',
      if (widget.materialId != null && widget.materialId!.isNotEmpty)
        'material=${widget.materialId}',
      if (widget.technique != null && widget.technique!.isNotEmpty)
        'technique=${widget.technique}',
    ].join('&');
    context.go('/product/${widget.setId}/framing-quiz?$q');
  }
}
