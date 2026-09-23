import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Full-screen badge celebration: confetti rain + achievement card.
Future<void> showBadgeCelebration(
  BuildContext context, {
  required String badgeLabel,
}) async {
  HapticFeedback.mediumImpact();
  await showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Badge celebration',
    barrierColor: Colors.black.withValues(alpha: 0.55),
    transitionDuration: const Duration(milliseconds: 320),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _BadgeCelebrationOverlay(
        badgeLabel: badgeLabel,
        entry: animation,
      );
    },
    transitionBuilder: (context, animation, secondary, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

class _BadgeCelebrationOverlay extends StatefulWidget {
  const _BadgeCelebrationOverlay({
    required this.badgeLabel,
    required this.entry,
  });

  final String badgeLabel;
  final Animation<double> entry;

  @override
  State<_BadgeCelebrationOverlay> createState() =>
      _BadgeCelebrationOverlayState();
}

class _BadgeCelebrationOverlayState extends State<_BadgeCelebrationOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _confetti;
  late final AnimationController _badge;
  late final AnimationController _autoClose;
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    final rng = math.Random(42);
    _particles = List.generate(72, (i) {
      return _Particle(
        x: rng.nextDouble(),
        delay: rng.nextDouble() * 0.45,
        speed: 0.35 + rng.nextDouble() * 0.75,
        size: 5 + rng.nextDouble() * 9,
        spin: (rng.nextDouble() - 0.5) * 8,
        color: _palette[i % _palette.length],
        shape: i % 3,
      );
    });

    _confetti = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..forward();

    _badge = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _autoClose = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..forward().whenComplete(() {
        if (mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
  }

  static const _palette = <Color>[
    Color(0xFF2B6CB0),
    Color(0xFF48BB78),
    Color(0xFFED8936),
    Color(0xFFECC94B),
    Color(0xFF9F7AEA),
    Color(0xFFED64A6),
    Color(0xFF38B2AC),
    Color(0xFFF56565),
    Color(0xFF4299E1),
    Color(0xFF68D391),
  ];

  @override
  void dispose() {
    _confetti.dispose();
    _badge.dispose();
    _autoClose.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final popIn = CurvedAnimation(
      parent: _badge,
      curve: Curves.elasticOut,
    );
    final fadeIn = CurvedAnimation(
      parent: _badge,
      curve: const Interval(0, 0.4, curve: Curves.easeOut),
    );

    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              animation: _confetti,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ConfettiPainter(
                    progress: _confetti.value,
                    particles: _particles,
                  ),
                  size: Size.infinite,
                );
              },
            ),
            Center(
              child: FadeTransition(
                opacity: fadeIn,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.55, end: 1).animate(popIn),
                  child: _AchievementCard(badgeLabel: widget.badgeLabel),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 36,
              child: FadeTransition(
                opacity: fadeIn,
                child: Text(
                  'Tap anywhere to continue',
                  textAlign: TextAlign.center,
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 12.5,
                    color: AppColors.white.withValues(alpha: 0.75),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({required this.badgeLabel});

  final String badgeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: math.min(320, MediaQuery.sizeOf(context).width - 48),
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 28,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0xFF9F7AEA).withValues(alpha: 0.25),
            blurRadius: 40,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4A86C8),
                  Color(0xFF2B6CB0),
                  Color(0xFF9F7AEA),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              size: 46,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3C4),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              'ACHIEVEMENT UNLOCKED',
              style: AppTypography.navLabel.copyWith(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: const Color(0xFFB7791F),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'BADGE EARNED',
            style: AppTypography.labelLarge.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            badgeLabel,
            textAlign: TextAlign.center,
            style: AppTypography.displayMedium.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Great work — keep going on your craft journey!',
            textAlign: TextAlign.center,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              height: 1.35,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _Particle {
  const _Particle({
    required this.x,
    required this.delay,
    required this.speed,
    required this.size,
    required this.spin,
    required this.color,
    required this.shape,
  });

  final double x;
  final double delay;
  final double speed;
  final double size;
  final double spin;
  final Color color;
  final int shape;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({
    required this.progress,
    required this.particles,
  });

  final double progress;
  final List<_Particle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final local = ((progress - p.delay) / (1 - p.delay)).clamp(0.0, 1.0);
      if (local <= 0) continue;

      final y = -40 + (size.height + 80) * local * p.speed.clamp(0.5, 1.2);
      final wobble = math.sin(local * math.pi * 4 + p.x * 10) * 28;
      final x = p.x * size.width + wobble;
      final opacity = (1 - (local - 0.75).clamp(0.0, 1.0) / 0.25);
      final paint = Paint()..color = p.color.withValues(alpha: opacity);
      final angle = local * p.spin;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle);

      switch (p.shape) {
        case 0:
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset.zero,
              width: p.size,
              height: p.size * 0.55,
            ),
            paint,
          );
          break;
        case 1:
          canvas.drawCircle(Offset.zero, p.size * 0.45, paint);
          break;
        default:
          final path = Path()
            ..moveTo(0, -p.size * 0.55)
            ..lineTo(p.size * 0.45, p.size * 0.4)
            ..lineTo(-p.size * 0.45, p.size * 0.4)
            ..close();
          canvas.drawPath(path, paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
