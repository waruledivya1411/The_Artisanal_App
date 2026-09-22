import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../home/click_social_clusters.dart';
import '../click_social_frames.dart';
import 'photo_lesson_chrome.dart';

/// HTML photoStep 0 — What are you photographing?
///
/// Fixed 2×2 image cards: Mekhela sador, Sari, Stole / Dupatta, Accessories.
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

    final l10n = AppLocalizations.of(context);

    return PhotoLessonChrome(
      stepIndex: 0,
      isPanel: false,
      footer: PhotoContinueBar(
        enabled: _product != null,
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
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.csWhatArePhotographing,
              style: AppTypography.displayMedium.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.csPickYourProduct,
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        for (var i = 0; i < 2; i++) ...[
                          if (i > 0) const SizedBox(width: 10),
                          Expanded(
                            child: PhotoImageCard(
                              label: _products[i],
                              imageAsset: productImageAsset(_products[i]),
                              selected: _product == _products[i],
                              onTap: () =>
                                  setState(() => _product = _products[i]),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: [
                        for (var i = 2; i < 4; i++) ...[
                          if (i > 2) const SizedBox(width: 10),
                          Expanded(
                            child: PhotoImageCard(
                              label: _products[i],
                              imageAsset: productImageAsset(_products[i]),
                              selected: _product == _products[i],
                              onTap: () =>
                                  setState(() => _product = _products[i]),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _continue() async {
    final product = _product;
    if (product == null) return;
    final categoryId = categoryIdForProduct(product);

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
