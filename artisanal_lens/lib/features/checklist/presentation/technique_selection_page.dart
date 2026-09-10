import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/widgets/common.dart';

/// HTML photoStep 2 — How is it made? (WOVEN / HAND-PAINTED).
class TechniqueSelectionPage extends StatefulWidget {
  const TechniqueSelectionPage({
    this.categoryId,
    this.productName,
    this.materialId,
    super.key,
  });

  final String? categoryId;
  final String? productName;
  final String? materialId;

  @override
  State<TechniqueSelectionPage> createState() => _TechniqueSelectionPageState();
}

class _TechniqueSelectionPageState extends State<TechniqueSelectionPage> {
  /// Stored technique ids — displayed through [AppLocalizations].
  static const _techniqueIds = ['WOVEN', 'HAND-PAINTED'];

  String? _technique;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.csNewProductTitle),
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
            l10n.csHowIsItMade,
            style: AppTypography.displayLarge.copyWith(fontSize: 28),
          ),
          const SizedBox(height: AppDimens.space8),
          Text(
            l10n.csTechniqueSub,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.space20),
          Row(
            children: [
              for (final id in _techniqueIds) ...[
                Expanded(
                  child: _TechniqueCard(
                    label: id == 'WOVEN'
                        ? l10n.csTechniqueWoven
                        : l10n.csTechniqueHandPainted,
                    selected: _technique == id,
                    onTap: () => setState(() => _technique = id),
                  ),
                ),
                if (id == 'WOVEN') const SizedBox(width: 8),
              ],
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAction(
        child: FilledButton.icon(
          onPressed: _technique == null ? null : _continue,
          icon: const Icon(Icons.arrow_forward, size: 20),
          label: Text(l10n.csNextMaterialType),
        ),
      ),
    );
  }

  void _continue() {
    context.pushNamed(
      AppRoute.silkType,
      queryParameters: {
        if (widget.categoryId != null) 'category': widget.categoryId!,
        if (widget.productName != null) 'name': widget.productName!,
        if (widget.materialId != null) 'material': widget.materialId!,
        'technique': _technique!,
      },
    );
  }
}

class _TechniqueCard extends StatelessWidget {
  const _TechniqueCard({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : AppColors.white,
          border: Border.all(color: AppColors.textPrimary, width: 2),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.labelLarge.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
            color: selected ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
