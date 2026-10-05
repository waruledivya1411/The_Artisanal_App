import 'dart:io';

import 'package:artisanal_lens/features/checklist/click_social_frames.dart';
import 'package:artisanal_lens/features/home/click_social_clusters.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every asset the frame catalog and its guides name, for one learner.
Set<String> _assetsFor({
  required String? clusterId,
  required String? categoryId,
  required String? technique,
  String? productLabel,
  String? materialId,
}) {
  final assets = <String>{};
  for (final frame in clickSocialFrames) {
    assets.add(
      frame.thumbAssetFor(
        clusterId: clusterId,
        categoryId: categoryId,
        technique: technique,
        productLabel: productLabel,
        materialId: materialId,
      ),
    );
    final steps = frame.guideSteps(
      isAssam: clickSocialIsAssam(clusterId),
      isKal: clickSocialIsKal(clusterId: clusterId, technique: technique),
      clusterId: clusterId,
      productLabel: productLabel ?? categoryId,
      technique: technique,
    );
    for (final step in steps) {
      if (step.imageAsset != null) assets.add(step.imageAsset!);
      if (step.gallery != null) assets.addAll(step.gallery!);
    }
  }
  return assets;
}

void main() {
  test('every frame and guide asset is bundled', () {
    final missing = <String>{};
    for (final cluster in clickSocialClusters) {
      for (final technique in [null, 'WOVEN', 'HAND-PAINTED']) {
        for (final category in ['saree', 'stole', 'shawl', 'cushion_cover']) {
          for (final product in [
            null,
            'Mekhela sador',
            'Sari',
            'Stole / Dupatta',
          ]) {
            for (final material in [null, 'silk', 'cotton']) {
              for (final asset in _assetsFor(
                clusterId: cluster.id,
                categoryId: category,
                technique: technique,
                productLabel: product,
                materialId: material,
              )) {
                if (!File(asset).existsSync()) missing.add(asset);
              }
            }
          }
        }
      }
    }
    expect(missing, isEmpty, reason: missing.join('\n'));
  });

  test('Assam mekhela thumbs match product + frame name', () {
    final full = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Mekhela sador',
      materialId: 'silk',
    );
    final stack = clickSocialFrames[4].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Mekhela sador',
      materialId: 'silk',
    );
    final stoleFull = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'stole',
      technique: 'WOVEN',
      productLabel: 'Stole / Dupatta',
      materialId: 'silk',
    );
    final sariClose = clickSocialFrames[1].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Sari',
      materialId: 'silk',
    );
    expect(full, contains('clusters/kamrup/mekhela/silk/woven/full_display'));
    expect(stack, contains('clusters/kamrup/mekhela/silk/woven/folded_stack'));
    expect(stoleFull, contains('clusters/kamrup/stole/silk/woven/full_display'));
    expect(sariClose, contains('clusters/kamrup/sari/silk/woven/close-up_texture'));
    expect(full, isNot(contains('templates/')));
    expect(stoleFull, isNot(contains('templates/')));
  });

  test('Maniabandha thumbs match product + frame name', () {
    final sariFull = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'maniabandha',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Sari',
      materialId: 'cotton',
    );
    final stoleDrape = clickSocialFrames[2].thumbAssetFor(
      clusterId: 'maniabandha',
      categoryId: 'stole',
      technique: 'WOVEN',
      productLabel: 'Stole / Dupatta',
      materialId: 'silk',
    );
    final hp = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'maniabandha',
      categoryId: 'saree',
      technique: 'HAND-PAINTED',
      productLabel: 'Sari',
      materialId: 'silk',
    );
    expect(sariFull, contains('clusters/maniabandha/sari/cotton/woven/full_display'));
    expect(stoleDrape, contains('clusters/maniabandha/stole/silk/woven/draped_look'));
    expect(hp, contains('clusters/maniabandha/sari/silk/handpainted/full_display'));
    expect(hp, isNot(contains('kal-')));
  });

  test('Srikalahasti listing thumbs match product + do not use kal- files', () {
    final sariHang = clickSocialFrames[8].thumbAssetFor(
      clusterId: 'srikalahasti',
      categoryId: 'saree',
      technique: 'HAND-PAINTED',
      productLabel: 'Sari',
      materialId: 'cotton',
    );
    final stoleClose = clickSocialFrames[1].thumbAssetFor(
      clusterId: 'srikalahasti',
      categoryId: 'stole',
      technique: 'HAND-PAINTED',
      productLabel: 'Stole / Dupatta',
      materialId: 'cotton',
    );
    final woven = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'srikalahasti',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Sari',
      materialId: 'silk',
    );
    expect(sariHang, contains('clusters/srikalahasti/sari/cotton/handpainted/hanging_display'));
    expect(stoleClose, contains('clusters/srikalahasti/stole/cotton/handpainted/close-up_texture'));
    expect(woven, contains('clusters/srikalahasti/sari/silk/woven/full_display'));
    expect(sariHang, isNot(contains('kal-')));
  });

  test('Assam hand-painted does not fall back to Kalamkari thumbs', () {
    final thumb = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'saree',
      technique: 'HAND-PAINTED',
      productLabel: 'Mekhela sador',
      materialId: 'silk',
    );
    expect(thumb, isNot(contains('kal-')));
    expect(thumb, contains('mekhela'));
  });

  test('Assam thumbs never use Banarasi or kilim stock', () {
    for (final product in ['Mekhela sador', 'Sari', 'Stole / Dupatta']) {
      for (final frame in clickSocialFrames) {
        final thumb = frame.thumbAssetFor(
          clusterId: 'assam',
          categoryId: 'saree',
          technique: 'WOVEN',
          productLabel: product,
          materialId: 'silk',
        );
        expect(thumb, isNot(contains('templates/')));
        expect(thumb, isNot(contains('presets/')));
        expect(thumb, isNot(contains('stole-flatlay')));
        expect(thumb, isNot(contains('stole-hung')));
      }
    }
  });

  test('product key prefers mekhela for Assam saree-class', () {
    expect(
      clickSocialFrameProductKey(clusterId: 'assam', categoryId: 'saree'),
      'mekhela',
    );
    expect(
      clickSocialFrameProductKey(
        productLabel: 'Stole / Dupatta',
        categoryId: 'saree',
        clusterId: 'assam',
      ),
      'stole',
    );
  });

  test('every frame has at least one guide step', () {
    for (final frame in clickSocialFrames) {
      final steps = frame.guideSteps(
        isAssam: false,
        isKal: false,
        clusterId: null,
        productLabel: 'saree',
        technique: 'WOVEN',
      );
      expect(steps, isNotEmpty, reason: 'frame ${frame.index}');
    }
  });

  test('a Kalamkari learner gets their own galleries', () {
    final steps = clickSocialFrames[0].guideSteps(
      isAssam: false,
      isKal: true,
      clusterId: 'srikalahasti',
      productLabel: 'cushion_cover',
      technique: 'HAND-PAINTED',
    );
    final gallery = steps.firstWhere((step) => step.hasGallery).gallery!;
    expect(gallery.first, contains('kal-panel-tree'));
  });

  test('an Assam learner gets the extra drape pages', () {
    final steps = clickSocialFrames[0].guideSteps(
      isAssam: true,
      isKal: false,
      clusterId: 'assam',
      productLabel: 'saree',
      technique: 'WOVEN',
    );
    expect(
      steps.map((step) => step.imageAsset).whereType<String>(),
      contains(contains('mekhela-drapes')),
    );
  });

  test('frames map onto the HTML archOf table', () {
    expect(
      [for (var i = 0; i < 12; i++) archForFrameIndex(i)],
      const [
        FrameArch.thirds,
        FrameArch.center,
        FrameArch.diag,
        FrameArch.detail,
        FrameArch.detail,
        FrameArch.thirds,
        FrameArch.center,
        FrameArch.thirds,
        FrameArch.center,
        FrameArch.diag,
        FrameArch.thirds,
        FrameArch.center,
      ],
    );
  });

  test('only the six listing frames are offered', () {
    expect(
      framesForSelection(isPanel: false).map((f) => f.index),
      clickSocialOfferedFrames,
    );
    expect(
      framesForSelection(isPanel: true).map((f) => f.index),
      clickSocialOfferedFrames,
    );
  });

  test('an empty pick list falls back to the six listing frames', () {
    expect(
      resolveFramePicks(const [], isPanel: false),
      clickSocialOfferedFrames,
    );
    expect(
      resolveFramePicks(const [], isPanel: true),
      clickSocialOfferedFrames,
    );
    expect(resolveFramePicks(const [7, 2, 99], isPanel: false), [2]);
  });

  test('a picked frame becomes a template that skips the fold step', () {
    final template = asTemplate(clickSocialFrames[7]);
    expect(template.id, 'cs_frame_7');
    expect(template.name, 'In-context lifestyle');
    expect(template.skipsStyleStep, isTrue);
    expect(template.needsStyleStep, isFalse);
    expect(template.guidance, isNotEmpty);
  });
}
