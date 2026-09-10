import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../domain/entities/lighting_advisory.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/widgets/choice_image_grid.dart';
import '../../../shared/widgets/common.dart';
import '../../home/shot_sets_controller.dart';

/// Step 1 — What are you photographing? (category + name).
class ProductSetupPage extends ConsumerStatefulWidget {
  const ProductSetupPage({
    this.setId,
    this.materialId,
    this.silkTypeId,
    super.key,
  });

  final String? setId;
  final String? materialId;
  final String? silkTypeId;

  @override
  ConsumerState<ProductSetupPage> createState() => _ProductSetupPageState();
}

class _ProductSetupPageState extends ConsumerState<ProductSetupPage> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedCategoryId;
  bool _isStarting = false;
  bool _hydrated = false;
  String? _activeSetId;

  @override
  void initState() {
    super.initState();
    _activeSetId = widget.setId;
  }

  bool get _isExistingSet => _activeSetId != null;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(catalogRepositoryProvider).categories();
    final existingSet = _activeSetId == null
        ? null
        : ref.watch(shotSetProvider(_activeSetId!));

    if (existingSet != null && !_hydrated) {
      _hydrated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          _selectedCategoryId = existingSet.categoryId;
          _nameController.text = existingSet.productName;
        });
      });
    }

    final selectedCategory = _selectedCategoryId == null
        ? null
        : ref
            .watch(catalogRepositoryProvider)
            .categoryById(_selectedCategoryId!);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          existingSet?.productName.isNotEmpty == true
              ? existingSet!.productName
              : AppLocalizations.of(context).newProduct,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimens.pagePadding,
          AppDimens.space24,
          AppDimens.pagePadding,
          AppDimens.space32,
        ),
        children: [
          Text(
            'What are you photographing?',
            style: AppTypography.displayLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Pick your product.',
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.space20),
          ChoiceImageGrid(
            choices: [
              for (final category in categories)
                ImageChoice(
                  id: category.id,
                  name: AppCopy.categoryName(
                    AppLocalizations.of(context),
                    category.id,
                  ),
                  thumbnailAsset: category.thumbnailAsset,
                ),
            ],
            selectedId: _selectedCategoryId,
            onSelected: _isExistingSet
                ? null
                : (id) => setState(() => _selectedCategoryId = id),
          ),
          if (selectedCategory != null) ...[
            const SizedBox(height: AppDimens.space32),
            const Divider(),
            const SizedBox(height: AppDimens.space24),
            Text(
              AppCopy.categoryName(
                AppLocalizations.of(context),
                selectedCategory.id,
              ),
              style: AppTypography.displayMedium,
            ),
            const SizedBox(height: AppDimens.space12),
            Text(
              AppLocalizations.of(context).giveProductName,
              style: AppTypography.labelSmall,
            ),
            const SizedBox(height: AppDimens.space8),
            TextField(
              controller: _nameController,
              enabled: !_isExistingSet,
              textCapitalization: TextCapitalization.words,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).nameHint(
                  AppCopy.categoryName(
                    AppLocalizations.of(context),
                    selectedCategory.id,
                  ),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppDimens.space24),
            const _ProTipBanner(),
          ],
        ],
      ),
      bottomNavigationBar: selectedCategory == null
          ? null
          : BottomAction(
              child: FilledButton.icon(
                onPressed: _canStart && !_isStarting ? _start : null,
                icon: const Icon(Icons.arrow_forward, size: 20),
                label: Text(
                  _isExistingSet
                      ? AppLocalizations.of(context).continueAction
                      : 'NEXT — MATERIAL',
                ),
              ),
            ),
    );
  }

  bool get _canStart =>
      _selectedCategoryId != null && _nameController.text.trim().isNotEmpty;

  Future<void> _start() async {
    if (_isStarting) return;

    FocusScope.of(context).unfocus();
    setState(() => _isStarting = true);

    try {
      // Resuming an existing shoot skips setup and opens the checklist.
      if (_activeSetId != null) {
        if (!mounted) return;
        context.go('/product/$_activeSetId/list');
        return;
      }

      if (!mounted) return;
      context.pushNamed(
        AppRoute.material,
        queryParameters: {
          'category': _selectedCategoryId!,
          'name': _nameController.text.trim(),
        },
      );
    } catch (error, stack) {
      debugPrint('Product setup continue failed: $error\n$stack');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not continue: $error')),
      );
    } finally {
      if (mounted) setState(() => _isStarting = false);
    }
  }
}

class _ProTipBanner extends StatelessWidget {
  const _ProTipBanner();

  @override
  Widget build(BuildContext context) {
    final advisory = LightingAdvisory.forTime(DateTime.now());
    final l10n = AppLocalizations.of(context);
    final message = advisory.shouldWait
        ? '${AppCopy.advisoryHeadline(l10n, advisory.reason)}: ${AppCopy.advisoryDetail(l10n, advisory.reason)}'
        : l10n.proTipGoodLight;

    return Container(
      padding: const EdgeInsets.all(AppDimens.space12),
      decoration: BoxDecoration(
        color: AppColors.surfaceSand,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.successBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline,
            size: 18,
            color: AppColors.success,
          ),
          const SizedBox(width: AppDimens.space8),
          Expanded(
            child: Text(
              message,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
