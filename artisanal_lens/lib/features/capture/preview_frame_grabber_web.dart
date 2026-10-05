import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

import 'preview_frame_grabber.dart';
import 'preview_luma.dart';

const bool kSupportsPreviewFrameGrabbing = true;

/// Reads the live preview straight off the `<video>` element `camera_web`
/// renders into.
///
/// `camera_web` implements no image stream, so in a browser the light check
/// had nothing to measure and every live prompt was hidden. Copying the video
/// into an offscreen canvas produces the same 8-bit luma plane an Android
/// frame arrives as, so the browser runs the one analyser the phone runs
/// rather than a second, looser brightness test that could disagree with it.
class PlatformPreviewFrameGrabber implements PreviewFrameGrabber {
  web.HTMLVideoElement? _video;
  web.HTMLCanvasElement? _canvas;
  web.CanvasRenderingContext2D? _context;
  Uint8List? _luma;

  /// Longest edge the frame is sampled at.
  ///
  /// `ResolutionPreset.high` already asks the browser for about 720p, so this
  /// mostly halves a 1280-wide webcam frame. Reading a quarter of the pixels
  /// keeps the per-frame copy cheap, and the analyser samples every eighth
  /// pixel anyway.
  static const int _maxEdge = 640;

  @override
  bool get isSupported => true;

  @override
  PreviewLumaFrame? grab() {
    final video = _liveVideo();
    if (video == null) return null;

    final sourceWidth = video.videoWidth;
    final sourceHeight = video.videoHeight;
    // readyState below HAVE_CURRENT_DATA means there is no frame to draw yet.
    if (sourceWidth <= 0 || sourceHeight <= 0 || video.readyState < 2) {
      return null;
    }

    final longest = sourceWidth > sourceHeight ? sourceWidth : sourceHeight;
    final scale = longest > _maxEdge ? _maxEdge / longest : 1.0;
    final width = (sourceWidth * scale).round();
    final height = (sourceHeight * scale).round();
    if (width <= 0 || height <= 0) return null;

    final context = _contextFor(width, height);
    if (context == null) return null;

    context.drawImage(video, 0, 0, width.toDouble(), height.toDouble());

    final rgba = context.getImageData(0, 0, width, height).data.toDart;
    final pixels = width * height;
    if (rgba.length < pixels * 4) return null;

    final luma = rgbaToLuma(rgba, pixels, _luma);
    _luma = luma;

    return PreviewLumaFrame(luma: luma, width: width, height: height);
  }

  /// The canvas is kept between frames — allocating one per frame is what
  /// makes this kind of sampling stutter.
  web.CanvasRenderingContext2D? _contextFor(int width, int height) {
    var canvas = _canvas;
    if (canvas == null) {
      canvas = web.document.createElement('canvas') as web.HTMLCanvasElement;
      _canvas = canvas;
      _context = null;
    }
    if (canvas.width != width || canvas.height != height) {
      canvas.width = width;
      canvas.height = height;
      // Resizing resets the context state, so the smoothing flag below is
      // reapplied rather than set once at creation.
      _context = null;
    }

    var context = _context;
    if (context == null) {
      // willReadFrequently keeps the canvas on the CPU; without it every
      // getImageData stalls on a readback from the GPU.
      context = canvas.getContext(
        '2d',
        {'willReadFrequently': true}.jsify(),
      ) as web.CanvasRenderingContext2D?;
      if (context == null) return null;
      // Smoothing the frame down would blur out the fine texture the focus
      // measure reads, and a sharp frame would start reporting itself blurred.
      context.imageSmoothingEnabled = false;
      _context = context;
    }
    return context;
  }

  /// Finds the preview element, remembering it between frames.
  ///
  /// Flutter mounts a platform view's element in the light DOM, so a plain
  /// document query reaches it. The cached element is revalidated each time
  /// because switching lens can replace it.
  web.HTMLVideoElement? _liveVideo() {
    final cached = _video;
    if (cached != null && cached.isConnected && cached.videoWidth > 0) {
      return cached;
    }

    final videos = web.document.querySelectorAll('video');
    for (var i = 0; i < videos.length; i++) {
      final node = videos.item(i);
      if (node == null || !node.isA<web.HTMLVideoElement>()) continue;
      final video = node as web.HTMLVideoElement;
      if (video.videoWidth > 0) {
        _video = video;
        return video;
      }
    }

    _video = null;
    return null;
  }

  @override
  void dispose() {
    _video = null;
    _context = null;
    _canvas = null;
    _luma = null;
  }
}
