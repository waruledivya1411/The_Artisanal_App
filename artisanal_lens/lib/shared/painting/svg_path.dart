import 'dart:math' as math;
import 'dart:ui';

/// Parses the small subset of SVG path data used by Click & Social grids.
///
/// Supports M/L/H/V/Z/A and their relative forms — enough for the HTML
/// `gridPaths` and framing-quiz `archDefs.grid` strings.
Path parseSvgPath(
  String data, {
  double scaleX = 1,
  double scaleY = 1,
}) {
  final path = Path();
  final tokens = _tokenize(data);
  var i = 0;
  var cx = 0.0;
  var cy = 0.0;
  var startX = 0.0;
  var startY = 0.0;
  var command = 'M';

  double next() {
    if (i >= tokens.length) return 0;
    return double.tryParse(tokens[i++]) ?? 0;
  }

  bool hasNumber() {
    if (i >= tokens.length) return false;
    return double.tryParse(tokens[i]) != null;
  }

  while (i < tokens.length) {
    final t = tokens[i];
    if (RegExp(r'^[MmLlHhVvZzAa]$').hasMatch(t)) {
      command = t;
      i++;
    }

    switch (command) {
      case 'M':
      case 'm':
        final relative = command == 'm';
        var first = true;
        while (hasNumber()) {
          final x = next();
          final y = next();
          if (relative) {
            cx += x;
            cy += y;
          } else {
            cx = x;
            cy = y;
          }
          if (first) {
            path.moveTo(cx * scaleX, cy * scaleY);
            startX = cx;
            startY = cy;
            first = false;
            command = relative ? 'l' : 'L';
          } else {
            path.lineTo(cx * scaleX, cy * scaleY);
          }
        }
      case 'L':
      case 'l':
        final relative = command == 'l';
        while (hasNumber()) {
          final x = next();
          final y = next();
          if (relative) {
            cx += x;
            cy += y;
          } else {
            cx = x;
            cy = y;
          }
          path.lineTo(cx * scaleX, cy * scaleY);
        }
      case 'H':
      case 'h':
        final relative = command == 'h';
        while (hasNumber()) {
          final x = next();
          cx = relative ? cx + x : x;
          path.lineTo(cx * scaleX, cy * scaleY);
        }
      case 'V':
      case 'v':
        final relative = command == 'v';
        while (hasNumber()) {
          final y = next();
          cy = relative ? cy + y : y;
          path.lineTo(cx * scaleX, cy * scaleY);
        }
      case 'Z':
      case 'z':
        path.close();
        cx = startX;
        cy = startY;
      case 'A':
      case 'a':
        final relative = command == 'a';
        while (hasNumber()) {
          final rx = next().abs();
          final ry = next().abs();
          final rotation = next() * math.pi / 180;
          final largeArc = next() != 0;
          final sweep = next() != 0;
          final x = next();
          final y = next();
          final ex = relative ? cx + x : x;
          final ey = relative ? cy + y : y;
          _addArc(
            path,
            Offset(cx * scaleX, cy * scaleY),
            Offset(ex * scaleX, ey * scaleY),
            rx * scaleX,
            ry * scaleY,
            rotation,
            largeArc,
            sweep,
          );
          cx = ex;
          cy = ey;
        }
      default:
        // Skip unknown tokens so a bad fragment cannot hang the loop.
        if (i < tokens.length && double.tryParse(tokens[i]) == null) i++;
    }
  }

  return path;
}

/// Strokes [data] into [canvas], scaled from a [viewBox] coordinate space.
void paintSvgPath(
  Canvas canvas,
  Size size,
  String data,
  Paint paint, {
  Size viewBox = const Size(100, 100),
}) {
  if (data.trim().isEmpty || viewBox.width == 0 || viewBox.height == 0) {
    return;
  }
  final path = parseSvgPath(
    data,
    scaleX: size.width / viewBox.width,
    scaleY: size.height / viewBox.height,
  );
  canvas.drawPath(path, paint);
}

List<String> _tokenize(String data) {
  final out = <String>[];
  final re = RegExp(
    r'([MmLlHhVvZzAa])|([+-]?(?:\d+\.?\d*|\.\d+)(?:[eE][+-]?\d+)?)',
  );
  for (final m in re.allMatches(data)) {
    out.add(m.group(0)!);
  }
  return out;
}

/// Endpoint-parameterized SVG arc → cubic beziers (W3C appendix F.6).
void _addArc(
  Path path,
  Offset start,
  Offset end,
  double rx,
  double ry,
  double xAxisRotation,
  bool largeArc,
  bool sweep,
) {
  if (rx == 0 || ry == 0 || start == end) {
    path.lineTo(end.dx, end.dy);
    return;
  }

  final cosPhi = math.cos(xAxisRotation);
  final sinPhi = math.sin(xAxisRotation);
  final dx = (start.dx - end.dx) / 2;
  final dy = (start.dy - end.dy) / 2;
  final x1p = cosPhi * dx + sinPhi * dy;
  final y1p = -sinPhi * dx + cosPhi * dy;

  var rxSq = rx * rx;
  var rySq = ry * ry;
  final x1pSq = x1p * x1p;
  final y1pSq = y1p * y1p;
  final lambda = x1pSq / rxSq + y1pSq / rySq;
  if (lambda > 1) {
    final s = math.sqrt(lambda);
    rx *= s;
    ry *= s;
    rxSq = rx * rx;
    rySq = ry * ry;
  }

  final num = math.max(0, rxSq * rySq - rxSq * y1pSq - rySq * x1pSq);
  final den = rxSq * y1pSq + rySq * x1pSq;
  var cFactor = den == 0 ? 0.0 : math.sqrt(num / den);
  if (largeArc == sweep) cFactor = -cFactor;

  final cxp = cFactor * (rx * y1p) / ry;
  final cyp = cFactor * (-ry * x1p) / rx;
  final cx = cosPhi * cxp - sinPhi * cyp + (start.dx + end.dx) / 2;
  final cy = sinPhi * cxp + cosPhi * cyp + (start.dy + end.dy) / 2;

  double angle(Offset u, Offset v) {
    final sign = u.dx * v.dy - u.dy * v.dx < 0 ? -1.0 : 1.0;
    final dot =
        ((u.dx * v.dx + u.dy * v.dy) / (u.distance * v.distance)).clamp(-1.0, 1.0);
    return sign * math.acos(dot);
  }

  final v1 = Offset((x1p - cxp) / rx, (y1p - cyp) / ry);
  final v2 = Offset((-x1p - cxp) / rx, (-y1p - cyp) / ry);
  var theta1 = angle(const Offset(1, 0), v1);
  var dTheta = angle(v1, v2);
  if (!sweep && dTheta > 0) dTheta -= 2 * math.pi;
  if (sweep && dTheta < 0) dTheta += 2 * math.pi;

  // Approximate with cubics; 90° segments keep the curve faithful.
  final segments = math.max(1, (dTheta.abs() / (math.pi / 2)).ceil());
  final delta = dTheta / segments;
  var t = theta1;
  for (var s = 0; s < segments; s++) {
    final t1 = t;
    final t2 = t + delta;
    final e1x = rx * math.cos(t1);
    final e1y = ry * math.sin(t1);
    final e2x = rx * math.cos(t2);
    final e2y = ry * math.sin(t2);
    final alpha = math.sin(delta) * (math.sqrt(4 + 3 * math.pow(math.tan(delta / 2), 2)) - 1) / 3;
    final q1 = Offset(
      cx + cosPhi * e1x - sinPhi * e1y,
      cy + sinPhi * e1x + cosPhi * e1y,
    );
    final q2 = Offset(
      cx + cosPhi * e2x - sinPhi * e2y,
      cy + sinPhi * e2x + cosPhi * e2y,
    );
    final t1x = -rx * math.sin(t1);
    final t1y = ry * math.cos(t1);
    final t2x = -rx * math.sin(t2);
    final t2y = ry * math.cos(t2);
    final c1 = Offset(
      q1.dx + alpha * (cosPhi * t1x - sinPhi * t1y),
      q1.dy + alpha * (sinPhi * t1x + cosPhi * t1y),
    );
    final c2 = Offset(
      q2.dx - alpha * (cosPhi * t2x - sinPhi * t2y),
      q2.dy - alpha * (sinPhi * t2x + cosPhi * t2y),
    );
    path.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, q2.dx, q2.dy);
    t = t2;
  }
}
