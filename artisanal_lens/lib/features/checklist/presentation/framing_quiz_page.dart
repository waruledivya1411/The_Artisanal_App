import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../framing_quiz_data.dart';
import '../../../shared/painting/svg_path.dart';

/// HTML photoStep 5 — framing quizzes. Inserted before the existing photo list.
class FramingQuizPage extends StatefulWidget {
  const FramingQuizPage({
    required this.setId,
    required this.categoryId,
    required this.frameIndexes,
    this.materialId,
    this.technique,
    super.key,
  });

  final String setId;
  final String categoryId;
  final List<int> frameIndexes;
  final String? materialId;
  final String? technique;

  @override
  State<FramingQuizPage> createState() => _FramingQuizPageState();
}

class _FramingQuizPageState extends State<FramingQuizPage> {
  int _index = 0;
  int? _pick;

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

  void _select(int oi) {
    setState(() => _pick = oi);
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
      if (widget.materialId != null && widget.materialId!.isNotEmpty)
        'material=${widget.materialId}',
      if (widget.technique != null && widget.technique!.isNotEmpty)
        'technique=${widget.technique}',
    ].join('&');
    context.go('/product/${widget.setId}/light-quiz?$q');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final def = localizedFramingArch(l10n, _arch);
    final picked = _pick != null ? def.options[_pick!] : null;
    final correct = picked?.correct == true;
    final msg = picked != null ? def.messageAt(_pick!) : null;
    final names = _frameNames(l10n);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _LessonHeader(
              onBack: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                    _pick = null;
                  });
                } else {
                  context.pop();
                }
              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
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
                      child: InkWell(
                        onTap: () => _select(oi),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(
                              color: _pick == oi
                                  ? (def.options[oi].correct
                                      ? AppColors.primary
                                      : AppColors.textMuted)
                                  : AppColors.textPrimary,
                              width: 2,
                            ),
                          ),
                          child: AspectRatio(
                            aspectRatio: 120 / 64,
                            child: CustomPaint(
                              painter: _FramingPainter(
                                gridPath: def.gridPath,
                                option: def.options[oi],
                              ),
                            ),
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
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: Text(
                          _index < _sequence.length - 1
                              ? l10n.csNextFraming
                              : l10n.csNextLightIt,
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

class _LessonHeader extends StatelessWidget {
  const _LessonHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
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

class _FramingPainter extends CustomPainter {
  _FramingPainter({required this.gridPath, required this.option});

  final String gridPath;
  final FramingOption option;

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 120;
    final sy = size.height / 64;
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = AppColors.surfaceMuted,
    );

    // HTML: dashed archetype grid matching the frames that share this quiz.
    final grid = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.square;
    paintSvgPath(
      canvas,
      size,
      gridPath,
      grid,
      viewBox: const Size(120, 64),
    );

    final fill = Paint()..color = AppColors.textPrimary;
    for (final r in option.rects) {
      canvas.drawRect(
        Rect.fromLTWH(r.left * sx, r.top * sy, r.width * sx, r.height * sy),
        fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FramingPainter oldDelegate) =>
      oldDelegate.option != option || oldDelegate.gridPath != gridPath;
}
