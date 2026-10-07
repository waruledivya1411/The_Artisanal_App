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
/// Image cards for the cluster. Kamrup & Nalbari also offers Shawl, Gamusa,
/// Jod Kapur, Yardages, and Home Furnishing. Home Furnishing opens into
/// Cushion, Runners, and Mats. Maniabandha, Venkatgiri, and Gopalpur add
/// their own garments on top of Mekhela sador, Sari, and Stole.
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
  String? _furnishing;
  bool _pickingFurnishing = false;
  bool _loading = true;

  List<String> get _cards =>
      _pickingFurnishing ? homeFurnishingOptions : _products;

  String? get _selected => _pickingFurnishing ? _furnishing : _product;

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

  void _goBack() {
    if (_pickingFurnishing) {
      setState(() {
        _pickingFurnishing = false;
        _furnishing = null;
      });
      return;
    }
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(AppRoute.home);
    }
  }

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
      onBack: _goBack,
      footer: PhotoContinueBar(
        enabled: _selected != null,
        label: l10n.continueAction,
        onBack: _goBack,
        onContinue: _continue,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _pickingFurnishing
                  ? 'Home furnishing'
                  : l10n.csWhatArePhotographing,
              style: AppTypography.displayMedium.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _pickingFurnishing
                  ? 'Cushion, runners, or mats.'
                  : l10n.csPickYourProduct,
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: _cards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, i) {
                  final label = _cards[i];
                  return PhotoImageCard(
                    label: label,
                    imageAsset: productImageAsset(label),
                    selected: _selected == label,
                    onTap: () => setState(() {
                      if (_pickingFurnishing) {
                        _furnishing = label;
                      } else {
                        _product = label;
                      }
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _continue() async {
    if (_product == 'Home Furnishing' && !_pickingFurnishing) {
      setState(() => _pickingFurnishing = true);
      return;
    }
    final product = _pickingFurnishing ? _furnishing : _product;
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
