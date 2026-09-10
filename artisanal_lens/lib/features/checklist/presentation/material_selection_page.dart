import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../domain/entities/fabric_material.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/widgets/choice_image_grid.dart';
import '../../../shared/widgets/common.dart';

/// Step 2 — What is it made of?
class MaterialSelectionPage extends StatefulWidget {
  const MaterialSelectionPage({
    this.categoryId,
    this.productName,
    super.key,
  });

  final String? categoryId;
  final String? productName;

  @override
  State<MaterialSelectionPage> createState() => _MaterialSelectionPageState();
}

class _MaterialSelectionPageState extends State<MaterialSelectionPage> {
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    final selected = FabricMaterial.byId(_selectedId ?? '');
    final l10n = AppLocalizations.of(context);

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
            'What is it made of?',
            style: AppTypography.displayLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'The material decides the light.',
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.space20),
          ChoiceImageGrid(
            choices: [
              for (final material in FabricMaterial.all)
                ImageChoice(
                  id: material.id,
                  name: AppCopy.materialName(l10n, material.id),
                  thumbnailAsset: material.thumbnailAsset,
                ),
            ],
            selectedId: _selectedId,
            onSelected: (id) => setState(() => _selectedId = id),
          ),
        ],
      ),
      bottomNavigationBar: BottomAction(
        child: FilledButton.icon(
          onPressed: selected == null ? null : () => _continue(selected),
          icon: const Icon(Icons.arrow_forward, size: 20),
          label: const Text('NEXT — TECHNIQUE'),
        ),
      ),
    );
  }

  void _continue(FabricMaterial material) {
    context.pushNamed(
      AppRoute.technique,
      queryParameters: {
        if (widget.categoryId != null) 'category': widget.categoryId!,
        if (widget.productName != null) 'name': widget.productName!,
        'material': material.id,
      },
    );
  }
}
