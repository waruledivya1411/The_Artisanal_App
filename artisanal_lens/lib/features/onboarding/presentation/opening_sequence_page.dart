import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';

/// Cold-start splash — Sutra mark on the app photography theme.
///
/// Logo red stays as shipped; black plate is stripped. Layout mirrors the
/// brand splash: compact mark card, title, ecosystem line, path pill.
class OpeningSequencePage extends StatefulWidget {
  const OpeningSequencePage({super.key});

  @override
  State<OpeningSequencePage> createState() => _OpeningSequencePageState();
}

class _OpeningSequencePageState extends State<OpeningSequencePage>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 2800);
  static const String _logoAsset = 'assets/images/sutra_logo.png';

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _duration,
  );

  bool _leaving = false;

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _finish();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _finish() {
    if (_leaving || !mounted) return;
    _leaving = true;
    context.goNamed(AppRoute.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _finish,
        child: DecoratedBox(
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
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final t = _controller.value;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    _AmbientGlow(progress: _seg(t, 0.0, 0.45)),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _LogoCard(
                              asset: _logoAsset,
                              progress: _seg(t, 0.0, 0.42, Curves.easeOutCubic),
                            ),
                            const SizedBox(height: 22),
                            _BrandTitle(
                              progress: _seg(t, 0.26, 0.55, Curves.easeOut),
                            ),
                            const SizedBox(height: 6),
                            _BrandSubtitle(
                              progress: _seg(t, 0.34, 0.62, Curves.easeOut),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 28,
                      child: _SkipHint(
                        progress: _seg(t, 0.55, 0.85, Curves.easeOut),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

double _seg(double t, double start, double end, [Curve curve = Curves.linear]) {
  if (end <= start) return t >= end ? 1 : 0;
  final raw = ((t - start) / (end - start)).clamp(0.0, 1.0);
  return curve.transform(raw);
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.9 * progress,
        child: Center(
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.12),
                  AppColors.surfaceSand.withValues(alpha: 0.35),
                  AppColors.primary.withValues(alpha: 0.0),
                ],
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact white plate — logo only, no black fill.
class _LogoCard extends StatelessWidget {
  const _LogoCard({required this.asset, required this.progress});

  final String asset;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final scale = 0.92 + (0.08 * progress);
    return Opacity(
      opacity: progress,
      child: Transform.scale(
        scale: scale,
        child: Material(
          color: AppColors.white,
          elevation: 5 * progress,
          shadowColor: AppColors.primary.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
            child: Image.asset(
              asset,
              width: 118,
              height: 138,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandTitle extends StatelessWidget {
  const _BrandTitle({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: progress,
      child: Transform.translate(
        offset: Offset(0, 10 * (1 - progress)),
        child: Text(
          'SUTRA',
          textAlign: TextAlign.center,
          style: AppTypography.displayLarge.copyWith(
            fontFamily: 'PlayfairDisplay',
            fontSize: 30,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.5,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _BrandSubtitle extends StatelessWidget {
  const _BrandSubtitle({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: progress,
      child: Transform.translate(
        offset: Offset(0, 8 * (1 - progress)),
        child: Text(
          'SUTRA CRAFT ECOSYSTEM',
          textAlign: TextAlign.center,
          style: AppTypography.navLabel.copyWith(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _SkipHint extends StatelessWidget {
  const _SkipHint({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.75 * progress,
      child: Text(
        'Tap anywhere to start',
        textAlign: TextAlign.center,
        style: AppTypography.labelSmall.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
