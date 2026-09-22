/// Cluster catalogue from Click & Social HTML (Framing the Fabric / SSI Lab).
class ClickSocialCluster {
  const ClickSocialCluster({
    required this.id,
    required this.fabric,
    required this.shortName,
    required this.place,
    required this.categoryId,
    required this.detailTip,
    required this.bioLines,
    required this.storyBlocks,
    required this.tags,
  });

  final String id;
  final String fabric;
  final String shortName;
  final String place;
  /// Nearest Artisanal Lens product category for capture flow.
  final String categoryId;

  /// What to shoot close for this craft (HTML `cluster.detailTip`).
  final String detailTip;
  final List<String> bioLines;
  /// Caption building blocks: [kicker, text].
  final List<(String, String)> storyBlocks;
  final List<String> tags;
}

const clickSocialClusters = <ClickSocialCluster>[
  ClickSocialCluster(
    id: 'assam',
    fabric: 'Mekhela sador — muga & eri silk',
    shortName: 'mekhela sador',
    place: 'Kamrup & Nalbari, Assam',
    categoryId: 'saree',
    detailTip:
        'Close on the extra-weft buta of the pallu — that is the handwork',
    bioLines: [
      'Handloom weaver',
      'Kamrup, Assam',
      'Mekhela sador & stoles',
      'DM to order',
      '3rd generation weaver',
    ],
    storyBlocks: [
      ('HERITAGE', 'Muga — the golden silk only Assam grows.'),
      ('MATERIAL', 'Handspun eri — soft as a shawl, warm as wool.'),
      ('PROCESS', 'Woven at home, weeks on the loom, motif by motif.'),
    ],
    tags: [
      '#mekhelachador',
      '#mugasilk',
      '#erisilk',
      '#assamhandloom',
      '#handwoven',
      '#vocalforlocal',
      '#silksofindia',
      '#weaversofindia',
    ],
  ),
  ClickSocialCluster(
    id: 'srikalahasti',
    fabric: 'Kalamkari — hand-painted cotton',
    shortName: 'kalamkari',
    place: 'Srikalahasti, Andhra Pradesh',
    categoryId: 'cushion_cover',
    detailTip: 'Close on one motif — show the free hand of the kalam pen',
    bioLines: [
      'Kalamkari artist',
      'Srikalahasti, Andhra Pradesh',
      'Hand-painted panels & saris',
      'DM to order',
      'Temple-art family',
    ],
    storyBlocks: [
      ('HERITAGE', 'Temple stories, drawn with a bamboo kalam.'),
      ('MATERIAL', 'Cotton and natural dyes — myrobalan, iron, alum.'),
      ('PROCESS', 'Drawn line by line — no two pieces alike.'),
    ],
    tags: [
      '#kalamkari',
      '#srikalahasti',
      '#naturaldyes',
      '#handpainted',
      '#craftindia',
      '#vocalforlocal',
      '#textileart',
      '#madeinindia',
    ],
  ),
  ClickSocialCluster(
    id: 'venkatgiri',
    fabric: 'Venkatgiri saree — fine cotton & zari',
    shortName: 'Venkatgiri saree',
    place: 'Venkatgiri, Andhra Pradesh',
    categoryId: 'saree',
    detailTip: 'Close on the zari border at a slight angle so the gold glints',
    bioLines: [
      'Handloom weaver',
      'Venkatgiri, Andhra Pradesh',
      'Fine cotton & zari saris',
      'DM to order',
      'Weaving family since 1970',
    ],
    storyBlocks: [
      ('HERITAGE', 'Once woven for the Venkatagiri court.'),
      ('MATERIAL', 'Cotton so fine the saree floats.'),
      ('PROCESS', 'Jamdani motifs — parrot, mango, swan — woven in by hand.'),
    ],
    tags: [
      '#venkatagiri',
      '#jamdani',
      '#zari',
      '#handloomsaree',
      '#cottonsaree',
      '#vocalforlocal',
      '#sareesofinstagram',
      '#madeinindia',
    ],
  ),
  ClickSocialCluster(
    id: 'maniabandha',
    fabric: 'Khandua ikat — tie-dyed silk',
    shortName: 'Khandua ikat',
    place: 'Maniabandha, Odisha',
    categoryId: 'saree',
    detailTip:
        'Close on a motif edge — the soft feathering is proof of true ikat',
    bioLines: [
      'Ikat weaver',
      'Maniabandha, Odisha',
      'Khandua saris & stoles',
      'DM to order',
      'Weaver village on the Mahanadi',
    ],
    storyBlocks: [
      ('HERITAGE', 'Khandua — woven for Lord Jagannath.'),
      ('MATERIAL', 'Silk yarns tie-dyed before they ever meet the loom.'),
      ('PROCESS', 'The pattern is dyed into the thread, then woven true.'),
    ],
    tags: [
      '#khandua',
      '#ikat',
      '#odishahandloom',
      '#maniabandha',
      '#handwoven',
      '#tiedye',
      '#vocalforlocal',
      '#sareelove',
    ],
  ),
  ClickSocialCluster(
    id: 'gopalpur',
    fabric: 'Gopalpur tussar — wild silk',
    shortName: 'tussar sari',
    place: 'Gopalpur, Jajpur, Odisha',
    categoryId: 'stole',
    detailTip: 'Close on the gheecha texture — the slubs say real wild silk',
    bioLines: [
      'Tussar weaver',
      'Gopalpur, Odisha',
      'Saris, stoles & fabric',
      'DM to order',
      'GI-tagged craft',
    ],
    storyBlocks: [
      (
        'HERITAGE',
        'Woven in Gopalpur since the 16th century — GI tagged.',
      ),
      ('MATERIAL', 'Wild tussar — its gold is natural, not dye.'),
      ('PROCESS', 'Hand-reeled, hand-spun, extra-weft motifs.'),
    ],
    tags: [
      '#tussarsilk',
      '#gopalpur',
      '#odishaweaves',
      '#wildsilk',
      '#handspun',
      '#vocalforlocal',
      '#silksofindia',
      '#handwoven',
    ],
  ),
  ClickSocialCluster(
    id: 'nagaland',
    fabric: 'Naga shawl — loin loom',
    shortName: 'Naga shawl',
    place: 'Nagaland clusters',
    categoryId: 'shawl',
    detailTip: 'Close on the motif band — every stripe carries a meaning',
    bioLines: [
      'Loin-loom weaver',
      'Nagaland',
      'Shawls & mekhalas',
      'DM to order',
      'Weaves of my tribe',
    ],
    storyBlocks: [
      ('HERITAGE', 'Every stripe and motif tells who you are.'),
      ('MATERIAL', 'Thick cotton on the loin loom, dyed deep.'),
      ('PROCESS', 'Woven strip by strip, stitched into one shawl.'),
    ],
    tags: [
      '#nagashawl',
      '#loinloom',
      '#nagaland',
      '#handwoven',
      '#tribaltextile',
      '#vocalforlocal',
      '#northeastindia',
      '#craftindia',
    ],
  ),
];

ClickSocialCluster? clusterById(String? id) {
  if (id == null) return null;
  for (final c in clickSocialClusters) {
    if (c.id == id) return c;
  }
  return null;
}

/// Products shown on photo lesson step 0 (fixed 2×2 catalog).
List<String> productsForCluster(String? clusterId) => const [
      'Mekhela sador',
      'Sari',
      'Stole / Dupatta',
      'Accessories',
    ];

/// Asset path for a photo-step product card image.
String? productImageAsset(String productLabel) => switch (productLabel) {
      'Mekhela sador' => 'assets/images/products/mekhela.png',
      'Sari' => 'assets/images/products/sari.png',
      'Stole / Dupatta' => 'assets/images/products/stole.png',
      'Accessories' => 'assets/images/products/accessories.png',
      _ => null,
    };

/// Map an HTML product label onto the nearest capture category id.
String categoryIdForProduct(String productLabel) => switch (productLabel) {
      'Kalamkari panel' || 'Pillow cover' || 'Bedcover' => 'cushion_cover',
      'Shawl' => 'shawl',
      'Stole / Dupatta' ||
      'Table runner' ||
      'Bags' ||
      'Accessories' =>
        'stole',
      _ => 'saree', // Mekhela sador, Sari, …
    };

