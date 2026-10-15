import 'dart:typed_data';

/// Converts a canvas RGBA buffer into the 8-bit luma plane
/// [FrameAnalyzer] reads.
///
/// Kept out of the browser-only grabber so the one piece of arithmetic that
/// decides how bright a browser thinks the room is can be tested directly. A
/// wrong coefficient here would not crash anything — it would just quietly
/// misreport the light, which is the whole point of the check.
///
/// [rgba] is four bytes per pixel in R, G, B, A order, as `getImageData`
/// returns it. [into] is reused across frames when it is already the right
/// length; allocating a new plane every frame is what makes live sampling
/// stutter.
Uint8List rgbaToLuma(List<int> rgba, int pixels, [Uint8List? into]) {
  final luma = (into != null && into.length == pixels)
      ? into
      : Uint8List(pixels);

  for (var i = 0, j = 0; i < pixels; i++, j += 4) {
    // BT.601, the same luma a YUV420 plane carries on Android, so a reading
    // taken in a browser sits on the same scale as one taken on a phone.
    // The weights are the 0.299 / 0.587 / 0.114 set scaled by 256, so the
    // shift replaces a float multiply on every pixel of every frame.
    luma[i] = (rgba[j] * 77 + rgba[j + 1] * 150 + rgba[j + 2] * 29) >> 8;
  }

  return luma;
}
