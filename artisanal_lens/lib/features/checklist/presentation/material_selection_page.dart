import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/motion/motion.dart';
import 'photo_lesson_chrome.dart';

/// HTML photoStep 1 — What is it made of?
///
/// Vertical material cards (image + title + tip + Select), with photos
/// matched to the chosen product.
class MaterialSelectionPage extends StatefulWidget {
  const MaterialSelectionPage({
    this.categoryId,
    this.productName,
    this.productLabel,
    super.key,
  });

  final String? categoryId;
  final String? productName;
  final String? productLabel;

  @override
  State<MaterialSelectionPage> createState() => _MaterialSelectionPageState();
}

class _MaterialSelectionPageState extends State<MaterialSelectionPage> {
  static const _materialIds = ['cotton', 'silk'];

  String? _selected;

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

  String get _productDisplayName => switch (_productKey) {
        'mekhela' => 'mekhela',
        'sari' => 'sari',
        'stole' => 'stole',
        'accessories' => 'accessories',
        _ => 'product',
      };

  String _assetFor(String materialId) =>
      'assets/images/materials/by_product/${_productKey}_$materialId.png';

  String _labelFor(AppLocalizations l10n, String materialId) {
    final material = switch (materialId) {
      'cotton' => _titleCase(l10n.csMaterialCotton),
      'silk' => _titleCase(l10n.csMaterialSilk),
      _ => materialId,
    };
    final product = _productDisplayName;
    if (product == 'product') return material;
    return '$material $product';
  }

  String _blurbFor(String materialId) => switch (materialId) {
        'cotton' => 'Matte finish · Soft woven texture',
        'silk' => 'Lustrous finish · Rich colour & drape',
        _ => '',
      };

  String _titleCase(String raw) {
    final t = raw.trim().toLowerCase();
    if (t.isEmpty) return raw;
    return '${t[0].toUpperCase()}${t.substring(1)}';
  }

  void _continue() {
    final selected = _selected;
    if (selected == null) return;
    context.pushNamed(
      AppRoute.technique,
      queryParameters: {
        if (widget.categoryId != null) 'category': widget.categoryId!,
        if (widget.productName != null) 'name': widget.productName!,
        if (widget.productLabel != null) 'product': widget.productLabel!,
        'material': selected,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return PhotoLessonChrome(
      stepIndex: 1,
      footer: PhotoContinueBar(
        enabled: _selected != null,
        label: l10n.continueAction,
        onBack: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.goNamed(AppRoute.home);
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
              l10n.csWhatIsItMadeOf,
              style: AppTypography.displayMedium.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.csMaterialDecidesLight,
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Column(
                children: [
                  for (var i = 0; i < _materialIds.length; i++) ...[
                    if (i > 0) const SizedBox(height: 12),
                    Expanded(
                      child: _MaterialChoiceCard(
                        title: _labelFor(l10n, _materialIds[i]),
                        blurb: _blurbFor(_materialIds[i]),
                        imageAsset: _assetFor(_materialIds[i]),
                        selected: _selected == _materialIds[i],
                        selectLabel: 'Select',
                        onTap: () =>
                            setState(() => _selected = _materialIds[i]),
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
}

class _MaterialChoiceCard extends StatelessWidget {
  const _MaterialChoiceCard({
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
