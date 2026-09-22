import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../home/shot_sets_controller.dart';
import '../click_social_frames.dart';
import 'photo_lesson_chrome.dart';
import '../../../shared/widgets/common.dart';

/// HTML photoStep 2 — How is it made? (WOVEN / HAND-PAINTED).
class TechniqueSelectionPage extends ConsumerStatefulWidget {
  const TechniqueSelectionPage({
    this.categoryId,
    this.productName,
    this.materialId,
    this.productLabel,
    super.key,
  });

  final String? categoryId;
  final String? productName;
  final String? materialId;
  final String? productLabel;

  @override
  ConsumerState<TechniqueSelectionPage> createState() =>
      _TechniqueSelectionPageState();
}

class _TechniqueSelectionPageState
    extends ConsumerState<TechniqueSelectionPage> {
  static const _techniqueIds = ['WOVEN', 'HAND-PAINTED'];

  String? _technique;
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels = {
      'WOVEN': l10n.csTechniqueWoven,
      'HAND-PAINTED': l10n.csTechniqueHandPainted,
    };

    return PhotoLessonChrome(
      stepIndex: 2,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          Text(
            l10n.csHowIsItMade,
            style: AppTypography.displayMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.csTechniqueSub,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (var i = 0; i < _techniqueIds.length; i++) ...[
                Expanded(
                  child: PhotoChoiceChip(
                    label: labels[_techniqueIds[i]]!,
                    selected: _technique == _techniqueIds[i],
                    onTap: () =>
                        setState(() => _technique = _techniqueIds[i]),
                    minHeight: 72,
                    fontSize: 15,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.w800,
                    useHeadingFont: true,
                  ),
                ),
                if (i == 0) const SizedBox(width: 8),
              ],
            ],
          ),
          if (_technique != null) ...[
            const SizedBox(height: 16),
            ActionWidth(
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _busy ? null : _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: Text(
                    l10n.csNextPickYourFrames,
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
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
    if (_busy || _technique == null) return;
    setState(() => _busy = true);

    try {
      final l10n = AppLocalizations.of(context);
      final categoryId = widget.categoryId;
      final materialId = widget.materialId;
      if (categoryId == null ||
          categoryId.isEmpty ||
          materialId == null ||
          materialId.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Missing product details. Go back and try again.'),
          ),
        );
        return;
      }

      final productName = (widget.productName?.trim().isNotEmpty == true)
          ? widget.productName!.trim()
          : AppCopy.categoryName(l10n, categoryId);

      final created = await ref.read(shotSetsProvider.notifier).createSet(
            productName: productName,
            categoryId: categoryId,
            materialId: materialId,
          );

      if (!mounted) return;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        clickSocialTechniqueKey(created.id),
        _technique!,
      );

      if (!mounted) return;
      final q = <String>[
        'category=$categoryId',
        'material=$materialId',
        'technique=${_technique!}',
        if (widget.productLabel != null && widget.productLabel!.isNotEmpty)
          'product=${Uri.encodeComponent(widget.productLabel!)}',
      ].join('&');
      context.go('/product/${created.id}/pick-frames?$q');
    } catch (error, stack) {
      debugPrint('Technique continue failed: $error\n$stack');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not continue: $error')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
