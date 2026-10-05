import 'package:flutter/material.dart';

import 'click_social_frames.dart';

export 'click_social_frames.dart' show FrameArch, frameByIndex;

/// One quiz answer — where the product sits in the camera viewfinder.
///
/// Same product photo in every option; only [alignment] + [sizeFactor] change
/// so the learner can see wrong vs right framing at a glance.
class FramingOption {
  const FramingOption({
    required this.alignment,
    required this.sizeFactor,
    required this.correct,
  });

  /// Where the product sits inside the frame (−1..1).
  final Alignment alignment;

  /// How much of the viewfinder the product object fills (~0.3–0.5).
  /// Keep it under ~half the frame so grid placement is readable.
  final double sizeFactor;

  final bool correct;
}

class FramingArchDef {
  const FramingArchDef({
    required this.options,
    required this.title,
    required this.sub,
    required this.msg0,
    required this.msg1,
    required this.msg2,
  });

  final List<FramingOption> options;
  final String title;
  final String sub;
  final String msg0;
  final String msg1;
  final String msg2;

  String messageAt(int optionIndex) => switch (optionIndex) {
        0 => msg0,
        1 => msg1,
        _ => msg2,
      };
}

/// One 3×3-grid quiz per Click & Social frame (indexes 0..11).
const framingQuizzesByIndex = <int, FramingArchDef>{
  0: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.62,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment(0.33, 0.33),
        sizeFactor: 0.52,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment(-0.85, -0.82),
        sizeFactor: 0.38,
        correct: false,
      ),
    ],
    title: 'Where should the full piece sit?',
    sub: 'On the 3×3 grid, put the whole product on a crossing — not dead centre.',
    msg0: 'Dead centre feels flat. Sit it on a grid crossing.',
    msg1: 'Yes — the full piece sits where the lines cross.',
    msg2: 'Packed into a corner — the full piece gets cut off.',
  ),
  1: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment(-0.85, -0.82),
        sizeFactor: 0.34,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.70,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment(1.0, 0.2),
        sizeFactor: 0.52,
        correct: false,
      ),
    ],
    title: 'How close should the texture fill sit?',
    sub: 'A close-up fills the middle of the grid so weave and thickness read.',
    msg0: 'Too small, stuck in one cell — step in.',
    msg1: 'Yes — the texture fills the centre of the grid.',
    msg2: 'Half off the grid — keep the close-up inside the lines.',
  ),
  2: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.48,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment(-0.33, 0.33),
        sizeFactor: 0.55,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment(-0.88, 0.85),
        sizeFactor: 0.36,
        correct: false,
      ),
    ],
    title: 'Where does the drape sit on the grid?',
    sub: 'Let the cloth rest on the lower-left crossing so it still has room to fall.',
    msg0: 'Parked in the exact middle — no fall, no story.',
    msg1: 'Yes — the drape sits on the lower-left crossing.',
    msg2: 'Crammed in a corner — the drape cannot read.',
  ),
  3: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment(0, 0.92),
        sizeFactor: 0.36,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment(0.67, -0.67),
        sizeFactor: 0.40,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.42,
        correct: false,
      ),
    ],
    title: 'Which grid cell holds the border?',
    sub: 'Put the embroidery in the top-right cell of the 3×3 grid.',
    msg0: 'Too low — that cell is empty table, not the border.',
    msg1: 'Yes — the motif fills the top-right cell.',
    msg2: 'Centre cell shows cloth, not the border work.',
  ),
  4: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment(-0.85, -0.82),
        sizeFactor: 0.34,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment(0, 0.15),
        sizeFactor: 0.58,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment(0.95, 0.4),
        sizeFactor: 0.48,
        correct: false,
      ),
    ],
    title: 'Where should the folded stack sit?',
    sub: 'Keep the stack in the middle of the grid so thickness and layers show.',
    msg0: 'Too far in a corner — nobody sees the fold.',
    msg1: 'Yes — the stack fills the centre of the grid.',
    msg2: 'Cut off at the edge — keep the whole stack inside.',
  ),
  5: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.72,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment(-0.40, 0.10),
        sizeFactor: 0.50,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment(-0.85, -0.82),
        sizeFactor: 0.36,
        correct: false,
      ),
    ],
    title: 'Where does the scale shot sit?',
    sub: 'Leave the right third free for the familiar object. Product on the left crossing.',
    msg0: 'Filling the whole grid leaves no room for the size object.',
    msg1: 'Yes — product on the left, space on the right for scale.',
    msg2: 'Tiny in a corner — neither the piece nor the object can read.',
  ),
  6: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment(-0.85, -0.82),
        sizeFactor: 0.32,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.68,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment(1.0, 0.25),
        sizeFactor: 0.50,
        correct: false,
      ),
    ],
    title: 'How should a flat lay fill the grid?',
    sub: 'Look straight down. The layout sits in the centre of the 3×3 grid.',
    msg0: 'Too small in one cell — the styling is lost.',
    msg1: 'Yes — the flat lay fills the middle of the grid.',
    msg2: 'Half off the table — keep props inside the lines.',
  ),
  7: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.70,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment(0, 0.40),
        sizeFactor: 0.50,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment(-0.85, -0.82),
        sizeFactor: 0.36,
        correct: false,
      ),
    ],
    title: 'Where does the lifestyle scene sit?',
    sub: 'Give the room air. Sit the scene on the lower third of the grid.',
    msg0: 'Filling the whole frame hides the room around it.',
    msg1: 'Yes — the scene sits on the lower third.',
    msg2: 'Tiny in the top corner — the context is gone.',
  ),
  8: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment(0.90, 0.20),
        sizeFactor: 0.48,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment(0, -0.08),
        sizeFactor: 0.56,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment(0, 0.90),
        sizeFactor: 0.40,
        correct: false,
      ),
    ],
    title: 'Where should a hanging piece sit?',
    sub: 'Hang it on the centre of the grid so both sides and the fringe match.',
    msg0: 'Slid to one side — the hang looks uneven.',
    msg1: 'Yes — centred on the grid, hanging straight.',
    msg2: 'Only the bottom is in frame — include the hang from the top.',
  ),
  9: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment(0, 0.92),
        sizeFactor: 0.36,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment(0.67, -0.50),
        sizeFactor: 0.38,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.55,
        correct: false,
      ),
    ],
    title: 'Which cell holds the fringe close-up?',
    sub: 'Fill a top-right cell so the hand-finishing is large and sharp.',
    msg0: 'Too low — the fringe is a thin strip, not a close-up.',
    msg1: 'Yes — the fringe fills the top-right cell.',
    msg2: 'Centre of the grid is too wide — this is a macro, not a full piece.',
  ),
  10: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment(0, -0.85),
        sizeFactor: 0.40,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment(-0.33, 0.40),
        sizeFactor: 0.50,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment(0.88, -0.80),
        sizeFactor: 0.34,
        correct: false,
      ),
    ],
    title: 'Where do hands and tools sit?',
    sub: 'Put the making on the lower-left crossing so process and tools read.',
    msg0: 'Only the top of the frame — the hands are missing.',
    msg1: 'Yes — the making sits on the lower-left crossing.',
    msg2: 'Tiny in a far corner — nobody sees the work.',
  ),
  11: FramingArchDef(
    options: [
      FramingOption(
        alignment: Alignment(-0.85, -0.82),
        sizeFactor: 0.34,
        correct: false,
      ),
      FramingOption(
        alignment: Alignment.center,
        sizeFactor: 0.66,
        correct: true,
      ),
      FramingOption(
        alignment: Alignment(1.0, 0.15),
        sizeFactor: 0.52,
        correct: false,
      ),
    ],
    title: 'How should a framed panel fill the grid?',
    sub: 'Square-on, centred, filling the middle of the 3×3 grid with even edges.',
    msg0: 'Too small in a corner — the panel looks lost.',
    msg1: 'Yes — the frame fills the centre, edges parallel to the grid.',
    msg2: 'Cut off on one side — keep the whole panel inside.',
  ),
};

FramingArchDef framingQuizForFrame(int frameIndex) =>
    framingQuizzesByIndex[frameIndex] ?? framingQuizzesByIndex[0]!;

/// One quiz step per picked frame (not one per shared grid type).
List<int> framingSequenceForPicks({
  required String categoryId,
  required List<int> pickedIndexes,
}) {
  final indexes = pickedIndexes.isEmpty
      ? clickSocialDefaultFrames
      : pickedIndexes;

  final seen = <int>{};
  final out = <int>[];
  for (final i in indexes) {
    if (frameByIndex(i) == null) continue;
    if (seen.add(i)) out.add(i);
  }
  return out.isEmpty ? const [0] : out;
}
