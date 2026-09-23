import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/motion/motion.dart';
import '../click_social_frames.dart';
import 'photo_lesson_chrome.dart';

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

  /// Bumped on every wrong choice so the shake replays on a repeat tap.
  int _shake = 0;

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
    final wrong = id != _correctLight;
    setState(() {
      _light = id;
      if (wrong) _shake += 1;
    });
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

    return PhotoLessonChrome(
      stepIndex: _isPanel ? 3 : 5,
      isPanel: _isPanel,
      onBack: _goBack,
      footer: correct
          ? Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
              child: FadeSlideIn(
                key: const ValueKey('light-next'),
                child: Pressable(
                  elevate: true,
                  borderRadius: BorderRadius.circular(28),
                  child: Material(
                    color: AppColors.primary,
                    elevation: 4,
                    shadowColor: AppColors.primary.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(28),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: _continue,
                      child: SizedBox(
                        height: 52,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.csNextShootYours,
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: AppColors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
        children: [
          Text(
            _heading(l10n),
            style: AppTypography.displayMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.25,
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
          const SizedBox(height: 16),
          for (final choice in _choices) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ShakeOnChange(
                trigger: _light == choice.$1 && choice.$1 != _correctLight
                    ? _shake
                    : null,
                child: _LightChoiceCard(
                  label: _choiceLabel(l10n, choice.$1),
                  sx: choice.$2,
                  sy: choice.$3,
                  selected: _light == choice.$1,
                  isCorrect: choice.$1 == _correctLight,
                  onTap: () => _pick(choice.$1),
                ),
              ),
            ),
          ],
          if (msg != null)
            FadeSlideIn(
              key: ValueKey('msg-$_light'),
              child: _FeedbackBanner(
                message: msg,
                correct: correct,
              ),
            ),
        ],
      ),
    );
  }
}

class _LightChoiceCard extends StatelessWidget {
  const _LightChoiceCard({
    required this.label,
    required this.sx,
    required this.sy,
    required this.selected,
    required this.isCorrect,
    required this.onTap,
  });

  final String label;
  final double sx;
  final double sy;
  final bool selected;
  final bool isCorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showCorrect = selected && isCorrect;
    final showWrong = selected && !isCorrect;

    return Pressable(
      elevate: true,
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: showCorrect ? AppColors.surfaceSelected : AppColors.white,
        elevation: selected ? 3 : 1,
        shadowColor: AppColors.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: AnimatedScale(
            scale: showCorrect ? 1.02 : 1,
            duration: AppMotion.select,
            curve: AppMotion.curve,
            child: AnimatedContainer(
              duration: AppMotion.select,
              curve: AppMotion.curve,
              constraints: const BoxConstraints(minHeight: 64),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: showCorrect
                      ? AppColors.primary
                      : showWrong
                          ? AppColors.textMuted
                          : AppColors.borderLight,
                  width: selected ? 2.2 : 1.2,
                ),
              ),
              child: Row(
                children: [
                  CustomPaint(
                    size: const Size(30, 30),
                    painter: _LightIconPainter(sx: sx, sy: sy),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      label,
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 14,
                        fontWeight: showCorrect ? FontWeight.w700 : FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (showCorrect)
                    AnimatedCheck(
                      visible: true,
                      color: AppColors.white,
                      background: AppColors.primary,
                      radius: 12,
                      size: 14,
                    )
                  else
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.border,
                          width: 1.6,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  const _FeedbackBanner({
    required this.message,
    required this.correct,
  });

  final String message;
  final bool correct;

  @override
  Widget build(BuildContext context) {
    // Correct copy is "Right — …" (localized prefix). Bold the leading word.
    final parts = message.split(' — ');
    final splitCorrect = correct && parts.length >= 2;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: correct ? const Color(0xFFEBF8FF) : AppColors.textPrimary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (correct) ...[
            const Padding(
              padding: EdgeInsets.only(top: 1),
              child: Icon(
                Icons.check_circle_rounded,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: splitCorrect
                ? Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: parts.first,
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(
                          text: ' — ${parts.skip(1).join(' — ')}',
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2A4365),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    message,
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: correct
                          ? const Color(0xFF2A4365)
                          : AppColors.white,
                      height: 1.35,
                    ),
                  ),
          ),
        ],
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
        borderRadius: BorderRadius.circular(12),
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
