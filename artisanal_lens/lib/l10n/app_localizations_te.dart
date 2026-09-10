// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'ది ఆర్టిసానల్ లెన్స్';

  @override
  String get navHome => 'హోమ్';

  @override
  String get navGallery => 'గ్యాలరీ';

  @override
  String get navNewProduct => 'కొత్త ఉత్పత్తి';

  @override
  String get navSettings => 'సెట్టింగ్‌లు';

  @override
  String get continueAction => 'కొనసాగించు';

  @override
  String get openCamera => 'కెమెరాను తెరవండి';

  @override
  String get language => 'భాష';

  @override
  String get photographyGuide => 'ఫోటోగ్రఫీ గైడ్';

  @override
  String get photographyGuideSubtitle =>
      'ఈ యాప్ మీకు అందించే ప్రతి ప్రాంప్ట్ వెనుక ఉన్న నియమాలు.';

  @override
  String get whatPhotographing => 'మీరు ఏమిటి\nఈరోజు ఫోటో తీస్తున్నారా?';

  @override
  String get continuePhotography => 'ఫోటోగ్రఫీని కొనసాగించండి';

  @override
  String get previousSets => 'మునుపటి సెట్లు.';

  @override
  String get filterAll => 'అన్నీ';

  @override
  String get filterFinished => 'పూర్తయింది';

  @override
  String get filterPending => 'పెండింగ్‌లో ఉంది';

  @override
  String photosCompleted(int done, int total) {
    return '$totalలో $done ఫోటోలు పూర్తయ్యాయి';
  }

  @override
  String get emptyAll => 'ఇంకా మునుపటి సెట్‌లు లేవు.';

  @override
  String get emptyFinished => 'ఇంకా పూర్తి సెట్లు లేవు.';

  @override
  String get emptyPending => 'పెండింగ్ సెట్‌లు లేవు.';

  @override
  String get newProduct => 'కొత్త ఉత్పత్తి';

  @override
  String get gallery => 'గ్యాలరీ';

  @override
  String get settings => 'సెట్టింగ్‌లు';

  @override
  String get product => 'ఉత్పత్తి';

  @override
  String get photos => 'ఫోటోలు';

  @override
  String get setup => 'సెటప్';

  @override
  String get tutorial => 'ట్యుటోరియల్';

  @override
  String get review => 'సమీక్షించండి';

  @override
  String get materialHeadline => 'ఏ పదార్థాలు ఉన్నాయి\nమీరు పని చేస్తున్నారా?';

  @override
  String materialTypeHeadline(String material) {
    return 'ఏ రకమైన $material\nమీరు ఉపయోగిస్తున్నారా?';
  }

  @override
  String get giveProductName => 'మీ ఉత్పత్తికి పేరు పెట్టండి';

  @override
  String nameHint(String category) {
    return 'ఉదా బ్లూ సిల్క్ $category';
  }

  @override
  String get photosToCapture => 'సంగ్రహించడానికి ఫోటోలు';

  @override
  String get photosToCaptureBody => 'మీరు తీసుకోవలసిన ఫోటోలు ఇవి.';

  @override
  String get sareePhotographyTemplatesTitle => 'చీర ఫోటోగ్రఫీ టెంప్లేట్లు';

  @override
  String get sareePhotographyTemplatesBody => 'ఇవి తీయాల్సిన ఐదు ఫోటోలు.';

  @override
  String get photographyTemplatesTitle => 'ఫోటోగ్రఫీ టెంప్లేట్లు';

  @override
  String get photographyTemplatesBody => 'ఇవి తీయాల్సిన ఐదు ఫోటోలు.';

  @override
  String get viewCompletedSet => 'పూర్తయిన సెట్‌ని వీక్షించండి';

  @override
  String get allPhotosCaptured => 'అన్ని ఫోటోలు క్యాప్చర్ చేయబడ్డాయి';

  @override
  String takeNext(String label) {
    return 'తర్వాత తీసుకోండి — $label';
  }

  @override
  String get productUnavailable => 'ఈ ఉత్పత్తి ఇకపై అందుబాటులో లేదు.';

  @override
  String get chooseAStyle => 'ఒక శైలిని ఎంచుకోండి';

  @override
  String get howShouldItLook => 'అది ఎలా కనిపించాలి?';

  @override
  String get stylePickFirst => 'ముందుగా జాబితా నుండి ఫోటోను ఎంచుకోండి.';

  @override
  String get styleNoNeeded => 'ఈ ఫోటోకు ఎలాంటి స్టైల్ అవసరం లేదు.';

  @override
  String styleSubtitleSaree(String template) {
    return 'ఈ $template ఫోటో కోసం అమరికను ఎంచుకోండి.';
  }

  @override
  String styleSubtitleShot(String shot) {
    return 'ఈ $shot ఫోటో కోసం అమరికను ఎంచుకోండి.';
  }

  @override
  String styleSubtitleCategory(String category, String shot) {
    return 'ఈ $category $shot ఫోటో కోసం అమరికను ఎంచుకోండి.';
  }

  @override
  String get labelContent => 'కంటెంట్';

  @override
  String get labelNeeds => 'అవసరాలు';

  @override
  String get labelPlacement => 'ప్లేస్‌మెంట్';

  @override
  String get labelLighting => 'లైటింగ్';

  @override
  String get labelGrid => 'గ్రిడ్';

  @override
  String contentPrefixed(String value) {
    return 'కంటెంట్: $value';
  }

  @override
  String needsPrefixed(String value) {
    return 'అవసరాలు: $value';
  }

  @override
  String get lightingAndSetup => 'లైటింగ్ మరియు సెటప్';

  @override
  String get step1of2 => '2లో 1వ దశ';

  @override
  String get step2of2 => '2లో 2వ దశ';

  @override
  String get beforeYouShoot => 'మీరు షూట్ చేయడానికి ముందు';

  @override
  String get setupIllustrationPlaceholder => 'సెటప్ ఇలస్ట్రేషన్ జోడించబడాలి';

  @override
  String get placeTheProduct => 'ఉత్పత్తిని ఉంచండి';

  @override
  String get setupSection => 'సెటప్';

  @override
  String get watchHowToSetUp => 'ఎలా సెటప్ చేయాలో చూడండి';

  @override
  String tutorialSubtitlePreset(String name) {
    return '$nameని ఎలా సెటప్ చేయాలో చూడండి.';
  }

  @override
  String tutorialSubtitleTemplate(String name) {
    return '$nameని ఎలా సెటప్ చేయాలో చూడండి.';
  }

  @override
  String get tutorialSubtitleFallback =>
      'ఈ సెటప్ జోడించబడినప్పుడు చిన్న వీడియో చూపబడుతుంది.';

  @override
  String get transcript => 'ట్రాన్స్‌క్రిప్ట్';

  @override
  String get transcriptPlaceholder =>
      'ట్యుటోరియల్ వీడియో జోడించబడిన తర్వాత స్పోకెన్ ట్రాన్స్క్రిప్ట్ ఇక్కడ కనిపిస్తుంది.';

  @override
  String get tutorialVideoPlaceholder => 'ట్యుటోరియల్ వీడియో జోడించబడాలి';

  @override
  String get referencePreset => 'రెఫరెన్స్ ప్రీసెట్';

  @override
  String get retake => 'తిరిగి తీసుకోండి';

  @override
  String get usePhoto => 'ఫోటోని ఉపయోగించండి';

  @override
  String get greatFraming => 'గొప్ప ఫ్రేమింగ్';

  @override
  String get checkFraming => 'ఫ్రేమింగ్‌ని తనిఖీ చేయండి';

  @override
  String get noPhotoToReview => 'సమీక్షించడానికి ఫోటో లేదు.';

  @override
  String get photoSetComplete => 'మీ ఫోటో సెట్ పూర్తయింది 🎉';

  @override
  String get viewPhotoSet => 'ఫోటో సెట్‌ని వీక్షించండి';

  @override
  String get startNewProduct => 'కొత్త ఉత్పత్తిని ప్రారంభించండి';

  @override
  String get offlineBanner =>
      'ఆఫ్‌లైన్ — కనెక్ట్ చేసినప్పుడు ఫోటోలు సమకాలీకరించబడతాయి';

  @override
  String get productNotFound => 'ఉత్పత్తి కనుగొనబడలేదు.';

  @override
  String get exportPhotoSet => 'ఫోటో సెట్‌ని ఎగుమతి చేయండి';

  @override
  String continueCount(int done, int total) {
    return 'కొనసాగించు — $done/$total';
  }

  @override
  String get noPhotosToExport => 'ఎగుమతి చేయడానికి ఇంకా ఫోటోలు లేవు.';

  @override
  String couldNotExport(String error) {
    return 'ఎగుమతి చేయడం సాధ్యపడలేదు: $error';
  }

  @override
  String exportShareText(String name, int count) {
    return '$name — $count ఫోటోలు, ది ఆర్టిసానల్ లెన్స్‌తో చిత్రీకరించబడ్డాయి';
  }

  @override
  String couldNotSavePhoto(String error) {
    return 'ఫోటోను సేవ్ చేయడం సాధ్యపడలేదు: $error';
  }

  @override
  String get galleryEmpty =>
      'ఇంకా ఫోటో సెట్‌లు లేవు.\nప్రారంభించడానికి కొత్త ఉత్పత్తిని ప్రారంభించండి.';

  @override
  String get galleryEmptyFiltered => 'ఈ వర్గంలో ఇంకా ఏదీ లేదు.';

  @override
  String get showAll => 'అన్నీ చూపించు';

  @override
  String get nextPill => 'తదుపరి';

  @override
  String get templateOverline => 'టెంప్లేట్';

  @override
  String get proTipGoodLight =>
      'ప్రో-చిట్కా: ఉత్పత్తి షాట్‌ల కోసం సహజ కాంతి ఇప్పుడు ఉత్తమం.';

  @override
  String get chipLight => 'కాంతి';

  @override
  String get chipDistance => 'దూరం';

  @override
  String get chipCentre => 'కేంద్రం';

  @override
  String get chipEmDash => '—';

  @override
  String get readingTheFrame => 'ఫ్రేమ్‌ని చదువుతోంది...';

  @override
  String fillFrameWith(String slot) {
    return 'ఫ్రేమ్‌ను $slotతో పూరించండి';
  }

  @override
  String promptNoProduct(String product) {
    return 'వీక్షణలో $product ఉంచండి';
  }

  @override
  String promptMoveIntoFrame(String product) {
    return 'ఫ్రేమ్‌లోకి $productని తరలించండి';
  }

  @override
  String promptKeepInsideFrame(String product) {
    return 'ఫ్రేమ్ లోపల $productని ఉంచండి';
  }

  @override
  String get promptAlignHorizontal =>
      'క్షితిజ సమాంతర గైడ్‌లతో మడతలను వరుసలో ఉంచండి';

  @override
  String get promptAlignDiagonal =>
      'ఫాబ్రిక్ వికర్ణ మార్గదర్శకాలను అనుసరించనివ్వండి';

  @override
  String get promptHoldSteady => 'ఫోన్‌ని స్థిరంగా పట్టుకోండి';

  @override
  String get promptMoveCloser => 'దగ్గరగా తరలించు';

  @override
  String get promptMoveFurther => 'విషయం నుండి మరింత ముందుకు వెళ్లండి';

  @override
  String promptCenterSubject(String product) {
    return '$product మధ్యలో';
  }

  @override
  String get promptKeepTextureCentre => 'ఆకృతిని మధ్యలో ఉంచండి';

  @override
  String get promptKeepBorderInside => 'ఫ్రేమ్ లోపల సరిహద్దు ఉంచండి';

  @override
  String get promptKeepFoldsVisible => 'మడతలు కనిపించేలా ఉంచండి';

  @override
  String get promptBacklight => 'బ్యాక్‌లైట్ కనుగొనబడింది';

  @override
  String get promptTooDark =>
      'చాలా చీకటిగా ఉంది - కిటికీ దగ్గర లేదా బయటికి వెళ్లండి';

  @override
  String get promptLowLight =>
      'వెలుతురు తక్కువగా ఉంది - కిటికీ దగ్గరికి తరలించండి';

  @override
  String get promptTooBright => 'చాలా ప్రకాశవంతంగా - ఓపెన్ షేడ్‌లోకి వెళ్లండి';

  @override
  String get promptTiltPhone => 'యాంగిల్ గైడ్‌తో సరిపోలడానికి ఫోన్‌ను వంచండి';

  @override
  String get promptReady => 'పట్టుకోవడానికి సిద్ధంగా ఉంది';

  @override
  String get lightTooDark => 'Too dark';

  @override
  String get lightLow => 'తక్కువ';

  @override
  String get lightOk => 'సరే';

  @override
  String get lightBright => 'ప్రకాశవంతమైన';

  @override
  String get distanceMoveCloser => 'దగ్గరగా తరలించు';

  @override
  String get distanceOk => 'సరే';

  @override
  String get distanceMoveBack => 'వెనక్కి తరలించు';

  @override
  String get centreMoveIn => 'లోపలికి వెళ్లు';

  @override
  String get centreOk => 'సరే';

  @override
  String get advisoryGoodHeadline => 'ప్రస్తుతం మంచి వెలుతురు';

  @override
  String get advisoryGoodDetail =>
      'సహజ కాంతి స్పష్టమైన, నిజమైన రంగులకు తగినంత మృదువైనది.';

  @override
  String get advisoryOverheadHeadline => 'ఓవర్ హెడ్ సూర్యుడు';

  @override
  String get advisoryOverheadDetail =>
      'సూర్యకాంతి మృదువుగా ఉన్నప్పుడు ఫోటో తీయడానికి ప్రయత్నించండి. ప్రస్తుతం, ఓవర్‌హెడ్ సూర్యుడు మీ సెటప్‌పై తీవ్రమైన నీడలను కలిగించవచ్చు.';

  @override
  String get advisoryDarkHeadline => 'తగినంత పగటి వెలుతురు లేదు';

  @override
  String get advisoryDarkDetail =>
      'ఇప్పుడు తగినంత సహజ కాంతి లేదు. కిటికీ దగ్గర ఉదయపు కాంతి నిజమైన రంగులను ఇస్తుంది.';

  @override
  String get openingTagline =>
      'చేతితో తయారు చేసిన ఉత్పత్తుల కోసం మార్గదర్శక ఫోటోగ్రఫీ';

  @override
  String get openingChipLight => 'కాంతి: బాగుంది';

  @override
  String get openingChipAngle => 'కోణం: బాగుంది';

  @override
  String get openingChipFrame => 'ఫ్రేమ్: సిద్ధంగా ఉంది';

  @override
  String get guidelineG1Title => 'క్లోజ్-అప్ షాట్‌లను ఉపయోగించండి';

  @override
  String get guidelineG1Body =>
      'చక్కటి వివరాలు, అల్లికలు మరియు ఫాబ్రిక్ యొక్క నైపుణ్యాన్ని క్యాప్చర్ చేయండి.';

  @override
  String get guidelineG2Title => 'ఫాబ్రిక్ అంచులను హైలైట్ చేయండి';

  @override
  String get guidelineG2Body =>
      'ఫాబ్రిక్ అంచుని క్యాప్చర్ చేయండి, చిత్రం యొక్క 2/3 భాగాన్ని ఫాబ్రిక్‌తో కవర్ చేయండి.';

  @override
  String get guidelineG3Title => 'వివిధ కోణాల నుండి షూట్ చేయండి';

  @override
  String get guidelineG3Body =>
      'ఉత్పత్తిని దాని రూపకల్పన మరియు నిర్మాణాన్ని హైలైట్ చేయడానికి బహుళ దృక్కోణాల నుండి ప్రదర్శించండి.';

  @override
  String get guidelineG4Title => 'విభిన్న లైటింగ్‌తో ప్రయోగం';

  @override
  String get guidelineG4Body =>
      'ఫాబ్రిక్ యొక్క నిజమైన రంగులు మరియు లోతును బయటకు తీసుకురావడానికి సహజ మరియు కృత్రిమ లైటింగ్, ఇండోర్ మరియు అవుట్‌డోర్ లైటింగ్, ముందు మరియు సైడ్ లైటింగ్‌లను ఉపయోగించండి.';

  @override
  String get guidelineG5Title => 'కాంప్లిమెంటరీ బ్యాక్‌గ్రౌండ్‌లను ఎంచుకోండి';

  @override
  String get guidelineG5Body =>
      'ఫ్యాబ్రిక్ అందాన్ని అధికం చేయకుండా పెంచే బ్యాక్‌గ్రౌండ్‌లను ఉపయోగించండి.';

  @override
  String get guidelineG6Title => 'సహజ క్రీజ్‌లను స్వీకరించండి';

  @override
  String get guidelineG6Body =>
      'మెటీరియల్ గురించి స్పష్టమైన ఆలోచన ఇవ్వడానికి ఫాబ్రిక్‌ను దాని ముడి, ఇస్త్రీ చేయని స్థితిలో ఫోటోగ్రాఫ్ చేయండి.';

  @override
  String get guidelineG7Title => 'బరువు మరియు ప్రవాహాన్ని సూచించండి';

  @override
  String get guidelineG7Body =>
      'ఫాబ్రిక్ దాని బరువు మరియు అనుభూతిని తెలియజేసేందుకు ఎలా కప్పబడి, ముడుచుకుంటుంది మరియు ప్రవహిస్తుందో క్యాప్చర్ చేయండి.';

  @override
  String get guidelineG8Title => 'ఒక కథ చెప్పండి';

  @override
  String get guidelineG8Body =>
      'ఫాబ్రిక్‌ను దాని సాంస్కృతిక వారసత్వం, కళాకారులు మరియు ఉద్దేశించిన వినియోగానికి అనుసంధానించే విధంగా ఫ్రేమ్ షాట్‌లు.';

  @override
  String get categorySaree => 'చీర';

  @override
  String get categoryCushionCover => 'కుషన్ కవర్';

  @override
  String get categoryShawl => 'శాలువా';

  @override
  String get categoryStole => 'దొంగిలించారు';

  @override
  String get categorySarees => 'చీరలు';

  @override
  String get categoryCushionCovers => 'కుషన్ కవర్లు';

  @override
  String get categoryShawls => 'శాలువాలు';

  @override
  String get categoryStoles => 'స్టోల్స్';

  @override
  String get nounSaree => 'చీర';

  @override
  String get nounCushionCover => 'కుషన్ కవర్';

  @override
  String get nounShawl => 'శాలువా';

  @override
  String get nounStole => 'దొంగిలించాడు';

  @override
  String get nounProduct => 'ఉత్పత్తి';

  @override
  String get materialSilk => 'పట్టు';

  @override
  String get materialCotton => 'పత్తి';

  @override
  String get materialWool => 'ఉన్ని';

  @override
  String get materialJute => 'జనపనార';

  @override
  String get materialSilkLower => 'పట్టు';

  @override
  String get materialCottonLower => 'పత్తి';

  @override
  String get materialWoolLower => 'ఉన్ని';

  @override
  String get materialJuteLower => 'జనపనార';

  @override
  String get silkMulberry => 'మల్బరీ';

  @override
  String get silkEri => 'ఏరి';

  @override
  String get silkTasar => 'తాసర్';

  @override
  String get silkMuga => 'ముగా';

  @override
  String get cottonKhadi => 'ఖాదీ';

  @override
  String get cottonMuslin => 'మస్లిన్';

  @override
  String get cottonHandloom => 'చేనేత';

  @override
  String get cottonJamdani => 'జామ్దాని';

  @override
  String get woolPashmina => 'పష్మీనా';

  @override
  String get woolAngora => 'అంగోరా';

  @override
  String get woolMerino => 'మెరినో';

  @override
  String get woolHandspun => 'హ్యాండ్స్పన్';

  @override
  String get juteGolden => 'బంగారు రంగు';

  @override
  String get juteTossa => 'తోసా';

  @override
  String get juteHessian => 'హెస్సియన్';

  @override
  String get juteBlended => 'బ్లెండెడ్';

  @override
  String get shotProcess => 'ప్రక్రియ';

  @override
  String get shotProduct => 'ఉత్పత్తి';

  @override
  String get shotDetail => 'వివరాలు';

  @override
  String get shotLifestyle => 'జీవనశైలి';

  @override
  String get shotPhotography => 'ఫోటోగ్రఫీ';

  @override
  String get shotProcessChecklist => 'తయారీ ప్రక్రియను చూపించు';

  @override
  String get shotProductChecklist => 'అంశం యొక్క పూర్తి షాట్';

  @override
  String get shotDetailChecklist => 'ఆకృతి/నేత యొక్క క్లోజ్-అప్‌లు';

  @override
  String get shotLifestyleChecklist => 'సహజమైన నేపధ్యంలో';

  @override
  String get shotPhotographyChecklist => 'చీర ఫోటోగ్రఫీ టెంప్లేట్లు';

  @override
  String get slotLoomSetup => 'మగ్గం సెటప్';

  @override
  String get slotDyeing => 'అద్దకం';

  @override
  String get slotHeroShot => 'హీరో షాట్';

  @override
  String get slotBorder => 'సరిహద్దు';

  @override
  String get slotWeave => 'నేత';

  @override
  String get slotMotif => 'మూలాంశం';

  @override
  String get slotStyledShot => 'స్టైల్ షాట్';

  @override
  String get templateFullDisplay => 'పూర్తి చీర ప్రదర్శన';

  @override
  String get templateTextureWeave => 'ఆకృతి & నేత';

  @override
  String get templateDrapedLook => 'డ్రాప్డ్ లుక్';

  @override
  String get templateEmbroideryBorder => 'ఎంబ్రాయిడరీ & బోర్డర్ వివరాలు';

  @override
  String get templateFoldedStack => 'మడతపెట్టిన స్టాక్ / చీర స్టాక్';

  @override
  String get templateFullDisplayLower => 'పూర్తి చీర ప్రదర్శన';

  @override
  String get templateTextureWeaveLower => 'ఆకృతి & నేత';

  @override
  String get templateDrapedLookLower => 'కట్టుకున్న లుక్';

  @override
  String get templateEmbroideryBorderLower => 'ఎంబ్రాయిడరీ & సరిహద్దు వివరాలు';

  @override
  String get templateFoldedStackLower => 'మడతపెట్టిన స్టాక్ / చీర స్టాక్';

  @override
  String get templateFullDisplayContent => 'రంగు, నమూనా, మెటీరియల్';

  @override
  String get templateTextureWeaveContent => 'ఆకృతి, మందం, పదార్థం, పారదర్శకత';

  @override
  String get templateDrapedLookContent => 'బలహీనత, షీన్, ఫ్లో, బరువు';

  @override
  String get templateEmbroideryBorderContent => 'ఎంబ్రాయిడరీ, నాణ్యత';

  @override
  String get templateFoldedStackContent => 'మందం, మెటీరియల్ బరువు';

  @override
  String get templateFullDisplayNeeds =>
      'సహజ పగటి కాంతి; తటస్థ లేదా విరుద్ధ నేపథ్యం';

  @override
  String get templateTextureWeaveNeeds => 'ప్రాధాన్యంగా సహజ కాంతి';

  @override
  String get templateDrapedLookNeeds =>
      'హ్యాంగర్, వెదురు లేదా బొమ్మ; వైపు లైటింగ్';

  @override
  String get templateEmbroideryBorderNeeds =>
      'సైడ్ లైటింగ్; కాంట్రాస్ట్ నేపథ్యం';

  @override
  String get templateFoldedStackNeeds => 'సైడ్ లైటింగ్';

  @override
  String get templateFullDisplayPlacement =>
      'చీర చదునుగా లేదా ఉపరితలంపై కప్పబడి ఉంటుంది';

  @override
  String get templateTextureWeavePlacement =>
      'చీరలో బాగా వెలుతురు ఉన్న విభాగం, సహజ కాంతిలో ఉండటం మంచిది';

  @override
  String get templateDrapedLookPlacement => 'హ్యాంగర్, వెదురు లేదా బొమ్మ';

  @override
  String get templateEmbroideryBorderPlacement =>
      'చీర అంచు లేదా ఎంబ్రాయిడరీ విభాగం యొక్క క్లోజప్';

  @override
  String get templateFoldedStackPlacement =>
      'కనిపించే మడతలతో చక్కగా పేర్చబడి ఉంటుంది';

  @override
  String get templateFullDisplayOverlay =>
      'ఎగువన మూడవ అంచుతో ఎగువ అంచుని లైన్ చేయండి';

  @override
  String get templateTextureWeaveOverlay => 'ఆకృతిని మధ్యలో ఉంచండి';

  @override
  String get templateDrapedLookOverlay => 'మడతలు వికర్ణాన్ని అనుసరించనివ్వండి';

  @override
  String get templateEmbroideryBorderOverlay =>
      'ఎంబ్రాయిడరీని ఫ్రేమ్ లోపల ఉంచండి';

  @override
  String get templateFoldedStackOverlay =>
      'క్షితిజ సమాంతర రేఖలకు సమాంతరంగా మడతలు ఉంచండి';

  @override
  String get templateTextureWeaveLighting =>
      'మృదువైన కాంతిని ఉపయోగించండి. కఠినమైన ప్రతిబింబాలను నివారించండి.';

  @override
  String get templateCushionFullCover => 'పూర్తి కవర్ డిస్ప్లే';

  @override
  String get templateCushionTextureWeave => 'ఆకృతి & నేత';

  @override
  String get templateCushionStackedPair => 'పేర్చబడిన జత / మందం';

  @override
  String get templateCushionCornerStitching => 'కార్నర్ & కుట్టడం';

  @override
  String get templateCushionInUse => 'సీటింగ్‌లో ఉపయోగంలో ఉంది';

  @override
  String get templateCushionFullCoverLower => 'పూర్తి కవర్ ప్రదర్శన';

  @override
  String get templateCushionTextureWeaveLower => 'ఆకృతి & నేత';

  @override
  String get templateCushionStackedPairLower => 'పేర్చబడిన జత / మందం';

  @override
  String get templateCushionCornerStitchingLower => 'మూలలో & కుట్టడం';

  @override
  String get templateCushionInUseLower => 'సీటింగ్‌లో ఉపయోగంలో ఉంది';

  @override
  String get templateCushionFullCoverContent => 'రంగు, నమూనా, మెటీరియల్';

  @override
  String get templateCushionTextureWeaveContent => 'ఆకృతి, మందం, పదార్థం';

  @override
  String get templateCushionStackedPairContent => 'మందం, పదార్థం, ఆకృతి';

  @override
  String get templateCushionCornerStitchingContent =>
      'నాణ్యత, ఆకృతి, ఎంబ్రాయిడరీ';

  @override
  String get templateCushionInUseContent => 'రంగు, నమూనా, నాణ్యత';

  @override
  String get templateCushionFullCoverNeeds => 'సహజ పగటి కాంతి; సాదా ఉపరితలం';

  @override
  String get templateCushionTextureWeaveNeeds => 'ప్రాధాన్యంగా సహజ కాంతి';

  @override
  String get templateCushionStackedPairNeeds => 'సైడ్ లైటింగ్; సరిపోలే జత';

  @override
  String get templateCushionCornerStitchingNeeds => 'సైడ్ లైటింగ్';

  @override
  String get templateCushionInUseNeeds => 'ఒక కుర్చీ, సోఫా లేదా మంచం';

  @override
  String get templateCushionFullCoverPlacement => 'సాదా ఉపరితలంపై చదునైన కవర్';

  @override
  String get templateCushionTextureWeavePlacement =>
      'కవర్ యొక్క బాగా వెలిగించిన విభాగం';

  @override
  String get templateCushionStackedPairPlacement =>
      'కెమెరాకు ఎదురుగా అంచులతో పేర్చబడిన రెండు కవర్లు';

  @override
  String get templateCushionCornerStitchingPlacement =>
      'కుట్టిన మూలలో క్లోజ్-అప్';

  @override
  String get templateCushionInUsePlacement =>
      'కెమెరాకు ఎదురుగా ఉన్న సీటుపై కవర్';

  @override
  String get templateCushionFullCoverOverlay =>
      'గ్రిడ్ వెంట అంచులను నేరుగా ఉంచండి';

  @override
  String get templateCushionTextureWeaveOverlay => 'ఆకృతిని మధ్యలో ఉంచండి';

  @override
  String get templateCushionStackedPairOverlay =>
      'క్షితిజ సమాంతర రేఖలకు సమాంతరంగా మడతలు ఉంచండి';

  @override
  String get templateCushionCornerStitchingOverlay =>
      'ఫ్రేమ్ లోపల కుట్టు ఉంచండి';

  @override
  String get templateCushionInUseOverlay => 'కవర్‌ను ఫ్రేమ్‌లో ఉంచండి';

  @override
  String get templateShawlFullDesign => 'పూర్తి డిజైన్ డిస్ప్లే';

  @override
  String get templateShawlTextureWeave => 'ఆకృతి & నేత';

  @override
  String get templateShawlDrapedLook => 'డ్రాప్డ్ లుక్';

  @override
  String get templateShawlBorderCorner => 'బోర్డర్ & కార్నర్';

  @override
  String get templateShawlFoldedStack => 'మడతపెట్టిన స్టాక్';

  @override
  String get templateShawlFullDesignLower => 'పూర్తి డిజైన్ ప్రదర్శన';

  @override
  String get templateShawlTextureWeaveLower => 'ఆకృతి & నేత';

  @override
  String get templateShawlDrapedLookLower => 'కట్టుకున్న లుక్';

  @override
  String get templateShawlBorderCornerLower => 'సరిహద్దు & మూల';

  @override
  String get templateShawlFoldedStackLower => 'మడతపెట్టిన స్టాక్';

  @override
  String get templateShawlFullDesignContent => 'నమూనా, రంగు, పారదర్శకత';

  @override
  String get templateShawlTextureWeaveContent => 'ఆకృతి, మందం, పదార్థం';

  @override
  String get templateShawlDrapedLookContent => 'చురుకుదనం, మెటీరియల్, నమూనా';

  @override
  String get templateShawlBorderCornerContent => 'ఆకృతి, నాణ్యత, ఎంబ్రాయిడరీ';

  @override
  String get templateShawlFoldedStackContent => 'మందం, పదార్థం';

  @override
  String get templateShawlFullDesignNeeds =>
      'ఒక లైన్, వెదురు స్తంభం లేదా గోడను పిన్ చేయడానికి';

  @override
  String get templateShawlTextureWeaveNeeds => 'ప్రాధాన్యంగా సహజ కాంతి';

  @override
  String get templateShawlDrapedLookNeeds => 'శాలువా ధరించడానికి ఎవరైనా';

  @override
  String get templateShawlBorderCornerNeeds => 'సైడ్ లైటింగ్';

  @override
  String get templateShawlFoldedStackNeeds => 'సైడ్ లైటింగ్';

  @override
  String get templateShawlFullDesignPlacement =>
      'శాలువా కుంగిపోకుండా వేలాడదీయబడింది లేదా పిన్ చేయబడింది';

  @override
  String get templateShawlTextureWeavePlacement =>
      'శాలువా యొక్క బాగా వెలిగించిన విభాగం';

  @override
  String get templateShawlDrapedLookPlacement =>
      'ఒక భుజంపై శాలువ, సహజంగా పడిపోతుంది';

  @override
  String get templateShawlBorderCornerPlacement =>
      'మూల మరియు సరిహద్దు యొక్క క్లోజ్-అప్';

  @override
  String get templateShawlFoldedStackPlacement =>
      'కనిపించే మడతలతో చక్కగా పేర్చబడి ఉంటుంది';

  @override
  String get templateShawlFullDesignOverlay =>
      'ఎగువ మూడవ భాగంతో సరిహద్దును వరుసలో ఉంచండి';

  @override
  String get templateShawlTextureWeaveOverlay => 'ఆకృతిని మధ్యలో ఉంచండి';

  @override
  String get templateShawlDrapedLookOverlay =>
      'మడతలు వికర్ణాన్ని అనుసరించనివ్వండి';

  @override
  String get templateShawlBorderCornerOverlay => 'ఫ్రేమ్ లోపల సరిహద్దు ఉంచండి';

  @override
  String get templateShawlFoldedStackOverlay =>
      'క్షితిజ సమాంతర రేఖలకు సమాంతరంగా మడతలు ఉంచండి';

  @override
  String get templateStoleFullLength => 'పూర్తి నిడివి ప్రదర్శన';

  @override
  String get templateStoleTextureWeave => 'ఆకృతి & నేత';

  @override
  String get templateStoleNeckWrap => 'అరిగిపోయిన మెడ చుట్టు';

  @override
  String get templateStoleSoftnessKnot => 'మృదుత్వం / ముడి';

  @override
  String get templateStoleEdgeThickness => 'అంచు & మందం';

  @override
  String get templateStoleFullLengthLower => 'పూర్తి నిడివి ప్రదర్శన';

  @override
  String get templateStoleTextureWeaveLower => 'ఆకృతి & నేత';

  @override
  String get templateStoleNeckWrapLower => 'అరిగిపోయిన మెడ చుట్టు';

  @override
  String get templateStoleSoftnessKnotLower => 'మృదుత్వం / ముడి';

  @override
  String get templateStoleEdgeThicknessLower => 'అంచు & మందం';

  @override
  String get templateStoleFullLengthContent => 'నమూనా, రంగు, మెటీరియల్';

  @override
  String get templateStoleTextureWeaveContent => 'ఆకృతి, మందం, పదార్థం';

  @override
  String get templateStoleNeckWrapContent => 'చురుకుదనం, రంగు, నమూనా';

  @override
  String get templateStoleSoftnessKnotContent => 'చురుకుదనం, ఆకృతి, మెటీరియల్';

  @override
  String get templateStoleEdgeThicknessContent => 'మందం, ఆకృతి, మెటీరియల్';

  @override
  String get templateStoleFullLengthNeeds => 'సహజ పగటి కాంతి; సాదా ఉపరితలం';

  @override
  String get templateStoleTextureWeaveNeeds => 'ప్రాధాన్యంగా సహజ కాంతి';

  @override
  String get templateStoleNeckWrapNeeds => 'దొంగిలించిన ధరించడానికి ఎవరైనా';

  @override
  String get templateStoleSoftnessKnotNeeds => 'మృదువైన వైపు కాంతి';

  @override
  String get templateStoleEdgeThicknessNeeds => 'మృదువైన వైపు కాంతి';

  @override
  String get templateStoleFullLengthPlacement =>
      'స్టోల్ స్ప్రెడ్ కాబట్టి దాని పూర్తి పొడవు కనిపిస్తుంది';

  @override
  String get templateStoleTextureWeavePlacement =>
      'దొంగిలించిన బాగా వెలిగించిన విభాగం';

  @override
  String get templateStoleNeckWrapPlacement =>
      'రెండు చివర్లు కనిపించేలా మెడ చుట్టూ ఒకసారి చుట్టాడు';

  @override
  String get templateStoleSoftnessKnotPlacement =>
      'మధ్యలో ఒక వదులుగా ఉన్న ముడి';

  @override
  String get templateStoleEdgeThicknessPlacement =>
      'స్టోల్‌ను కాయిల్‌లోకి వదులుగా చుట్టారు';

  @override
  String get templateStoleFullLengthOverlay => 'గ్రిడ్ వెంట స్టోల్ ఉంచండి';

  @override
  String get templateStoleTextureWeaveOverlay => 'ఆకృతిని మధ్యలో ఉంచండి';

  @override
  String get templateStoleNeckWrapOverlay => 'ఫ్రేమ్‌లో ర్యాప్ ఉంచండి';

  @override
  String get templateStoleSoftnessKnotOverlay => 'ముడిని మధ్యలో ఉంచండి';

  @override
  String get templateStoleEdgeThicknessOverlay => 'మధ్యలో కాయిల్ ఉంచండి';

  @override
  String get presetSareePalluDrapeName => 'పల్లు డ్రెప్ (హ్యాంగర్)';

  @override
  String get presetSareeBoxFoldName => 'పెట్టె / ఫ్లాట్ మడత';

  @override
  String get presetSareeWornDrapeName => 'అరిగిన వస్త్రం (నమూనా)';

  @override
  String get presetSareeRollDisplayName => 'రోల్ ప్రదర్శన';

  @override
  String get presetCushionFlatLayName => 'ఫ్లాట్ లే';

  @override
  String get presetCushionStackedPairName => 'పేర్చబడిన జత';

  @override
  String get presetCushionProppedName => 'సీటింగ్‌పై ఆసరాగా నిలిచారు';

  @override
  String get presetCushionCornerTuckName => 'కార్నర్ టక్ క్లోజప్';

  @override
  String get presetShawlDrapedShoulderName => 'భుజం మీద వేసుకుంది';

  @override
  String get presetShawlFoldedStackName => 'మడతపెట్టిన స్టాక్';

  @override
  String get presetShawlHungFlatName => 'వేలాడదీసిన / పిన్ చేయబడిన ఫ్లాట్';

  @override
  String get presetShawlCornerTuckName => 'కార్నర్ టక్ క్లోజప్';

  @override
  String get presetStoleNeckWrapName => 'మెడ చుట్టు (ధరించిన)';

  @override
  String get presetStoleFlatSpreadName => 'ఫ్లాట్ స్ప్రెడ్';

  @override
  String get presetStoleLooseKnotName => 'వదులైన ముడి';

  @override
  String get presetStoleRolledCoilName => 'చుట్టిన కాయిల్';

  @override
  String get presetSareePalluDrapePurpose =>
      'బలహీనత, మెరుపు, ప్రవాహం మరియు బరువును చూపుతుంది.';

  @override
  String get presetSareeBoxFoldPurpose =>
      'మందం మరియు పదార్థ బరువును చూపుతుంది.';

  @override
  String get presetSareeWornDrapePurpose =>
      'ధరించినప్పుడు రంగు, నమూనా మరియు మెటీరియల్‌ని చూపుతుంది.';

  @override
  String get presetSareeRollDisplayPurpose =>
      'కాంపాక్ట్ రోల్‌లో రంగు, నమూనా మరియు మెటీరియల్‌ని చూపుతుంది.';

  @override
  String get presetCushionFlatLayPurpose =>
      'వక్రీకరణ లేకుండా పూర్తి నమూనా మరియు రంగును చూపించు.';

  @override
  String get presetCushionStackedPairPurpose =>
      'మందం మరియు ఒక జత కలిసి ఎలా కనిపిస్తుందో చూపించు.';

  @override
  String get presetCushionProppedPurpose =>
      'ఉపయోగంలో ఉన్న కవర్‌ను వాస్తవ స్థాయిలో చూపండి.';

  @override
  String get presetCushionCornerTuckPurpose =>
      'మూలలో కుట్టు నాణ్యత మరియు ముగింపును చూపించు.';

  @override
  String get presetShawlDrapedShoulderPurpose =>
      'డ్రేప్, బరువు మరియు ధరించినప్పుడు అది ఎలా కూర్చుంటుందో చూపించండి.';

  @override
  String get presetShawlFoldedStackPurpose =>
      'మందం మరియు పదార్థ బరువును చూపించు.';

  @override
  String get presetShawlHungFlatPurpose =>
      'పూర్తి డిజైన్, రంగు మరియు అంచుని ఒకేసారి చూపండి.';

  @override
  String get presetShawlCornerTuckPurpose =>
      'నేత, సరిహద్దు వివరాలు మరియు నైపుణ్యాన్ని చూపించు.';

  @override
  String get presetStoleNeckWrapPurpose =>
      'స్కేల్ మరియు స్టోల్ ధరించినప్పుడు ఎలా కూర్చుంటుందో చూపించు.';

  @override
  String get presetStoleFlatSpreadPurpose =>
      'పూర్తి పొడవు, నమూనా మరియు రెండు అంచులను చూపండి.';

  @override
  String get presetStoleLooseKnotPurpose =>
      'ఫాబ్రిక్ ఎంత మృదువుగా ఉందో మరియు ఎంత తేలికగా ముడిపడుతుందో చూపించండి.';

  @override
  String get presetStoleRolledCoilPurpose =>
      'నేత యొక్క అంచు, మందం మరియు ముగింపును చూపించు.';

  @override
  String get presetSareePalluDrapeContent => 'బలహీనత, షీన్, ఫ్లో, బరువు';

  @override
  String get presetSareeBoxFoldContent => 'మందం, మెటీరియల్ బరువు';

  @override
  String get presetSareeWornDrapeContent => 'రంగు, నమూనా, మెటీరియల్';

  @override
  String get presetSareeRollDisplayContent => 'రంగు, నమూనా, మెటీరియల్';

  @override
  String get presetSareePalluDrapeNeeds =>
      'హ్యాంగర్, వెదురు లేదా బొమ్మ; వైపు లైటింగ్';

  @override
  String get presetSareeBoxFoldNeeds => 'సైడ్ లైటింగ్';

  @override
  String get presetSareeWornDrapeNeeds =>
      'చీర కట్టుకోవడానికి ఎవరైనా; సహజ పగటి; తటస్థ లేదా విరుద్ధ నేపథ్యం';

  @override
  String get presetSareeRollDisplayNeeds =>
      'సహజ పగటి కాంతి; తటస్థ లేదా విరుద్ధ నేపథ్యం';

  @override
  String get presetSareePalluDrapeLower => 'పల్లు వస్త్రం (హ్యాంగర్)';

  @override
  String get presetSareeBoxFoldLower => 'పెట్టె / ఫ్లాట్ మడత';

  @override
  String get presetSareeWornDrapeLower => 'ధరించిన వస్త్రం (నమూనా)';

  @override
  String get presetSareeRollDisplayLower => 'రోల్ ప్రదర్శన';

  @override
  String get presetCushionFlatLayLower => 'ఫ్లాట్ లే';

  @override
  String get presetCushionStackedPairLower => 'పేర్చబడిన జత';

  @override
  String get presetCushionProppedLower => 'సీటింగ్ మీద ఆసరా';

  @override
  String get presetCushionCornerTuckLower => 'మూలలో టక్ క్లోజప్';

  @override
  String get presetShawlDrapedShoulderLower => 'భుజం మీద వేసుకున్నాడు';

  @override
  String get presetShawlFoldedStackLower => 'మడతపెట్టిన స్టాక్';

  @override
  String get presetShawlHungFlatLower => 'వేలాడదీసిన / పిన్ చేయబడిన ఫ్లాట్';

  @override
  String get presetShawlCornerTuckLower => 'మూలలో టక్ క్లోజప్';

  @override
  String get presetStoleNeckWrapLower => 'మెడ చుట్టు (ధరించిన)';

  @override
  String get presetStoleFlatSpreadLower => 'ఫ్లాట్ స్ప్రెడ్';

  @override
  String get presetStoleLooseKnotLower => 'వదులైన ముడి';

  @override
  String get presetStoleRolledCoilLower => 'చుట్టిన కాయిల్';

  @override
  String get shotProcessLower => 'ప్రక్రియ';

  @override
  String get shotProductLower => 'ఉత్పత్తి';

  @override
  String get shotDetailLower => 'వివరాలు';

  @override
  String get shotLifestyleLower => 'జీవనశైలి';

  @override
  String get shotPhotographyLower => 'ఫోటోగ్రఫీ';

  @override
  String get categorySareeLower => 'చీర';

  @override
  String get categoryCushionCoverLower => 'కుషన్ కవర్';

  @override
  String get categoryShawlLower => 'శాలువా';

  @override
  String get categoryStoleLower => 'దొంగిలించాడు';

  @override
  String get propertyColour => 'రంగు';

  @override
  String get propertyMaterial => 'మెటీరియల్';

  @override
  String get propertyQuality => 'నాణ్యత';

  @override
  String get propertyFlimsiness => 'చురుకుదనం';

  @override
  String get propertyTexture => 'ఆకృతి';

  @override
  String get propertyThickness => 'మందం';

  @override
  String get propertyTransparency => 'పారదర్శకత';

  @override
  String get propertyPattern => 'నమూనా';

  @override
  String get propertySheen => 'షీన్ / గ్లోస్';

  @override
  String get propertyEmbroidery => 'ఎంబ్రాయిడరీ';

  @override
  String get angleEyeLevel => 'కంటి స్థాయి';

  @override
  String get angleEyeLevelHint =>
      'ఫోన్‌ను ఉత్పత్తి ఎత్తులో నేరుగా ఆన్‌లో పట్టుకోండి.';

  @override
  String get angleOverhead => 'Overhead (flat lay)';

  @override
  String get angleOverheadHint =>
      'ఉత్పత్తిపై నిలబడి, ఫోన్‌ను నేరుగా క్రిందికి చూపండి.';

  @override
  String get angleLow => 'తక్కువ కోణం';

  @override
  String get angleLowHint =>
      'ఉత్పత్తికి దిగువన ఫోన్‌ను క్రిందికి దించి, కొద్దిగా పైకి వంచండి.';

  @override
  String get angleMacro => 'మాక్రో క్లోజప్';

  @override
  String get angleMacroHint =>
      'నేత ఫ్రేమ్‌ను నింపే వరకు దగ్గరగా తరలించండి, ఆపై ఫోకస్ చేయడానికి నొక్కండి.';

  @override
  String get lightingSoftWindow => 'మృదువైన విండో లైట్';

  @override
  String get lightingSoftWindowHint =>
      'ఉత్పత్తిని బల్బ్ కింద కాకుండా కిటికీ పక్కన ఉంచండి.';

  @override
  String get lightingDiffused => 'విస్తరించిన పగలు';

  @override
  String get lightingDiffusedHint =>
      'బహిరంగ నీడలో, ఒక వైపు నుండి కాంతి వచ్చేలా ఆరుబయట షూట్ చేయండి.';

  @override
  String get lightingAvoidMidday => 'కఠినమైన మధ్యాహ్న ఎండను నివారించండి';

  @override
  String get lightingAvoidMiddayHint =>
      '3 PM తర్వాత వరకు వేచి ఉండండి - ఓవర్ హెడ్ సూర్యుడు రంగును కడుగుతుంది.';

  @override
  String get lightingBacklight => 'షీర్ ఫ్యాబ్రిక్స్ కోసం బ్యాక్‌లైట్';

  @override
  String get lightingBacklightHint =>
      'ఫాబ్రిక్ వెనుక లైట్ ఉంచండి, అది ఎంత వరకు వెళుతుందో చూపిస్తుంది.';

  @override
  String get compositionRuleOfThirds => 'మూడింట నియమం';

  @override
  String get compositionRuleOfThirdsHint =>
      'గ్రిడ్‌లోని ఎగువ మూడవ భాగంతో సరిహద్దును వరుసలో ఉంచండి.';

  @override
  String get compositionCentered => 'కేంద్రీకృత ఉత్పత్తి';

  @override
  String get compositionCenteredHint =>
      'ఉత్పత్తిని గ్రిడ్ మధ్య పెట్టెలో ఉంచండి.';

  @override
  String get compositionNegativeSpace => 'మడతల చుట్టూ ప్రతికూల స్థలం';

  @override
  String get compositionNegativeSpaceHint =>
      'మడతల చుట్టూ ఖాళీ స్థలాన్ని వదిలివేయండి, తద్వారా అవి స్పష్టంగా చదవబడతాయి.';

  @override
  String get compositionLeadingLines => 'ప్రముఖ ఫాబ్రిక్ లైన్లు';

  @override
  String get compositionLeadingLinesHint =>
      'వికర్ణ మార్గదర్శకాల వెంట మడతలు వేయండి.';

  @override
  String get compositionCentreFocus => 'కేంద్రం దృష్టి';

  @override
  String get compositionCentreFocusHint => 'ఫ్రేమ్ మధ్యలో ఆకృతిని ఉంచండి.';

  @override
  String get compositionDetailFrame => 'వివరాల ఫ్రేమ్';

  @override
  String get compositionDetailFrameHint =>
      'హైలైట్ చేసిన ఫ్రేమ్ లోపల ఎంబ్రాయిడరీని ఉంచండి.';

  @override
  String get accountBackup => 'ఖాతా & బ్యాకప్';

  @override
  String get accountBackupSubtitle =>
      'ఆన్‌లైన్‌లో పురోగతిని సేవ్ చేయడానికి వినియోగదారు పేరు మరియు పాస్‌వర్డ్‌ను సృష్టించండి.';

  @override
  String get cloudBackupNotConfigured => 'క్లౌడ్ బ్యాకప్ కాన్ఫిగర్ చేయబడలేదు';

  @override
  String get cloudBackupNotConfiguredBody =>
      'ఈ బిల్డ్ క్లౌడ్ కనెక్షన్ లేదు. ప్రోగ్రెస్ ఈ ఫోన్‌లో మాత్రమే ఉంటుంది.';

  @override
  String get signedInAs => 'గా సైన్ ఇన్ చేసారు';

  @override
  String get artisanFallback => 'కళాకారుడు';

  @override
  String get syncNow => 'ఇప్పుడు సమకాలీకరించండి';

  @override
  String get signOut => 'సైన్ అవుట్ చేయండి';

  @override
  String get createAccountPrompt =>
      'మీ పనిని ఆన్‌లైన్‌లో సేవ్ చేయడానికి ఖాతాను సృష్టించండి.';

  @override
  String get signInPrompt =>
      'మీరు సేవ్ చేసిన ఉత్పత్తులు మరియు ఫోటోలను లోడ్ చేయడానికి సైన్ ఇన్ చేయండి.';

  @override
  String get username => 'వినియోగదారు పేరు';

  @override
  String get usernameHint => 'ఉదా ప్రియ_నేత';

  @override
  String get password => 'పాస్వర్డ్';

  @override
  String get createAccount => 'ఖాతాను సృష్టించండి';

  @override
  String get signIn => 'సైన్ ఇన్ చేయండి';

  @override
  String get alreadyHaveAccount => 'ఇప్పటికే ఖాతా ఉందా? సైన్ ఇన్ చేయండి';

  @override
  String get needAccount => 'ఖాతా కావాలా? ఒకదాన్ని సృష్టించండి';

  @override
  String get accountCreated =>
      'ఖాతా సృష్టించబడింది. మీ పురోగతి ఆన్‌లైన్‌లో సమకాలీకరించబడుతుంది.';

  @override
  String get signedInSuccess =>
      'సైన్ ఇన్ చేసారు. మీరు సేవ్ చేసిన పని ఈ ఫోన్‌లో ఉంది.';

  @override
  String get signedOutSuccess =>
      'సైన్ అవుట్ చేసారు. స్థానిక ఫోటోలు ఈ ఫోన్‌లో ఉంటాయి.';

  @override
  String get syncOffline =>
      'ఇంటర్నెట్ లేదు - మీరు తిరిగి ఆన్‌లైన్‌లో ఉన్నప్పుడు సమకాలీకరించండి.';

  @override
  String syncDone(int sets, int shots) {
    return 'సమకాలీకరించబడింది: $sets ఉత్పత్తులు అప్‌లోడ్ చేయబడ్డాయి, $shots ఫోటోలు అప్‌లోడ్ చేయబడ్డాయి.';
  }

  @override
  String get syncUpToDate => 'ప్రతిదీ ఇప్పటికే తాజాగా ఉంది.';

  @override
  String syncFailed(String error) {
    return 'సమకాలీకరణ విఫలమైంది: $error';
  }

  @override
  String get yourProgress => 'మీ పురోగతి';

  @override
  String get productsStarted => 'ఉత్పత్తులు ప్రారంభమయ్యాయి';

  @override
  String get finishedSets => 'పూర్తయిన సెట్లు';

  @override
  String get inProgressSets => 'పురోగతిలో ఉంది';

  @override
  String get photosCaptured => 'ఫోటోలు తీయబడ్డాయి';

  @override
  String get usernameTooShort =>
      'వినియోగదారు పేరు తప్పనిసరిగా కనీసం 3 అక్షరాలు లేదా సంఖ్యలు ఉండాలి.';

  @override
  String get usernameTooLong =>
      'వినియోగదారు పేరు తప్పనిసరిగా 32 అక్షరాలు లేదా అంతకంటే తక్కువ ఉండాలి.';

  @override
  String get passwordTooShort =>
      'పాస్‌వర్డ్ తప్పనిసరిగా కనీసం 6 అక్షరాలు ఉండాలి.';

  @override
  String get fullScreen => 'పూర్తి స్క్రీన్';

  @override
  String get tapToSkip => 'దాటవేయడానికి నొక్కండి';

  @override
  String get cameraPermissionNeeded =>
      'ఫోటోలు తీయడానికి కెమెరా అనుమతి అవసరం.\nదయచేసి సెట్టింగ్‌లలో కెమెరా యాక్సెస్‌ని అనుమతించండి.';

  @override
  String get cameraUnavailable => 'కెమెరా అందుబాటులో లేదు.';

  @override
  String get noCameraFound => 'ఈ పరికరంలో కెమెరా ఏదీ కనుగొనబడలేదు.';

  @override
  String get accountCreateFailed =>
      'మీ ఖాతాను సృష్టించడం సాధ్యపడలేదు. మళ్లీ ప్రయత్నించండి.';

  @override
  String get enterValidUsername =>
      'చెల్లుబాటు అయ్యే వినియోగదారు పేరును నమోదు చేయండి.';

  @override
  String get monthJan => 'జనవరి';

  @override
  String get monthFeb => 'ఫిబ్రవరి';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'ఏప్రిల్';

  @override
  String get monthMay => 'మే';

  @override
  String get monthJun => 'జూన్';

  @override
  String get monthJul => 'జూలై';

  @override
  String get monthAug => 'ఆగస్ట్';

  @override
  String get monthSep => 'సెప్టెంబరు';

  @override
  String get monthOct => 'అక్టోబర్';

  @override
  String get monthNov => 'నవంబర్';

  @override
  String get monthDec => 'డిసెంబర్';

  @override
  String get presetCushionFlatLayNeeds => 'చిందరవందరగా ఉండే సాదా ఉపరితలం';

  @override
  String get presetCushionStackedPairNeeds => 'రెండు కవర్లు; వైపు కాంతి';

  @override
  String get presetCushionProppedNeeds => 'ఒక కుర్చీ, సోఫా లేదా మంచం';

  @override
  String get presetCushionCornerTuckNeeds => 'క్లోజ్-అప్ లైట్';

  @override
  String get presetShawlDrapedShoulderNeeds => 'శాలువా ధరించడానికి ఎవరైనా';

  @override
  String get presetShawlFoldedStackNeeds => 'సైడ్ లైటింగ్';

  @override
  String get presetShawlHungFlatNeeds =>
      'ఒక లైన్, వెదురు స్తంభం లేదా గోడను పిన్ చేయడానికి';

  @override
  String get presetShawlCornerTuckNeeds => 'క్లోజ్-అప్ లైట్';

  @override
  String get presetStoleNeckWrapNeeds => 'దొంగిలించిన ధరించడానికి ఎవరైనా';

  @override
  String get presetStoleFlatSpreadNeeds => 'సాదా ఉపరితలం; ఓవర్ హెడ్ వీక్షణ';

  @override
  String get presetStoleLooseKnotNeeds => 'మృదువైన వైపు కాంతి';

  @override
  String get presetStoleRolledCoilNeeds => 'మృదువైన వైపు కాంతి';

  @override
  String get placementSareePalluDrape =>
      'చీరను హ్యాంగర్, వెదురు లేదా బొమ్మ మీద వేయండి, తద్వారా పల్లు స్వేచ్ఛగా పడిపోతుంది.';

  @override
  String get placementSareeBoxFold =>
      'చీరను సమాన పొరలుగా మడిచి, అంచు కనిపించేలా వాటిని పేర్చండి.';

  @override
  String get placementSareeWornDrape =>
      'చీరను వ్యక్తిపై వేయండి, తద్వారా రంగు, నమూనా మరియు అంచు స్పష్టంగా కనిపిస్తాయి.';

  @override
  String get placementSareeRollDisplay =>
      'పల్లు మరియు అంచు కెమెరాకు ఎదురుగా ఉండేలా చీరను చుట్టండి.';

  @override
  String get placementCushionFlatLay =>
      'కవర్‌ను సాదా, చిందరవందరగా ఉండే ఉపరితలంపై ఉంచండి.';

  @override
  String get placementCushionStackedPair =>
      'ఒక కవర్‌ను మరొకదానిపై చక్కగా ఉంచండి.';

  @override
  String get placementCushionPropped =>
      'కుషన్‌ను కుర్చీ లేదా సోఫాపై ఆసరాగా ఉంచండి.';

  @override
  String get placementCushionCornerTuck =>
      'ఒక కుట్టిన మూల మీకు ఎదురుగా ఉండేలా కవర్‌ని తిప్పండి.';

  @override
  String get placementShawlDrapedShoulder =>
      'శాలువను ఒక భుజంపై ఉంచండి, అది పడేలా చేయండి.';

  @override
  String get placementShawlFoldedStack =>
      'శాలువను సరి పొరలుగా మడిచి వాటిని చక్కగా పేర్చండి.';

  @override
  String get placementShawlHungFlat =>
      'రెండు ఎగువ మూలలను పిన్ చేయండి, తద్వారా శాలువ కుంగిపోకుండా వేలాడుతుంది.';

  @override
  String get placementShawlCornerTuck =>
      'నేత యొక్క రెండు వైపులా చూపించడానికి ఒక మూలను వెనుకకు మడవండి.';

  @override
  String get placementStoleNeckWrap =>
      'మెడ చుట్టూ ఒకసారి చుట్టండి, రెండు చివరలను వేలాడదీయండి.';

  @override
  String get placementStoleFlatSpread =>
      'స్టోల్‌ను ఫ్లాట్‌గా విస్తరించండి, తద్వారా దాని పూర్తి పొడవు కనిపిస్తుంది.';

  @override
  String get placementStoleLooseKnot =>
      'మధ్యలో ఒక వదులుగా ముడి వేయండి - గట్టిగా లాగవద్దు.';

  @override
  String get placementStoleRolledCoil =>
      'స్టోల్‌ను ఫ్లాట్ కాయిల్‌లో వదులుగా రోల్ చేయండి.';

  @override
  String get transcriptSareePalluDrape1 =>
      'చీర పతనం స్పష్టంగా కనిపించేలా దాన్ని వేలాడదీయండి.';

  @override
  String get transcriptSareePalluDrape2 =>
      'భుజం ఎత్తులో హ్యాంగర్, వెదురు స్తంభం లేదా బొమ్మను ఉపయోగించండి.';

  @override
  String get transcriptSareePalluDrape3 =>
      'పల్లును స్వేచ్ఛగా వేలాడదీయండి - దానిని నేరుగా లాగవద్దు.';

  @override
  String get transcriptSareePalluDrape4 =>
      'మడతలు మీ స్క్రీన్‌పై వికర్ణ రేఖలను అనుసరించనివ్వండి.';

  @override
  String get transcriptSareePalluDrape5 =>
      'ఒక కాంతి మూలాన్ని ప్రక్కకు ఉంచండి, తద్వారా షీన్ కనిపిస్తుంది.';

  @override
  String get transcriptSareeBoxFold1 =>
      'పొరలు కనిపించేలా చీరను చక్కని స్టాక్‌లో మడవండి.';

  @override
  String get transcriptSareeBoxFold2 =>
      'మడతపెట్టిన అంచుని కెమెరాకు ఎదురుగా ఉంచండి - ఆ అంచు మందాన్ని చూపుతుంది.';

  @override
  String get transcriptSareeBoxFold3 =>
      'క్షితిజ సమాంతర గైడ్‌లతో మడతలను వరుసలో ఉంచండి.';

  @override
  String get transcriptSareeBoxFold4 =>
      'ప్రతి పొర లోతును కలిగి ఉండేలా వైపు నుండి కాంతిని ఉపయోగించండి.';

  @override
  String get transcriptSareeWornDrape1 =>
      'ధరించిన షాట్ పూర్తి చీరను చూపుతుంది - రంగు, నమూనా మరియు మెటీరియల్.';

  @override
  String get transcriptSareeWornDrape2 =>
      'బహిరంగ నీడలో నిలబడండి, తద్వారా రంగు నిజం అవుతుంది.';

  @override
  String get transcriptSareeWornDrape3 =>
      'చీర ఫ్రేమ్‌లో ఎక్కువ భాగాన్ని కవర్ చేయనివ్వండి.';

  @override
  String get transcriptSareeWornDrape4 =>
      'గ్రిడ్‌లో మూడవ భాగానికి ఎగువ అంచుని లైన్ చేయండి.';

  @override
  String get transcriptSareeWornDrape5 =>
      'మడతలు ఉన్నట్లయితే, నిలువు గ్రిడ్ లైన్‌లను అనుసరించండి.';

  @override
  String get transcriptSareeRollDisplay1 =>
      'పల్లు మరియు అంచు కెమెరాకు ఎదురుగా ఉండేలా చీరను చుట్టండి.';

  @override
  String get transcriptSareeRollDisplay2 =>
      'రోల్ ఫ్రేమ్‌లో ఎక్కువ భాగాన్ని కవర్ చేయనివ్వండి.';

  @override
  String get transcriptSareeRollDisplay3 =>
      'గ్రిడ్‌లో మూడవ భాగానికి ఎగువ అంచుని లైన్ చేయండి.';

  @override
  String get transcriptSareeRollDisplay4 =>
      'మృదువైన పగటి కాంతిని ఉపయోగించండి, తద్వారా రంగు నిజమైనదిగా ఉంటుంది.';

  @override
  String get transcriptCushionFlatLay1 =>
      'కుషన్ కవర్‌ను సాదా ఉపరితలంపై ఫ్లాట్‌గా వేయండి.';

  @override
  String get transcriptCushionFlatLay2 =>
      'దాన్ని స్మూత్ చేయండి కానీ సహజ ఆకృతిని కనిపించేలా ఉంచండి.';

  @override
  String get transcriptCushionFlatLay3 =>
      'ఫోన్‌ను కోణంలో కాకుండా నేరుగా పైన పట్టుకోండి.';

  @override
  String get transcriptCushionFlatLay4 => 'గ్రిడ్ వెంట అంచులను నేరుగా ఉంచండి.';

  @override
  String get transcriptCushionStackedPair1 =>
      'కొనుగోలుదారు మందాన్ని చూడగలిగేలా రెండు కవర్లను పేర్చండి.';

  @override
  String get transcriptCushionStackedPair2 =>
      'పేర్చబడిన అంచులను కెమెరాకు ఎదురుగా ఉంచండి.';

  @override
  String get transcriptCushionStackedPair3 =>
      'సైడ్ లైట్ ఉపయోగించండి, తద్వారా ప్రతి పొర మృదువైన నీడను చూపుతుంది.';

  @override
  String get transcriptCushionPropped1 =>
      'కుర్చీపై కుషన్ ఉంచడం దాని నిజమైన పరిమాణాన్ని చూపుతుంది.';

  @override
  String get transcriptCushionPropped2 => 'నమూనాతో పోటీ పడని సీటును ఎంచుకోండి.';

  @override
  String get transcriptCushionPropped3 =>
      'పై నుండి కాకుండా కంటి స్థాయిలో కాల్చండి.';

  @override
  String get transcriptCushionCornerTuck1 =>
      'మూలలో మీ కుట్టడం చాలా స్పష్టంగా చూపిస్తుంది.';

  @override
  String get transcriptCushionCornerTuck2 =>
      'మూలలో చిన్న ఫ్రేమ్‌ను నింపే వరకు దగ్గరగా తరలించండి.';

  @override
  String get transcriptCushionCornerTuck3 =>
      'ఫోకస్ చేయడానికి స్టిచింగ్‌పై స్క్రీన్‌ను నొక్కండి.';

  @override
  String get transcriptShawlDrapedShoulder1 =>
      'భుజంపై శాలువా కప్పుకుంటే అది ఎంత బరువుగా ఉందో చూపిస్తుంది.';

  @override
  String get transcriptShawlDrapedShoulder2 =>
      'ఒక చివర మరొకదాని కంటే తక్కువగా వేలాడదీయండి.';

  @override
  String get transcriptShawlDrapedShoulder3 =>
      'దానిని పిన్ చేయవద్దు - ఫాబ్రిక్ దాని స్వంతదానిపై పడనివ్వండి.';

  @override
  String get transcriptShawlFoldedStack1 =>
      'మడతలు కనిపించేలా శాలువాను చక్కగా పేర్చండి.';

  @override
  String get transcriptShawlFoldedStack2 =>
      'క్షితిజ సమాంతర రేఖలకు సమాంతరంగా మడతలు ఉంచండి.';

  @override
  String get transcriptShawlFoldedStack3 =>
      'శాలువ అంచు మందం కోసం కనిపించేలా చూసుకోండి.';

  @override
  String get transcriptShawlFoldedStack4 =>
      'సైడ్ లైటింగ్ ఉపయోగించండి కాబట్టి ప్రతి మడత లోతు ఉంటుంది.';

  @override
  String get transcriptShawlHungFlat1 =>
      'షాల్ ఫ్లాట్‌ని వేలాడదీయడం వల్ల మొత్తం డిజైన్‌ను ఒకేసారి చూపిస్తుంది.';

  @override
  String get transcriptShawlHungFlat2 =>
      'రెండు ఎగువ మూలలను పిన్ చేయండి, తద్వారా ఇది మధ్యలో కుంగిపోదు.';

  @override
  String get transcriptShawlHungFlat3 =>
      'ఒక వైపు కాకుండా నేరుగా ముందు నిలబడండి.';

  @override
  String get transcriptShawlCornerTuck1 =>
      'మూలలోని క్లోజప్ నేత మరియు సరిహద్దును కలిపి చూపుతుంది.';

  @override
  String get transcriptShawlCornerTuck2 =>
      'రెండు వైపులా కనిపించేలా ఒక మూలను వెనుకకు మడవండి.';

  @override
  String get transcriptShawlCornerTuck3 =>
      'నేత ఫ్రేమ్‌ను నింపే వరకు దగ్గరగా తరలించండి.';

  @override
  String get transcriptStoleNeckWrap1 =>
      'అరిగిన షాట్ అత్యంత సాధారణ ప్రశ్నకు సమాధానం ఇస్తుంది — ఇది ఎంత పెద్దది?';

  @override
  String get transcriptStoleNeckWrap2 =>
      'మెడ చుట్టూ ఒకసారి చుట్టి, రెండు చివరలను వేలాడదీయండి.';

  @override
  String get transcriptStoleNeckWrap3 =>
      'ఛాతీ నుండి పైకి కాల్చండి, తద్వారా చివరలు ఫ్రేమ్‌లో ఉంటాయి.';

  @override
  String get transcriptStoleFlatSpread1 =>
      'స్టోల్‌ను విస్తరించండి, తద్వారా దాని పూర్తి పొడవు కనిపిస్తుంది.';

  @override
  String get transcriptStoleFlatSpread2 =>
      'సహజమైన మడతలను వదిలివేయండి - ఫాబ్రిక్ ఎలా ఉంటుందో అవి చూపుతాయి.';

  @override
  String get transcriptStoleFlatSpread3 => 'ఫోన్‌ను నేరుగా మధ్యలో పట్టుకోండి.';

  @override
  String get transcriptStoleLooseKnot1 =>
      'ఒక వదులుగా ఉన్న ముడి స్టోల్ ఎంత మెత్తగా మరియు తేలికగా ఉందో చూపిస్తుంది.';

  @override
  String get transcriptStoleLooseKnot2 =>
      'దాన్ని వదులుగా కట్టండి - దాన్ని ఎప్పుడూ గట్టిగా లాగండి.';

  @override
  String get transcriptStoleLooseKnot3 => 'ఫ్రేమ్ మధ్యలో ముడి ఉంచండి.';

  @override
  String get transcriptStoleRolledCoil1 =>
      'స్టోల్‌ను కాయిల్‌లోకి రోల్ చేయడం అంచు మరియు మందాన్ని చూపుతుంది.';

  @override
  String get transcriptStoleRolledCoil2 =>
      'పొరలు వేరుగా ఉండేలా దాన్ని వదులుగా చుట్టండి.';

  @override
  String get transcriptStoleRolledCoil3 => 'నేరుగా కాయిల్‌పైకి షూట్ చేయండి.';

  @override
  String get guideSareeFullDisplay1 => 'చీర చాలా ఫ్రేమ్‌ను కవర్ చేస్తుంది.';

  @override
  String get guideSareeFullDisplay2 =>
      'ఎగువ అంచు గ్రిడ్ యొక్క ఎగువ మూడవ భాగంతో సమలేఖనం అవుతుంది.';

  @override
  String get guideSareeFullDisplay3 =>
      'డ్రేప్ చేసినప్పుడు, ప్లీట్స్ నిలువు గ్రిడ్‌తో సమలేఖనం చేస్తాయి.';

  @override
  String get guideSareeTextureWeave1 => 'చీర ఫ్రేమ్‌ని నింపుతుంది.';

  @override
  String get guideSareeTextureWeave2 => 'ఆకృతి మధ్యలో ఉంటుంది.';

  @override
  String get guideSareeTextureWeave3 => 'మృదువైన కాంతిని ఉపయోగించండి.';

  @override
  String get guideSareeTextureWeave4 => 'కఠినమైన ప్రతిబింబాలను నివారించండి.';

  @override
  String get guideSareeEmbroideryBorder1 => 'ఎంబ్రాయిడరీ ఫ్రేమ్ లోపల ఉంటుంది.';

  @override
  String get guideSareeEmbroideryBorder2 => 'సైడ్ లైటింగ్ ఉపయోగించండి.';

  @override
  String get guideSareeEmbroideryBorder3 =>
      'వివరాలను పదునుగా మరియు బాగా వెలిగించండి.';

  @override
  String get guideCushionTextureWeave1 => 'నేత ఫ్రేమ్ను నింపుతుంది.';

  @override
  String get guideCushionTextureWeave2 => 'ఆకృతి మధ్యలో ఉంటుంది.';

  @override
  String get guideShawlFullDesign1 =>
      'షాల్ ఫ్లాట్‌ని వేలాడదీయడం వల్ల మొత్తం డిజైన్‌ను ఒకేసారి చూపిస్తుంది.';

  @override
  String get guideShawlFullDesign2 =>
      'రెండు ఎగువ మూలలను పిన్ చేయండి, తద్వారా ఇది మధ్యలో కుంగిపోదు.';

  @override
  String get guideShawlTextureWeave1 => 'నేత ఫ్రేమ్ను నింపుతుంది.';

  @override
  String get guideShawlTextureWeave2 => 'ఆకృతి మధ్యలో ఉంటుంది.';

  @override
  String get guideStoleFullLength1 =>
      'స్టోల్‌ను విస్తరించండి, తద్వారా దాని పూర్తి పొడవు కనిపిస్తుంది.';

  @override
  String get guideStoleFullLength2 =>
      'సహజమైన మడతలను వదిలివేయండి - ఫాబ్రిక్ ఎలా ఉంటుందో అవి చూపుతాయి.';

  @override
  String get guideStoleTextureWeave1 => 'నేత ఫ్రేమ్ను నింపుతుంది.';

  @override
  String get guideStoleTextureWeave2 => 'ఆకృతి మధ్యలో ఉంటుంది.';

  @override
  String get authInvalidCredentials =>
      'తప్పు వినియోగదారు పేరు లేదా పాస్‌వర్డ్.';

  @override
  String get authUserAlreadyRegistered =>
      'ఆ వినియోగదారు పేరు ఇప్పటికే తీసుకోబడింది.';

  @override
  String get authEmailNotConfirmed =>
      'మీ ఇమెయిల్‌ను నిర్ధారించి, ఆపై మళ్లీ ప్రయత్నించండి.';

  @override
  String get authGeneric => 'సైన్ ఇన్ చేయడం సాధ్యపడలేదు. మళ్లీ ప్రయత్నించండి.';

  @override
  String get languageAssamese => 'అస్సామీ';

  @override
  String get languageEnglish => 'English';

  @override
  String get guideSareeDrapedLook1 => 'ఫాబ్రిక్ సహజంగా పడిపోనివ్వండి.';

  @override
  String get guideSareeDrapedLook2 => 'మడతలు వికర్ణాన్ని అనుసరిస్తాయి.';

  @override
  String get guideSareeDrapedLook3 => 'సైడ్ లైటింగ్ ఉపయోగించండి.';

  @override
  String get guideSareeEmbroideryBorder4 =>
      'కాంట్రాస్ట్ నేపథ్యాన్ని ఉపయోగించండి.';

  @override
  String get guideSareeFoldedStack1 =>
      'మడతలు క్షితిజ సమాంతర రేఖలకు సమాంతరంగా ఉంటాయి.';

  @override
  String get guideSareeFoldedStack2 => 'సైడ్ లైటింగ్ ఉపయోగించండి.';

  @override
  String get guideSareeFoldedStack3 => 'అంచు కనిపించేలా ఉంచండి.';

  @override
  String get guideCushionFullCover1 =>
      'పూర్తి నమూనా కనిపించేలా కవర్‌ను ఫ్లాట్‌గా వేయండి.';

  @override
  String get guideCushionFullCover2 =>
      'ఫోన్‌ను కోణంలో కాకుండా నేరుగా పైన పట్టుకోండి.';

  @override
  String get guideCushionFullCover3 => 'గ్రిడ్ వెంట అంచులను నేరుగా ఉంచండి.';

  @override
  String get guideCushionTextureWeave3 => 'మృదువైన కాంతిని ఉపయోగించండి.';

  @override
  String get guideCushionTextureWeave4 => 'కఠినమైన ప్రతిబింబాలను నివారించండి.';

  @override
  String get guideCushionStackedThickness1 =>
      'కొనుగోలుదారు మందాన్ని చూడగలిగేలా రెండు కవర్లను పేర్చండి.';

  @override
  String get guideCushionStackedThickness2 =>
      'పేర్చబడిన అంచులను కెమెరాకు ఎదురుగా ఉంచండి.';

  @override
  String get guideCushionStackedThickness3 =>
      'సైడ్ లైట్ ఉపయోగించండి, తద్వారా ప్రతి పొర మృదువైన నీడను చూపుతుంది.';

  @override
  String get guideCushionCornerStitching1 =>
      'మూలలో చాలా స్పష్టంగా కుట్టడం చూపిస్తుంది.';

  @override
  String get guideCushionCornerStitching2 =>
      'మూలలో చిన్న ఫ్రేమ్‌ను నింపే వరకు దగ్గరగా తరలించండి.';

  @override
  String get guideCushionCornerStitching3 =>
      'కుట్టును పదునుగా మరియు బాగా వెలిగించేలా ఉంచండి.';

  @override
  String get guideCushionInUse1 =>
      'కుర్చీపై కుషన్ ఉంచడం దాని నిజమైన పరిమాణాన్ని చూపుతుంది.';

  @override
  String get guideCushionInUse2 => 'నమూనాతో పోటీ పడని సీటును ఎంచుకోండి.';

  @override
  String get guideCushionInUse3 => 'పై నుండి కాకుండా కంటి స్థాయిలో కాల్చండి.';

  @override
  String get guideShawlFullDesign3 => 'ఒక వైపు కాకుండా నేరుగా ముందు నిలబడండి.';

  @override
  String get guideShawlTextureWeave3 => 'మృదువైన కాంతిని ఉపయోగించండి.';

  @override
  String get guideShawlTextureWeave4 => 'కఠినమైన ప్రతిబింబాలను నివారించండి.';

  @override
  String get guideShawlDrapedLook1 =>
      'భుజంపై శాలువా కప్పుకుంటే అది ఎంత బరువుగా ఉందో చూపిస్తుంది.';

  @override
  String get guideShawlDrapedLook2 =>
      'ఒక చివర మరొకదాని కంటే తక్కువగా వేలాడదీయండి.';

  @override
  String get guideShawlDrapedLook3 =>
      'దానిని పిన్ చేయవద్దు - ఫాబ్రిక్ దాని స్వంతదానిపై పడనివ్వండి.';

  @override
  String get guideShawlBorderCorner1 =>
      'మూలలోని క్లోజప్ నేత మరియు సరిహద్దును కలిపి చూపుతుంది.';

  @override
  String get guideShawlBorderCorner2 =>
      'రెండు వైపులా కనిపించేలా ఒక మూలను వెనుకకు మడవండి.';

  @override
  String get guideShawlBorderCorner3 =>
      'నేత ఫ్రేమ్‌ను నింపే వరకు దగ్గరగా తరలించండి.';

  @override
  String get guideShawlStackDisplay1 =>
      'మడతలు కనిపించేలా శాలువాను చక్కగా పేర్చండి.';

  @override
  String get guideShawlStackDisplay2 =>
      'క్షితిజ సమాంతర రేఖలకు సమాంతరంగా మడతలు ఉంచండి.';

  @override
  String get guideShawlStackDisplay3 =>
      'సైడ్ లైటింగ్ ఉపయోగించండి కాబట్టి ప్రతి మడత లోతు ఉంటుంది.';

  @override
  String get guideStoleFullLength3 => 'ఫోన్‌ను నేరుగా మధ్యలో పట్టుకోండి.';

  @override
  String get guideStoleTextureWeave3 => 'మృదువైన కాంతిని ఉపయోగించండి.';

  @override
  String get guideStoleTextureWeave4 => 'కఠినమైన ప్రతిబింబాలను నివారించండి.';

  @override
  String get guideStoleWornNeckWrap1 =>
      'అరిగిపోయిన షాట్ స్టోల్ ఎంత పెద్దదో సమాధానం ఇస్తుంది.';

  @override
  String get guideStoleWornNeckWrap2 =>
      'మెడ చుట్టూ ఒకసారి చుట్టి, రెండు చివరలను వేలాడదీయండి.';

  @override
  String get guideStoleWornNeckWrap3 =>
      'ఛాతీ నుండి పైకి కాల్చండి, తద్వారా చివరలు ఫ్రేమ్‌లో ఉంటాయి.';

  @override
  String get guideStoleSoftnessKnot1 =>
      'ఒక వదులుగా ఉన్న ముడి స్టోల్ ఎంత మెత్తగా మరియు తేలికగా ఉందో చూపిస్తుంది.';

  @override
  String get guideStoleSoftnessKnot2 =>
      'దాన్ని వదులుగా కట్టండి - దాన్ని ఎప్పుడూ గట్టిగా లాగండి.';

  @override
  String get guideStoleSoftnessKnot3 => 'ఫ్రేమ్ మధ్యలో ముడి ఉంచండి.';

  @override
  String get guideStoleEdgeThickness1 =>
      'స్టోల్‌ను కాయిల్‌లోకి రోల్ చేయడం అంచు మరియు మందాన్ని చూపుతుంది.';

  @override
  String get guideStoleEdgeThickness2 =>
      'పొరలు వేరుగా ఉండేలా దాన్ని వదులుగా చుట్టండి.';

  @override
  String get guideStoleEdgeThickness3 => 'నేరుగా కాయిల్‌పైకి షూట్ చేయండి.';

  @override
  String get csNavLearn => 'నేర్చుకోండి';

  @override
  String get csNavPractice => 'ప్రాక్టీస్ చేయండి';

  @override
  String get csNavProgress => 'ప్రోగ్రెస్';

  @override
  String get csLearnerFallback => 'అభ్యాసకుడు';

  @override
  String get csClusterNotSelected => 'క్లస్టర్ ఎంచుకోబడలేదు';

  @override
  String get csAntaranLearningTool => 'అంతరాన్ · అభ్యాస సాధనం';

  @override
  String get csWorksOffline => 'ఆఫ్‌లైన్‌లో పని చేస్తుంది';

  @override
  String get csClickAndSocial => 'క్లిక్ చేయండి &\nసామాజిక';

  @override
  String get csClickAndSocialInline => 'క్లిక్ & సామాజిక';

  @override
  String get csOnboardingTagline =>
      'మీ క్రాఫ్ట్ ఫోటోగ్రాఫ్. దాని కథ చెప్పండి. ఆన్‌లైన్‌లో విక్రయించండి — అన్నీ ఈ ఫోన్ నుండి.';

  @override
  String get csStepYourName => 'మీ పేరు';

  @override
  String get csNameHint => 'మీ పేరును టైప్ చేయండి';

  @override
  String get csStepYourLanguage => 'మీ భాష';

  @override
  String csLanguageChip(String label, String code) {
    return '$label ($code)';
  }

  @override
  String get csStepYourCluster => 'మీ క్లస్టర్ - మీరు ఎక్కడ పని చేస్తారు';

  @override
  String get csClusterHint =>
      'ఒకసారి ఎంపిక చేయబడింది. మీ పాఠాలు, కథనాలు మరియు హ్యాష్‌ట్యాగ్‌లు దీనికి ట్యూన్ చేయబడ్డాయి.';

  @override
  String get csSelected => 'ఎంపిక చేయబడింది';

  @override
  String get csPick => 'ఎంచుకోండి';

  @override
  String get csStartLearning => 'నేర్చుకోవడం ప్రారంభించండి';

  @override
  String get csOfflineReady => 'ఆఫ్‌లైన్ సిద్ధంగా ఉంది';

  @override
  String csHelloName(String name) {
    return 'హలో, $name';
  }

  @override
  String get csChange => 'మార్చు';

  @override
  String csLessonsDone(int done) {
    return '$done 5 పాఠాలు పూర్తయ్యాయి';
  }

  @override
  String get csLesson01Title => 'ఫోటోగ్రఫీ';

  @override
  String get csLesson01Subtitle =>
      'ఉత్పత్తి · మెటీరియల్ · క్లస్టర్ · ఫ్రేమ్‌లు · కాంతి';

  @override
  String get csLesson02Title => 'Instagramలో మీ పేజీని సెటప్ చేయండి';

  @override
  String get csLesson02Subtitle => 'పేరు · బయో · వృత్తిపరమైన ఖాతా';

  @override
  String get csLesson03Title => 'పోస్ట్‌ను సృష్టించండి';

  @override
  String get csLesson03Subtitle => 'కథ · హ్యాష్‌ట్యాగ్‌లు · ప్రచురించండి';

  @override
  String get csLesson04Title => 'పోస్టింగ్ ప్లాన్';

  @override
  String get csLesson04Subtitle => 'ఎప్పుడు పోస్ట్ చేయాలి · వీక్లీ రిథమ్';

  @override
  String get csLesson05Title => 'సంఖ్యలను చదవండి';

  @override
  String get csLesson05Subtitle => 'రీచ్ · ఏమి పని చేసింది మరియు ఎందుకు';

  @override
  String get csLesson01Overline => 'పాఠం 01';

  @override
  String get csLesson02Overline => 'పాఠం 02';

  @override
  String get csLesson03Overline => 'పాఠం 03';

  @override
  String get csLesson04Overline => 'పాఠం 04';

  @override
  String get csLesson05Overline => 'పాఠం 05';

  @override
  String csStepOfTotal(int step, int total) {
    return '$step / $total';
  }

  @override
  String get csPickYourUsername => 'మీ వినియోగదారు పేరును ఎంచుకోండి';

  @override
  String get csUsernameHint =>
      'పొట్టి. అందులో మీ క్రాఫ్ట్. బిగ్గరగా చెప్పడం సులభం.';

  @override
  String get csNextEditProfile => 'తదుపరి - ప్రొఫైల్‌ను సవరించండి';

  @override
  String get csEditProfileIntroBefore => 'ఇది ది';

  @override
  String get csEditProfileIntroBold => 'ప్రొఫైల్‌ని సవరించండి';

  @override
  String get csEditProfileIntroAfter => 'తెర. ప్రతి అడ్డు వరుసను పూరించండి.';

  @override
  String get csChangePhotoTip =>
      'ఫోటోను మార్చండి - మీ ఉత్పత్తిని ఉపయోగించండి, సూర్యాస్తమయం కాదు';

  @override
  String get csFieldName => 'పేరు';

  @override
  String get csFieldUsername => 'వినియోగదారు పేరు';

  @override
  String get csFieldBio => 'బయో';

  @override
  String get csBioPlaceholder =>
      'దీన్ని నిర్మించడానికి దిగువ పంక్తులను నొక్కండి…';

  @override
  String get csBioLinesPrompt =>
      'బయో లైన్లు - కనీసం 2 ఎంచుకోండి (స్థలం + క్రాఫ్ట్ + ఎలా కొనుగోలు చేయాలి)';

  @override
  String get csNextGoProfessional => 'తదుపరి - వృత్తికి వెళ్లండి';

  @override
  String get csSettingsPrompt =>
      'యాప్‌లో, సెట్టింగ్‌లను తెరవండి. వృత్తిపరమైన ఖాతాకు దారితీసే అడ్డు వరుసను కనుగొనండి — ఎరుపు బిందువును అనుసరించండి.';

  @override
  String get csSettingsPromptAlmost => 'దాదాపుగా ఉంది — ఇంకొకసారి నొక్కండి.';

  @override
  String get csSettingsTitle => 'సెట్టింగ్‌లు';

  @override
  String get csAccountTypeAndTools => 'ఖాతా రకం మరియు సాధనాలు';

  @override
  String get csSettingsNotifications => 'నోటిఫికేషన్‌లు';

  @override
  String get csSettingsNotificationsSub => 'ఇష్టాలు, వ్యాఖ్యలు, సందేశాలు';

  @override
  String get csSettingsPrivacy => 'గోప్యత';

  @override
  String get csSettingsPrivacySub => 'ప్రైవేట్ ఖాతా, బ్లాక్ చేయబడిన వ్యక్తులు';

  @override
  String get csSettingsAccountTypeSub => 'వృత్తిపరమైన ఖాతాకు మారండి';

  @override
  String get csSettingsHelp => 'సహాయం';

  @override
  String get csSettingsHelpSub => 'సమస్యను నివేదించండి';

  @override
  String get csSettingsSwitchProfessional => 'వృత్తిపరమైన ఖాతాకు మారండి';

  @override
  String get csSettingsSwitchProfessionalSub =>
      'ఉచిత — సృష్టికర్తలు మరియు వ్యాపారాల కోసం';

  @override
  String get csSettingsDeleteAccount => 'ఖాతాను తొలగించండి';

  @override
  String get csSettingsDeleteAccountSub => 'మీ ఖాతాను తీసివేయండి';

  @override
  String get csSettingsPersonalInfo => 'వ్యక్తిగత సమాచారం';

  @override
  String get csSettingsPersonalInfoSub => 'పుట్టినరోజు, ఇమెయిల్';

  @override
  String get csSettingsWrongPick => 'అది కాదు - ఎరుపు బిందువును అనుసరించండి.';

  @override
  String get csCategoryIntroBefore => 'చివరి దశ -';

  @override
  String get csCategoryIntroBold => 'నువ్వు ఏమిటి?';

  @override
  String get csCategoryIntroAfter => 'కొనుగోలుదారులు చూసే వర్గాన్ని ఎంచుకోండి.';

  @override
  String get csCategoryArtist => 'కళాకారుడు';

  @override
  String get csCategoryShoppingRetail => 'షాపింగ్ & రిటైల్';

  @override
  String get csCategoryLocalBusiness => 'స్థానిక వ్యాపారం';

  @override
  String get csCategoryEntrepreneur => 'వ్యాపారవేత్త';

  @override
  String get csProAccountNote1 =>
      'వృత్తిపరమైన ఖాతా ఉచితం. ఇది అన్‌లాక్ చేస్తుంది';

  @override
  String get csProAccountInsights => 'అంతర్దృష్టులు';

  @override
  String get csProAccountNote2 => '(మీ పోస్ట్‌లను ఎవరు చూస్తారు - పాఠం 05), a';

  @override
  String get csProAccountContactButton => 'సంప్రదింపు బటన్';

  @override
  String get csProAccountNote3 => ', మరియు';

  @override
  String get csProAccountAds => 'ప్రకటనలు';

  @override
  String get csProAccountNote4 => 'తరువాత.';

  @override
  String get csSwitchToProfessional => 'వృత్తికి మారండి';

  @override
  String get csPreviewIntro =>
      'పూర్తయింది. కొనుగోలుదారులు మీ పేజీని ఈ విధంగా చూస్తారు:';

  @override
  String get csPostsFollowers => '0 పోస్ట్‌లు 0 అనుచరులు';

  @override
  String get csFollow => 'అనుసరించండి';

  @override
  String get csMessage => 'సందేశం';

  @override
  String get csProfessionalAccount => 'వృత్తిపరమైన ఖాతా';

  @override
  String get csPickANameFallback => 'పేరు_ఎంచుకోండి';

  @override
  String get csCraftFallback => 'క్రాఫ్ట్';

  @override
  String get csBioFallbackHandloomWeaver => 'చేనేత నేత';

  @override
  String get csBioFallbackDmToOrder => 'ఆర్డర్ చేయడానికి DM';

  @override
  String get csBioFallbackMadeByHand => 'చేతితో తయారు చేయబడింది';

  @override
  String get csFormatPost => 'పోస్ట్';

  @override
  String get csFormatStory => 'కథ';

  @override
  String get csFormatReel => 'రీల్';

  @override
  String get csPhotoPlaceholder =>
      'పాఠం 01 నుండి మీ ఫోటో — లేదా ఫోటో లేదా వీడియోను వదలండి';

  @override
  String get csExampleKotpad =>
      'ఉదాహరణ: కోట్‌ప్యాడ్ పోస్ట్ — దగ్గరగా ఉన్న ఫోటో, ఆపై క్రాఫ్ట్ మరియు దాని నేవర్ల పేర్లతో రెండు పంక్తులు.';

  @override
  String get csAddYourStory => 'మీ కథనాన్ని జోడించండి — లైన్లను నొక్కండి';

  @override
  String get csHashtagsPick => 'హ్యాష్‌ట్యాగ్‌లు - 3 నుండి 5 వరకు ఎంచుకోండి';

  @override
  String csHashtagCount(int count) {
    return '$count/5';
  }

  @override
  String csHashtagCountFull(int count) {
    return '$count/5 — ఐదు సరిపోతుంది';
  }

  @override
  String get csCaptionPreview => 'శీర్షిక ప్రివ్యూ';

  @override
  String get csCaptionPlaceholder =>
      'మీ క్యాప్షన్ రాయడానికి ఎగువన ఉన్న కథాంశాలను నొక్కండి.';

  @override
  String get csPostToPracticeFeed =>
      'ఫీడ్‌ను ప్రాక్టీస్ చేయడానికి పోస్ట్ చేయండి';

  @override
  String get csPracticeFeedOnly =>
      'ఫీడ్‌ను మాత్రమే ప్రాక్టీస్ చేయండి — మీ ఫోన్‌ను ఏదీ వదిలిపెట్టదు.';

  @override
  String get csStoryFallbackHeritage => 'మా గ్రామంలో చేతితో తయారు చేయబడింది.';

  @override
  String get csStoryFallbackMaterial => 'సహజ ఫైబర్, జాగ్రత్తగా రంగు వేయబడింది.';

  @override
  String get csStoryFallbackProcess =>
      'ఇంటి మగ్గంపై నేసినది, మూలాంశం ద్వారా మూలాంశం.';

  @override
  String get csTagFallback0 => '#చేతితో నేసిన';

  @override
  String get csTagFallback1 => '#వోకల్ఫోకల్';

  @override
  String get csTagFallback2 => '#క్రాఫ్ట్ఇండియా';

  @override
  String get csTagFallback3 => '#మేడినిండియా';

  @override
  String get csTagFallback4 => '#చేనేత';

  @override
  String get csWhenDoBuyersScroll =>
      'కొనుగోలుదారులు ఎప్పుడు స్క్రోల్ చేస్తారు?';

  @override
  String get csTimeMorning => 'ఉదయం 6-9';

  @override
  String get csTimeNight => 'రాత్రి 7-10';

  @override
  String get csTimeAfternoon => 'మధ్యాహ్నం 2 గం';

  @override
  String get csTimeCorrectMsg =>
      'అవును — సాయంత్రాలు, రోజు పని పూర్తయినప్పుడు, ప్రజలు స్క్రోల్ చేసి షాపింగ్ చేస్తారు.';

  @override
  String get csTimeWrongMsg =>
      'ప్రజలు అప్పుడు పని చేస్తున్నారు. రోజు పూర్తయినప్పుడు ప్రయత్నించండి.';

  @override
  String get csPlanYourWeek => 'మీ వారాన్ని ప్లాన్ చేయండి - 3 రోజులు ఎంచుకోండి';

  @override
  String get csSpreadThemOut =>
      'వాటిని విస్తరించండి. కొనుగోలుదారులు వారంతా మిమ్మల్ని చూడాలి.';

  @override
  String get csDayMon => 'ఎం';

  @override
  String get csDayTue => 'టి';

  @override
  String get csDayWed => 'W';

  @override
  String get csDayThu => 'టి';

  @override
  String get csDayFri => 'ఎఫ్';

  @override
  String get csDaySat => 'ఎస్';

  @override
  String get csDaySun => 'ఎస్';

  @override
  String get csGoodRhythm =>
      'మంచి రిథమ్ — మూడు పోస్ట్‌లు, వారం అంతటా వ్యాపించాయి.';

  @override
  String get csThreePostsOneWinner => 'మూడు పోస్టులు. ఒక విజేత.';

  @override
  String get csReachExplainer =>
      'రీచ్ = ఎంత మంది దీనిని చూసారు. ఉత్తమ పోస్ట్‌ను నొక్కండి.';

  @override
  String get csResultPhotoOnly => 'ఫోటో మాత్రమే';

  @override
  String get csResultPhotoStory => 'ఫోటో + కథ శీర్షిక';

  @override
  String get csResultPhotoStoryTags => 'ఫోటో + కథ + హ్యాష్‌ట్యాగ్‌లు';

  @override
  String get csBestCorrectMsg =>
      'కుడివైపు — స్టోరీ ప్లస్ హ్యాష్‌ట్యాగ్‌లు ఒక్క ఫోటో కంటే 10× ఎక్కువ మందిని చేరాయి.';

  @override
  String get csBestWrongMsg => 'మళ్లీ చూడండి — ఏ బార్ పొడవైనది?';

  @override
  String get csYourWeekReached => 'మీ వారం - ప్రజలు చేరుకున్నారు';

  @override
  String get csTallBarsNote =>
      'పొడవైన బార్‌లు మీ పోస్టింగ్ రోజులు. మీ ప్లాన్‌పై పోస్ట్ చేయండి - కింది వాటిని చేరుకోండి.';

  @override
  String get csPracticeFeed => 'ప్రాక్టీస్ ఫీడ్';

  @override
  String get csStaysOnYourPhone => 'మీ ఫోన్‌లో ఉంటుంది';

  @override
  String get csFeedTimeNow => 'ఇప్పుడు';

  @override
  String get csFeedSampleTime1 => '2 డి';

  @override
  String get csFeedSampleTime2 => '5 డి';

  @override
  String get csFeedYourPhotoPlaceholder => 'పాఠాల నుండి మీ ఫోటో';

  @override
  String get csFeedSamplePlaceholder => 'నమూనా ఫోటోను వదలండి';

  @override
  String get csFeedSampleUser1 => 'మాయ_ఇకట్';

  @override
  String get csFeedSampleUser2 => 'మగ్గాలు_నాగ';

  @override
  String get csFeedSampleCaption1 =>
      'డబుల్ ఇకత్, నేయడానికి ముందు చేతితో కట్టి, రంగు వేయబడుతుంది.';

  @override
  String get csFeedSampleTags1 => '#ఇకత్ #ఒడిషాహ్యాండ్లూమ్ #చేనేత';

  @override
  String get csFeedSampleCaption2 =>
      'నడుము మగ్గం శాలువా - ప్రతి గీత ఒక అర్థాన్ని కలిగి ఉంటుంది.';

  @override
  String get csFeedSampleTags2 => '#నాగ శాలువ #లోయిన్లూమ్ #చేతితో నేసినది';

  @override
  String get csFeedCommentUser1 => 'కొనుగోలుదారు_ప్రియ';

  @override
  String get csFeedCommentUser2 => 'క్రాఫ్ట్.ప్రేమికుడు';

  @override
  String get csFeedCommentBuyer => 'అందమైన! దయచేసి ధర?';

  @override
  String get csFeedCommentCraftLover => 'అద్భుతమైన పని!';

  @override
  String get csFeedTapHeart =>
      'కొనుగోలుదారులు ఎలా స్పందిస్తారో చూడటానికి హృదయాన్ని నొక్కండి.';

  @override
  String get csYourProgress => 'మీ పురోగతి';

  @override
  String get csBadgesOfFive => '/ 5 బ్యాడ్జ్‌లు';

  @override
  String get csBadgePhotographer => 'ఫోటోగ్రాఫర్';

  @override
  String get csBadgePageBuilder => 'పేజీ బిల్డర్';

  @override
  String get csBadgeStoryteller => 'కథకుడు';

  @override
  String get csBadgePlanner => 'ప్లానర్';

  @override
  String get csBadgeAnalyst => 'విశ్లేషకుడు';

  @override
  String get csBadgeEarned => 'సంపాదించారు';

  @override
  String get csBadgeLocked => 'లాక్ చేయబడింది';

  @override
  String get csEditNameLanguageCluster =>
      'పేరు, భాష లేదా క్లస్టర్‌ని సవరించండి';

  @override
  String get csAccountCloudBackup => 'ఖాతా & క్లౌడ్ బ్యాకప్';

  @override
  String get csStartOverClearProgress =>
      'ప్రారంభించండి - అన్ని పురోగతిని క్లియర్ చేయండి';

  @override
  String get csStartOverTitle => 'మళ్లీ ప్రారంభించాలా?';

  @override
  String get csStartOverBody =>
      'ఇది ఈ ఫోన్‌లో పాఠ్య బ్యాడ్జ్‌లు మరియు అభ్యాస పోస్ట్‌లను క్లియర్ చేస్తుంది. మీరు ఇప్పటికే తీసిన ఫోటోలు స్థానిక నిల్వలో ఉంటాయి.';

  @override
  String get csCancel => 'రద్దు చేయి';

  @override
  String get csClear => 'క్లియర్';

  @override
  String get csStoryKickerHeritage => 'హెరిటేజ్';

  @override
  String get csStoryKickerMaterial => 'మెటీరియల్';

  @override
  String get csStoryKickerProcess => 'ప్రక్రియ';

  @override
  String get csClusterAssamFabric => 'మేఖేలా సడోర్ — ముగా & ఎరి సిల్క్';

  @override
  String get csClusterAssamShortName => 'mekhela sador';

  @override
  String get csClusterAssamPlace => 'కమ్రూప్ & నల్బారి, అస్సాం';

  @override
  String get csClusterAssamBio0 => 'చేనేత నేత';

  @override
  String get csClusterAssamBio1 => 'కమ్రూప్, అస్సాం';

  @override
  String get csClusterAssamBio2 => 'మేఖేలా సడోర్ & స్టోల్స్';

  @override
  String get csClusterAssamBio3 => 'ఆర్డర్ చేయడానికి DM';

  @override
  String get csClusterAssamBio4 => '3వ తరం నేత';

  @override
  String get csClusterAssamStoryHeritage =>
      'ముగా - బంగారు పట్టు అస్సాంలో మాత్రమే పెరుగుతుంది.';

  @override
  String get csClusterAssamStoryMaterial =>
      'హ్యాండ్‌స్పన్ ఎరి - శాలువాలా మెత్తగా, ఉన్నిలా వెచ్చగా ఉంటుంది.';

  @override
  String get csClusterAssamStoryProcess =>
      'ఇంట్లో నేసిన, మగ్గంపై వారాలు, మూలాంశం ద్వారా మూలాంశం.';

  @override
  String get csClusterAssamTag0 => '#మేఖేలాచాడోర్';

  @override
  String get csClusterAssamTag1 => '#ముగసిల్క్';

  @override
  String get csClusterAssamTag2 => '#ఎరిసిల్క్';

  @override
  String get csClusterAssamTag3 => '#అస్సాం చేనేత';

  @override
  String get csClusterAssamTag4 => '#చేతితో నేసిన';

  @override
  String get csClusterAssamTag5 => '#వోకల్ఫోకల్';

  @override
  String get csClusterAssamTag6 => '#సిల్క్‌సోఫిండియా';

  @override
  String get csClusterAssamTag7 => '#weversofindia';

  @override
  String get csClusterSrikalahastiFabric => 'కలంకారి - చేతితో పూసిన పత్తి';

  @override
  String get csClusterSrikalahastiShortName => 'కలంకారి';

  @override
  String get csClusterSrikalahastiPlace => 'శ్రీకాళహస్తి, ఆంధ్రప్రదేశ్';

  @override
  String get csClusterSrikalahastiBio0 => 'కలంకారి కళాకారుడు';

  @override
  String get csClusterSrikalahastiBio1 => 'శ్రీకాళహస్తి, ఆంధ్రప్రదేశ్';

  @override
  String get csClusterSrikalahastiBio2 =>
      'చేతితో పెయింట్ చేయబడిన ప్యానెల్లు & చీరలు';

  @override
  String get csClusterSrikalahastiBio3 => 'ఆర్డర్ చేయడానికి DM';

  @override
  String get csClusterSrikalahastiBio4 => 'దేవాలయం-కళా కుటుంబం';

  @override
  String get csClusterSrikalahastiStoryHeritage =>
      'వెదురు కలంతో గీసిన ఆలయ కథలు.';

  @override
  String get csClusterSrikalahastiStoryMaterial =>
      'పత్తి మరియు సహజ రంగులు - మైరోబాలన్, ఇనుము, పటిక.';

  @override
  String get csClusterSrikalahastiStoryProcess =>
      'లైన్ ద్వారా గీసిన - రెండు ముక్కలు ఒకే విధంగా లేవు.';

  @override
  String get csClusterSrikalahastiTag0 => '#కలమకారి';

  @override
  String get csClusterSrikalahastiTag1 => '#శ్రీకాళహస్తి';

  @override
  String get csClusterSrikalahastiTag2 => '#సహజ రంగులు';

  @override
  String get csClusterSrikalahastiTag3 => '#చేతితో పెయింట్ చేయబడింది';

  @override
  String get csClusterSrikalahastiTag4 => '#క్రాఫ్ట్ఇండియా';

  @override
  String get csClusterSrikalahastiTag5 => '#వోకల్ఫోకల్';

  @override
  String get csClusterSrikalahastiTag6 => '#వస్త్రకళ';

  @override
  String get csClusterSrikalahastiTag7 => '#మేడినిండియా';

  @override
  String get csClusterVenkatgiriFabric => 'వెంకటగిరి చీర — ఫైన్ కాటన్ & జరీ';

  @override
  String get csClusterVenkatgiriShortName => 'వెంకటగిరి చీర';

  @override
  String get csClusterVenkatgiriPlace => 'వెంకటగిరి, ఆంధ్రప్రదేశ్';

  @override
  String get csClusterVenkatgiriBio0 => 'చేనేత నేత';

  @override
  String get csClusterVenkatgiriBio1 => 'వెంకటగిరి, ఆంధ్రప్రదేశ్';

  @override
  String get csClusterVenkatgiriBio2 => 'చక్కటి కాటన్ & జరీ చీరలు';

  @override
  String get csClusterVenkatgiriBio3 => 'ఆర్డర్ చేయడానికి DM';

  @override
  String get csClusterVenkatgiriBio4 => '1970 నుంచి నేత కుటుంబం';

  @override
  String get csClusterVenkatgiriStoryHeritage =>
      'ఒకప్పుడు వెంకటగిరి ఆస్థానానికి అల్లినది.';

  @override
  String get csClusterVenkatgiriStoryMaterial =>
      'కాటన్ చాలా చక్కగా చీర తేలుతుంది.';

  @override
  String get csClusterVenkatgiriStoryProcess =>
      'జమ్దానీ మూలాంశాలు - చిలుక, మామిడి, హంస - చేతితో అల్లినవి.';

  @override
  String get csClusterVenkatgiriTag0 => '#వెంకటగిరి';

  @override
  String get csClusterVenkatgiriTag1 => '#జామ్దాని';

  @override
  String get csClusterVenkatgiriTag2 => '#జారీ';

  @override
  String get csClusterVenkatgiriTag3 => '#చేనేత చీర';

  @override
  String get csClusterVenkatgiriTag4 => '#కాటన్‌చీర';

  @override
  String get csClusterVenkatgiriTag5 => '#వోకల్ఫోకల్';

  @override
  String get csClusterVenkatgiriTag6 => '#సరీసోఫిన్‌స్టాగ్రామ్';

  @override
  String get csClusterVenkatgiriTag7 => '#మేడినిండియా';

  @override
  String get csClusterManiabandhaFabric => 'ఖండువా ఇకత్ - టై-డైడ్ సిల్క్';

  @override
  String get csClusterManiabandhaShortName => 'ఖండువా ఇకత్';

  @override
  String get csClusterManiabandhaPlace => 'మానియాబంధ, ఒడిశా';

  @override
  String get csClusterManiabandhaBio0 => 'ఇకత్ నేత';

  @override
  String get csClusterManiabandhaBio1 => 'మానియాబంధ, ఒడిశా';

  @override
  String get csClusterManiabandhaBio2 => 'ఖండవా చీరలు & స్టోల్స్';

  @override
  String get csClusterManiabandhaBio3 => 'ఆర్డర్ చేయడానికి DM';

  @override
  String get csClusterManiabandhaBio4 => 'మహానందిపై నేత గ్రామం';

  @override
  String get csClusterManiabandhaStoryHeritage =>
      'ఖండూవా - జగన్నాథుని కోసం అల్లినది.';

  @override
  String get csClusterManiabandhaStoryMaterial =>
      'సిల్క్ నూలులు మగ్గాన్ని కలిసే ముందు టై-డై ఉంటాయి.';

  @override
  String get csClusterManiabandhaStoryProcess =>
      'నమూనా థ్రెడ్‌లో రంగు వేయబడుతుంది, ఆపై నిజమైన అల్లినది.';

  @override
  String get csClusterManiabandhaTag0 => '#ఖండువ';

  @override
  String get csClusterManiabandhaTag1 => '#ikat';

  @override
  String get csClusterManiabandhaTag2 => '#ఒడిషాహ్యాండ్లూమ్';

  @override
  String get csClusterManiabandhaTag3 => '#ఉన్మాదబంధ';

  @override
  String get csClusterManiabandhaTag4 => '#చేతితో నేసిన';

  @override
  String get csClusterManiabandhaTag5 => '#టైడీ';

  @override
  String get csClusterManiabandhaTag6 => '#వోకల్ఫోకల్';

  @override
  String get csClusterManiabandhaTag7 => '#చీరప్రేమ';

  @override
  String get csClusterGopalpurFabric => 'గోపాల్పూర్ టస్సార్ - అడవి పట్టు';

  @override
  String get csClusterGopalpurShortName => 'టస్సార్ చీర';

  @override
  String get csClusterGopalpurPlace => 'గోపాల్‌పూర్, జాజ్‌పూర్, ఒడిశా';

  @override
  String get csClusterGopalpurBio0 => 'టస్సార్ నేత';

  @override
  String get csClusterGopalpurBio1 => 'గోపాల్‌పూర్, ఒడిశా';

  @override
  String get csClusterGopalpurBio2 => 'చీరలు, స్టోల్స్ & ఫాబ్రిక్';

  @override
  String get csClusterGopalpurBio3 => 'ఆర్డర్ చేయడానికి DM';

  @override
  String get csClusterGopalpurBio4 => 'GI-ట్యాగ్ చేయబడిన క్రాఫ్ట్';

  @override
  String get csClusterGopalpurStoryHeritage =>
      '16వ శతాబ్దం నుండి గోపాల్‌పూర్‌లో అల్లినది — GI ట్యాగ్ చేయబడింది.';

  @override
  String get csClusterGopalpurStoryMaterial =>
      'వైల్డ్ టస్సార్ - దాని బంగారం సహజమైనది, రంగు కాదు.';

  @override
  String get csClusterGopalpurStoryProcess =>
      'హ్యాండ్-రీల్డ్, హ్యాండ్-స్పన్, ఎక్స్‌ట్రా-వెఫ్ట్ మోటిఫ్‌లు.';

  @override
  String get csClusterGopalpurTag0 => '#టుస్సార్సిల్క్';

  @override
  String get csClusterGopalpurTag1 => '#గోపాలపూర్';

  @override
  String get csClusterGopalpurTag2 => '#ఒడిషావీవ్స్';

  @override
  String get csClusterGopalpurTag3 => '#అడవి పట్టు';

  @override
  String get csClusterGopalpurTag4 => '#చేతి తిప్పడం';

  @override
  String get csClusterGopalpurTag5 => '#వోకల్ఫోకల్';

  @override
  String get csClusterGopalpurTag6 => '#సిల్క్‌సోఫిండియా';

  @override
  String get csClusterGopalpurTag7 => '#చేతితో నేసిన';

  @override
  String get csClusterNagalandFabric => 'నాగ శాలువా - నడుము మగ్గం';

  @override
  String get csClusterNagalandShortName => 'నాగ శాలువా';

  @override
  String get csClusterNagalandPlace => 'నాగాలాండ్ సమూహాలు';

  @override
  String get csClusterNagalandBio0 => 'నడుము-మగ్గం నేత';

  @override
  String get csClusterNagalandBio1 => 'నాగాలాండ్';

  @override
  String get csClusterNagalandBio2 => 'శాలువాలు & మేఖలాలు';

  @override
  String get csClusterNagalandBio3 => 'ఆర్డర్ చేయడానికి DM';

  @override
  String get csClusterNagalandBio4 => 'నా తెగకు చెందిన అల్లికలు';

  @override
  String get csClusterNagalandStoryHeritage =>
      'ప్రతి గీత మరియు మూలాంశం మీరు ఎవరో చెబుతుంది.';

  @override
  String get csClusterNagalandStoryMaterial =>
      'నడుము మగ్గంపై దట్టమైన పత్తి, లోతైన రంగు వేయబడింది.';

  @override
  String get csClusterNagalandStoryProcess =>
      'స్ట్రిప్ ద్వారా నేసిన స్ట్రిప్, ఒక శాలువలో కుట్టబడింది.';

  @override
  String get csClusterNagalandTag0 => '#నాగశాలువు';

  @override
  String get csClusterNagalandTag1 => '# నడుము మగ్గం';

  @override
  String get csClusterNagalandTag2 => '#నాగాలాండ్';

  @override
  String get csClusterNagalandTag3 => '#చేతితో నేసిన';

  @override
  String get csClusterNagalandTag4 => '#గిరిజన వస్త్రాలు';

  @override
  String get csClusterNagalandTag5 => '#వోకల్ఫోకల్';

  @override
  String get csClusterNagalandTag6 => '#ఈశాన్య భారతదేశం';

  @override
  String get csClusterNagalandTag7 => '#క్రాఫ్ట్ఇండియా';

  @override
  String get csNewProductTitle => 'కొత్త ఉత్పత్తి';

  @override
  String get csHowIsItMade => 'ఎలా తయారు చేస్తారు?';

  @override
  String get csTechniqueSub => 'కెమెరా ఏమి చూపించాలో సాంకేతికత నిర్ణయిస్తుంది.';

  @override
  String get csTechniqueWoven => 'నేసిన';

  @override
  String get csTechniqueHandPainted => 'చేతితో పెయింట్ చేయబడింది';

  @override
  String get csNextMaterialType => 'తదుపరి - మెటీరియల్ రకం';

  @override
  String get csNextMaterial => 'తదుపరి - మెటీరియల్';

  @override
  String get csWhatArePhotographing => 'మీరు ఏమి ఫోటో తీస్తున్నారు?';

  @override
  String get csPickYourProduct => 'మీ ఉత్పత్తిని ఎంచుకోండి.';

  @override
  String get csPickYourFrames => 'మీ ఫ్రేమ్‌లను ఎంచుకోండి';

  @override
  String get csPickFramesSub =>
      'మీరు ఏ షాట్లు తీస్తారు? కనీసం ఇద్దరిని ఎంచుకోండి.';

  @override
  String get csNoTemplatesYet => 'ఈ ఉత్పత్తికి ఇంకా టెంప్లేట్‌లు లేవు.';

  @override
  String get csNextFrameIt => 'తదుపరి - ఫ్రేమ్ ఐటి';

  @override
  String csFramingProgress(int index, int total) {
    return 'ఫ్రేమింగ్ $index ఆఫ్ $total';
  }

  @override
  String csFramingProgressNamed(int index, int total, String names) {
    return 'ఫ్రేమింగ్ $index OF $total — $names';
  }

  @override
  String get csFramingThirdsTitle => 'మీ ఉత్పత్తి ఎక్కడ కూర్చోవాలి?';

  @override
  String get csFramingThirdsSub =>
      'ఉత్తమ ఫ్రేమ్‌ని నొక్కండి. పంక్తులు మూడింట నియమం.';

  @override
  String get csFramingThirdsMsg0 =>
      'డెడ్ సెంటర్ ఫ్లాట్ అనిపిస్తుంది. క్రాసింగ్ పాయింట్ ప్రయత్నించండి.';

  @override
  String get csFramingThirdsMsg1 =>
      'అవును — పంక్తులు దాటే చోట సెట్ చేయండి. ఫోటో ఊపిరి పీల్చుకుంటుంది.';

  @override
  String get csFramingThirdsMsg2 =>
      'అంచుకు చాలా దగ్గరగా - ఉత్పత్తి కత్తిరించబడుతుంది.';

  @override
  String get csFramingCenterTitle => 'మీరు ఎంత దగ్గరగా వెళ్ళాలి?';

  @override
  String get csFramingCenterSub =>
      'క్లోజ్-అప్‌లు, ఫ్లాట్ లేలు మరియు వేలాడదీసిన ముక్కలు మధ్యలో ఉంటాయి - మధ్య పెట్టెని నింపండి.';

  @override
  String get csFramingCenterMsg0 =>
      'చాలా దూరం - వివరాలు పోయాయి. అడుగు పెట్టండి.';

  @override
  String get csFramingCenterMsg1 =>
      'అవును — ఫ్రేమ్‌కి సమాంతరంగా మధ్య పెట్టె, అంచులను పూరించండి.';

  @override
  String get csFramingCenterMsg2 =>
      'ఫ్రేమ్ నుండి సగం బయటికి - మీరు షూట్ చేయడానికి ముందు దానిని మధ్యలో ఉంచండి.';

  @override
  String get csFramingDiagTitle => 'ఫాబ్రిక్ ఎలా ప్రవహించాలి?';

  @override
  String get csFramingDiagSub =>
      'డ్రెప్‌లు మరియు స్థూల షాట్‌లు వికర్ణంగా కదులుతాయి - గుడ్డ కంటికి దారి తీయనివ్వండి.';

  @override
  String get csFramingDiagMsg0 =>
      'చదునైన వరుసలో కదలిక లేదు. అది లైన్ వెంట పడనివ్వండి.';

  @override
  String get csFramingDiagMsg1 =>
      'అవును - మడతలు వికర్ణం నుండి క్రిందికి వస్తాయి మరియు కన్ను అనుసరిస్తుంది.';

  @override
  String get csFramingDiagMsg2 => 'ఒక మూలలో బంచ్ చేయబడింది - ప్రవాహం పోయింది.';

  @override
  String get csFramingDetailTitle => 'ఫ్రేమ్‌లో సరిహద్దు ఎంత?';

  @override
  String get csFramingDetailSub =>
      'అంచు, మూలాంశం మరియు మడతపెట్టిన షాట్‌లు: వివరాల ఫ్రేమ్‌ను పనితోనే పూరించండి.';

  @override
  String get csFramingDetailMsg0 =>
      'చాలా సన్నగా, చాలా దూరం - ఎవరూ క్రాఫ్ట్ చూడలేరు.';

  @override
  String get csFramingDetailMsg1 =>
      'అవును — అంచు ఫ్రేమ్‌ను నింపుతుంది, థ్రెడ్‌లను లెక్కించడానికి తగినంత దగ్గరగా ఉంటుంది.';

  @override
  String get csFramingDetailMsg2 =>
      'తేలియాడే చతురస్రం సరిహద్దు లేదా మూలాంశాన్ని చూపదు. బ్యాండ్‌ని అనుసరించండి.';

  @override
  String get csNextFraming => 'తదుపరి ఫ్రేమింగ్';

  @override
  String get csNextLightIt => 'తదుపరి - లైట్ IT';

  @override
  String get csLightSide => 'వైపు నుండి కాంతి';

  @override
  String get csLightFront => 'ముందు నుండి మృదువైన కాంతి';

  @override
  String get csLightBack => 'వెనుక నుండి వెలుగు';

  @override
  String get csLightHeadingPanel =>
      'పెయింట్ చేయబడిన ప్యానెల్ కాంతిని ద్వేషిస్తుంది.';

  @override
  String get csLightHeadingPainted =>
      'చేతితో పెయింట్ చేయబడింది - దానిని సమానంగా ఉంచండి.';

  @override
  String get csLightHeadingSilk => 'పట్టు మెరుస్తుంది. ప్రకాశించేలా చేయండి.';

  @override
  String get csLightHeadingCotton =>
      'పత్తి మెత్తగా ఉంటుంది. కాంతిని మృదువుగా ఉంచండి.';

  @override
  String get csLightPromptPanel =>
      'గుడ్డ మీద పెయింటింగ్ ప్రతిబింబిస్తుంది. ఫ్లాట్ మరియు మెత్తగా వెలిగించండి.';

  @override
  String get csLightPromptPainted =>
      'పెయింట్ చేసిన రంగులను నిజం చేసే కాంతిని ఎంచుకోండి.';

  @override
  String get csLightPromptSilk =>
      'మీ పట్టును ఉత్తమంగా చూపించే కాంతిని ఎంచుకోండి.';

  @override
  String get csLightPromptDefault =>
      'మీ ఉత్పత్తిని ఉత్తమంగా చూపించే కాంతిని ఎంచుకోండి.';

  @override
  String get csLightWhyPanel =>
      'కుడి - ముందు నుండి మృదువైన, సమానమైన కాంతి. సహజ-రంగు రంగులు నిజమైనవి మరియు కెమెరా వద్ద ఏమీ మెరుస్తాయి. ఎప్పుడూ ఫ్లాష్‌ని ఉపయోగించవద్దు.';

  @override
  String get csLightWhyPainted =>
      'కుడివైపు — ఫ్రంట్ లైట్ కూడా రంగులను నిజం చేస్తుంది, పెయింట్ చేసిన ఉపరితలంపై కాంతి ఉండదు.';

  @override
  String get csLightWhySilk =>
      'కుడివైపు - సైడ్ లైట్ పట్టు మెరుపును పట్టుకుంటుంది.';

  @override
  String get csLightWhyCotton =>
      'కుడివైపు — మృదువైన ఫ్రంట్ లైట్ పత్తిని సున్నితంగా ఉంచుతుంది మరియు దాని రంగులను నిజం చేస్తుంది.';

  @override
  String get csLightWrongPanel =>
      'రేకింగ్ సైడ్ లైట్ బ్రష్‌వర్క్‌పై నీడలను విసురుతుంది మరియు ఉపరితలంపై కాంతిని పట్టుకుంటుంది. దానిని సమానంగా మరియు విస్తరించి ఉంచండి.';

  @override
  String get csLightWrongPainted =>
      'సైడ్ లైట్ పెయింట్ చేసిన పని మీద నీడలను విసురుతుంది. మృదువుగా మరియు సమానంగా ఉంచండి.';

  @override
  String get csLightWrongSilk =>
      'ఫ్లాట్ ఫ్రంట్ లైట్ ప్రకాశాన్ని చంపుతుంది. చుట్టూ ఉన్న కాంతిని పక్కకు తీసుకురండి.';

  @override
  String get csLightWrongCotton =>
      'హార్డ్ సైడ్ లైట్ పత్తిని గరుకుగా చేస్తుంది. ముందు నుండి మెత్తగా ఉంచండి.';

  @override
  String get csLightWrongBacklight =>
      'బ్యాక్‌లైట్ మీ ఉత్పత్తిని నీడగా మారుస్తుంది. మందం షాట్ కోసం దాన్ని సేవ్ చేయండి.';

  @override
  String get csLightTipDoThisBadge => 'దీన్ని చేయండి';

  @override
  String get csLightTipDoThisBody =>
      'పెద్ద మృదువైన కిటికీ, తెర గీసింది. మొత్తం ప్యానెల్ అంతటా కూడా కాంతి - ప్రతి రంగు నిజం, షైన్ లేదు.';

  @override
  String get csLightTipNeverFlashBadge => 'ఎప్పుడూ ఫ్లాష్ చేయవద్దు';

  @override
  String get csLightTipNeverFlashBody =>
      'ఫ్లాష్ నేరుగా వెనుకకు బౌన్స్ అవుతుంది - తెల్లటి గ్లేర్ స్పాట్ పెయింటింగ్‌ను కాల్చేస్తుంది.';

  @override
  String get csLightTipAvoidSideBadge => 'హార్డ్ సైడ్ లైట్‌ను నివారించండి';

  @override
  String get csLightTipAvoidSideBody =>
      'ఒక వైపు నుండి ఒక దీపం లేదా సూర్యుడు బ్రష్‌వర్క్‌లో నీడలను లాగుతుంది మరియు వస్త్రం ఆకృతి పెయింటింగ్‌తో పోరాడుతుంది.';

  @override
  String get csLightNowPick => 'ఇప్పుడు సరైన కాంతిని ఎంచుకోండి';

  @override
  String get csNextShootYours => 'తదుపరి - మీ షూట్';

  @override
  String get csFinishEarnBadge => 'ముగించు - బ్యాడ్జ్ సంపాదించండి';

  @override
  String get languageOdia => 'ఒడియా';

  @override
  String get languageTelugu => 'తెలుగు';

  @override
  String get csWhatIsItMadeOf => 'ఇది దేనితో తయారు చేయబడింది?';

  @override
  String get csMaterialDecidesLight => 'పదార్థం కాంతిని నిర్ణయిస్తుంది.';

  @override
  String get csNextTechnique => 'తదుపరి - టెక్నిక్';

  @override
  String get csNextPickYourFrames => 'తదుపరి - మీ ఫ్రేమ్‌లను ఎంచుకోండి';

  @override
  String get csMaterialCotton => 'పత్తి';

  @override
  String get csMaterialSilk => 'సిల్క్';

  @override
  String get csPhotosToCaptureHeading => 'సంగ్రహించడానికి ఫోటోలు';

  @override
  String get csOpenGuideDropTick =>
      'గైడ్‌ని తెరవండి, షాట్ తీసుకోండి, దాన్ని డ్రాప్ చేయండి, టిక్ ఆఫ్ చేయండి.';

  @override
  String get csMarkAsTaken => 'తీసుకున్నట్లు గుర్తు పెట్టండి';

  @override
  String get csTickedUndo => 'టిక్ చేయబడింది - అన్డు';

  @override
  String get csDropFirstShot => 'ప్రారంభించడానికి మీ మొదటి షాట్‌ను వదలండి.';

  @override
  String csShotsLeft(int count) {
    return '$count షాట్లు మిగిలి ఉన్నాయి.';
  }

  @override
  String get csAllShotsSaved => 'అన్ని షాట్‌లు సేవ్ చేయబడ్డాయి';

  @override
  String csShotSavedLeft(int count) {
    return 'షాట్ సేవ్ చేయబడింది - $count ఎడమ';
  }

  @override
  String csDropYourShotHere(String name) {
    return 'మీ $name షాట్‌ను ఇక్కడ వదలండి';
  }

  @override
  String get csChoosePhoto => 'ఫోటో';

  @override
  String get csChooseVideo => 'వీడియో';

  @override
  String get csDropPhotoOrVideo =>
      'పాఠం 01 నుండి మీ ఫోటో — లేదా ఫోటో లేదా వీడియోను వదలండి';

  @override
  String get csVideoSelected => 'వీడియో ఎంచుకోబడింది — మార్చడానికి నొక్కండి';
}
