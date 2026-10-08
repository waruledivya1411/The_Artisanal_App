import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/motion/motion.dart';
import '../../home/shot_sets_controller.dart';
import '../click_social_frames.dart';
import 'photo_lesson_chrome.dart';

/// HTML photoStep 1 — What is it made of?
///
/// Vertical material cards (image + title + tip + Select). The product was
/// already chosen, so these cards name the fibre only. Kamrup & Nalbari,
/// Maniabandha, and Gopalpur also list their local fibres.
class MaterialSelectionPage extends ConsumerStatefulWidget {
  const MaterialSelectionPage({
    this.categoryId,
    this.productName,
    this.productLabel,
    this.materialId,
    super.key,
  });

  final String? categoryId;
  final String? productName;
  final String? productLabel;
  final String? materialId;

  @override
  ConsumerState<MaterialSelectionPage> createState() =>
      _MaterialSelectionPageState();
}

class _MaterialSelectionPageState extends ConsumerState<MaterialSelectionPage> {
  static const _baseMaterials = ['cotton', 'silk'];

  /// Kamrup & Nalbari (cluster id `assam`).
  static const _kamrupMaterials = [
    'cotton',
    'eri',
    'mulberry',
    'tussar',
    'muga',
  ];

  /// Maniabandha and Gopalpur keep cotton and silk and add these fibres.
  static const _maniabandhaMaterials = [
    'cotton',
    'silk',
    'korea-tussar',
    'mulberry',
    'eri',
    'liva-viscose',
    'linen',
    'spun-tussar',
    'noil',
  ];

  String? _clusterId;
  bool _clusterReady = false;
  String? _selected;
  bool _busy = false;

  List<String> _materialsFor(String? clusterId) => switch (clusterId) {
        'assam' => _kamrupMaterials,
        'maniabandha' || 'gopalpur' => _maniabandhaMaterials,
        _ => _baseMaterials,
      };

  List<String> get _materials => _materialsFor(_clusterId);

  @override
  void initState() {
    super.initState();
    _loadCluster();
  }

  Future<void> _loadCluster() async {
    String? id;
    try {
      final prefs = await SharedPreferences.getInstance();
      id = prefs.getString(clickSocialClusterKey);
    } catch (_) {}
    if (!mounted) return;
    final materials = _materialsFor(id);
    final incoming = widget.materialId;
    setState(() {
      _clusterId = id;
      _clusterReady = true;
      if (incoming != null && materials.contains(incoming)) {
        _selected = incoming;
      }
    });
  }

  String _assetFor(String materialId) => switch (materialId) {
        'cotton' => _clusterId == 'assam'
            ? 'assets/images/clusters/kamrup/mekhela/cotton/woven/full_display.jpg'
            : 'assets/images/materials/cotton.jpg',
        'silk' => 'assets/images/materials/silk.jpg',
        'mulberry' => 'assets/images/materials/mulberry.jpg',
        'zari' => 'assets/images/materials/zari.jpg',
        'eri' => 'assets/images/materials/eri.jpg',
        'tussar' => 'assets/images/materials/tussar.jpg',
        'tussar-gheecha' => 'assets/images/materials/tussar_gheecha.jpg',
        'muga' => 'assets/images/materials/muga.jpg',
        'muga-gheecha' => 'assets/images/materials/muga_gheecha.jpg',
        'spun-silk' => 'assets/images/materials/spun_silk.jpg',
        'spun-tussar' => 'assets/images/materials/spun_tussar.jpg',
        'korea-tussar' => 'assets/images/materials/korea_tussar.jpg',
        'liva-viscose' => 'assets/images/materials/liva_viscose.jpg',
        'linen' => 'assets/images/materials/linen.jpg',
        'noil' => 'assets/images/materials/noil.jpg',
        _ => 'assets/images/materials/$materialId.png',
      };

  String _labelFor(AppLocalizations l10n, String materialId) =>
      switch (materialId) {
        'cotton' => _titleCase(l10n.csMaterialCotton),
        'silk' => _titleCase(l10n.csMaterialSilk),
        'mulberry' => 'Mulberry',
        'zari' => 'Zari',
        'eri' => 'Eri',
        'tussar' => 'Tussar',
        'tussar-gheecha' => 'Tussar Gheecha',
        'muga' => 'Muga',
        'muga-gheecha' => 'Muga Gheecha',
        'spun-silk' => 'Spun Silk',
        'spun-tussar' => 'Spun Tussar',
        'korea-tussar' => 'Korea Tussar',
        'liva-viscose' => 'Liva/Viscose',
        'linen' => 'Linen',
        'noil' => 'Noil',
        _ => materialId,
      };

  String _blurbFor(String materialId) => switch (materialId) {
        'cotton' => 'Matte finish · Soft woven texture',
        'silk' => 'Lustrous finish · Rich colour & drape',
        'mulberry' => 'Smooth cultivated silk',
        'zari' => 'Metallic gold thread',
        'eri' => 'Matte, wool-soft silk',
        'tussar' => 'Honey-gold wild silk',
        'tussar-gheecha' => 'Coarse slubby tussar',
        'muga' => 'Natural gold of Assam',
        'muga-gheecha' => 'Slubby golden muga',
        'spun-silk' => 'Fine spun silk yarn',
        'spun-tussar' => 'Spun wild-silk yarn',
        'korea-tussar' => 'Pale, even wild silk',
        'liva-viscose' => 'Fluid drape · Soft lustre',
        'linen' => 'Crisp weave · Natural slub',
        'noil' => 'Matte, nubby silk',
        _ => '',
      };

  String _titleCase(String raw) {
    final t = raw.trim().toLowerCase();
    if (t.isEmpty) return raw;
    return '${t[0].toUpperCase()}${t.substring(1)}';
  }

  Widget _card(AppLocalizations l10n, String materialId) {
    return _MaterialChoiceCard(
      title: _labelFor(l10n, materialId),
      blurb: _blurbFor(materialId),
      imageAsset: _assetFor(materialId),
      selected: _selected == materialId,
      selectLabel: 'Select',
      onTap: () => setState(() => _selected = materialId),
    );
  }

  Future<void> _continue() async {
    final selected = _selected;
    if (selected == null || _busy) return;
    setState(() => _busy = true);

    try {
      final l10n = AppLocalizations.of(context);
      final categoryId = widget.categoryId;
      if (categoryId == null || categoryId.isEmpty) {
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
            materialId: selected,
          );

      if (!mounted) return;
      final q = <String>[
        'category=$categoryId',
        'material=$selected',
        if (widget.productLabel != null && widget.productLabel!.isNotEmpty)
          'product=${Uri.encodeComponent(widget.productLabel!)}',
      ].join('&');
      context.go('/product/${created.id}/pick-frames?$q');
    } catch (error, stack) {
      debugPrint('Material continue failed: $error\n$stack');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not continue: $error')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return PhotoLessonChrome(
      stepIndex: 1,
      footer: PhotoContinueBar(
        enabled: _selected != null && !_busy,
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
            if (!_clusterReady)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_materials.length <= 2)
              Expanded(
                child: Column(
                  children: [
                    for (var i = 0; i < _materials.length; i++) ...[
                      if (i > 0) const SizedBox(height: 12),
                      Expanded(child: _card(l10n, _materials[i])),
                    ],
                  ],
                ),
              )
            else
              Expanded(
                child: GridView.builder(
                  itemCount: _materials.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (context, i) => _card(l10n, _materials[i]),
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
                          filterQuality: FilterQuality.high,
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
