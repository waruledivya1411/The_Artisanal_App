import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../framing_quiz_data.dart';
import '../../../shared/motion/motion.dart';
import '../../../shared/painting/svg_path.dart';

/// HTML photoStep 5 — framing quizzes. Inserted before the existing photo list.
class FramingQuizPage extends StatefulWidget {
  const FramingQuizPage({
    required this.setId,
    required this.categoryId,
    required this.frameIndexes,
    this.materialId,
    this.technique,
    this.productLabel,
    super.key,
  });

  final String setId;
  final String categoryId;
  final List<int> frameIndexes;
  final String? materialId;
  final String? technique;
  final String? productLabel;

  @override
  State<FramingQuizPage> createState() => _FramingQuizPageState();
}

class _FramingQuizPageState extends State<FramingQuizPage> {
  int _index = 0;
  int? _pick;

  /// Bumped on every wrong choice so the shake replays even when the learner
  /// taps the same wrong option twice.
  int _shake = 0;

  List<FrameArch> get _sequence => framingSequenceForPicks(
        categoryId: widget.categoryId,
        pickedIndexes: widget.frameIndexes,
      );

  FrameArch get _arch => _sequence[_index.clamp(0, _sequence.length - 1)];

  String _frameNames(AppLocalizations l10n) => frameNamesForArch(
        l10n: l10n,
        categoryId: widget.categoryId,
        pickedIndexes: widget.frameIndexes,
        arch: _arch,
      );

  String get _productAsset => framingProductAsset(
        productLabel: widget.productLabel,
        categoryId: widget.categoryId,
        materialId: widget.materialId,
      );

  void _select(int oi) {
    final l10n = AppLocalizations.of(context);
    final wrong = !localizedFramingArch(l10n, _arch).options[oi].correct;
    setState(() {
      _pick = oi;
      if (wrong) _shake += 1;
    });
  }

  void _next() {
    if (_index < _sequence.length - 1) {
      setState(() {
        _index += 1;
        _pick = null;
      });
      return;
    }
    final q = <String>[
      'category=${widget.categoryId}',
      if (widget.frameIndexes.isNotEmpty)
        'frames=${widget.frameIndexes.join(',')}',
      if (widget.materialId != null && widget.materialId!.isNotEmpty)
        'material=${widget.materialId}',
      if (widget.technique != null && widget.technique!.isNotEmpty)
        'technique=${widget.technique}',
      if (widget.productLabel != null && widget.productLabel!.isNotEmpty)
        'product=${Uri.encodeComponent(widget.productLabel!)}',
    ].join('&');
    context.go('/product/${widget.setId}/light-quiz?$q');
  }

  void _goBack() {
    if (_index > 0) {
      setState(() {
        _index -= 1;
        _pick = null;
      });
      return;
    }
    // Opened via context.go from Pick frames — pop often has nowhere to go.
    final q = <String>[
      'category=${widget.categoryId}',
      if (widget.materialId != null && widget.materialId!.isNotEmpty)
        'material=${widget.materialId}',
      if (widget.technique != null && widget.technique!.isNotEmpty)
        'technique=${widget.technique}',
      if (widget.productLabel != null && widget.productLabel!.isNotEmpty)
        'product=${Uri.encodeComponent(widget.productLabel!)}',
    ].join('&');
    context.go('/product/${widget.setId}/pick-frames?$q');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final def = localizedFramingArch(l10n, _arch);
    final picked = _pick != null ? def.options[_pick!] : null;
    final correct = picked?.correct == true;
    final msg = picked != null ? def.messageAt(_pick!) : null;
    final names = _frameNames(l10n);
    final productAsset = _productAsset;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7FAFD),
              Color(0xFFEEF5FB),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _LessonHeader(onBack: _goBack),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  children: [
                    Text(
                      names.isEmpty
                          ? l10n.csFramingProgress(
                              _index + 1,
                              _sequence.length,
                            )
                          : l10n.csFramingProgressNamed(
                              _index + 1,
                              _sequence.length,
                              names,
                            ),
                      style: AppTypography.navLabel.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      def.title,
                      style: AppTypography.displayMedium.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      def.sub,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (var oi = 0; oi < def.options.length; oi++) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ShakeOnChange(
                          trigger: _pick == oi && !def.options[oi].correct
                              ? _shake
                              : null,
                          child: Pressable(
                            elevate: true,
                            borderRadius: BorderRadius.circular(16),
                            child: Material(
                              color: AppColors.white,
                              elevation: _pick == oi ? 3 : 1,
                              shadowColor:
                                  AppColors.primary.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () => _select(oi),
                                child: AnimatedScale(
                                  scale: _pick == oi &&
                                          def.options[oi].correct
                                      ? 1.02
                                      : 1,
                                  duration: AppMotion.select,
                                  curve: AppMotion.curve,
                                  child: AnimatedContainer(
                                    duration: AppMotion.select,
                                    curve: AppMotion.curve,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: _pick == oi
                                            ? (def.options[oi].correct
                                                ? AppColors.primary
                                                : AppColors.textMuted)
                                            : AppColors.borderLight,
                                        width: _pick == oi ? 2.2 : 1.2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 4 / 3,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14.5),
                                            child: _FramingOptionPreview(
                                              gridPath: def.gridPath,
                                              option: def.options[oi],
                                              productAsset: productAsset,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: AnimatedCheck(
                                            visible: _pick == oi &&
                                                def.options[oi].correct,
                                            color: AppColors.white,
                                            background: AppColors.primary,
                                            radius: 11,
                                            size: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (msg != null)
                      FadeSlideIn(
                        key: ValueKey('msg-$_index-$_pick'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: correct
                                ? const Color(0xFFEBF8FF)
                                : AppColors.textPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                      ),
                  ],
                ),
              ),
              _FramingContinueBar(
                enabled: correct,
                label: _index < _sequence.length - 1
                    ? l10n.csNextFraming
                    : l10n.csNextLightIt,
                onContinue: _next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sticky bottom CTA — grey until the correct frame is picked, then primary.
class _FramingContinueBar extends StatelessWidget {
  const _FramingContinueBar({
    required this.enabled,
    required this.label,
    required this.onContinue,
  });

  final bool enabled;
  final String label;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Pressable(
        enabled: enabled,
        elevate: enabled,
        borderRadius: BorderRadius.circular(28),
        child: AnimatedOpacity(
          duration: AppMotion.select,
          opacity: enabled ? 1 : 0.55,
          child: Material(
            color: enabled ? AppColors.primary : AppColors.surfaceMuted,
            elevation: enabled ? 4 : 0,
            shadowColor: AppColors.primary.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(28),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: enabled ? onContinue : null,
              child: SizedBox(
                height: 52,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: AppTypography.labelLarge.copyWith(
                        color: enabled
                            ? AppColors.white
                            : AppColors.textMuted,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: enabled
                          ? AppColors.white
                          : AppColors.textMuted,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Clear product photo filling the camera viewfinder.
String framingProductAsset({
  required String? productLabel,
  required String categoryId,
  String? materialId,
}) {
  final productKey = switch ((productLabel ?? '').trim()) {
    'Mekhela sador' => 'mekhela',
    'Sari' => 'sari',
    'Stole / Dupatta' => 'stole',
    'Accessories' => 'accessories',
    _ => switch (categoryId) {
        'stole' || 'shawl' => 'stole',
        'cushion_cover' => 'accessories',
        _ => 'sari',
      },
  };
  final material =
      (materialId ?? 'cotton').toLowerCase() == 'silk' ? 'silk' : 'cotton';
  return 'assets/images/materials/by_product/${productKey}_$material.png';
}

/// Camera viewfinder: scene + product placed in-frame (clearly different per option).
class _FramingOptionPreview extends StatelessWidget {
  const _FramingOptionPreview({
    required this.gridPath,
    required this.option,
    required this.productAsset,
  });

  final String gridPath;
  final FramingOption option;
  final String productAsset;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
      fit: StackFit.expand,
      children: [
        // Neutral shooting surface (table / wall) — not another product
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFD8DEE6),
                Color(0xFFC5CDD8),
                Color(0xFFB7C0CC),
              ],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
        ),
        // Soft table horizon
        Align(
          alignment: const Alignment(0, 0.35),
          child: Container(
            height: 1.2,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ),
        // Product sitting in the frame — size + position = the quiz
        Align(
          alignment: option.alignment,
          child: FractionallySizedBox(
            widthFactor: option.sizeFactor,
            heightFactor: option.sizeFactor,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.28),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  productAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => ColoredBox(
                    color: AppColors.primaryLight,
                    child: Icon(
                      Icons.checkroom_rounded,
                      color: AppColors.white.withValues(alpha: 0.9),
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Soft vignette — lens feel
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.05,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.2),
              ],
              stops: const [0.5, 1],
            ),
          ),
        ),
        CustomPaint(painter: _GridPainter(gridPath: gridPath)),
        const CustomPaint(painter: _ViewfinderCornersPainter()),
      ],
      ),
    );
  }
}

class _LessonHeader extends StatelessWidget {
  const _LessonHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
      child: Row(
        children: [
          Material(
            color: AppColors.white,
            elevation: 2,
            shadowColor: AppColors.primary.withValues(alpha: 0.12),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onBack,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 26,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.gridPath});

  final String gridPath;

  @override
  void paint(Canvas canvas, Size size) {
    // Dark halo so the grid stays readable on light or dark fabric.
    final halo = Paint()
      ..color = Colors.black.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.square;
    paintSvgPath(
      canvas,
      size,
      gridPath,
      halo,
      viewBox: const Size(120, 64),
    );
    final grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.88)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.15
      ..strokeCap = StrokeCap.square;
    paintSvgPath(
      canvas,
      size,
      gridPath,
      grid,
      viewBox: const Size(120, 64),
    );
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.gridPath != gridPath;
}

/// Camera viewfinder corner brackets.
class _ViewfinderCornersPainter extends CustomPainter {
  const _ViewfinderCornersPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.square;

    const inset = 10.0;
    const arm = 16.0;
    final corners = <List<Offset>>[
      [const Offset(inset, inset + arm), const Offset(inset, inset), const Offset(inset + arm, inset)],
      [
        Offset(size.width - inset - arm, inset),
        Offset(size.width - inset, inset),
        Offset(size.width - inset, inset + arm),
      ],
      [
        Offset(inset, size.height - inset - arm),
        Offset(inset, size.height - inset),
        Offset(inset + arm, size.height - inset),
      ],
      [
        Offset(size.width - inset - arm, size.height - inset),
        Offset(size.width - inset, size.height - inset),
        Offset(size.width - inset, size.height - inset - arm),
      ],
    ];
    for (final pts in corners) {
      final path = Path()
        ..moveTo(pts[0].dx, pts[0].dy)
        ..lineTo(pts[1].dx, pts[1].dy)
        ..lineTo(pts[2].dx, pts[2].dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ViewfinderCornersPainter oldDelegate) => false;
}
