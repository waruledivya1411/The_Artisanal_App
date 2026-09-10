import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/widgets/common.dart';
import '../click_social_frames.dart';

/// HTML photoStep 4 — Pick your frames (at least two).
///
/// The frames are the twelve shared Click & Social frames, not the five BTP
/// templates for the category. The picks are saved against the shoot so the
/// framing quiz, the checklist and the guide all work from the same list.
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
      // No store to read: the default reference photographs still apply.
      return;
    }
    if (!mounted) return;
    setState(() => _clusterId = clusterId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final frames = _frames;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.csLesson01Title),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
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
        ],
      ),
      bottomNavigationBar: !_ready
          ? null
          : BottomAction(
              child: FilledButton.icon(
                onPressed: _continue,
                icon: const Icon(Icons.arrow_forward, size: 20),
                label: Text(l10n.csNextFrameIt),
              ),
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
