import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/motion/motion.dart';
import '../../home/shot_sets_controller.dart';
import '../click_social_frames.dart';
import 'photo_lesson_chrome.dart';

/// HTML photoStep 2 — How is it made? (WOVEN / HAND-PAINTED).
///
/// Same vertical image cards as Cotton/Silk, with photos matched to the
/// chosen product + material + technique.
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

  String get _productKey {
    final raw = (widget.productLabel ?? widget.productName ?? '').trim();
    return switch (raw) {
      'Mekhela sador' => 'mekhela',
      'Sari' => 'sari',
      'Stole / Dupatta' => 'stole',
      'Accessories' => 'accessories',
      _ => 'sari',
    };
  }

  String get _materialKey {
    final raw = (widget.materialId ?? 'cotton').trim().toLowerCase();
    return raw == 'silk' ? 'silk' : 'cotton';
  }

  String get _productDisplayName => switch (_productKey) {
        'mekhela' => 'mekhela',
        'sari' => 'sari',
        'stole' => 'stole',
        'accessories' => 'accessories',
        _ => 'product',
      };

  String get _materialDisplayName =>
      _materialKey == 'silk' ? 'silk' : 'cotton';

  String _assetFor(String techniqueId) {
    final tech =
        techniqueId == 'HAND-PAINTED' ? 'handpainted' : 'woven';
    final base =
        'assets/images/techniques/by_product/${_productKey}_${_materialKey}_$tech';
    // Woven silk/stole/accessories assets are png; others are jpg.
    const pngKeys = {
      'mekhela_silk_woven',
      'sari_silk_woven',
      'stole_cotton_woven',
      'stole_silk_woven',
      'accessories_cotton_woven',
      'accessories_silk_woven',
    };
    final key = '${_productKey}_${_materialKey}_$tech';
    return pngKeys.contains(key) ? '$base.png' : '$base.jpg';
  }

  String _labelFor(AppLocalizations l10n, String techniqueId) {
    final technique =
        techniqueId == 'HAND-PAINTED' ? 'Hand-painted' : 'Woven';
    return '$technique $_materialDisplayName $_productDisplayName';
  }

  String _blurbFor(String techniqueId) => switch (techniqueId) {
        'WOVEN' => 'Loom-made · Texture, border & weave detail',
        'HAND-PAINTED' => 'Brushwork · Motif, line & colour detail',
        _ => '',
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return PhotoLessonChrome(
      stepIndex: 2,
      footer: PhotoContinueBar(
        enabled: _technique != null && !_busy,
        label: l10n.csNextPickYourFrames,
        onBack: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/home');
          }
        },
        onContinue: _continue,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.csHowIsItMade,
              style: AppTypography.displayMedium.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.csTechniqueSub,
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Column(
                children: [
                  for (var i = 0; i < _techniqueIds.length; i++) ...[
                    if (i > 0) const SizedBox(height: 12),
                    Expanded(
                      child: _TechniqueChoiceCard(
                        title: _labelFor(l10n, _techniqueIds[i]),
                        blurb: _blurbFor(_techniqueIds[i]),
                        imageAsset: _assetFor(_techniqueIds[i]),
                        selected: _technique == _techniqueIds[i],
                        selectLabel: 'Select',
                        onTap: () =>
                            setState(() => _technique = _techniqueIds[i]),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
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

class _TechniqueChoiceCard extends StatelessWidget {
  const _TechniqueChoiceCard({
    required this.title,
    required this.blurb,
    required this.imageAsset,
    required this.selected,
    required this.selectLabel,
    required this.onTap,
  });

  final String title;
  final String blurb;
  final String imageAsset;
  final bool selected;
  final String selectLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      elevate: true,
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: AppColors.white,
        elevation: selected ? 4 : 2,
        shadowColor: AppColors.primary.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppMotion.select,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
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
                          top: Radius.circular(18),
                        ),
                        child: Image.asset(
                          imageAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => ColoredBox(
                            color: AppColors.surfaceMuted,
                            child: Icon(
                              Icons.image_outlined,
                              color: AppColors.textMuted.withValues(alpha: 0.5),
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: AnimatedContainer(
                          duration: AppMotion.select,
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary
                                : AppColors.white.withValues(alpha: 0.95),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.white,
                              width: 1.5,
                            ),
                          ),
                          child: selected
                              ? const Icon(
                                  Icons.check_rounded,
                                  size: 15,
                                  color: AppColors.white,
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelLarge.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              blurb,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelSmall.copyWith(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedContainer(
                        duration: AppMotion.select,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary
                              : AppColors.surfaceSelected,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          selectLabel,
                          style: AppTypography.navLabel.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                            color: selected
                                ? AppColors.white
                                : AppColors.primary,
                          ),
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
