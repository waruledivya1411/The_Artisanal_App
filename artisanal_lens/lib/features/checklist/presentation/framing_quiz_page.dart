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
                  ],
                ),
              ),
              if (msg != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                  child: FadeSlideIn(
                    key: ValueKey('msg-$_index-$_pick'),
                    child: Container(
                      width: double.infinity,
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

/// Clear product cutout for the framing quiz (no table in the image).
String framingProductAsset({
  required String? productLabel,
  required String categoryId,
  String? materialId,
}) {
  final label = (productLabel ?? '').trim().toLowerCase();
  final productKey = switch (label) {
    'mekhela sador' || 'mekhela' => 'mekhela',
    'sari' || 'saree' => 'sari',
    'stole / dupatta' || 'stole' || 'dupatta' || 'shawl' => 'stole',
    'accessories' => 'accessories',
    _ => switch (categoryId) {
        'stole' || 'shawl' => 'stole',
        'cushion_cover' => 'accessories',
        _ => 'sari',
      },
  };
  final material =
      (materialId ?? 'cotton').toLowerCase() == 'silk' ? 'silk' : 'cotton';

  // Prefer dedicated framing cutouts (product only). Fall back sensibly.
  const cutouts = {
    'sari_cotton',
    'sari_silk',
    'stole_cotton',
    'mekhela_silk',
    'accessories_cotton',
  };
  final key = '${productKey}_$material';
  if (cutouts.contains(key)) {
    return 'assets/images/framing/$key.png';
  }
  // Closest cutout when exact material file is missing.
  final fallback = switch (productKey) {
    'sari' => 'sari_cotton',
    'stole' => 'stole_cotton',
    'mekhela' => 'mekhela_silk',
    _ => 'accessories_cotton',
  };
  return 'assets/images/framing/$fallback.png';
}

/// Full-bleed wood table that covers the entire framing viewfinder.
const framingTableAsset = 'assets/images/framing/table.png';

/// Camera viewfinder: real table covers all grids; product cutout sits
/// in the required cell (centre / thirds / corner / etc.).
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
    // Large enough to read as a saree, still inside ~2–4 grid cells.
    final w = option.sizeFactor.clamp(0.36, 0.72);
    final h = (option.sizeFactor * 0.92).clamp(0.32, 0.66);

    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Separate table image — fills every grid cell.
          Image.asset(
            framingTableAsset,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) =>
                const _WoodTableBackground(),
          ),
          // Selected product (saree / stole / …) in the required frame spot.
          Align(
            alignment: option.alignment,
            child: FractionallySizedBox(
              widthFactor: w,
              heightFactor: h,
              child: Image.asset(
                productAsset,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
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
          // Soft vignette — lens feel
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.05,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.16),
                ],
                stops: const [0.55, 1],
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

/// Fallback painted table if [framingTableAsset] fails to load.
class _WoodTableBackground extends StatelessWidget {
  const _WoodTableBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFC4A484),
            Color(0xFFB08968),
            Color(0xFF9C7A55),
            Color(0xFF8B6B4A),
          ],
          stops: [0.0, 0.35, 0.7, 1.0],
        ),
      ),
      child: CustomPaint(
        painter: _WoodGrainPainter(),
        child: SizedBox.expand(),
      ),
    );
  }
}

class _WoodGrainPainter extends CustomPainter {
  const _WoodGrainPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final grain = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..color = const Color(0xFF6F4E37).withValues(alpha: 0.12);
    final highlight = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = const Color(0xFFE8D5B7).withValues(alpha: 0.1);

    for (var i = 0; i < 14; i++) {
      final y = size.height * (0.04 + i * 0.07);
      final path = Path()
        ..moveTo(0, y)
        ..quadraticBezierTo(
          size.width * 0.35,
          y + (i.isEven ? 4 : -3),
          size.width * 0.7,
          y + (i.isEven ? -2 : 3),
        )
        ..quadraticBezierTo(
          size.width * 0.88,
          y + (i.isEven ? 2 : -2),
          size.width,
          y,
        );
      canvas.drawPath(path, i.isEven ? grain : highlight);
    }

    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.78, size.width, size.height * 0.22),
      Paint()..color = Colors.black.withValues(alpha: 0.06),
    );
  }

  @override
  bool shouldRepaint(covariant _WoodGrainPainter oldDelegate) => false;
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
