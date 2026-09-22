import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import 'photo_lesson_chrome.dart';
import '../../../shared/widgets/common.dart';

/// HTML photoStep 1 — What is it made of? (COTTON / SILK, text only).
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
  /// Stored ids stay English for routing; labels are localized.
  static const _materialIds = ['cotton', 'silk'];
  String? _selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels = {
      'cotton': l10n.csMaterialCotton,
      'silk': l10n.csMaterialSilk,
    };

    return PhotoLessonChrome(
      stepIndex: 1,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          Text(
            l10n.csWhatIsItMadeOf,
            style: AppTypography.displayMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.csMaterialDecidesLight,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (var i = 0; i < _materialIds.length; i++) ...[
                Expanded(
                  child: PhotoChoiceChip(
                    label: labels[_materialIds[i]]!,
                    selected: _selected == _materialIds[i],
                    onTap: () => setState(() => _selected = _materialIds[i]),
                    minHeight: 72,
                    fontSize: 16,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.w800,
                    useHeadingFont: true,
                  ),
                ),
                if (i == 0) const SizedBox(width: 8),
              ],
            ],
          ),
          if (_selected != null) ...[
            const SizedBox(height: 16),
            ActionWidth(
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.technique,
                      queryParameters: {
                        if (widget.categoryId != null)
                          'category': widget.categoryId!,
                        if (widget.productName != null)
                          'name': widget.productName!,
                        if (widget.productLabel != null)
                          'product': widget.productLabel!,
                        'material': _selected!,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: Text(
                    l10n.csNextTechnique,
                    style: AppTypography.labelLarge.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
