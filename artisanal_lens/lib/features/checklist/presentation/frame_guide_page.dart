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
    super.key,
  });

  final String setId;
  final int frameIndex;
  final String? clusterId;
  final String? categoryId;
  final String? technique;

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
      productLabel: widget.categoryId,
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
        backgroundColor: AppColors.background,
        appBar: AppBar(title: Text(l10n.csLesson01Title)),
        body: Center(
          child: Text(l10n.productUnavailable, style: AppTypography.bodyMedium),
        ),
      );
    }

    final step = steps[_step.clamp(0, steps.length - 1)];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _GuideHeader(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
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
                  const SizedBox(height: 4),
                  // Everything below the overline belongs to one step, so it
                  // moves as a single block when the step changes.
                  StepSwitcher(
                    child: Column(
                      key: ValueKey(_step),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: AppTypography.displayMedium.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          step.subtitle,
                          style: AppTypography.labelSmall.copyWith(
                            fontSize: 13,
                            height: 1.4,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _StepBody(
                          step: step,
                          framePhotoAsset: frame.thumbAssetFor(
                            clusterId: _clusterId,
                            categoryId: widget.categoryId,
                            technique: widget.technique,
                          ),
                          photoLabel: _photoLabel(),
                        ),
                        if (step.caption != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            step.caption!,
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 12,
                              height: 1.4,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _GuideFooter(
              stepLabel: '${_step + 1} / ${steps.length}',
              nextLabel: _step == steps.length - 1 ? 'TAKE THE SHOT' : 'NEXT',
              onBack: _back,
              onNext: () => _next(steps),
            ),
          ],
        ),
      ),
    );
  }

  /// HTML `gPhotoLabel` — product and place, over the reference photograph.
  String _photoLabel() {
    final cluster = clusterById(_clusterId);
    final product = cluster?.shortName ?? 'handloom';
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
  final String framePhotoAsset;
  final String photoLabel;

  @override
  Widget build(BuildContext context) {
    final box = BoxDecoration(
      color: AppColors.surfaceMuted,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.border),
    );

    if (step.imageAsset != null) {
      return Container(
        height: 340,
        clipBehavior: Clip.antiAlias,
        decoration: box,
        child: GuideImage(asset: step.imageAsset!),
      );
    }

    if (step.hasGallery) {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: box,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            for (final asset in step.gallery!)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 240,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: GuideImage(asset: asset),
                ),
              ),
          ],
        ),
      );
    }

    // HTML `gCols: '1fr 1fr'` — the diagram sits beside the reference photo.
    // The height follows the diagram's 200×140 source box so it is not
    // stretched, with a floor so the photograph still reads on a narrow phone.
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = (constraints.maxWidth / 2) * 140 / 200;
        return Container(
          height: height.clamp(180.0, 280.0),
          clipBehavior: Clip.antiAlias,
          decoration: box,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                // CustomPaint with no child prefers Size.zero; without expand it
                // collapses under Row's loose height and only the muted panel shows.
                child: ColoredBox(
                  color: AppColors.surface,
                  child: CustomPaint(
                    painter: GuideDiagramPainter(step.diagram ?? 'grid'),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    border: Border(left: BorderSide(color: AppColors.border)),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      GuideImage(asset: framePhotoAsset),
                      Positioned(
                        left: 6,
                        bottom: 6,
                        right: 6,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.textPrimary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              photoLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.navLabel.copyWith(
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GuideHeader extends StatelessWidget {
  const _GuideHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 2)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
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
    );
  }
}

class _GuideFooter extends StatelessWidget {
  const _GuideFooter({
    required this.stepLabel,
    required this.nextLabel,
    required this.onBack,
    required this.onNext,
  });

  final String stepLabel;
  final String nextLabel;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.divider, width: 2)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Pressable(
              child: OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(),
                side: const BorderSide(color: AppColors.textPrimary, width: 2),
              ),
                child: const Icon(
                  Icons.chevron_left,
                  size: 22,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: AppMotion.select,
              child: Text(
                stepLabel,
                key: ValueKey(stepLabel),
                textAlign: TextAlign.center,
                style: AppTypography.labelSmall.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Pressable(
              child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: const RoundedRectangleBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Text(
                nextLabel,
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                ),
              ),
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

  void _grid(Canvas canvas) {
    _rect(canvas, 62, 4, 76, 132, fill: _ink);
    _rect(canvas, 68, 14, 64, 98, fill: _pale);
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
    _rect(canvas, 89, 24, 22, 70, fill: _line, stroke: _ink, strokeWidth: 1.5);
    _rect(canvas, 89, 83, 22, 11, fill: _ink);
    canvas.drawCircle(const Offset(100, 124), 6, _fill(AppColors.white));
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
