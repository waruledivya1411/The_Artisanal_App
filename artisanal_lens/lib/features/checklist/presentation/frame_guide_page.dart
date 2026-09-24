import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/motion/motion.dart';
import '../../../shared/widgets/common.dart';
import '../../home/click_social_clusters.dart';
import '../click_social_frames.dart';
import 'photo_lesson_chrome.dart';

/// HTML photoStep 7 GUIDE — one frame, taught a page at a time.
///
/// The last page is "TAKE THE SHOT", which closes the guide and expands that
/// frame's drop zone on the checklist (HTML: drop / upload, not the camera).
class FrameGuidePage extends ConsumerStatefulWidget {
  const FrameGuidePage({
    required this.setId,
    required this.frameIndex,
    this.clusterId,
    this.categoryId,
    this.technique,
    this.productLabel,
    super.key,
  });

  final String setId;
  final int frameIndex;
  final String? clusterId;
  final String? categoryId;
  final String? technique;
  final String? productLabel;

  @override
  ConsumerState<FrameGuidePage> createState() => _FrameGuidePageState();
}

class _FrameGuidePageState extends ConsumerState<FrameGuidePage> {
  int _step = 0;
  String? _clusterId;
  List<int> _picks = const [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _clusterId = widget.clusterId;
    _load();
  }

  Future<void> _load() async {
    final String raw;
    final String? clusterId;
    try {
      final prefs = await SharedPreferences.getInstance();
      raw = prefs.getString(clickSocialFramePicksKey(widget.setId)) ?? '';
      clusterId = prefs.getString(clickSocialClusterKey);
    } catch (_) {
      // No store to read: the guide still works, minus the "shot n of m" line.
      return;
    }
    if (!mounted) return;
    setState(() {
      _clusterId ??= clusterId;
      _picks = resolveFramePicks(
        raw
            .split(',')
            .map((e) => int.tryParse(e.trim()))
            .whereType<int>()
            .toList(),
        isPanel: _isPanel,
      );
      _loaded = true;
    });
  }

  bool get _isPanel => clickSocialIsPanel(
        categoryId: widget.categoryId,
        technique: widget.technique,
      );

  ClickSocialFrame? get _frame => frameByIndex(widget.frameIndex);

  List<GuideStep> get _steps {
    final frame = _frame;
    if (frame == null) return const [];
    return frame.guideSteps(
      isAssam: clickSocialIsAssam(_clusterId),
      isKal: clickSocialIsKal(
        clusterId: _clusterId,
        technique: widget.technique,
      ),
      clusterId: _clusterId,
      productLabel: widget.productLabel ?? widget.categoryId,
      technique: widget.technique,
    );
  }

  /// HTML `guideShotName`: "FULL DISPLAY — SHOT 1 OF 5".
  String _overline(ClickSocialFrame frame) {
    final at = _picks.indexOf(frame.index);
    if (!_loaded || at == -1) return frame.name.toUpperCase();
    return '${frame.name.toUpperCase()} — SHOT ${at + 1} OF ${_picks.length}';
  }

  void _back() {
    if (_step == 0) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => _step -= 1);
  }

  void _next(List<GuideStep> steps) {
    if (_step < steps.length - 1) {
      setState(() => _step += 1);
      return;
    }
    _takeTheShot();
  }

  /// HTML TAKE THE SHOT: close the guide and expand that frame's drop zone.
  void _takeTheShot() {
    final frame = _frame;
    if (frame == null) return;
    Navigator.of(context).pop(frame.index);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final frame = _frame;
    final steps = _steps;

    if (frame == null || steps.isEmpty) {
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
            child: Center(
              child: Text(
                l10n.productUnavailable,
                style: AppTypography.bodyMedium,
              ),
            ),
          ),
        ),
      );
    }

    final step = steps[_step.clamp(0, steps.length - 1)];

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
              _GuideHeader(
                onBack: () => Navigator.of(context).pop(),
                stepLabel: '${_step + 1} / ${steps.length}',
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  children: [
                    Text(
                      _overline(frame),
                      style: AppTypography.navLabel.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    StepSwitcher(
                      child: Column(
                        key: ValueKey(_step),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.title,
                            style: AppTypography.displayMedium.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            step.subtitle,
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 13,
                              height: 1.4,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _StepBody(
                            step: step,
                            // Only pair a photo when the step names one that
                            // matches the instruction — never fall back to a
                            // random shot thumb (that caused the mismatches).
                            framePhotoAsset: step.referenceAsset,
                            photoLabel: _photoLabel(),
                          ),
                          if (step.caption != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              step.caption!,
                              style: AppTypography.labelSmall.copyWith(
                                fontSize: 12.5,
                                height: 1.4,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PhotoContinueBar(
                enabled: true,
                label:
                    _step == steps.length - 1 ? 'TAKE THE SHOT' : 'NEXT',
                onBack: _back,
                onContinue: () => _next(steps),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Label over the reference photograph — selected product + place.
  String _photoLabel() {
    final cluster = clusterById(_clusterId);
    final product = (widget.productLabel ?? '').trim().isNotEmpty
        ? widget.productLabel!.trim()
        : (cluster?.shortName ?? 'handloom');
    final place = (cluster?.place ?? '').split(',').first;
    if (place.isEmpty) return product.toUpperCase();
    return '${product.toUpperCase()} · ${place.toUpperCase()}';
  }
}

/// Diagram, single photograph or gallery — HTML picks exactly one per step.
class _StepBody extends StatelessWidget {
  const _StepBody({
    required this.step,
    required this.framePhotoAsset,
    required this.photoLabel,
  });

  final GuideStep step;
  /// Matched example photo, or null for diagram-only instructional steps.
  final String? framePhotoAsset;
  final String photoLabel;

  @override
  Widget build(BuildContext context) {
    if (step.imageAsset != null) {
      return _GuideCard(
        child: SizedBox(
          height: 340,
          width: double.infinity,
          child: GuideImage(asset: step.imageAsset!),
        ),
      );
    }

    if (step.hasGallery) {
      return Column(
        children: [
          for (var i = 0; i < step.gallery!.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            _GuideCard(
              child: SizedBox(
                height: 240,
                width: double.infinity,
                child: GuideImage(asset: step.gallery![i]),
              ),
            ),
          ],
        ],
      );
    }

    final diagram = step.diagram ?? 'grid';
    final photo = framePhotoAsset;

    // Instructional step with no matching photo yet — diagram only.
    if (photo == null) {
      return _GuideCard(
        child: SizedBox(
          height: 220,
          width: double.infinity,
          child: ColoredBox(
            color: AppColors.white,
            child: CustomPaint(
              painter: GuideDiagramPainter(diagram),
              child: const SizedBox.expand(),
            ),
          ),
        ),
      );
    }

    // Diagram beside the matching reference photo.
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = (constraints.maxWidth / 2) * 140 / 200;
        return _GuideCard(
          child: SizedBox(
            height: height.clamp(190.0, 280.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ColoredBox(
                    color: AppColors.white,
                    child: CustomPaint(
                      painter: GuideDiagramPainter(diagram),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
                Container(width: 1, color: AppColors.borderLight),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      GuideImage(asset: photo),
                      Positioned(
                        left: 8,
                        bottom: 8,
                        right: 8,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              photoLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.navLabel.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.6,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GuideCard extends StatelessWidget {
  const _GuideCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.primary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight, width: 1.2),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GuideHeader extends StatelessWidget {
  const _GuideHeader({
    required this.onBack,
    required this.stepLabel,
  });

  final VoidCallback onBack;
  final String stepLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 16, 4),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.surfaceSelected,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              stepLabel,
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The nine HTML guide diagrams, drawn in the source 200×140 space.
class GuideDiagramPainter extends CustomPainter {
  GuideDiagramPainter(this.diagram);

  final String diagram;

  static const _ink = AppColors.textPrimary;
  static const _accent = AppColors.primary;
  static const _mid = AppColors.textSecondary;
  static const _pale = AppColors.surfaceMuted;
  static const _line = AppColors.border;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.surface);
    canvas.save();
    canvas.scale(size.width / 200, size.height / 140);
    switch (diagram) {
      case 'hang':
        _hang(canvas);
      case 'drape':
        _drape(canvas);
      case 'grid':
        _grid(canvas);
      case 'gridmotif':
        _gridMotif(canvas);
      case 'scale':
        _scale(canvas);
      case 'gridthirds':
        _gridThirds(canvas);
      case 'flatprops':
        _flatProps(canvas);
      case 'diagline':
        _diagLine(canvas);
      case 'foldmid':
        _foldMid(canvas);
      case 'folddiag':
        _foldDiag(canvas);
      case 'dist':
        _dist(canvas);
      case 'rake':
        _rake(canvas);
      case 'close':
        _close(canvas);
      case 'border':
        _border(canvas);
      default:
        _grid(canvas);
    }
    canvas.restore();
  }

  static Paint _fill(Color color) => Paint()..color = color;

  static Paint _stroke(Color color, double width, {bool dashed = false}) =>
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..strokeCap = dashed ? StrokeCap.butt : StrokeCap.square;

  static void _rect(
    Canvas canvas,
    double l,
    double t,
    double w,
    double h, {
    Color? fill,
    Color? stroke,
    double strokeWidth = 2,
  }) {
    final rect = Rect.fromLTWH(l, t, w, h);
    if (fill != null) canvas.drawRect(rect, _fill(fill));
    if (stroke != null) canvas.drawRect(rect, _stroke(stroke, strokeWidth));
  }

  /// Draws [path] as a dashed line, the way the HTML `stroke-dasharray` does.
  static void _dashed(
    Canvas canvas,
    Path path,
    Color color, {
    double width = 2,
    double on = 5,
    double off = 4,
  }) {
    final paint = _stroke(color, width, dashed: true);
    for (final metric in path.computeMetrics()) {
      var at = 0.0;
      while (at < metric.length) {
        final end = (at + on).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(at, end), paint);
        at = end + off;
      }
    }
  }

  static void _arrow(Canvas canvas, List<Offset> points, Color color) {
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(path..close(), _fill(color));
  }

  static void _label(
    Canvas canvas,
    String text,
    Offset at, {
    double fontSize = 13,
    FontWeight weight = FontWeight.w800,
    Color color = _ink,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: weight,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, Offset(at.dx, at.dy - painter.height));
  }

  void _hang(Canvas canvas) {
    _rect(canvas, 16, 28, 168, 7, fill: _mid);
    _rect(canvas, 82, 35, 44, 88, fill: _pale, stroke: _ink);
    final folds = Path()
      ..moveTo(92, 36)
      ..lineTo(92, 122)
      ..moveTo(102, 36)
      ..lineTo(102, 122)
      ..moveTo(112, 36)
      ..lineTo(112, 122);
    canvas.drawPath(folds, _stroke(_line, 1));
    _rect(canvas, 82, 109, 44, 14, fill: _ink);
    _dashed(
      canvas,
      Path()
        ..moveTo(38, 112)
        ..cubicTo(38, 62, 54, 42, 74, 33),
      _accent,
    );
    _arrow(
      canvas,
      const [Offset(78, 32), Offset(68, 31), Offset(72, 40)],
      _accent,
    );
  }

  void _drape(Canvas canvas) {
    _rect(canvas, 16, 28, 168, 7, fill: _mid);
    _rect(canvas, 72, 35, 56, 72, fill: _pale, stroke: _ink);
    final cloth = Path()
      ..moveTo(72, 35)
      ..lineTo(86, 123)
      ..lineTo(100, 53)
      ..lineTo(114, 123)
      ..lineTo(128, 35);
    canvas.drawPath(cloth, _fill(_line));
    canvas.drawPath(cloth, _stroke(_ink, 2));
    _dashed(
      canvas,
      Path()
        ..moveTo(40, 100)
        ..cubicTo(44, 66, 56, 46, 68, 36),
      _accent,
    );
    _arrow(
      canvas,
      const [Offset(72, 34), Offset(62, 34), Offset(65, 42)],
      _accent,
    );
  }

  /// Phone + thirds grid with the piece edges sitting on the grid lines.
  void _grid(Canvas canvas) {
    _phoneShell(canvas);
    _thirdsGrid(canvas);
    // Piece fills the centre cell — left/right on vertical thirds, top/bottom
    // on horizontal thirds so "align with the gridlines" is literal.
    _rect(canvas, 89, 47, 22, 33, fill: _line, stroke: _ink, strokeWidth: 1.5);
    _rect(canvas, 89, 72, 22, 8, fill: _ink);
  }

  /// Motif (dark square) sits on a grid crossing — not centred.
  void _gridMotif(Canvas canvas) {
    _phoneShell(canvas);
    _thirdsGrid(canvas);
    _rect(canvas, 78, 28, 44, 72, fill: _line, stroke: _ink, strokeWidth: 1.5);
    // Lower-left thirds intersection (89, 80).
    _rect(canvas, 82, 73, 14, 14, fill: _ink);
    canvas.drawCircle(const Offset(89, 80), 2.5, _fill(_accent));
  }

  /// Familiar object (coin / bangle) beside the piece for scale.
  void _scale(Canvas canvas) {
    _phoneShell(canvas);
    _thirdsGrid(canvas);
    _rect(canvas, 78, 28, 36, 72, fill: _line, stroke: _ink, strokeWidth: 1.5);
    _rect(canvas, 78, 88, 36, 12, fill: _ink);
    // Coin
    canvas.drawCircle(const Offset(126, 92), 8, _fill(_accent));
    canvas.drawCircle(const Offset(126, 92), 5, _stroke(AppColors.white, 1.5));
    // Bangle
    canvas.drawCircle(const Offset(126, 58), 10, _stroke(_accent, 2.5));
  }

  /// Piece fills the frame; reference object sits on a thirds crossing.
  void _gridThirds(Canvas canvas) {
    _phoneShell(canvas);
    _thirdsGrid(canvas);
    _rect(canvas, 74, 22, 52, 86, fill: _line, stroke: _ink, strokeWidth: 1.5);
    // Object on lower-right crossing (111, 80).
    canvas.drawCircle(const Offset(111, 80), 7, _fill(_accent));
    canvas.drawCircle(const Offset(111, 80), 4, _stroke(AppColors.white, 1.5));
  }

  void _phoneShell(Canvas canvas) {
    _rect(canvas, 62, 4, 76, 132, fill: _ink);
    _rect(canvas, 68, 14, 64, 98, fill: _pale);
    canvas.drawCircle(const Offset(100, 124), 6, _fill(AppColors.white));
  }

  void _thirdsGrid(Canvas canvas) {
    _dashed(
      canvas,
      Path()
        ..moveTo(89, 14)
        ..lineTo(89, 112)
        ..moveTo(111, 14)
        ..lineTo(111, 112)
        ..moveTo(68, 47)
        ..lineTo(132, 47)
        ..moveTo(68, 80)
        ..lineTo(132, 80),
      _accent,
      width: 1,
      on: 3,
      off: 3,
    );
  }

  /// Flat piece with 1–2 small props beside it.
  void _flatProps(Canvas canvas) {
    _rect(canvas, 24, 36, 110, 72, fill: _pale, stroke: _ink);
    _rect(canvas, 24, 36, 110, 10, fill: _ink);
    _rect(canvas, 24, 98, 110, 10, fill: _ink);
    // Cup / prop
    _rect(canvas, 148, 48, 22, 28, fill: _line, stroke: _ink, strokeWidth: 1.5);
    _rect(canvas, 152, 44, 14, 6, fill: _mid);
    // Flower / thread ball
    canvas.drawCircle(const Offset(159, 100), 10, _fill(_accent));
    canvas.drawCircle(const Offset(159, 100), 4, _fill(AppColors.white));
  }

  /// Fringe / border band running on the leading diagonal.
  void _diagLine(Canvas canvas) {
    _phoneShell(canvas);
    // Diagonal guide
    _dashed(
      canvas,
      Path()
        ..moveTo(68, 112)
        ..lineTo(132, 14),
      _accent,
      width: 1.5,
      on: 4,
      off: 3,
    );
    // Fabric strip along the diagonal
    final strip = Path()
      ..moveTo(72, 100)
      ..lineTo(118, 28)
      ..lineTo(128, 34)
      ..lineTo(82, 106)
      ..close();
    canvas.drawPath(strip, _fill(_line));
    canvas.drawPath(strip, _stroke(_ink, 1.5));
    // Fringe ticks at the lower end
    for (final o in const [0.0, 6.0, 12.0, 18.0]) {
      canvas.drawLine(
        Offset(74 + o * 0.55, 102 + o * 0.35),
        Offset(70 + o * 0.55, 112 + o * 0.2),
        _stroke(_ink, 1.5),
      );
    }
  }

  void _foldMid(Canvas canvas) {
    _rect(canvas, 20, 30, 160, 80, fill: _pale, stroke: _ink);
    _rect(canvas, 20, 30, 160, 8, fill: _ink);
    _rect(canvas, 20, 102, 160, 8, fill: _ink);
    _dashed(
      canvas,
      Path()
        ..moveTo(20, 70)
        ..lineTo(180, 70),
      _mid,
      width: 1.5,
      on: 6,
      off: 4,
    );
    _dashed(
      canvas,
      Path()
        ..moveTo(100, 44)
        ..cubicTo(122, 52, 122, 88, 102, 96),
      _accent,
    );
    _arrow(
      canvas,
      const [Offset(100, 98), Offset(110, 94), Offset(104, 87)],
      _accent,
    );
  }

  void _foldDiag(Canvas canvas) {
    _rect(canvas, 20, 36, 160, 72, fill: _pale, stroke: _ink);
    final corner = Path()
      ..moveTo(20, 36)
      ..lineTo(84, 36)
      ..lineTo(20, 100)
      ..close();
    canvas.drawPath(corner, _fill(_line));
    canvas.drawPath(corner, _stroke(_ink, 2));
    _dashed(
      canvas,
      Path()
        ..moveTo(70, 92)
        ..cubicTo(58, 78, 48, 66, 40, 56),
      _accent,
    );
    _arrow(
      canvas,
      const [Offset(37, 52), Offset(38, 62), Offset(45, 57)],
      _accent,
    );
  }

  void _dist(Canvas canvas) {
    _rect(canvas, 16, 108, 168, 18, fill: _pale, stroke: _ink);
    final weave = Path()
      ..moveTo(16, 112)
      ..lineTo(184, 112)
      ..moveTo(16, 117)
      ..lineTo(184, 117)
      ..moveTo(16, 122)
      ..lineTo(184, 122);
    canvas.drawPath(weave, _stroke(_mid, 1));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(82, 18, 36, 22),
        const Radius.circular(3),
      ),
      _fill(_ink),
    );
    canvas.drawCircle(
      const Offset(100, 29),
      5,
      _stroke(AppColors.white, 2),
    );
    canvas.drawLine(
      const Offset(100, 46),
      const Offset(100, 100),
      _stroke(_accent, 2),
    );
    _arrow(
      canvas,
      const [Offset(100, 46), Offset(96, 53), Offset(104, 53)],
      _accent,
    );
    _arrow(
      canvas,
      const [Offset(100, 100), Offset(96, 93), Offset(104, 93)],
      _accent,
    );
    _label(canvas, '15–30 cm', const Offset(108, 78));
    _label(
      canvas,
      'about one hand-span',
      const Offset(108, 92),
      fontSize: 9,
      weight: FontWeight.w400,
      color: _mid,
    );
  }

  void _rake(Canvas canvas) {
    _rect(canvas, 16, 96, 168, 26, fill: _pale, stroke: _ink);
    final ripple = Path()..moveTo(28, 96);
    for (var x = 28.0; x < 172; x += 12) {
      ripple.quadraticBezierTo(x + 6, 88, x + 12, 96);
    }
    canvas.drawPath(ripple, _stroke(_mid, 1.5));
    final shadows = Path();
    for (final x in const [42.0, 66.0, 90.0, 114.0, 138.0, 162.0]) {
      shadows
        ..moveTo(x, 94)
        ..lineTo(x + 7, 94);
    }
    canvas.drawPath(shadows, _stroke(_ink, 3));
    canvas.drawCircle(const Offset(26, 40), 10, _fill(_accent));
    _dashed(
      canvas,
      Path()
        ..moveTo(38, 46)
        ..lineTo(88, 88)
        ..moveTo(42, 40)
        ..lineTo(110, 82)
        ..moveTo(40, 54)
        ..lineTo(70, 88),
      _accent,
      width: 1.5,
      on: 4,
      off: 3,
    );
    _label(canvas, '30°', const Offset(118, 86));
    _label(
      canvas,
      'low light = shadows show weave',
      const Offset(118, 100),
      fontSize: 9,
      weight: FontWeight.w400,
      color: _mid,
    );
  }

  void _close(Canvas canvas) {
    _rect(canvas, 28, 18, 144, 104, fill: _pale, stroke: _ink);
    final threads = Path();
    for (var y = 34.0; y <= 114; y += 16) {
      threads
        ..moveTo(28, y)
        ..lineTo(172, y);
    }
    canvas.drawPath(threads, _stroke(_line, 1));
    final motif = Path()
      ..moveTo(52, 40)
      ..lineTo(148, 40)
      ..moveTo(52, 100)
      ..lineTo(148, 100);
    canvas.drawPath(motif, _stroke(_mid, 1));
    final corners = Path()
      ..moveTo(52, 54)
      ..lineTo(52, 40)
      ..lineTo(66, 40)
      ..moveTo(148, 40)
      ..lineTo(134, 40)
      ..moveTo(52, 86)
      ..lineTo(52, 100)
      ..lineTo(66, 100)
      ..moveTo(148, 100)
      ..lineTo(134, 100);
    canvas.drawPath(corners, _stroke(_accent, 2.5));
    canvas.drawLine(
      const Offset(6, 44),
      const Offset(24, 58),
      _stroke(_accent, 2),
    );
    _arrow(
      canvas,
      const [Offset(26, 60), Offset(24, 50), Offset(17, 55)],
      _accent,
    );
  }

  void _border(Canvas canvas) {
    _rect(canvas, 28, 24, 144, 92, fill: _pale, stroke: _ink);
    _rect(canvas, 28, 84, 144, 32, fill: _line, stroke: _ink);
    for (final x in const [44.0, 70.0, 96.0, 122.0]) {
      _rect(canvas, x, 94, 12, 10, fill: _ink);
    }
    _dashed(
      canvas,
      Path()..addRect(const Rect.fromLTWH(88, 78, 56, 42)),
      _accent,
      on: 5,
      off: 3,
    );
  }

  @override
  bool shouldRepaint(covariant GuideDiagramPainter oldDelegate) =>
      oldDelegate.diagram != diagram;
}
