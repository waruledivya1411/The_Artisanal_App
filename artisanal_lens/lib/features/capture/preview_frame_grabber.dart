import 'dart:typed_data';

import 'preview_frame_grabber_stub.dart'
    if (dart.library.js_interop) 'preview_frame_grabber_web.dart' as impl;

/// Whether the running platform can read frames off the live preview widget.
///
/// False where the camera plugin streams frames itself — nothing needs to
/// read the preview in that case.
bool get supportsPreviewFrameGrabbing => impl.kSupportsPreviewFrameGrabbing;

/// One greyscale preview frame, in the shape [FrameAnalyzer] already reads
/// from an Android `CameraImage`: an 8-bit luma plane plus its row stride.
class PreviewLumaFrame {
  const PreviewLumaFrame({
    required this.luma,
    required this.width,
    required this.height,
  });

  final Uint8List luma;
  final int width;
  final int height;

  /// Rows come back tightly packed, so the stride is simply the width. A
  /// camera plane often pads its rows; this one never does.
  int get bytesPerRow => width;
}

/// Pulls luma frames from the live preview on platforms where the camera
/// plugin offers no image stream.
abstract class PreviewFrameGrabber {
  factory PreviewFrameGrabber() = impl.PlatformPreviewFrameGrabber;

  /// Whether frames can be read at all here.
  bool get isSupported;

  /// The frame on screen right now, or null while the preview has not
  /// produced one yet.
  PreviewLumaFrame? grab();

  void dispose();
}
