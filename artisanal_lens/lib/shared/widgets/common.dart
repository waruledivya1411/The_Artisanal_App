import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_typography.dart';
import '../motion/motion.dart';

/// Uppercase section header, e.g. "CONTINUE PHOTOGRAPHY".
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {this.trailing, super.key});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title.toUpperCase(), style: AppTypography.sectionHeader),
        ?trailing,
      ],
    );
  }
}

/// The thin rounded progress bar used on the home and setup screens.
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({required this.value, this.height = 6, super.key});

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      // Travels to the new value rather than jumping, so finishing a photo
      // reads as progress being made.
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value.clamp(0.0, 1.0)),
        duration: AppMotion.progress,
        curve: AppMotion.curveInOut,
        builder: (context, animated, _) => LinearProgressIndicator(
          value: animated,
          minHeight: height,
          backgroundColor: AppColors.surfaceMuted,
          valueColor: const AlwaysStoppedAnimation(AppColors.primary),
        ),
      ),
    );
  }
}

/// A rounded pill, used for step chips, counters and status badges.
class AppPill extends StatelessWidget {
  const AppPill({
    required this.label,
    this.icon,
    this.background = AppColors.surface,
    this.foreground = AppColors.textSecondary,
    this.borderColor,
    super.key,
  });

  final String label;
  final IconData? icon;
  final Color background;
  final Color foreground;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space4 + 2,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        border: borderColor == null ? null : Border.all(color: borderColor!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: foreground),
            const SizedBox(width: AppDimens.space4 + 2),
          ],
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(color: foreground),
          ),
        ],
      ),
    );
  }
}

/// Caps how wide a primary action may grow and centres it in its column.
///
/// The actions here are laid out as `width: double.infinity` so they fill the
/// content column on a phone. Left alone that also stretches them across a
/// large handset or a browser window, where a button reads as a banner.
/// Wrapping restores the intent of the design — `width: 100%; max-width:
/// 360px; margin: 0 auto`.
///
/// The child keeps its own height, colour and label; this only bounds width.
class ActionWidth extends StatelessWidget {
  const ActionWidth({
    required this.child,
    this.maxWidth = AppDimens.maxActionWidth,
    this.pressShape = BorderRadius.zero,
    this.pressable = true,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  /// Shape of the press shadow, which has to match the shape the button
  /// paints. Most actions here are square; the pill-shaped ones in
  /// [BottomAction] pass a rounded value.
  final BorderRadius pressShape;

  /// Set false for something that is not tappable.
  final bool pressable;

  @override
  Widget build(BuildContext context) {
    // Every primary action goes through here, so this is also where the press
    // feel is attached — one place, rather than repeated at each call site.
    final action = pressable
        ? Pressable(borderRadius: pressShape, child: child)
        : child;

    // heightFactor: 1 keeps the wrapper exactly as tall as the button, so
    // dropping it around an existing action cannot shift anything vertically.
    return Align(
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        // Fills the capped width — without this the button would shrink to
        // its label once the tight width constraint is relaxed.
        child: SizedBox(width: double.infinity, child: action),
      ),
    );
  }
}

/// Holds a secondary action at its natural width inside a stretched column.
///
/// `CrossAxisAlignment.stretch` is right for cards and text fields but drags
/// small actions — CHANGE, EDIT, CANCEL — out to the full column width, where
/// a bordered control reads as a primary button it is not.
class CompactAction extends StatelessWidget {
  const CompactAction({
    required this.child,
    this.alignment = Alignment.center,
    super.key,
  });

  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      heightFactor: 1,
      child: Pressable(elevate: false, child: child),
    );
  }
}

/// Full-width primary action anchored to the bottom of a screen.
class BottomAction extends StatelessWidget {
  const BottomAction({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.pagePadding,
        AppDimens.space12,
        AppDimens.pagePadding,
        AppDimens.space12,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: ActionWidth(
          pressShape: BorderRadius.circular(AppDimens.radiusPill),
          child: child,
        ),
      ),
    );
  }
}

/// Displays a captured photograph, or a neutral placeholder when it can no
/// longer be read.
///
/// The photograph is resolved through [PhotoStorage] rather than opened
/// directly, because a handle is a file path on a phone and a key into memory
/// in a browser.
class PhotoThumb extends ConsumerWidget {
  const PhotoThumb({
    required this.path,
    this.fit = BoxFit.cover,
    this.borderRadius,
    super.key,
  });

  final String path;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = borderRadius ?? BorderRadius.circular(AppDimens.radiusMd);
    final provider = ref.watch(photoStorageProvider).imageProvider(path);

    final image = provider == null
        ? _fallback(context, 'missing', null)
        : Image(image: provider, fit: fit, errorBuilder: _fallback);

    return ClipRRect(borderRadius: radius, child: image);
  }

  static Widget _fallback(BuildContext context, Object error, StackTrace? _) {
    return Container(
      color: AppColors.surfaceMuted,
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_outlined,
        color: AppColors.textMuted,
        size: 28,
      ),
    );
  }
}

/// A bundled reference photograph, with a neutral tile when it is missing.
///
/// Lesson content ships dozens of these; a typo in one path should leave a
/// placeholder rather than a red error box in the middle of a guide.
class GuideImage extends StatelessWidget {
  const GuideImage({
    required this.asset,
    this.fit = BoxFit.contain,
    this.borderRadius,
    super.key,
  });

  final String asset;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      asset,
      fit: fit,
      errorBuilder: (_, _, _) => Container(
        color: AppColors.surfaceMuted,
        alignment: Alignment.center,
        child: const Icon(
          Icons.image_outlined,
          color: AppColors.textMuted,
          size: 28,
        ),
      ),
    );
    if (borderRadius == null) return image;
    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}
