import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../home/click_social_clusters.dart';
import '../../home/shot_sets_controller.dart';
import '../click_social_frames.dart';
import 'photo_lesson_chrome.dart';

/// HTML photoStep 0 — What are you photographing?
///
/// Cluster-specific product chips (text only, no images), matching the HTML.
class ProductSetupPage extends ConsumerStatefulWidget {
  const ProductSetupPage({
    this.setId,
    this.materialId,
    super.key,
  });

  final String? setId;
  final String? materialId;

  @override
  ConsumerState<ProductSetupPage> createState() => _ProductSetupPageState();
}

class _ProductSetupPageState extends ConsumerState<ProductSetupPage> {
  String? _clusterId;
  String? _product;
  bool _loading = true;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _clusterId = prefs.getString(clickSocialClusterKey);
      _loading = false;
    });
  }

  List<String> get _products => productsForCluster(_clusterId);

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (widget.setId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.go('/product/${widget.setId}/list');
      });
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PhotoLessonChrome(
      stepIndex: 0,
      isPanel: _product == 'Kalamkari panel',
      child: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context);
          return ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          Text(
            l10n.csWhatArePhotographing,
            style: AppTypography.displayMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.csPickYourProduct,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.55,
            ),
            itemBuilder: (context, i) {
              final label = _products[i];
              return PhotoChoiceChip(
                label: label,
                selected: _product == label,
                onTap: () => setState(() => _product = label),
              );
            },
          ),
          if (_product != null) ...[
            const SizedBox(height: 16),
            SizedBox(
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
                  _product == 'Kalamkari panel'
                      ? l10n.csNextPickYourFrames
                      : l10n.csNextMaterial,
                  style: AppTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      );
        },
      ),
    );
  }

  Future<void> _continue() async {
    final product = _product;
    if (product == null || _busy) return;
    final categoryId = categoryIdForProduct(product);

    // HTML: Kalamkari panel skips material + technique → pick frames.
    if (product == 'Kalamkari panel') {
      setState(() => _busy = true);
      try {
        final created = await ref.read(shotSetsProvider.notifier).createSet(
              productName: product,
              categoryId: categoryId,
            );
        if (!mounted) return;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'click_social_technique_${created.id}',
          'HAND-PAINTED',
        );
        if (!mounted) return;
        context.go(
          '/product/${created.id}/pick-frames'
          '?category=$categoryId&technique=HAND-PAINTED&product=${Uri.encodeComponent(product)}',
        );
      } catch (error, stack) {
        debugPrint('Panel continue failed: $error\n$stack');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not continue: $error')),
        );
      } finally {
        if (mounted) setState(() => _busy = false);
      }
      return;
    }

    context.pushNamed(
      AppRoute.material,
      queryParameters: {
        'category': categoryId,
        'name': product,
        'product': product,
      },
    );
  }
}
