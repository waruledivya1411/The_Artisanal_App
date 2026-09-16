import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../click_social_frames.dart';

/// HTML photoStep 6 — light quiz. Then continues to the existing photo list.
class LightQuizPage extends StatefulWidget {
  const LightQuizPage({
    required this.setId,
    this.categoryId,
    this.materialId,
    this.technique,
    this.frameIndexes = const [],
    super.key,
  });

  final String setId;
  final String? categoryId;
  final String? materialId;
  final String? technique;
  final List<int> frameIndexes;

  @override
  State<LightQuizPage> createState() => _LightQuizPageState();
}

class _LightQuizPageState extends State<LightQuizPage> {
  /// Light ids with the icon origin, in display order.
  static const _choices = <(String id, double sx, double sy)>[
    ('side', 4, 20),
    ('front', 16, 6),
    ('back', 28, 20),
  ];

  String? _light;

  String _choiceLabel(AppLocalizations l10n, String id) => switch (id) {
        'side' => l10n.csLightSide,
        'front' => l10n.csLightFront,
        _ => l10n.csLightBack,
      };

  /// HTML: Kalamkari panel (cushion + hand-painted) gets panel light tips.
  bool get _isPanel =>
      (widget.categoryId ?? '') == 'cushion_cover' &&
      (widget.technique ?? '').toUpperCase() == 'HAND-PAINTED';

  bool get _isPainted =>
      _isPanel || (widget.technique ?? '').toUpperCase() == 'HAND-PAINTED';

  String get _correctLight {
    if (_isPainted) return 'front';
    final material = (widget.materialId ?? '').toLowerCase();
    if (material == 'silk') return 'side';
    return 'front';
  }

  bool get _isSilk {
    if (_isPainted) return false;
    return (widget.materialId ?? '').toLowerCase() == 'silk';
  }

  String _heading(AppLocalizations l10n) {
    if (_isPanel) return l10n.csLightHeadingPanel;
    if (_isPainted) return l10n.csLightHeadingPainted;
    if (_isSilk) return l10n.csLightHeadingSilk;
    return l10n.csLightHeadingCotton;
  }

  String _prompt(AppLocalizations l10n) {
    if (_isPanel) return l10n.csLightPromptPanel;
    if (_isPainted) return l10n.csLightPromptPainted;
    if (_isSilk) return l10n.csLightPromptSilk;
    return l10n.csLightPromptDefault;
  }

  String _why(AppLocalizations l10n) {
    if (_isPanel) return l10n.csLightWhyPanel;
    if (_isPainted) return l10n.csLightWhyPainted;
    if (_isSilk) return l10n.csLightWhySilk;
    return l10n.csLightWhyCotton;
  }

  String _wrong(AppLocalizations l10n) {
    if (_isPanel) return l10n.csLightWrongPanel;
    if (_isPainted) return l10n.csLightWrongPainted;
    if (_isSilk) return l10n.csLightWrongSilk;
    return l10n.csLightWrongCotton;
  }

  void _pick(String id) {
    setState(() => _light = id);
  }

  void _continue() async {
    final prefs = await SharedPreferences.getInstance();
    // Pick your frames writes these. Fall back to the HTML defaults so the
    // checklist still opens in Click & Social mode if that step was skipped.
    final picksKey = clickSocialFramePicksKey(widget.setId);
    if (!prefs.containsKey(picksKey)) {
      await prefs.setString(
        picksKey,
        (_isPanel ? clickSocialPanelFrames : clickSocialDefaultFrames)
            .join(','),
      );
      await prefs.setString(
        clickSocialTechniqueKey(widget.setId),
        widget.technique ?? '',
      );
    }
    if (!mounted) return;
    context.go('/product/${widget.setId}/list');
  }

  void _goBack() {
    // Opened via context.go from framing quiz — pop often has nowhere to go.
    final category = widget.categoryId ?? 'saree';
    final frames = widget.frameIndexes.isNotEmpty
        ? widget.frameIndexes.join(',')
        : null;
    final q = <String>[
      'category=$category',
      if (frames != null) 'frames=$frames',
      if (widget.materialId != null && widget.materialId!.isNotEmpty)
        'material=${widget.materialId}',
      if (widget.technique != null && widget.technique!.isNotEmpty)
        'technique=${widget.technique}',
    ].join('&');
    context.go('/product/${widget.setId}/framing-quiz?$q');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final correct = _light == _correctLight;
    String? msg;
    if (_light != null) {
      if (correct) {
        msg = _why(l10n);
      } else if (_light == 'back') {
        msg = l10n.csLightWrongBacklight;
      } else {
        msg = _wrong(l10n);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.divider, width: 2),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _goBack,
                    icon: const Icon(Icons.chevron_left, size: 28),
                    color: AppColors.textPrimary,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.csLesson01Overline,
                          style: AppTypography.navLabel.copyWith(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          l10n.csLesson01Title,
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                children: [
                  Text(
                    _heading(l10n),
                    style: AppTypography.displayMedium.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _prompt(l10n),
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (_isPanel) ...[
                    const SizedBox(height: 14),
                    _PanelTip(
                      badge: l10n.csLightTipDoThisBadge,
                      badgeColor: AppColors.primary,
                      borderColor: AppColors.primary,
                      body: l10n.csLightTipDoThisBody,
                    ),
                    const SizedBox(height: 10),
                    _PanelTip(
                      badge: l10n.csLightTipNeverFlashBadge,
                      badgeColor: AppColors.textSecondary,
                      borderColor: AppColors.border,
                      body: l10n.csLightTipNeverFlashBody,
                    ),
                    const SizedBox(height: 10),
                    _PanelTip(
                      badge: l10n.csLightTipAvoidSideBadge,
                      badgeColor: AppColors.textSecondary,
                      borderColor: AppColors.border,
                      body: l10n.csLightTipAvoidSideBody,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.csLightNowPick,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  for (final choice in _choices) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () => _pick(choice.$1),
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 56),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(
                              color: _light == choice.$1
                                  ? (choice.$1 == _correctLight
                                      ? AppColors.primary
                                      : AppColors.textMuted)
                                  : AppColors.textPrimary,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              CustomPaint(
                                size: const Size(30, 30),
                                painter: _LightIconPainter(
                                  sx: choice.$2,
                                  sy: choice.$3,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  _choiceLabel(l10n, choice.$1),
                                  style: AppTypography.labelLarge.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (msg != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      color: correct
                          ? const Color(0xFFEBF8FF)
                          : AppColors.textPrimary,
                      child: Text(
                        msg,
                        style: AppTypography.labelLarge.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: correct
                              ? const Color(0xFF2A4365)
                              : AppColors.white,
                        ),
                      ),
                    ),
                  if (correct) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _continue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: Text(
                          l10n.csNextShootYours,
                          style: AppTypography.labelLarge.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                        ),
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

class _LightIconPainter extends CustomPainter {
  _LightIconPainter({required this.sx, required this.sy});

  final double sx;
  final double sy;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 32;
    canvas.drawRect(
      Rect.fromLTWH(11 * scale, 18 * scale, 10 * scale, 10 * scale),
      Paint()..color = AppColors.textPrimary,
    );
    canvas.drawCircle(
      Offset(sx * scale, sy * scale),
      4 * scale,
      Paint()..color = AppColors.primary,
    );
  }

  @override
  bool shouldRepaint(covariant _LightIconPainter oldDelegate) =>
      oldDelegate.sx != sx || oldDelegate.sy != sy;
}

class _PanelTip extends StatelessWidget {
  const _PanelTip({
    required this.badge,
    required this.badgeColor,
    required this.borderColor,
    required this.body,
  });

  final String badge;
  final Color badgeColor;
  final Color borderColor;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            badge,
            style: AppTypography.navLabel.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
              color: badgeColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            body,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 12.5,
              height: 1.4,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
