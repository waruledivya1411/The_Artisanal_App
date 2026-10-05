import 'dart:typed_data';

import 'package:artisanal_lens/domain/entities/capture_feedback.dart';
import 'package:artisanal_lens/data/datasources/preset_catalog.dart';
import 'package:artisanal_lens/domain/entities/preset_capture_guidance.dart';
import 'package:artisanal_lens/domain/services/capture_guidance_service.dart';
import 'package:artisanal_lens/domain/services/frame_analyzer.dart';
import 'package:artisanal_lens/features/capture/preview_luma.dart';
import 'package:flutter_test/flutter_test.dart';

/// Builds a canvas-shaped RGBA buffer of one flat grey, the way
/// `getImageData` hands a frame over in a browser.
List<int> _flatRgba(int level, {required int pixels}) {
  final rgba = Uint8List(pixels * 4);
  for (var i = 0; i < pixels; i++) {
    final j = i * 4;
    rgba[j] = level;
    rgba[j + 1] = level;
    rgba[j + 2] = level;
    rgba[j + 3] = 255;
  }
  return rgba;
}

void main() {
  group('rgbaToLuma', () {
    test('maps black and white to the ends of the range', () {
      expect(rgbaToLuma(_flatRgba(0, pixels: 4), 4), everyElement(0));
      // 255 * 256 >> 8 is 255, so white survives the integer shift intact.
      expect(rgbaToLuma(_flatRgba(255, pixels: 4), 4), everyElement(255));
    });

    test('keeps mid grey in the middle', () {
      final luma = rgbaToLuma(_flatRgba(128, pixels: 4), 4);
      expect(luma.first, closeTo(128, 1));
    });

    test('weights the channels the way BT.601 does', () {
      final red = rgbaToLuma(Uint8List.fromList([255, 0, 0, 255]), 1).first;
      final green = rgbaToLuma(Uint8List.fromList([0, 255, 0, 255]), 1).first;
      final blue = rgbaToLuma(Uint8List.fromList([0, 0, 255, 255]), 1).first;

      // Green carries most of the brightness, blue the least. Getting this
      // backwards would read a blue saree as far brighter than it is.
      expect(green, greaterThan(red));
      expect(red, greaterThan(blue));
      expect(green, closeTo(149, 2));
      expect(red, closeTo(76, 2));
      expect(blue, closeTo(28, 2));
    });

    test('reuses the buffer it is handed, and replaces a mismatched one', () {
      final reusable = Uint8List(4);
      expect(
        identical(rgbaToLuma(_flatRgba(10, pixels: 4), 4, reusable), reusable),
        isTrue,
      );
      expect(
        identical(rgbaToLuma(_flatRgba(10, pixels: 9), 9, reusable), reusable),
        isFalse,
      );
    });
  });

  group('a browser frame reaches the same verdict a phone frame would', () {
    // The guidance a Pallu drape runs with, minus the angle check a laptop
    // has no accelerometer for — exactly what the camera controller passes
    // in a browser.
    const catalog = BundledCatalogDataSource();
    final preset = catalog.presetById('saree_pallu_drape')!;
    final guidance = PresetCaptureGuidance.fromPreset(
      preset,
      productNoun: 'saree',
    ).cameraGuidance.withoutAngleCheck();

    const width = 160;
    const height = 120;
    const analyzer = FrameAnalyzer();
    const service = CaptureGuidanceService();

    CaptureFeedback feedbackFor(int level) {
      final luma = rgbaToLuma(
        _flatRgba(level, pixels: width * height),
        width * height,
      );
      return service.evaluate(
        metrics: analyzer.analyseLumaPlane(
          luma: luma,
          width: width,
          height: height,
          bytesPerRow: width,
        ),
        technique: preset.technique,
        pitchDegrees: 0,
        profile: guidance,
      );
    }

    test('a dark room is reported as too dark', () {
      final feedback = feedbackFor(20);
      expect(feedback.lightQuality, LightQuality.tooDark);
      expect(feedback.prompt, CapturePrompt.tooDark);
      expect(feedback.prompt.message, contains('Too dark'));
    });

    test('a blown-out frame is reported as too bright', () {
      expect(feedbackFor(250).lightQuality, LightQuality.tooBright);
    });

    test('a well-lit frame is not called dark', () {
      final feedback = feedbackFor(140);
      expect(feedback.lightQuality, LightQuality.good);
      expect(feedback.prompt, isNot(CapturePrompt.tooDark));
    });

    test('the angle check stays silent without a tilt sensor', () {
      // Pitch is zero because no accelerometer reported, which would read as
      // "off" against the preset's target angle if the check were left on.
      expect(feedbackFor(140).prompt, isNot(CapturePrompt.tiltPhone));
    });
  });
}
