import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../domain/entities/capture_feedback.dart';
import '../../../../domain/entities/placement_kind.dart';
import '../../../../domain/entities/technique_preset.dart';
import '../../../../shared/motion/motion.dart';
import '../../../../shared/painting/svg_path.dart';

/// Placement marking + composition grid over the live camera.
///
/// Each [PlacementKind] draws a different "put the product here" border.
/// The dashed box is the same inset the analyser measures. Border colour
/// follows live light / distance so Ready turns green.
class GuideOverlay extends StatelessWidget {
  const GuideOverlay({
    required this.grid,
    required this.placement,
    required this.caption,
    this.gridPath,
    this.feedback,
    super.key,
  });

  final GridOverlayType grid;
  final PlacementKind placement;
  final String? gridPath;
  final String caption;
  final CaptureFeedback? feedback;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: TweenAnimationBuilder<double>(
                  key: ValueKey('$grid|${placement.name}|$gridPath'),
                  tween: Tween(begin: 0, end: 1),
                  duration: AppMotion.screen,
                  curve: AppMotion.curve,
                  builder: (context, value, child) =>
                      Opacity(opacity: value, child: child),
                  child: CustomPaint(
                    painter: _GuidePainter(
                      grid: grid,
                      placement: placement,
                      gridPath: gridPath,
                      borderColor: _borderColor(feedback),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: constraints.maxHeight * 0.30,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: AppMotion.select,
                    child: caption.trim().isEmpty
                        ? const SizedBox.shrink()
                        : Container(
                            key: ValueKey(caption),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cameraScrim,
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              caption,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                height: 16 / 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static Color _borderColor(CaptureFeedback? feedback) {
    if (feedback == null || !feedback.hasVisiblePrompt) {
      return AppColors.white;
    }
    if (feedback.isReadyToShoot) return AppColors.success;
    return switch (feedback.prompt) {
      CapturePrompt.tooDark ||
      CapturePrompt.lowLight ||
      CapturePrompt.tooBright ||
      CapturePrompt.backlightDetected =>
        AppColors.warning,
      CapturePrompt.moveCloser ||
      CapturePrompt.moveFurther ||
      CapturePrompt.moveIntoFrame ||
      CapturePrompt.keepInsideFrame ||
      CapturePrompt.centerSubject =>
        AppColors.primaryLight,
      _ => AppColors.warning,
    };
  }
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter({
    required this.grid,
    required this.placement,
    required this.borderColor,
    this.gridPath,
  });

  final GridOverlayType grid;
  final PlacementKind placement;
  final Color borderColor;
  final String? gridPath;

  @override
  void paint(Canvas canvas, Size size) {
    final box = Rect.fromLTRB(
      size.width * placement.ghostInsetX,
      size.height * placement.ghostInsetY,
      size.width * (1 - placement.ghostInsetX),
      size.height * (1 - placement.ghostInsetY),
    );

    _dimOutside(canvas, size, box);

    final gridPaint = Paint()
      ..color = AppColors.white.withValues(alpha: 0.32)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.save();
    canvas.clipRect(box);
    final path = gridPath?.trim();
    final hasPath = path != null && path.isNotEmpty;
    // Border shots: one motif window from placement marks, not a second SVG box.
    final skipPath = placement == PlacementKind.border;
    if (hasPath && !skipPath) {
      paintSvgPath(
        canvas,
        size,
        path,
        Paint()
          ..color = AppColors.white.withValues(alpha: 0.38)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.15,
      );
    } else if (!hasPath && _gridDrawnByPlacement(placement)) {
      _drawGrid(canvas, size, gridPaint);
    }
    canvas.restore();

    if (!hasPath || skipPath) {
      _drawKindMarks(canvas, box);
    }

    final framePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;
    _dashedRect(canvas, box, framePaint);
    _corners(canvas, box, framePaint);
  }

  /// Thirds / centre grids are the composition. Other kinds use [_drawKindMarks].
  static bool _gridDrawnByPlacement(PlacementKind placement) =>
      placement == PlacementKind.fullDisplay ||
      placement == PlacementKind.closeUp ||
      placement == PlacementKind.lifestyle ||
      placement == PlacementKind.making;

  void _dimOutside(Canvas canvas, Size size, Rect box) {
    final overlay = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Offset.zero & size)
      ..addRRect(RRect.fromRectAndRadius(box, const Radius.circular(10)));
    canvas.drawPath(
      overlay,
      Paint()..color = Colors.black.withValues(alpha: 0.38),
    );
  }

  void _drawGrid(Canvas canvas, Size size, Paint paint) {
    switch (grid) {
      case GridOverlayType.ruleOfThirds:
        for (var i = 1; i < 3; i++) {
          final x = size.width * i / 3;
          final y = size.height * i / 3;
          canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
          canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
        }
      case GridOverlayType.centerFocus:
        final inner = Rect.fromLTRB(
          size.width * 0.30,
          size.height * 0.28,
          size.width * 0.70,
          size.height * 0.72,
        );
        canvas.drawRect(inner, paint);
        canvas.drawLine(
          Offset(size.width * 0.5, 0),
          Offset(size.width * 0.5, inner.top),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.5, inner.bottom),
          Offset(size.width * 0.5, size.height),
          paint,
        );
      case GridOverlayType.leadingLines:
        canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), paint);
        canvas.drawLine(
          Offset(0, size.height * 0.55),
          Offset(size.width * 0.55, 0),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.45, size.height),
          Offset(size.width, size.height * 0.45),
          paint,
        );
      case GridOverlayType.detailFrame:
        canvas.drawRect(
          Rect.fromLTRB(
            size.width * 0.52,
            size.height * 0.08,
            size.width * 0.88,
            size.height * 0.42,
          ),
          paint,
        );
        canvas.drawLine(
          Offset(0, size.height),
          Offset(size.width, size.height * 0.34),
          paint,
        );
      case GridOverlayType.horizontalFolds:
        canvas.drawLine(
          Offset(0, size.height * 0.33),
          Offset(size.width, size.height * 0.33),
          paint,
        );
        canvas.drawLine(
          Offset(0, size.height * 0.66),
          Offset(size.width, size.height * 0.66),
          paint,
        );
        canvas.drawLine(
          Offset(0, size.height * 0.82),
          Offset(size.width, size.height * 0.22),
          paint,
        );
    }
  }

  /// Extra marks so each shot reads as a different "place it here" shape.
  void _drawKindMarks(Canvas canvas, Rect box) {
    final mark = Paint()
      ..color = borderColor.withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    switch (placement) {
      case PlacementKind.hanging:
        canvas.drawLine(
          Offset(box.left - 8, box.top),
          Offset(box.right + 8, box.top),
          mark,
        );
        canvas.drawCircle(Offset(box.center.dx, box.top), 3.5, mark);
      case PlacementKind.flatLay:
        canvas.drawLine(
          Offset(box.left, box.bottom + 6),
          Offset(box.right, box.bottom + 6),
          mark,
        );
      case PlacementKind.folded:
        _dashedLine(
          canvas,
          Offset(box.left, box.center.dy),
          Offset(box.right, box.center.dy),
          mark,
        );
      case PlacementKind.scale:
        final spot = Offset(
          box.left + box.width * 2 / 3,
          box.top + box.height * 2 / 3,
        );
        canvas.drawCircle(spot, 10, mark);
        canvas.drawCircle(spot, 4, mark);
      case PlacementKind.drape:
      case PlacementKind.fringe:
        canvas.drawLine(box.bottomLeft, box.topRight, mark);
      case PlacementKind.border:
        final window = Rect.fromLTWH(
          box.left + box.width * 0.42,
          box.top + 8,
          box.width * 0.52,
          box.height * 0.42,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(window, const Radius.circular(6)),
          mark,
        );
      case PlacementKind.framed:
        final inner = box.deflate(18);
        canvas.drawRRect(
          RRect.fromRectAndRadius(inner, const Radius.circular(4)),
          mark,
        );
      case PlacementKind.closeUp:
      case PlacementKind.fullDisplay:
      case PlacementKind.lifestyle:
      case PlacementKind.making:
        break;
    }
  }

  void _corners(Canvas canvas, Rect rect, Paint paint) {
    final len = (rect.shortestSide * 0.12).clamp(14.0, 28.0);
    void arm(Offset from, Offset along) {
      canvas.drawLine(from, from + along, paint);
    }

    arm(rect.topLeft, Offset(len, 0));
    arm(rect.topLeft, Offset(0, len));
    arm(rect.topRight, Offset(-len, 0));
    arm(rect.topRight, Offset(0, len));
    arm(rect.bottomLeft, Offset(len, 0));
    arm(rect.bottomLeft, Offset(0, -len));
    arm(rect.bottomRight, Offset(-len, 0));
    arm(rect.bottomRight, Offset(0, -len));
  }

  void _dashedRect(Canvas canvas, Rect rect, Paint paint) {
    _dashedLine(canvas, rect.topLeft, rect.topRight, paint);
    _dashedLine(canvas, rect.topRight, rect.bottomRight, paint);
    _dashedLine(canvas, rect.bottomRight, rect.bottomLeft, paint);
    _dashedLine(canvas, rect.bottomLeft, rect.topLeft, paint);
  }

  void _dashedLine(Canvas canvas, Offset from, Offset to, Paint paint) {
    const dash = 10.0;
    const gap = 6.0;
    final delta = to - from;
    final length = delta.distance;
    if (length == 0) return;
    final step = delta / length;
    var travelled = 0.0;
    while (travelled < length) {
      final segment = (travelled + dash).clamp(0.0, length);
      canvas.drawLine(from + step * travelled, from + step * segment, paint);
      travelled += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _GuidePainter oldDelegate) =>
      oldDelegate.grid != grid ||
      oldDelegate.placement != placement ||
      oldDelegate.gridPath != gridPath ||
      oldDelegate.borderColor != borderColor;
}
