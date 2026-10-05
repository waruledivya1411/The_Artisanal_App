import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../app/providers.dart';
import '../../domain/entities/capture_feedback.dart';
import '../../domain/entities/placement_kind.dart';
import '../../domain/entities/preset_capture_guidance.dart';
import '../../domain/services/capture_guidance_service.dart';
import '../../domain/services/frame_analyzer.dart';
import '../../domain/services/frame_metrics_smoother.dart';
import '../../domain/services/live_guidance_stabiliser.dart';
import 'preview_frame_grabber.dart';

/// Lifecycle state of the guided camera.
enum CameraStatus { idle, initialising, ready, permissionDenied, unavailable }

class GuidedCameraState {
  const GuidedCameraState({
    this.status = CameraStatus.idle,
    this.controller,
    this.feedback = const CaptureFeedback.initial(),
    this.isFlashOn = false,
    this.canUseFlash = true,
    this.isCapturing = false,
    this.lensDirection = CameraLensDirection.back,
    this.canSwitchCamera = false,
    this.isSwitchingCamera = false,
    this.errorMessage,
  });

  final CameraStatus status;
  final CameraController? controller;
  final CaptureFeedback feedback;
  final bool isFlashOn;

  /// False when the lens has no torch — a laptop webcam, most front cameras.
  /// The flash button is hidden rather than left to throw.
  final bool canUseFlash;
  final bool isCapturing;

  /// Which lens is live. The front camera is offered for worn presets, where
  /// the artisan is both the model and the photographer.
  final CameraLensDirection lensDirection;

  /// False on a handset with only one usable lens, so the button can be hidden
  /// rather than shown doing nothing.
  final bool canSwitchCamera;
  final bool isSwitchingCamera;
  final String? errorMessage;

  bool get isReady =>
      status == CameraStatus.ready &&
      controller != null &&
      controller!.value.isInitialized;

  GuidedCameraState copyWith({
    CameraStatus? status,
    CameraController? controller,
    CaptureFeedback? feedback,
    bool? isFlashOn,
    bool? canUseFlash,
    bool? isCapturing,
    CameraLensDirection? lensDirection,
    bool? canSwitchCamera,
    bool? isSwitchingCamera,
    String? errorMessage,
  }) {
    return GuidedCameraState(
      status: status ?? this.status,
      controller: controller ?? this.controller,
      feedback: feedback ?? this.feedback,
      isFlashOn: isFlashOn ?? this.isFlashOn,
      canUseFlash: canUseFlash ?? this.canUseFlash,
      isCapturing: isCapturing ?? this.isCapturing,
      lensDirection: lensDirection ?? this.lensDirection,
      canSwitchCamera: canSwitchCamera ?? this.canSwitchCamera,
      isSwitchingCamera: isSwitchingCamera ?? this.isSwitchingCamera,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Owns the camera, the preview frame analysis and the tilt sensor, and
/// publishes a single [CaptureFeedback] for the capture screen to render.
class GuidedCameraController extends AutoDisposeNotifier<GuidedCameraState> {
  StreamSubscription<AccelerometerEvent>? _accelerometerSub;
  List<CameraDescription> _cameras = const [];
  double _pitchDegrees = 0;

  /// Set by the first accelerometer reading that actually arrives. A laptop
  /// browser never delivers one, and the angle check is skipped there.
  bool _hasTilt = false;
  FrameMetrics _metrics = const FrameMetrics.empty();
  PresetCaptureGuidance? _guidance;
  final LiveGuidanceStabiliser _stabiliser = LiveGuidanceStabiliser();
  final FrameMetricsSmoother _metricsSmoother = FrameMetricsSmoother();
  final PreviewFrameGrabber _frameGrabber = PreviewFrameGrabber();
  Timer? _previewSampler;
  bool _isAnalysing = false;
  DateTime _lastAnalysis = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime? _openedAt;
  int _unexposedSkips = 0;

  /// Frames are analysed at most this often — enough to feel live without
  /// pinning the CPU on the low-end handsets this app targets.
  static const Duration _analysisInterval = Duration(milliseconds: 200);

  /// The browser sampler ticks faster than that and lets the throttle in
  /// [_claimAnalysisSlot] set the real rate; on a tick exactly one interval
  /// long, timer jitter would drop every other frame and halve it.
  static const Duration _samplerInterval = Duration(milliseconds: 100);

  /// Auto-exposure is still hunting. Showing those black frames as "too dark"
  /// or "move in" is what made opening the camera look broken.
  static const Duration _warmup = Duration(milliseconds: 700);

  /// Extra black frames to ignore after warmup, while the sensor catches up.
  static const int _maxUnexposedSkips = 6;

  @override
  GuidedCameraState build() {
    ref.onDispose(_disposeResources);
    return const GuidedCameraState();
  }

  /// Starts the camera for the photograph the session is set up to take.
  ///
  /// The guidance object carries both the technique (grid, angle, lighting)
  /// and the profile of checks the analyser is allowed to run for this preset.
  Future<void> start(PresetCaptureGuidance guidance) async {
    _guidance = guidance;
    if (state.status == CameraStatus.initialising || state.isReady) return;

    state = state.copyWith(status: CameraStatus.initialising);

    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        state = state.copyWith(
          status: CameraStatus.unavailable,
          errorMessage: 'no_camera',
        );
        return;
      }

      final back = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras.first,
      );

      await _openLens(back);
      _listenToTilt();
    } on CameraException catch (error) {
      _reportCameraError(error);
    } catch (error) {
      state = state.copyWith(
        status: CameraStatus.unavailable,
        errorMessage: '$error',
      );
    }
  }

  /// Opens [description], replacing whatever lens was live before.
  Future<void> _openLens(CameraDescription description) async {
    final controller = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    await controller.initialize();

    // Flash is optional hardware. A laptop webcam has no torch and throws
    // here, which must not take the whole camera down — the artisan still
    // needs the preview, the guide and the shutter.
    var canUseFlash = true;
    try {
      await controller.setFlashMode(FlashMode.off);
    } on CameraException catch (error) {
      canUseFlash = false;
      debugPrint('Flash unavailable on this camera: ${error.code}');
    }

    state = state.copyWith(
      status: CameraStatus.ready,
      controller: controller,
      lensDirection: description.lensDirection,
      // Flash belongs to the lens, so a switch always lands with it off.
      isFlashOn: false,
      canUseFlash: canUseFlash,
      canSwitchCamera: _lensDirections.length > 1,
    );

    // camera_web has no image stream. Rather than drop the live guidance in a
    // browser, frames are read off the preview element and fed to the same
    // analyser the streamed ones go through.
    if (_streamsFrames) {
      await controller.startImageStream(_onFrame);
    } else if (_frameGrabber.isSupported) {
      _startPreviewSampling();
    }
    _markOpened();
  }

  /// Whether the camera plugin hands frames over by itself.
  static bool get _streamsFrames => !kIsWeb;

  void _startPreviewSampling() {
    _previewSampler ??= Timer.periodic(
      _samplerInterval,
      (_) => _samplePreview(),
    );
  }

  void _stopPreviewSampling() {
    _previewSampler?.cancel();
    _previewSampler = null;
  }

  /// Reads one frame off the preview element, where the plugin streams none.
  void _samplePreview() {
    if (!_claimAnalysisSlot()) return;
    try {
      final frame = _frameGrabber.grab();
      // Null simply means the preview has not painted yet; the next tick
      // tries again.
      if (frame == null) return;
      _analyseLuma(
        luma: frame.luma,
        width: frame.width,
        height: frame.height,
        bytesPerRow: frame.bytesPerRow,
      );
    } catch (error) {
      debugPrint('Preview sampling skipped: $error');
    } finally {
      _isAnalysing = false;
    }
  }

  /// Fresh lens: wait for auto-exposure before trusting a verdict.
  void _markOpened() {
    _openedAt = DateTime.now();
    _unexposedSkips = 0;
    _lastAnalysis = DateTime.fromMillisecondsSinceEpoch(0);
    _stabiliser.reset();
    _metricsSmoother.reset();
    state = state.copyWith(feedback: _stabiliser.current);
  }

  /// Whether this platform can deliver preview frames for analysis.
  ///
  /// Android and iOS stream them from the plugin; a browser has them read off
  /// the preview element instead.
  static bool get isGuidanceSupported =>
      _streamsFrames || supportsPreviewFrameGrabbing;

  Set<CameraLensDirection> get _lensDirections =>
      _cameras.map((camera) => camera.lensDirection).toSet();

  /// Swaps between the front and back lens.
  ///
  /// Worn presets — a draped saree, a neck-wrapped stole — are often shot by
  /// the artisan wearing the piece, who needs the front lens to see the guide.
  Future<void> switchCamera() async {
    if (!state.isReady || state.isSwitchingCamera || state.isCapturing) return;
    if (_cameras.length < 2) return;

    final target = state.lensDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;
    CameraDescription? next;
    for (final camera in _cameras) {
      if (camera.lensDirection == target) {
        next = camera;
        break;
      }
    }
    if (next == null) return;

    state = state.copyWith(isSwitchingCamera: true);
    final previous = state.controller;
    try {
      // Tear the old lens down first — two open capture sessions will fail to
      // initialise on most Android devices.
      if (previous != null) {
        if (previous.value.isStreamingImages) {
          await previous.stopImageStream();
        }
        await previous.dispose();
      }
      _metrics = const FrameMetrics.empty();
      // The new lens sees a different frame; carrying the old verdict over
      // would show a reading of a picture that is no longer on screen.
      _stabiliser.reset();
      state = state.copyWith(feedback: _stabiliser.current);
      await _openLens(next);
    } on CameraException catch (error) {
      _reportCameraError(error);
    } finally {
      state = state.copyWith(isSwitchingCamera: false);
    }
  }

  void _reportCameraError(CameraException error) {
    final denied = error.code == 'CameraAccessDenied' ||
        error.code == 'CameraAccessDeniedWithoutPrompt';
    state = state.copyWith(
      status: denied ? CameraStatus.permissionDenied : CameraStatus.unavailable,
      errorMessage: error.description ?? error.code,
    );
  }

  void _listenToTilt() {
    if (_accelerometerSub != null) return;
    // A laptop browser has no accelerometer and reports it by throwing or by
    // erroring the stream. Neither may take the camera down: the preview, the
    // light reading and the shutter all still work without tilt.
    try {
      _accelerometerSub = accelerometerEventStream().listen(
        (event) {
          _hasTilt = true;
          _pitchDegrees = CaptureGuidanceService.pitchFromAccelerometer(
            x: event.x,
            y: event.y,
            z: event.z,
          );
        },
        onError: (Object error) {
          _hasTilt = false;
          debugPrint('Tilt sensor unavailable: $error');
        },
        cancelOnError: true,
      );
    } catch (error) {
      _hasTilt = false;
      debugPrint('Tilt sensor unavailable: $error');
    }
  }

  /// Throttles analysis, claiming the slot when one may start now.
  ///
  /// Keeps a second analysis from queueing behind the first, and holds every
  /// verdict back until auto-exposure has had [_warmup] to settle.
  bool _claimAnalysisSlot() {
    final now = DateTime.now();
    if (_openedAt != null && now.difference(_openedAt!) < _warmup) {
      return false;
    }
    if (_isAnalysing || now.difference(_lastAnalysis) < _analysisInterval) {
      return false;
    }
    _isAnalysing = true;
    _lastAnalysis = now;
    return true;
  }

  void _onFrame(CameraImage image) {
    if (!_claimAnalysisSlot()) return;

    try {
      if (image.planes.isEmpty) return;

      // plane.bytes is already a Uint8List and the analyser only reads it, so
      // it is passed straight through — copying it every frame would allocate
      // megabytes per second on the low-end handsets this app targets.
      final plane = image.planes.first;
      _analyseLuma(
        luma: plane.bytes,
        width: image.width,
        height: image.height,
        bytesPerRow: plane.bytesPerRow,
      );
    } catch (error) {
      // A malformed frame must never take the camera down; the next frame is
      // analysed as normal.
      debugPrint('Frame analysis skipped: $error');
    } finally {
      _isAnalysing = false;
    }
  }

  /// Measures one luma plane and publishes the verdict.
  ///
  /// Both sources land here — the streamed frames on a phone and the ones
  /// sampled off the preview in a browser — so the two platforms cannot drift
  /// apart on what counts as too dark.
  void _analyseLuma({
    required Uint8List luma,
    required int width,
    required int height,
    required int bytesPerRow,
  }) {
    final guidance = _guidance;
    if (guidance == null) return;

    final placement = PlacementKind.resolve(
      guidance.templateId,
      guidance.technique.grid,
    );
    final raw = ref.read(frameAnalyzerProvider).analyseLumaPlane(
          luma: luma,
          width: width,
          height: height,
          bytesPerRow: bytesPerRow,
          // Same rectangle the artisan sees as the placement marking.
          insetX: placement.ghostInsetX,
          insetY: placement.ghostInsetY,
        );

    // The first frames after the shutter opens are often black. Feeding
    // them to the evaluator locked the chips on Too dark / Move in.
    if (_unexposedSkips < _maxUnexposedSkips && raw.isUnexposedPreview) {
      _unexposedSkips++;
      return;
    }

    _metrics = _metricsSmoother.accept(raw);

    final measured = ref.read(captureGuidanceServiceProvider).evaluate(
          metrics: _metrics,
          technique: guidance.technique,
          pitchDegrees: _pitchDegrees,
          profile: _measurableProfile(guidance.cameraGuidance),
          previousDistance: state.feedback.distanceQuality,
          previousCentre: state.feedback.centreQuality,
        );

    final feedback = _stabiliser.accept(measured);
    if (feedback != state.feedback) {
      state = state.copyWith(feedback: feedback);
    }
  }

  /// Drops the checks this device cannot actually take a reading for.
  ///
  /// Everything else in the profile is measured from the frame itself and
  /// works wherever a frame does. The angle is the exception: it needs the
  /// accelerometer, which a laptop browser does not have.
  CameraGuidanceProfile _measurableProfile(CameraGuidanceProfile profile) {
    if (_hasTilt) return profile;
    return profile.withoutAngleCheck();
  }

  Future<void> toggleFlash() async {
    final controller = state.controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (!state.canUseFlash) return;

    final next = !state.isFlashOn;
    try {
      await controller.setFlashMode(next ? FlashMode.torch : FlashMode.off);
      state = state.copyWith(isFlashOn: next);
    } on CameraException catch (error) {
      // Some lenses report a torch and then refuse it; stop offering the
      // button rather than failing the same way again.
      debugPrint('Flash toggle refused: ${error.code}');
      state = state.copyWith(canUseFlash: false, isFlashOn: false);
    }
  }

  /// Takes a photograph and returns its file path, or null if it failed.
  Future<String?> capture() async {
    final controller = state.controller;
    if (controller == null || !controller.value.isInitialized) return null;
    if (state.isCapturing) return null;

    state = state.copyWith(isCapturing: true);
    try {
      // The image stream must stop before takePicture on Android, otherwise
      // the capture can dead-lock against the streaming session.
      if (controller.value.isStreamingImages) {
        await controller.stopImageStream();
      }
      _stopPreviewSampling();
      final file = await controller.takePicture();
      return file.path;
    } on CameraException catch (error) {
      state = state.copyWith(errorMessage: error.description ?? error.code);
      return null;
    } finally {
      state = state.copyWith(isCapturing: false);
    }
  }

  /// Resumes live analysis after a capture the artisan chose to retake.
  Future<void> resumePreview() async {
    final controller = state.controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (_streamsFrames) {
      if (!controller.value.isStreamingImages) {
        await controller.startImageStream(_onFrame);
      }
    } else if (_frameGrabber.isSupported) {
      _startPreviewSampling();
    }
  }

  void _disposeResources() {
    _accelerometerSub?.cancel();
    _accelerometerSub = null;
    _stopPreviewSampling();
    _frameGrabber.dispose();

    final controller = state.controller;
    if (controller != null) {
      if (controller.value.isStreamingImages) {
        controller.stopImageStream().catchError((_) {});
      }
      controller.dispose();
    }
  }
}

final guidedCameraProvider =
    AutoDisposeNotifierProvider<GuidedCameraController, GuidedCameraState>(
  GuidedCameraController.new,
);
