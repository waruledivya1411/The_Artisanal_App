import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../app/theme/app_colors.dart';

/// Plays a locally persisted video path from [PhotoStorage] (mobile/desktop).
class LocalVideoPreview extends StatefulWidget {
  const LocalVideoPreview({
    required this.path,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String path;
  final BoxFit fit;

  @override
  State<LocalVideoPreview> createState() => _LocalVideoPreviewState();
}

class _LocalVideoPreviewState extends State<LocalVideoPreview> {
  VideoPlayerController? _controller;
  bool _ready = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _open();
  }

  @override
  void didUpdateWidget(LocalVideoPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _controller?.dispose();
      _controller = null;
      _ready = false;
      _error = null;
      _open();
    }
  }

  Future<void> _open() async {
    if (kIsWeb) {
      if (!mounted) return;
      setState(() {
        _error = StateError('unavailable');
        _ready = false;
      });
      return;
    }

    final controller = VideoPlayerController.file(File(widget.path));
    try {
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.play();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _ready = true;
      });
    } catch (error) {
      await controller.dispose();
      if (!mounted) return;
      setState(() {
        _error = error;
        _ready = false;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return const ColoredBox(
        color: AppColors.surfaceMuted,
        child: Center(
          child: Icon(Icons.videocam_outlined, color: AppColors.textMuted),
        ),
      );
    }

    final controller = _controller;
    if (!_ready || controller == null || !controller.value.isInitialized) {
      return const ColoredBox(
        color: AppColors.surfaceMuted,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return FittedBox(
      fit: widget.fit,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: controller.value.size.width,
        height: controller.value.size.height,
        child: VideoPlayer(controller),
      ),
    );
  }
}
