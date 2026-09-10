import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../domain/entities/fabric_material.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/widgets/choice_image_grid.dart';
import '../../../shared/widgets/common.dart';
import '../../home/shot_sets_controller.dart';

/// Material variety step, then framing quiz / shoot flow.
class SilkTypePage extends ConsumerStatefulWidget {
  const SilkTypePage({
    this.materialId,
    this.categoryId,
    this.productName,
    this.technique,
    super.key,
  });

  final String? materialId;
  final String? categoryId;
  final String? productName;
  final String? technique;

  @override
  ConsumerState<SilkTypePage> createState() => _SilkTypePageState();
}

class _SilkTypePageState extends ConsumerState<SilkTypePage> {
  String? _selectedId;
  bool _busy = false;

  FabricMaterial get _material =>
      FabricMaterial.byId(widget.materialId ?? '') ?? FabricMaterial.silk;

  List<ImageChoice> _choices(AppLocalizations l10n) => switch (_material.id) {
        FabricMaterial.silkId => [
            for (final variety in SilkVariety.all)
              ImageChoice(
                id: variety.id,
                name: AppCopy.materialVarietyName(
                  l10n,
                  _material.id,
                  variety.id,
                ),
                thumbnailAsset: variety.thumbnailAsset,
              ),
          ],
        FabricMaterial.cottonId => [
            for (final variety in CottonVariety.all)
              ImageChoice(
                id: variety.id,
                name: AppCopy.materialVarietyName(
                  l10n,
                  _material.id,
                  variety.id,
                ),
                thumbnailAsset: variety.thumbnailAsset,
              ),
          ],
        FabricMaterial.woolId => [
            for (final variety in WoolVariety.all)
              ImageChoice(
                id: variety.id,
                name: AppCopy.materialVarietyName(
                  l10n,
                  _material.id,
                  variety.id,
                ),
                thumbnailAsset: variety.thumbnailAsset,
              ),
          ],
        FabricMaterial.juteId => [
            for (final variety in JuteVariety.all)
              ImageChoice(
                id: variety.id,
                name: AppCopy.materialVarietyName(
                  l10n,
                  _material.id,
                  variety.id,
                ),
                thumbnailAsset: variety.thumbnailAsset,
              ),
          ],
        _ => const [],
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final choices = _choices(l10n);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.newProduct),
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
            l10n.materialTypeHeadline(
              AppCopy.materialNameForHeadline(l10n, _material.id),
            ),
            style: AppTypography.displayLarge,
          ),
          const SizedBox(height: AppDimens.space20),
          ChoiceImageGrid(
            choices: choices,
            selectedId: _selectedId,
            onSelected: (id) => setState(() => _selectedId = id),
          ),
        ],
      ),
      bottomNavigationBar: BottomAction(
        child: FilledButton.icon(
          onPressed: _selectedId == null || _busy ? null : _continue,
          icon: const Icon(Icons.arrow_forward, size: 20),
          label: const Text('NEXT — FRAME IT'),
        ),
      ),
    );
  }

  Future<void> _continue() async {
    if (_busy) return;
    setState(() => _busy = true);

    try {
      final categoryId = widget.categoryId;
      final l10n = AppLocalizations.of(context);
      final productName = (widget.productName?.trim().isNotEmpty == true)
          ? widget.productName!.trim()
          : (categoryId == null || categoryId.isEmpty)
              ? l10n.newProduct
              : AppCopy.categoryName(l10n, categoryId);
      if (categoryId == null || categoryId.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Missing product details. Go back and try again.'),
          ),
        );
        return;
      }

      final created = await ref.read(shotSetsProvider.notifier).createSet(
            productName: productName,
            categoryId: categoryId,
            materialId: _material.id,
            silkTypeId: _selectedId,
          );

      if (!mounted) return;

      final technique = widget.technique;
      final material = _material.id;
      final q = <String>[
        'category=$categoryId',
        'material=$material',
        if (technique != null && technique.isNotEmpty) 'technique=$technique',
      ].join('&');
      context.go('/product/${created.id}/pick-frames?$q');
    } catch (error, stack) {
      debugPrint('Silk type continue failed: $error\n$stack');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not continue: $error')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
