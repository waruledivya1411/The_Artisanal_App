import 'preview_frame_grabber.dart';

/// Android and iOS get real frames from `startImageStream`, so nothing on
/// those platforms needs to read the preview widget itself.
const bool kSupportsPreviewFrameGrabbing = false;

class PlatformPreviewFrameGrabber implements PreviewFrameGrabber {
  @override
  bool get isSupported => false;

  @override
  PreviewLumaFrame? grab() => null;

  @override
  void dispose() {}
}
