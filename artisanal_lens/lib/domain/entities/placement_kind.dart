import 'technique_preset.dart';

/// Where the product should sit in the live camera — one marking per shot.
///
/// The dashed box the artisan sees is the same region [FrameAnalyzer]
/// measures, so "place it here" and "move closer" stay in lockstep.
enum PlacementKind {
  /// Whole piece, eye-level — tall thirds frame.
  fullDisplay,

  /// Texture / weave — small centre box.
  closeUp,

  /// Worn on a person — full-length portrait on thirds.
  drape,

  /// Embroidery and border — offset detail window.
  border,

  /// Folded stack — wide landscape with a mid fold line.
  folded,

  /// Scale reference — thirds plus a spot for the familiar object.
  scale,

  /// Overhead flat lay — table-like rectangle, phone looking down.
  flatLay,

  /// In a room / on a chair — thirds with a subject box.
  lifestyle,

  /// Hung on a rod — tall centre with a rod at the top.
  hanging,

  /// Macro fringe — diagonal strip.
  fringe,

  /// Hands at work — open thirds.
  making,

  /// Wall panel — nested square frames.
  framed;

  static PlacementKind fromTemplateId(String? templateId) {
    final id = templateId ?? '';
    const prefix = 'cs_frame_';
    if (id.startsWith(prefix)) {
      final index = int.tryParse(id.substring(prefix.length));
      if (index != null) return fromFrameIndex(index);
    }
    return fullDisplay;
  }

  static PlacementKind resolve(String? templateId, GridOverlayType grid) {
    final id = templateId ?? '';
    if (id.startsWith('cs_frame_')) return fromTemplateId(id);
    return fromGrid(grid);
  }

  static PlacementKind fromFrameIndex(int index) => switch (index) {
        0 => fullDisplay,
        1 => closeUp,
        2 => drape,
        3 => border,
        4 => folded,
        5 => scale,
        6 => flatLay,
        7 => lifestyle,
        8 => hanging,
        9 => fringe,
        10 => making,
        11 => framed,
        _ => fullDisplay,
      };

  static PlacementKind fromGrid(GridOverlayType grid) => switch (grid) {
        GridOverlayType.ruleOfThirds => fullDisplay,
        GridOverlayType.centerFocus => closeUp,
        GridOverlayType.leadingLines => drape,
        GridOverlayType.detailFrame => border,
        GridOverlayType.horizontalFolds => folded,
      };

  /// Short line under the box: where to put the product.
  String get hint => switch (this) {
        PlacementKind.fullDisplay => 'Place the whole piece inside this frame',
        PlacementKind.closeUp => 'Fill this box with the weave',
        PlacementKind.drape => 'Place the person wearing it inside this frame',
        PlacementKind.border => 'Put the border / motif in this window',
        PlacementKind.folded => 'Lay the folded stack in this box',
        PlacementKind.scale => 'Piece in the frame · object on the spot',
        PlacementKind.flatLay => 'Lay it flat inside this table frame',
        PlacementKind.lifestyle => 'Keep the scene inside this frame',
        PlacementKind.hanging => 'Hang the piece in the centre, under the rod',
        PlacementKind.fringe => 'Run the fringe along the diagonal',
        PlacementKind.making => 'Keep hands and tools inside the frame',
        PlacementKind.framed => 'Line the panel up with the inner frame',
      };

  double get ghostInsetX => switch (this) {
        PlacementKind.fullDisplay => 0.12,
        PlacementKind.closeUp => 0.22,
        PlacementKind.drape => 0.10,
        PlacementKind.border => 0.16,
        PlacementKind.folded => 0.08,
        PlacementKind.scale => 0.12,
        PlacementKind.flatLay => 0.10,
        PlacementKind.lifestyle => 0.12,
        PlacementKind.hanging => 0.22,
        PlacementKind.fringe => 0.12,
        PlacementKind.making => 0.12,
        PlacementKind.framed => 0.16,
      };

  double get ghostInsetY => switch (this) {
        PlacementKind.fullDisplay => 0.14,
        PlacementKind.closeUp => 0.26,
        PlacementKind.drape => 0.04,
        PlacementKind.border => 0.18,
        PlacementKind.folded => 0.26,
        PlacementKind.scale => 0.14,
        PlacementKind.flatLay => 0.22,
        PlacementKind.lifestyle => 0.14,
        PlacementKind.hanging => 0.12,
        PlacementKind.fringe => 0.16,
        PlacementKind.making => 0.14,
        PlacementKind.framed => 0.12,
      };
}
