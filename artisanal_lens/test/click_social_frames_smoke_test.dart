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

  test('Assam shawl thumbs match cotton/silk and stay off stole folders', () {
    final cottonFull = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'cotton',
    );
    final silkHang = clickSocialFrames[8].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'silk',
    );
    expect(
      cottonFull,
      contains('clusters/kamrup/shawl/cotton/woven/full_display'),
    );
    expect(
      silkHang,
      contains('clusters/kamrup/shawl/silk/woven/hanging_display'),
    );
    expect(cottonFull, isNot(contains('/stole/')));
  });

  test('Assam shawl thumbs use mulberry and zari folders', () {
    final mulberry = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'mulberry',
    );
    final zari = clickSocialFrames[3].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'zari',
    );
    final stoleMulberry = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'stole',
      technique: 'WOVEN',
      productLabel: 'Stole',
      materialId: 'mulberry',
    );
    expect(
      mulberry,
      contains('clusters/kamrup/shawl/mulberry/woven/full_display'),
    );
    expect(
      zari,
      contains('clusters/kamrup/shawl/zari/woven/embroidery_and_border'),
    );
    expect(stoleMulberry, contains('clusters/kamrup/stole/silk/woven/'));
  });

  test('Assam gamusa thumbs match materials and stay off stole folders', () {
    final cotton = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'stole',
      technique: 'WOVEN',
      productLabel: 'Gamusa',
      materialId: 'cotton',
    );
    final muga = clickSocialFrames[8].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'stole',
      technique: 'WOVEN',
      productLabel: 'Gamusa',
      materialId: 'muga',
    );
    final gheecha = clickSocialFrames[4].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'stole',
      technique: 'WOVEN',
      productLabel: 'Gamusa',
      materialId: 'tussar-gheecha',
    );
    expect(cotton, contains('clusters/kamrup/gamusa/cotton/woven/full_display'));
    expect(muga, contains('clusters/kamrup/gamusa/muga/woven/hanging_display'));
    expect(
      gheecha,
      contains('clusters/kamrup/gamusa/tussar-gheecha/woven/folded_stack'),
    );
    expect(cotton, isNot(contains('/stole/')));
    expect(cotton, isNot(contains('/shawl/')));
  });

  test('Assam sari thumbs match materials and stay on sari folders', () {
    final cotton = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Sari',
      materialId: 'cotton',
    );
    final muga = clickSocialFrames[8].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Sari',
      materialId: 'muga',
    );
    final zari = clickSocialFrames[3].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Sari',
      materialId: 'zari',
    );
    expect(cotton, contains('clusters/kamrup/sari/cotton/woven/full_display'));
    expect(muga, contains('clusters/kamrup/sari/muga/woven/hanging_display'));
    expect(zari, contains('clusters/kamrup/sari/zari/woven/embroidery_and_border'));
    expect(cotton, isNot(contains('/shawl/')));
    expect(cotton, isNot(contains('/gamusa/')));
  });

  test('Assam mekhela thumbs match named fibres', () {
    final muga = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Mekhela sador',
      materialId: 'muga',
    );
    final eri = clickSocialFrames[2].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Mekhela sador',
      materialId: 'eri',
    );
    expect(muga, contains('clusters/kamrup/mekhela/muga/woven/full_display'));
    expect(eri, contains('clusters/kamrup/mekhela/eri/woven/draped_look'));
    expect(muga, isNot(contains('/sari/')));
  });

  test('Assam shawl thumbs use eri, tussar, tussar-gheecha and muga folders', () {
    final eri = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'eri',
    );
    final tussar = clickSocialFrames[1].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'tussar',
    );
    final gheecha = clickSocialFrames[4].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'tussar-gheecha',
    );
    final muga = clickSocialFrames[8].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'muga',
    );
    expect(eri, contains('clusters/kamrup/shawl/eri/woven/full_display'));
    expect(tussar, contains('clusters/kamrup/shawl/tussar/woven/close-up_texture'));
    expect(
      gheecha,
      contains('clusters/kamrup/shawl/tussar-gheecha/woven/folded_stack'),
    );
    expect(muga, contains('clusters/kamrup/shawl/muga/woven/hanging_display'));
  });

  test('Assam shawl thumbs use muga-gheecha, spun-silk and spun-tussar folders', () {
    final mugaGheecha = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'muga-gheecha',
    );
    final spunSilk = clickSocialFrames[2].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'spun-silk',
    );
    final spunTussar = clickSocialFrames[8].thumbAssetFor(
      clusterId: 'assam',
      categoryId: 'shawl',
      technique: 'WOVEN',
      productLabel: 'Shawl',
      materialId: 'spun-tussar',
    );
    expect(
      mugaGheecha,
      contains('clusters/kamrup/shawl/muga-gheecha/woven/full_display'),
    );
    expect(
      spunSilk,
      contains('clusters/kamrup/shawl/spun-silk/woven/draped_look'),
    );
    expect(
      spunTussar,
      contains('clusters/kamrup/shawl/spun-tussar/woven/hanging_display'),
    );
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
    expect(hp, contains('clusters/maniabandha/sari/silk/woven/full_display'));
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
    expect(sariHang, contains('clusters/srikalahasti/sari/cotton/woven/hanging_display'));
    expect(stoleClose, contains('clusters/srikalahasti/stole/cotton/woven/close-up_texture'));
    expect(woven, contains('clusters/srikalahasti/sari/silk/woven/full_display'));
    expect(sariHang, isNot(contains('kal-')));
  });

  test('Venkatgiri sari thumbs match cotton/silk and woven/hand-painted', () {
    final cottonWoven = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'venkatgiri',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Sari',
      materialId: 'cotton',
    );
    final silkPainted = clickSocialFrames[8].thumbAssetFor(
      clusterId: 'venkatgiri',
      categoryId: 'saree',
      technique: 'HAND-PAINTED',
      productLabel: 'Sari',
      materialId: 'silk',
    );
    final stoleFallback = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'venkatgiri',
      categoryId: 'stole',
      technique: 'WOVEN',
      productLabel: 'Stole / Dupatta',
      materialId: 'cotton',
    );
    expect(
      cottonWoven,
      contains('clusters/venkatgiri/sari/cotton/woven/full_display'),
    );
    expect(
      silkPainted,
      contains('clusters/venkatgiri/sari/silk/woven/hanging_display'),
    );
    expect(
      stoleFallback,
      contains('clusters/venkatgiri/stole/cotton/woven/full_display'),
    );
  });

  test('Venkatgiri stole thumbs match cotton/silk and woven/hand-painted', () {
    final cottonWoven = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'venkatgiri',
      categoryId: 'stole',
      technique: 'WOVEN',
      productLabel: 'Stole / Dupatta',
      materialId: 'cotton',
    );
    final silkPainted = clickSocialFrames[8].thumbAssetFor(
      clusterId: 'venkatgiri',
      categoryId: 'stole',
      technique: 'HAND-PAINTED',
      productLabel: 'Stole / Dupatta',
      materialId: 'silk',
    );
    expect(
      cottonWoven,
      contains('clusters/venkatgiri/stole/cotton/woven/full_display'),
    );
    expect(
      silkPainted,
      contains('clusters/venkatgiri/stole/silk/woven/hanging_display'),
    );
  });

  test('Venkatgiri mekhela thumbs match cotton/silk and woven/hand-painted', () {
    final cottonWoven = clickSocialFrames[0].thumbAssetFor(
      clusterId: 'venkatgiri',
      categoryId: 'saree',
      technique: 'WOVEN',
      productLabel: 'Mekhela sador',
      materialId: 'cotton',
    );
    final silkPainted = clickSocialFrames[2].thumbAssetFor(
      clusterId: 'venkatgiri',
      categoryId: 'saree',
      technique: 'HAND-PAINTED',
      productLabel: 'Mekhela sador',
      materialId: 'silk',
    );
    expect(
      cottonWoven,
      contains('clusters/venkatgiri/mekhela/cotton/woven/full_display'),
    );
    expect(
      silkPainted,
      contains('clusters/venkatgiri/mekhela/silk/woven/draped_look'),
    );
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

  test('Kamrup and Nalbari list extra products and stole without dupatta', () {
    expect(productsForCluster('assam'), [
      'Mekhela sador',
      'Sari',
      'Gamusa',
      'Shawl',
      'Stole',
      'Jod Kapur',
      'Yardages',
      'Home Furnishing',
    ]);
    expect(productsForCluster('maniabandha'), [
      'Mekhela sador',
      'Sari',
      'Stole',
      'Yardage',
      'Chadar',
      'Dhoti',
      'Jodo',
      'Muffler',
    ]);
    expect(productsForCluster('venkatgiri'), [
      'Mekhela sador',
      'Sari',
      'Stole',
      'Dupatta',
      'Angvastram set',
      'Yardage',
    ]);
    expect(productsForCluster('gopalpur'), [
      'Mekhela sador',
      'Sari',
      'Stole',
      'Jodo',
      'Dupatta',
      'Uttaraya',
      'Muffler',
      'Handkerchief',
      'Dhoti',
      'Chadar',
    ]);
    expect(productsForCluster('srikalahasti'), [
      'Mekhela sador',
      'Sari',
      'Stole',
      'Dupattas',
      'Yardages',
    ]);
    expect(productsForCluster('nagaland'), [
      'Mufflers',
      'Mekhela Chador',
      'Table Cloth',
      'Naga Sling Bags',
      'Table Runners',
      'Naga Shawl',
      'Naga Wraparound',
    ]);
    expect(productsForCluster('assam').join(), isNot(contains('Dupatta')));
    expect(
      clickSocialFrameProductKey(
        productLabel: 'Gamusa',
        clusterId: 'assam',
      ),
      'stole',
    );
    expect(
      clickSocialFrameProductKey(
        productLabel: 'Jod Kapur',
        clusterId: 'assam',
      ),
      'mekhela',
    );
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

  test('mekhela draped look uses the chair camera guide', () {
    final steps = clickSocialFrames[2].guideSteps(
      isAssam: true,
      isKal: false,
      clusterId: 'assam',
      productLabel: 'Mekhela sador',
      technique: 'WOVEN',
    );
    expect(steps.first.title, 'Drape it over a chair');
    expect(steps.first.diagram, 'chair');
    expect(steps.first.referenceAsset, contains('cs_cam_ref_2_chair'));
    expect(
      asTemplate(clickSocialFrames[2], chairDrape: true).referenceImageAsset,
      clickSocialCameraRefAsset(2, chairDrape: true),
    );
    expect(File(clickSocialCameraRefAsset(2, chairDrape: true)).existsSync(), isTrue);
  });

  test('sari draped look stays a worn person guide', () {
    final steps = clickSocialFrames[2].guideSteps(
      isAssam: true,
      isKal: false,
      clusterId: 'assam',
      productLabel: 'Sari',
      technique: 'WOVEN',
    );
    expect(steps.first.title, 'Drape it on a person');
    expect(steps.first.diagram, 'worn');
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
        FrameArch.thirds,
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

  test('each listing frame has a camera-layout reference photo', () {
    for (final index in clickSocialOfferedFrames) {
      final asset = clickSocialCameraRefAsset(index);
      expect(File(asset).existsSync(), isTrue, reason: asset);
      expect(asTemplate(frameByIndex(index)!).referenceImageAsset, asset);
      expect(clickSocialCameraPlacementLines(index), isNotEmpty);
    }
  });
}
