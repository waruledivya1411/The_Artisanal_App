// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'द आर्टिसनल लेंस';

  @override
  String get navHome => 'होम';

  @override
  String get navGallery => 'गैलरी';

  @override
  String get navNewProduct => 'नया उत्पाद';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get continueAction => 'आगे बढ़ें';

  @override
  String get openCamera => 'कैमरा खोलें';

  @override
  String get language => 'भाषा';

  @override
  String get photographyGuide => 'फोटोग्राफी गाइड';

  @override
  String get photographyGuideSubtitle =>
      'इस ऐप के हर सुझाव के पीछे ये नियम हैं।';

  @override
  String get whatPhotographing => 'आज आप किस चीज़ की\nफोटो ले रहे हैं?';

  @override
  String get continuePhotography => 'फोटोग्राफी जारी रखें';

  @override
  String get previousSets => 'पिछले सेट।';

  @override
  String get filterAll => 'सभी';

  @override
  String get filterFinished => 'पूरे';

  @override
  String get filterPending => 'बाकी';

  @override
  String photosCompleted(int done, int total) {
    return '$done में से $total फोटो पूरी हुईं';
  }

  @override
  String get emptyAll => 'अभी कोई पिछला सेट नहीं है।';

  @override
  String get emptyFinished => 'अभी कोई पूरा सेट नहीं है।';

  @override
  String get emptyPending => 'कोई अधूरा सेट नहीं है।';

  @override
  String get newProduct => 'नया उत्पाद';

  @override
  String get gallery => 'गैलरी';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get product => 'उत्पाद';

  @override
  String get photos => 'फोटो';

  @override
  String get setup => 'सेटअप';

  @override
  String get tutorial => 'ट्यूटोरियल';

  @override
  String get review => 'समीक्षा';

  @override
  String get materialHeadline => 'आप किस कपड़े के साथ\nकाम कर रहे हैं?';

  @override
  String materialTypeHeadline(String material) {
    return 'आप किस तरह का $material\nइस्तेमाल कर रहे हैं?';
  }

  @override
  String get giveProductName => 'अपने उत्पाद का नाम लिखें';

  @override
  String nameHint(String category) {
    return 'जैसे नीला रेशम $category';
  }

  @override
  String get photosToCapture => 'लेनी वाली फोटो';

  @override
  String get photosToCaptureBody => 'ये फोटो आपको लेनी हैं।';

  @override
  String get sareePhotographyTemplatesTitle => 'साड़ी फोटोग्राफी टेम्पलेट';

  @override
  String get sareePhotographyTemplatesBody => 'ये पाँच फोटो लेनी हैं।';

  @override
  String get photographyTemplatesTitle => 'फोटोग्राफी टेम्पलेट';

  @override
  String get photographyTemplatesBody => 'ये पाँच फोटो लेनी हैं।';

  @override
  String get viewCompletedSet => 'पूरा सेट देखें';

  @override
  String get allPhotosCaptured => 'सभी फोटो ले ली गईं';

  @override
  String takeNext(String label) {
    return 'अगली लें — $label';
  }

  @override
  String get productUnavailable => 'यह उत्पाद अब उपलब्ध नहीं है।';

  @override
  String get chooseAStyle => 'एक स्टाइल चुनें';

  @override
  String get howShouldItLook => 'यह कैसा दिखना चाहिए?';

  @override
  String get stylePickFirst => 'पहले सूची से एक फोटो चुनें।';

  @override
  String get styleNoNeeded => 'इस फोटो के लिए कोई स्टाइल नहीं चाहिए।';

  @override
  String styleSubtitleSaree(String template) {
    return 'इस $template फोटो की व्यवस्था चुनें।';
  }

  @override
  String styleSubtitleShot(String shot) {
    return 'इस $shot फोटो की व्यवस्था चुनें।';
  }

  @override
  String styleSubtitleCategory(String category, String shot) {
    return 'इस $category $shot फोटो की व्यवस्था चुनें।';
  }

  @override
  String get labelContent => 'विषय';

  @override
  String get labelNeeds => 'ज़रूरत';

  @override
  String get labelPlacement => 'रखने का तरीका';

  @override
  String get labelLighting => 'रोशनी';

  @override
  String get labelGrid => 'ग्रिड';

  @override
  String contentPrefixed(String value) {
    return 'विषय: $value';
  }

  @override
  String needsPrefixed(String value) {
    return 'ज़रूरत: $value';
  }

  @override
  String get lightingAndSetup => 'रोशनी और सेटअप';

  @override
  String get step1of2 => 'चरण 1 में से 2';

  @override
  String get step2of2 => 'चरण 2 में से 2';

  @override
  String get beforeYouShoot => 'फोटो से पहले';

  @override
  String get setupIllustrationPlaceholder =>
      'सेटअप की तस्वीर बाद में जोड़ी जाएगी';

  @override
  String get placeTheProduct => 'उत्पाद रखें';

  @override
  String get setupSection => 'सेटअप';

  @override
  String get watchHowToSetUp => 'सेटअप कैसे करें, देखें';

  @override
  String tutorialSubtitlePreset(String name) {
    return '$name का सेटअप कैसे करें, देखें।';
  }

  @override
  String tutorialSubtitleTemplate(String name) {
    return '$name का सेटअप कैसे करें, देखें।';
  }

  @override
  String get tutorialSubtitleFallback =>
      'जब वीडियो जुड़ेगा, यह सेटअप दिखाया जाएगा।';

  @override
  String get transcript => 'ट्रांस्क्रिप्ट';

  @override
  String get transcriptPlaceholder =>
      'ट्यूटोरियल वीडियो जुड़ने पर बोली गई बात यहाँ दिखेगी।';

  @override
  String get tutorialVideoPlaceholder =>
      'ट्यूटोरियल वीडियो बाद में जोड़ा जाएगा';

  @override
  String get referencePreset => 'संदर्भ प्रीसेट';

  @override
  String get retake => 'फिर से लें';

  @override
  String get usePhoto => 'फोटो इस्तेमाल करें';

  @override
  String get greatFraming => 'फ्रेम ठीक है';

  @override
  String get checkFraming => 'फ्रेम जाँचें';

  @override
  String get noPhotoToReview => 'समीक्षा के लिए कोई फोटो नहीं है।';

  @override
  String get photoSetComplete => 'आपका फोटो सेट पूरा हो गया 🎉';

  @override
  String get viewPhotoSet => 'फोटो सेट देखें';

  @override
  String get startNewProduct => 'नया उत्पाद शुरू करें';

  @override
  String get offlineBanner => 'ऑफलाइन — जुड़ने पर फोटो सिंक होंगी';

  @override
  String get productNotFound => 'उत्पाद नहीं मिला।';

  @override
  String get exportPhotoSet => 'फोटो सेट भेजें';

  @override
  String continueCount(int done, int total) {
    return 'जारी रखें — $done/$total';
  }

  @override
  String get noPhotosToExport => 'भेजने के लिए अभी कोई फोटो नहीं है।';

  @override
  String couldNotExport(String error) {
    return 'भेज नहीं सके: $error';
  }

  @override
  String exportShareText(String name, int count) {
    return '$name — $count फोटो, द आर्टिसनल लेंस से ली गईं';
  }

  @override
  String couldNotSavePhoto(String error) {
    return 'फोटो सेव नहीं हो सकी: $error';
  }

  @override
  String get galleryEmpty =>
      'अभी कोई फोटो सेट नहीं है।\nशुरू करने के लिए नया उत्पाद बनाएँ।';

  @override
  String get galleryEmptyFiltered => 'इस श्रेणी में अभी कुछ नहीं है।';

  @override
  String get showAll => 'सभी दिखाएँ';

  @override
  String get nextPill => 'अगली';

  @override
  String get templateOverline => 'टेम्पलेट';

  @override
  String get proTipGoodLight =>
      'सुझाव: उत्पाद की फोटो के लिए अभी प्राकृतिक रोशनी सबसे अच्छी है।';

  @override
  String get chipLight => 'रोशनी';

  @override
  String get chipDistance => 'दूरी';

  @override
  String get chipCentre => 'केंद्र';

  @override
  String get chipEmDash => '—';

  @override
  String get readingTheFrame => 'फ्रेम पढ़ रहा है…';

  @override
  String fillFrameWith(String slot) {
    return '$slot से फ्रेम भरें';
  }

  @override
  String promptNoProduct(String product) {
    return '$product को सामने रखें';
  }

  @override
  String promptMoveIntoFrame(String product) {
    return '$product को फ्रेम में लाइए';
  }

  @override
  String promptKeepInsideFrame(String product) {
    return '$product को फ्रेम के अंदर रखें';
  }

  @override
  String get promptAlignHorizontal => 'मोड़ों को आड़ी रेखाओं के साथ मिलाएँ';

  @override
  String get promptAlignDiagonal => 'कपड़े को तिरछी रेखाओं के साथ बहने दें';

  @override
  String get promptHoldSteady => 'फोन स्थिर रखें';

  @override
  String get promptMoveCloser => 'पास आइए';

  @override
  String get promptMoveFurther => 'विषय से थोड़ा दूर जाएँ';

  @override
  String promptCenterSubject(String product) {
    return '$product को बीच में रखें';
  }

  @override
  String get promptKeepTextureCentre => 'बनावट को केंद्र में रखें';

  @override
  String get promptKeepBorderInside => 'बॉर्डर को फ्रेम के अंदर रखें';

  @override
  String get promptKeepFoldsVisible => 'मोड़ दिखते रहें';

  @override
  String get promptBacklight => 'पीछे की रोशनी दिख रही है';

  @override
  String get promptTooDark => 'बहुत अंधेरा — खिड़की के पास या बाहर जाएँ';

  @override
  String get promptLowLight => 'रोशनी कम है — खिड़की के और पास जाएँ';

  @override
  String get promptTooBright => 'बहुत तेज रोशनी — छाया में जाएँ';

  @override
  String get promptTiltPhone => 'कोण के गाइड के अनुसार फोन झुकाएँ';

  @override
  String get promptReady => 'फोटो लेने के लिए तैयार';

  @override
  String get lightTooDark => 'बहुत अंधेरा';

  @override
  String get lightLow => 'कम';

  @override
  String get lightOk => 'ठीक';

  @override
  String get lightBright => 'तेज';

  @override
  String get distanceMoveCloser => 'पास आइए';

  @override
  String get distanceOk => 'ठीक';

  @override
  String get distanceMoveBack => 'पीछे हटें';

  @override
  String get centreMoveIn => 'अंदर लाइए';

  @override
  String get centreOk => 'ठीक';

  @override
  String get advisoryGoodHeadline => 'अभी रोशनी अच्छी है';

  @override
  String get advisoryGoodDetail =>
      'प्राकृतिक रोशनी नरम है, रंग साफ और सही दिखेंगे।';

  @override
  String get advisoryOverheadHeadline => 'सिर के ऊपर धूप';

  @override
  String get advisoryOverheadDetail =>
      'फोटो थोड़ी देर बाद लें, जब धूप नरम हो। अभी ऊपर की धूप से सेटअप पर कड़ी छाया पड़ सकती है।';

  @override
  String get advisoryDarkHeadline => 'दिन की रोशनी काफी नहीं';

  @override
  String get advisoryDarkDetail =>
      'अभी प्राकृतिक रोशनी कम है। सुबह खिड़की के पास रंग सबसे सही दिखते हैं।';

  @override
  String get openingTagline => 'हस्तशिल्प उत्पादों के लिए गाइडेड फोटोग्राफी';

  @override
  String get openingChipLight => 'रोशनी: अच्छी';

  @override
  String get openingChipAngle => 'कोण: ठीक';

  @override
  String get openingChipFrame => 'फ्रेम: तैयार';

  @override
  String get guidelineG1Title => 'क्लोज-अप शॉट लें';

  @override
  String get guidelineG1Body =>
      'कपड़े की बारीक बनावट, विवरण और कारीगरी दिखाएँ।';

  @override
  String get guidelineG2Title => 'कपड़े के किनारे दिखाएँ';

  @override
  String get guidelineG2Body =>
      'कपड़े का किनारा कैद करें, तस्वीर का दो-तिहाई हिस्सा कपड़े से भरा हो।';

  @override
  String get guidelineG3Title => 'कई कोणों से फोटो लें';

  @override
  String get guidelineG3Body =>
      'डिज़ाइन और बनावट दिखाने के लिए उत्पाद को कई नज़रों से दिखाएँ।';

  @override
  String get guidelineG4Title => 'अलग-अलग रोशनी आज़माएँ';

  @override
  String get guidelineG4Body =>
      'प्राकृतिक और कृत्रिम रोशनी, घर के अंदर और बाहर, सामने और बगल से — ताकि कपड़े के असली रंग और गहराई दिखें।';

  @override
  String get guidelineG5Title => 'सही पृष्ठभूमि चुनें';

  @override
  String get guidelineG5Body =>
      'ऐसी पृष्ठभूमि रखें जो कपड़े की खूबसूरती बढ़ाए, उस पर हावी न हो।';

  @override
  String get guidelineG6Title => 'प्राकृतिक सिलवटें रहने दें';

  @override
  String get guidelineG6Body =>
      'कपड़े को इस्त्री किए बिना, उसके असली रूप में फोटो लें ताकि सामग्री साफ समझ आए।';

  @override
  String get guidelineG7Title => 'वज़न और बहना दिखाएँ';

  @override
  String get guidelineG7Body =>
      'कपड़ा कैसे लटकता, मुड़ता और बहता है, वही उसके वज़न और अहसास को बताता है।';

  @override
  String get guidelineG8Title => 'एक कहानी बताएँ';

  @override
  String get guidelineG8Body =>
      'फोटो ऐसे फ्रेम करें कि कपड़ा अपनी संस्कृति, कारीगरों और इस्तेमाल से जुड़कर दिखे।';

  @override
  String get categorySaree => 'साड़ी';

  @override
  String get categoryCushionCover => 'कुशन कवर';

  @override
  String get categoryShawl => 'शॉल';

  @override
  String get categoryStole => 'स्टोल';

  @override
  String get categorySarees => 'साड़ियाँ';

  @override
  String get categoryCushionCovers => 'कुशन कवर';

  @override
  String get categoryShawls => 'शॉल';

  @override
  String get categoryStoles => 'स्टोल';

  @override
  String get nounSaree => 'साड़ी';

  @override
  String get nounCushionCover => 'कुशन कवर';

  @override
  String get nounShawl => 'शॉल';

  @override
  String get nounStole => 'स्टोल';

  @override
  String get nounProduct => 'उत्पाद';

  @override
  String get materialSilk => 'रेशम';

  @override
  String get materialCotton => 'कपास';

  @override
  String get materialWool => 'ऊन';

  @override
  String get materialJute => 'जूट';

  @override
  String get materialSilkLower => 'रेशम';

  @override
  String get materialCottonLower => 'कपास';

  @override
  String get materialWoolLower => 'ऊन';

  @override
  String get materialJuteLower => 'जूट';

  @override
  String get silkMulberry => 'मलबरी';

  @override
  String get silkEri => 'एरी';

  @override
  String get silkTasar => 'तसर';

  @override
  String get silkMuga => 'मूगा';

  @override
  String get cottonKhadi => 'खादी';

  @override
  String get cottonMuslin => 'मलमल';

  @override
  String get cottonHandloom => 'हथकरघा';

  @override
  String get cottonJamdani => 'जमदानी';

  @override
  String get woolPashmina => 'पश्मीना';

  @override
  String get woolAngora => 'एंगोरा';

  @override
  String get woolMerino => 'मेरिनो';

  @override
  String get woolHandspun => 'हाथ से काता';

  @override
  String get juteGolden => 'सुनहरा';

  @override
  String get juteTossa => 'टोसा';

  @override
  String get juteHessian => 'हेसियन';

  @override
  String get juteBlended => 'मिश्रित';

  @override
  String get shotProcess => 'प्रक्रिया';

  @override
  String get shotProduct => 'उत्पाद';

  @override
  String get shotDetail => 'विवरण';

  @override
  String get shotLifestyle => 'लाइफस्टाइल';

  @override
  String get shotPhotography => 'फोटोग्राफी';

  @override
  String get shotProcessChecklist => 'बनाने की प्रक्रिया दिखाएँ';

  @override
  String get shotProductChecklist => 'पूरी वस्तु की फोटो';

  @override
  String get shotDetailChecklist => 'बनावट/बुनाई के क्लोज-अप';

  @override
  String get shotLifestyleChecklist => 'प्राकृतिक सेटिंग में';

  @override
  String get shotPhotographyChecklist => 'साड़ी फोटोग्राफी टेम्पलेट';

  @override
  String get slotLoomSetup => 'करघा सेटअप';

  @override
  String get slotDyeing => 'रंगाई';

  @override
  String get slotHeroShot => 'मुख्य फोटो';

  @override
  String get slotBorder => 'बॉर्डर';

  @override
  String get slotWeave => 'बुनाई';

  @override
  String get slotMotif => 'मोटिफ';

  @override
  String get slotStyledShot => 'स्टाइल वाली फोटो';

  @override
  String get templateFullDisplay => 'पूरी साड़ी का प्रदर्शन';

  @override
  String get templateTextureWeave => 'बनावट और बुनाई';

  @override
  String get templateDrapedLook => 'ड्रेप लुक';

  @override
  String get templateEmbroideryBorder => 'कढ़ाई और बॉर्डर का विवरण';

  @override
  String get templateFoldedStack => 'मुड़ी हुई ढेर / साड़ी स्टैक';

  @override
  String get templateFullDisplayLower => 'पूरी साड़ी का प्रदर्शन';

  @override
  String get templateTextureWeaveLower => 'बनावट और बुनाई';

  @override
  String get templateDrapedLookLower => 'ड्रेप लुक';

  @override
  String get templateEmbroideryBorderLower => 'कढ़ाई और बॉर्डर का विवरण';

  @override
  String get templateFoldedStackLower => 'मुड़ी हुई ढेर / साड़ी स्टैक';

  @override
  String get templateFullDisplayContent => 'रंग, पैटर्न, सामग्री';

  @override
  String get templateTextureWeaveContent => 'बनावट, मोटाई, सामग्री, पारदर्शिता';

  @override
  String get templateDrapedLookContent => 'हलकापन, चमक, बहना, वज़न';

  @override
  String get templateEmbroideryBorderContent => 'कढ़ाई, गुणवत्ता';

  @override
  String get templateFoldedStackContent => 'मोटाई, सामग्री का वज़न';

  @override
  String get templateFullDisplayNeeds =>
      'प्राकृतिक दिन की रोशनी; सादा या विपरीत पृष्ठभूमि';

  @override
  String get templateTextureWeaveNeeds => 'जितना हो सके प्राकृतिक रोशनी';

  @override
  String get templateDrapedLookNeeds => 'हैंगर, बाँस या पुतला; बगल की रोशनी';

  @override
  String get templateEmbroideryBorderNeeds => 'बगल की रोशनी; विपरीत पृष्ठभूमि';

  @override
  String get templateFoldedStackNeeds => 'बगल की रोशनी';

  @override
  String get templateFullDisplayPlacement =>
      'साड़ी को समतल फैलाएँ या सतह पर लटकाएँ';

  @override
  String get templateTextureWeavePlacement =>
      'साड़ी का अच्छा रोशन हिस्सा, बेहतर हो प्राकृतिक रोशनी में';

  @override
  String get templateDrapedLookPlacement => 'हैंगर, बाँस या पुतला';

  @override
  String get templateEmbroideryBorderPlacement =>
      'साड़ी के बॉर्डर या कढ़ाई वाले हिस्से का क्लोज-अप';

  @override
  String get templateFoldedStackPlacement => 'साफ-सुथरी ढेर, मोड़ दिखते हुए';

  @override
  String get templateFullDisplayOverlay =>
      'ऊपरी बॉर्डर को ग्रिड के ऊपरी तिहाई से मिलाएँ';

  @override
  String get templateTextureWeaveOverlay => 'बनावट को केंद्र में रखें';

  @override
  String get templateDrapedLookOverlay =>
      'मोड़ों को तिरछी रेखाओं के साथ बहने दें';

  @override
  String get templateEmbroideryBorderOverlay => 'कढ़ाई को फ्रेम के अंदर रखें';

  @override
  String get templateFoldedStackOverlay =>
      'मोड़ों को आड़ी रेखाओं के समांतर रखें';

  @override
  String get templateTextureWeaveLighting => 'नरम रोशनी रखें। तेज चमक से बचें।';

  @override
  String get templateCushionFullCover => 'पूरे कवर का प्रदर्शन';

  @override
  String get templateCushionTextureWeave => 'बनावट और बुनाई';

  @override
  String get templateCushionStackedPair => 'जोड़ी की ढेर / मोटाई';

  @override
  String get templateCushionCornerStitching => 'कोना और सिलाई';

  @override
  String get templateCushionInUse => 'सीट पर उपयोग में';

  @override
  String get templateCushionFullCoverLower => 'पूरे कवर का प्रदर्शन';

  @override
  String get templateCushionTextureWeaveLower => 'बनावट और बुनाई';

  @override
  String get templateCushionStackedPairLower => 'जोड़ी की ढेर / मोटाई';

  @override
  String get templateCushionCornerStitchingLower => 'कोना और सिलाई';

  @override
  String get templateCushionInUseLower => 'सीट पर उपयोग में';

  @override
  String get templateCushionFullCoverContent => 'रंग, पैटर्न, सामग्री';

  @override
  String get templateCushionTextureWeaveContent => 'बनावट, मोटाई, सामग्री';

  @override
  String get templateCushionStackedPairContent => 'मोटाई, सामग्री, बनावट';

  @override
  String get templateCushionCornerStitchingContent => 'गुणवत्ता, बनावट, कढ़ाई';

  @override
  String get templateCushionInUseContent => 'रंग, पैटर्न, गुणवत्ता';

  @override
  String get templateCushionFullCoverNeeds =>
      'प्राकृतिक दिन की रोशनी; सादा सतह';

  @override
  String get templateCushionTextureWeaveNeeds => 'जितना हो सके प्राकृतिक रोशनी';

  @override
  String get templateCushionStackedPairNeeds => 'बगल की रोशनी; एक जोड़ी कवर';

  @override
  String get templateCushionCornerStitchingNeeds => 'बगल की रोशनी';

  @override
  String get templateCushionInUseNeeds => 'कुर्सी, सोफा या बिस्तर';

  @override
  String get templateCushionFullCoverPlacement =>
      'कवर को सादी सतह पर समतल रखें';

  @override
  String get templateCushionTextureWeavePlacement => 'कवर का अच्छा रोशन हिस्सा';

  @override
  String get templateCushionStackedPairPlacement =>
      'दो कवर ऐसे ढेर करें कि किनारे कैमरे की ओर हों';

  @override
  String get templateCushionCornerStitchingPlacement =>
      'सिलाई वाले कोने का क्लोज-अप';

  @override
  String get templateCushionInUsePlacement =>
      'कवर को सीट पर टिकाएँ, कैमरे की ओर';

  @override
  String get templateCushionFullCoverOverlay =>
      'किनारों को ग्रिड के साथ सीधा रखें';

  @override
  String get templateCushionTextureWeaveOverlay => 'बनावट को केंद्र में रखें';

  @override
  String get templateCushionStackedPairOverlay =>
      'मोड़ों को आड़ी रेखाओं के समांतर रखें';

  @override
  String get templateCushionCornerStitchingOverlay =>
      'सिलाई को फ्रेम के अंदर रखें';

  @override
  String get templateCushionInUseOverlay => 'कवर को फ्रेम में रखें';

  @override
  String get templateShawlFullDesign => 'पूरे डिज़ाइन का प्रदर्शन';

  @override
  String get templateShawlTextureWeave => 'बनावट और बुनाई';

  @override
  String get templateShawlDrapedLook => 'ड्रेप लुक';

  @override
  String get templateShawlBorderCorner => 'बॉर्डर और कोना';

  @override
  String get templateShawlFoldedStack => 'मुड़ी हुई ढेर';

  @override
  String get templateShawlFullDesignLower => 'पूरे डिज़ाइन का प्रदर्शन';

  @override
  String get templateShawlTextureWeaveLower => 'बनावट और बुनाई';

  @override
  String get templateShawlDrapedLookLower => 'ड्रेप लुक';

  @override
  String get templateShawlBorderCornerLower => 'बॉर्डर और कोना';

  @override
  String get templateShawlFoldedStackLower => 'मुड़ी हुई ढेर';

  @override
  String get templateShawlFullDesignContent => 'पैटर्न, रंग, पारदर्शिता';

  @override
  String get templateShawlTextureWeaveContent => 'बनावट, मोटाई, सामग्री';

  @override
  String get templateShawlDrapedLookContent => 'हलकापन, सामग्री, पैटर्न';

  @override
  String get templateShawlBorderCornerContent => 'बनावट, गुणवत्ता, कढ़ाई';

  @override
  String get templateShawlFoldedStackContent => 'मोटाई, सामग्री';

  @override
  String get templateShawlFullDesignNeeds =>
      'रस्सी, बाँस या दीवार जिस पर पिन करें';

  @override
  String get templateShawlTextureWeaveNeeds => 'जितना हो सके प्राकृतिक रोशनी';

  @override
  String get templateShawlDrapedLookNeeds => 'शॉल पहनने वाला कोई व्यक्ति';

  @override
  String get templateShawlBorderCornerNeeds => 'बगल की रोशनी';

  @override
  String get templateShawlFoldedStackNeeds => 'बगल की रोशनी';

  @override
  String get templateShawlFullDesignPlacement =>
      'शॉल बिना झुके समतल लटकाएँ या पिन करें';

  @override
  String get templateShawlTextureWeavePlacement => 'शॉल का अच्छा रोशन हिस्सा';

  @override
  String get templateShawlDrapedLookPlacement =>
      'शॉल एक कंधे पर, प्राकृतिक रूप से गिरता हुआ';

  @override
  String get templateShawlBorderCornerPlacement => 'कोने और बॉर्डर का क्लोज-अप';

  @override
  String get templateShawlFoldedStackPlacement =>
      'साफ-सुथरी ढेर, मोड़ दिखते हुए';

  @override
  String get templateShawlFullDesignOverlay =>
      'बॉर्डर को ग्रिड के ऊपरी तिहाई से मिलाएँ';

  @override
  String get templateShawlTextureWeaveOverlay => 'बनावट को केंद्र में रखें';

  @override
  String get templateShawlDrapedLookOverlay =>
      'मोड़ों को तिरछी रेखाओं के साथ बहने दें';

  @override
  String get templateShawlBorderCornerOverlay => 'बॉर्डर को फ्रेम के अंदर रखें';

  @override
  String get templateShawlFoldedStackOverlay =>
      'मोड़ों को आड़ी रेखाओं के समांतर रखें';

  @override
  String get templateStoleFullLength => 'पूरी लंबाई का प्रदर्शन';

  @override
  String get templateStoleTextureWeave => 'बनावट और बुनाई';

  @override
  String get templateStoleNeckWrap => 'पहना हुआ गर्दन रैप';

  @override
  String get templateStoleSoftnessKnot => 'नरमपन / गाँठ';

  @override
  String get templateStoleEdgeThickness => 'किनारा और मोटाई';

  @override
  String get templateStoleFullLengthLower => 'पूरी लंबाई का प्रदर्शन';

  @override
  String get templateStoleTextureWeaveLower => 'बनावट और बुनाई';

  @override
  String get templateStoleNeckWrapLower => 'पहना हुआ गर्दन रैप';

  @override
  String get templateStoleSoftnessKnotLower => 'नरमपन / गाँठ';

  @override
  String get templateStoleEdgeThicknessLower => 'किनारा और मोटाई';

  @override
  String get templateStoleFullLengthContent => 'पैटर्न, रंग, सामग्री';

  @override
  String get templateStoleTextureWeaveContent => 'बनावट, मोटाई, सामग्री';

  @override
  String get templateStoleNeckWrapContent => 'हलकापन, रंग, पैटर्न';

  @override
  String get templateStoleSoftnessKnotContent => 'हलकापन, बनावट, सामग्री';

  @override
  String get templateStoleEdgeThicknessContent => 'मोटाई, बनावट, सामग्री';

  @override
  String get templateStoleFullLengthNeeds => 'प्राकृतिक दिन की रोशनी; सादा सतह';

  @override
  String get templateStoleTextureWeaveNeeds => 'जितना हो सके प्राकृतिक रोशनी';

  @override
  String get templateStoleNeckWrapNeeds => 'स्टोल पहनने वाला कोई व्यक्ति';

  @override
  String get templateStoleSoftnessKnotNeeds => 'नरम बगल की रोशनी';

  @override
  String get templateStoleEdgeThicknessNeeds => 'नरम बगल की रोशनी';

  @override
  String get templateStoleFullLengthPlacement =>
      'स्टोल को पूरी लंबाई दिखने तक फैलाएँ';

  @override
  String get templateStoleTextureWeavePlacement => 'स्टोल का अच्छा रोशन हिस्सा';

  @override
  String get templateStoleNeckWrapPlacement =>
      'गर्दन पर एक बार लपेटें, दोनों सिरे दिखें';

  @override
  String get templateStoleSoftnessKnotPlacement => 'बीच में एक ढीली गाँठ';

  @override
  String get templateStoleEdgeThicknessPlacement =>
      'स्टोल को ढीला कुंडली में लपेटें';

  @override
  String get templateStoleFullLengthOverlay => 'स्टोल को ग्रिड के साथ रखें';

  @override
  String get templateStoleTextureWeaveOverlay => 'बनावट को केंद्र में रखें';

  @override
  String get templateStoleNeckWrapOverlay => 'रैप को फ्रेम में रखें';

  @override
  String get templateStoleSoftnessKnotOverlay => 'गाँठ को केंद्र में रखें';

  @override
  String get templateStoleEdgeThicknessOverlay => 'कुंडली को केंद्र में रखें';

  @override
  String get presetSareePalluDrapeName => 'पल्लू ड्रेप (हैंगर)';

  @override
  String get presetSareeBoxFoldName => 'बॉक्स / समतल मोड़';

  @override
  String get presetSareeWornDrapeName => 'पहनी हुई ड्रेप (मॉडल)';

  @override
  String get presetSareeRollDisplayName => 'रोल प्रदर्शन';

  @override
  String get presetCushionFlatLayName => 'फ्लैट ले';

  @override
  String get presetCushionStackedPairName => 'जोड़ी की ढेर';

  @override
  String get presetCushionProppedName => 'सीट पर टिकाकर';

  @override
  String get presetCushionCornerTuckName => 'कोने का क्लोज-अप';

  @override
  String get presetShawlDrapedShoulderName => 'कंधे पर लिपटा';

  @override
  String get presetShawlFoldedStackName => 'मुड़ी हुई ढेर';

  @override
  String get presetShawlHungFlatName => 'लटका / समतल पिन किया';

  @override
  String get presetShawlCornerTuckName => 'कोने का क्लोज-अप';

  @override
  String get presetStoleNeckWrapName => 'गर्दन पर लिपटा (पहना हुआ)';

  @override
  String get presetStoleFlatSpreadName => 'समतल फैलाया';

  @override
  String get presetStoleLooseKnotName => 'ढीली गाँठ';

  @override
  String get presetStoleRolledCoilName => 'रोल की कुंडली';

  @override
  String get presetSareePalluDrapePurpose =>
      'हलकापन, चमक, बहना और वज़न दिखाता है।';

  @override
  String get presetSareeBoxFoldPurpose => 'मोटाई और सामग्री का वज़न दिखाता है।';

  @override
  String get presetSareeWornDrapePurpose =>
      'पहनने पर रंग, पैटर्न और सामग्री दिखाता है।';

  @override
  String get presetSareeRollDisplayPurpose =>
      'कॉम्पैक्ट रोल में रंग, पैटर्न और सामग्री दिखाता है।';

  @override
  String get presetCushionFlatLayPurpose =>
      'पूरा पैटर्न और रंग बिना बिगाड़े दिखाएँ।';

  @override
  String get presetCushionStackedPairPurpose =>
      'मोटाई और जोड़ी कैसी लगती है, दिखाएँ।';

  @override
  String get presetCushionProppedPurpose =>
      'कवर इस्तेमाल में, असल आकार में दिखाएँ।';

  @override
  String get presetCushionCornerTuckPurpose => 'कोने पर सिलाई और फिनिश दिखाएँ।';

  @override
  String get presetShawlDrapedShoulderPurpose =>
      'ड्रेप, वज़न और पहनने पर बैठना दिखाएँ।';

  @override
  String get presetShawlFoldedStackPurpose =>
      'मोटाई और सामग्री का वज़न दिखाएँ।';

  @override
  String get presetShawlHungFlatPurpose =>
      'पूरा डिज़ाइन, रंग और बॉर्डर एक साथ दिखाएँ।';

  @override
  String get presetShawlCornerTuckPurpose => 'बुनाई, बॉर्डर और कारीगरी दिखाएँ।';

  @override
  String get presetStoleNeckWrapPurpose =>
      'आकार और पहनने पर स्टोल कैसे बैठता है, दिखाएँ।';

  @override
  String get presetStoleFlatSpreadPurpose =>
      'पूरी लंबाई, पैटर्न और दोनों बॉर्डर दिखाएँ।';

  @override
  String get presetStoleLooseKnotPurpose =>
      'कपड़ा कितना नरम है और कितनी आसानी से बँधता है, दिखाएँ।';

  @override
  String get presetStoleRolledCoilPurpose =>
      'किनारा, मोटाई और बुनाई की फिनिश दिखाएँ।';

  @override
  String get presetSareePalluDrapeContent => 'हलकापन, चमक, बहना, वज़न';

  @override
  String get presetSareeBoxFoldContent => 'मोटाई, सामग्री का वज़न';

  @override
  String get presetSareeWornDrapeContent => 'रंग, पैटर्न, सामग्री';

  @override
  String get presetSareeRollDisplayContent => 'रंग, पैटर्न, सामग्री';

  @override
  String get presetSareePalluDrapeNeeds => 'हैंगर, बाँस या पुतला; बगल की रोशनी';

  @override
  String get presetSareeBoxFoldNeeds => 'बगल की रोशनी';

  @override
  String get presetSareeWornDrapeNeeds =>
      'साड़ी पहनने वाला कोई; प्राकृतिक दिन की रोशनी; सादा या विपरीत पृष्ठभूमि';

  @override
  String get presetSareeRollDisplayNeeds =>
      'प्राकृतिक दिन की रोशनी; सादा या विपरीत पृष्ठभूमि';

  @override
  String get presetSareePalluDrapeLower => 'पल्लू ड्रेप (हैंगर)';

  @override
  String get presetSareeBoxFoldLower => 'बॉक्स / समतल मोड़';

  @override
  String get presetSareeWornDrapeLower => 'पहनी हुई ड्रेप (मॉडल)';

  @override
  String get presetSareeRollDisplayLower => 'रोल प्रदर्शन';

  @override
  String get presetCushionFlatLayLower => 'फ्लैट ले';

  @override
  String get presetCushionStackedPairLower => 'जोड़ी की ढेर';

  @override
  String get presetCushionProppedLower => 'सीट पर टिकाकर';

  @override
  String get presetCushionCornerTuckLower => 'कोने का क्लोज-अप';

  @override
  String get presetShawlDrapedShoulderLower => 'कंधे पर लिपटा';

  @override
  String get presetShawlFoldedStackLower => 'मुड़ी हुई ढेर';

  @override
  String get presetShawlHungFlatLower => 'लटका / समतल पिन किया';

  @override
  String get presetShawlCornerTuckLower => 'कोने का क्लोज-अप';

  @override
  String get presetStoleNeckWrapLower => 'गर्दन पर लिपटा (पहना हुआ)';

  @override
  String get presetStoleFlatSpreadLower => 'समतल फैलाया';

  @override
  String get presetStoleLooseKnotLower => 'ढीली गाँठ';

  @override
  String get presetStoleRolledCoilLower => 'रोल की कुंडली';

  @override
  String get shotProcessLower => 'प्रक्रिया';

  @override
  String get shotProductLower => 'उत्पाद';

  @override
  String get shotDetailLower => 'विवरण';

  @override
  String get shotLifestyleLower => 'लाइफस्टाइल';

  @override
  String get shotPhotographyLower => 'फोटोग्राफी';

  @override
  String get categorySareeLower => 'साड़ी';

  @override
  String get categoryCushionCoverLower => 'कुशन कवर';

  @override
  String get categoryShawlLower => 'शॉल';

  @override
  String get categoryStoleLower => 'स्टोल';

  @override
  String get propertyColour => 'रंग';

  @override
  String get propertyMaterial => 'सामग्री';

  @override
  String get propertyQuality => 'गुणवत्ता';

  @override
  String get propertyFlimsiness => 'हलकापन';

  @override
  String get propertyTexture => 'बनावट';

  @override
  String get propertyThickness => 'मोटाई';

  @override
  String get propertyTransparency => 'पारदर्शिता';

  @override
  String get propertyPattern => 'पैटर्न';

  @override
  String get propertySheen => 'चमक';

  @override
  String get propertyEmbroidery => 'कढ़ाई';

  @override
  String get angleEyeLevel => 'आँखों की ऊँचाई';

  @override
  String get angleEyeLevelHint => 'फोन को उत्पाद की ऊँचाई पर, सीधे सामने रखें।';

  @override
  String get angleOverhead => 'ऊपर से (फ्लैट ले)';

  @override
  String get angleOverheadHint => 'उत्पाद के ऊपर खड़े होकर फोन सीधे नीचे करें।';

  @override
  String get angleLow => 'नीचे से कोण';

  @override
  String get angleLowHint => 'फोन को उत्पाद से नीचे करें और थोड़ा ऊपर झुकाएँ।';

  @override
  String get angleMacro => 'मैक्रो क्लोज-अप';

  @override
  String get angleMacroHint =>
      'पास जाएँ जब तक बुनाई फ्रेम भर दे, फिर फोकस के लिए टैप करें।';

  @override
  String get lightingSoftWindow => 'नरम खिड़की की रोशनी';

  @override
  String get lightingSoftWindowHint =>
      'उत्पाद को खिड़की के पास रखें, बल्ब के नीचे नहीं।';

  @override
  String get lightingDiffused => 'फैली दिन की रोशनी';

  @override
  String get lightingDiffusedHint =>
      'बाहर खुली छाया में फोटो लें, रोशनी एक तरफ से आए।';

  @override
  String get lightingAvoidMidday => 'दोपहर की तेज धूप से बचें';

  @override
  String get lightingAvoidMiddayHint =>
      'तीन बजे के बाद लें — सिर के ऊपर धूप रंग उड़ा देती है।';

  @override
  String get lightingBacklight => 'पतले कपड़े के लिए पीछे की रोशनी';

  @override
  String get lightingBacklightHint =>
      'रोशनी कपड़े के पीछे रखें, ताकि पारदर्शिता दिखे।';

  @override
  String get compositionRuleOfThirds => 'तिहाई का नियम';

  @override
  String get compositionRuleOfThirdsHint =>
      'बॉर्डर को ग्रिड के ऊपरी तिहाई से मिलाएँ।';

  @override
  String get compositionCentered => 'केंद्र में उत्पाद';

  @override
  String get compositionCenteredHint =>
      'उत्पाद को ग्रिड के बीच वाले बॉक्स में रखें।';

  @override
  String get compositionNegativeSpace => 'मोड़ों के चारों ओर खाली जगह';

  @override
  String get compositionNegativeSpaceHint =>
      'मोड़ों के चारों ओर खाली जगह छोड़ें ताकि वे साफ दिखें।';

  @override
  String get compositionLeadingLines => 'कपड़े की तिरछी रेखाएँ';

  @override
  String get compositionLeadingLinesHint =>
      'मोड़ों को तिरछी गाइड के साथ बिछाएँ।';

  @override
  String get compositionCentreFocus => 'केंद्र फोकस';

  @override
  String get compositionCentreFocusHint => 'बनावट को फ्रेम के केंद्र में रखें।';

  @override
  String get compositionDetailFrame => 'विवरण फ्रेम';

  @override
  String get compositionDetailFrameHint =>
      'कढ़ाई को हाइलाइट किए फ्रेम के अंदर रखें।';

  @override
  String get accountBackup => 'खाता और बैकअप';

  @override
  String get accountBackupSubtitle =>
      'प्रगति ऑनलाइन सहेजने के लिए उपयोगकर्ता नाम और पासवर्ड बनाएँ।';

  @override
  String get cloudBackupNotConfigured => 'क्लाउड बैकअप तैयार नहीं है';

  @override
  String get cloudBackupNotConfiguredBody =>
      'इस बिल्ड में क्लाउड कनेक्शन नहीं है। प्रगति केवल इस फ़ोन पर रहती है।';

  @override
  String get signedInAs => 'साइन इन है';

  @override
  String get artisanFallback => 'कारीगर';

  @override
  String get syncNow => 'अभी सिंक करें';

  @override
  String get signOut => 'साइन आउट';

  @override
  String get createAccountPrompt => 'अपना काम ऑनलाइन सहेजने के लिए खाता बनाएँ।';

  @override
  String get signInPrompt =>
      'सहेजे गए उत्पाद और फ़ोटो लोड करने के लिए साइन इन करें।';

  @override
  String get username => 'उपयोगकर्ता नाम';

  @override
  String get usernameHint => 'जैसे priya_weaver';

  @override
  String get password => 'पासवर्ड';

  @override
  String get createAccount => 'खाता बनाएँ';

  @override
  String get signIn => 'साइन इन';

  @override
  String get alreadyHaveAccount => 'पहले से खाता है? साइन इन करें';

  @override
  String get needAccount => 'खाता चाहिए? एक बनाएँ';

  @override
  String get accountCreated => 'खाता बन गया। आपकी प्रगति ऑनलाइन सिंक होगी।';

  @override
  String get signedInSuccess => 'साइन इन हो गया। आपका सहेजा काम इस फ़ोन पर है।';

  @override
  String get signedOutSuccess =>
      'साइन आउट हो गया। स्थानीय फ़ोटो इस फ़ोन पर रहेंगे।';

  @override
  String get syncOffline => 'इंटरनेट नहीं — वापस ऑनलाइन आने पर सिंक करें।';

  @override
  String syncDone(int sets, int shots) {
    return 'सिंक हुआ: $sets उत्पाद अपलोड, $shots फ़ोटो अपलोड।';
  }

  @override
  String get syncUpToDate => 'सब कुछ पहले से अपडेट है।';

  @override
  String syncFailed(String error) {
    return 'सिंक असफल: $error';
  }

  @override
  String get yourProgress => 'आपकी प्रगति';

  @override
  String get productsStarted => 'शुरू किए उत्पाद';

  @override
  String get finishedSets => 'पूर्ण सेट';

  @override
  String get inProgressSets => 'जारी';

  @override
  String get photosCaptured => 'ली गई फ़ोटो';

  @override
  String get usernameTooShort =>
      'उपयोगकर्ता नाम कम से कम 3 अक्षर या अंक का होना चाहिए।';

  @override
  String get usernameTooLong =>
      'उपयोगकर्ता नाम 32 अक्षरों से अधिक नहीं होना चाहिए।';

  @override
  String get passwordTooShort => 'पासवर्ड कम से कम 6 अक्षर का होना चाहिए।';

  @override
  String get fullScreen => 'पूर्ण स्क्रीन';

  @override
  String get tapToSkip => 'छोड़ने के लिए टैप करें';

  @override
  String get cameraPermissionNeeded =>
      'फ़ोटो लेने के लिए कैमरा अनुमति चाहिए।\nकृपया सेटिंग्स में कैमरा एक्सेस दें।';

  @override
  String get cameraUnavailable => 'कैमरा उपलब्ध नहीं है।';

  @override
  String get noCameraFound => 'इस डिवाइस पर कोई कैमरा नहीं मिला।';

  @override
  String get accountCreateFailed => 'खाता नहीं बन सका। फिर कोशिश करें।';

  @override
  String get enterValidUsername => 'सही उपयोगकर्ता नाम डालें।';

  @override
  String get monthJan => 'जन';

  @override
  String get monthFeb => 'फर';

  @override
  String get monthMar => 'मार्च';

  @override
  String get monthApr => 'अप्रै';

  @override
  String get monthMay => 'मई';

  @override
  String get monthJun => 'जून';

  @override
  String get monthJul => 'जुल';

  @override
  String get monthAug => 'अग';

  @override
  String get monthSep => 'सित';

  @override
  String get monthOct => 'अक्टू';

  @override
  String get monthNov => 'नव';

  @override
  String get monthDec => 'दिस';

  @override
  String get presetCushionFlatLayNeeds => 'सादा, साफ़ सतह';

  @override
  String get presetCushionStackedPairNeeds => 'दो कवर; बगल की रोशनी';

  @override
  String get presetCushionProppedNeeds => 'कुर्सी, सोफ़ा या बिस्तर';

  @override
  String get presetCushionCornerTuckNeeds => 'क्लोज-अप रोशनी';

  @override
  String get presetShawlDrapedShoulderNeeds => 'शॉल पहनाने वाला कोई व्यक्ति';

  @override
  String get presetShawlFoldedStackNeeds => 'बगल की रोशनी';

  @override
  String get presetShawlHungFlatNeeds => 'रस्सी, बाँस या दीवार जहाँ पिन करें';

  @override
  String get presetShawlCornerTuckNeeds => 'क्लोज-अप रोशनी';

  @override
  String get presetStoleNeckWrapNeeds => 'स्टोल पहनाने वाला कोई व्यक्ति';

  @override
  String get presetStoleFlatSpreadNeeds => 'सादी सतह; ऊपर से नज़र';

  @override
  String get presetStoleLooseKnotNeeds => 'नरम बगल की रोशनी';

  @override
  String get presetStoleRolledCoilNeeds => 'नरम बगल की रोशनी';

  @override
  String get placementSareePalluDrape =>
      'साड़ी को हैंगर, बाँस या मैनक्विन पर लटकाएँ ताकि पल्लू आज़ाद लटके।';

  @override
  String get placementSareeBoxFold =>
      'साड़ी को बराबर परतों में मोड़कर ढेर करें ताकि किनारा दिखे।';

  @override
  String get placementSareeWornDrape =>
      'व्यक्ति पर साड़ी इस तरह लपेटें कि रंग, पैटर्न और बॉर्डर साफ़ दिखें।';

  @override
  String get placementSareeRollDisplay =>
      'साड़ी को ऐसे रोल करें कि पल्लू और बॉर्डर कैमरे की ओर हों।';

  @override
  String get placementCushionFlatLay => 'कवर को सादी, साफ़ सतह पर समतल रखें।';

  @override
  String get placementCushionStackedPair =>
      'एक कवर को दूसरे पर साफ़-सुथरे ढंग से रखें।';

  @override
  String get placementCushionPropped =>
      'कुशन को कुर्सी या सोफ़े पर आगे की ओर टिकाएँ।';

  @override
  String get placementCushionCornerTuck =>
      'कवर घुमाएँ ताकि सिला हुआ एक कोना आपके सामने हो।';

  @override
  String get placementShawlDrapedShoulder =>
      'शॉल एक कंधे पर रखें और उसे लटकने दें।';

  @override
  String get placementShawlFoldedStack =>
      'शॉल को बराबर परतों में मोड़कर साफ़ ढेर करें।';

  @override
  String get placementShawlHungFlat =>
      'दोनों ऊपरी कोनों को पिन करें ताकि शॉल बीच में न झुके।';

  @override
  String get placementShawlCornerTuck =>
      'एक कोना पीछे मोड़ें ताकि बुनाई के दोनों पहलू दिखें।';

  @override
  String get placementStoleNeckWrap =>
      'गर्दन पर एक बार लपेटें, दोनों सिरे लटकने दें।';

  @override
  String get placementStoleFlatSpread =>
      'स्टोल को समतल फैलाएँ ताकि पूरी लंबाई दिखे।';

  @override
  String get placementStoleLooseKnot =>
      'बीच में एक ढीली गाँठ बाँधें — कसकर न खींचें।';

  @override
  String get placementStoleRolledCoil =>
      'स्टोल को ढीला समतल कुंडली में रोल करें।';

  @override
  String get transcriptSareePalluDrape1 =>
      'साड़ी ऐसे लटकाएँ कि उसका गिरना साफ़ दिखे।';

  @override
  String get transcriptSareePalluDrape2 =>
      'कंधे की ऊँचाई पर हैंगर, बाँस या मैनक्विन का उपयोग करें।';

  @override
  String get transcriptSareePalluDrape3 =>
      'पल्लू को आज़ाद लटकने दें — सीधा न खींचें।';

  @override
  String get transcriptSareePalluDrape4 =>
      'मोड़ स्क्रीन की तिरछी रेखाओं का अनुसरण करें।';

  @override
  String get transcriptSareePalluDrape5 =>
      'चमक दिखाने के लिए एक रोशनी बगल में रखें।';

  @override
  String get transcriptSareeBoxFold1 =>
      'साड़ी को साफ़ ढेर में मोड़ें ताकि परतें दिखें।';

  @override
  String get transcriptSareeBoxFold2 =>
      'मुड़ा किनारा कैमरे की ओर रखें — वह मोटाई दिखाता है।';

  @override
  String get transcriptSareeBoxFold3 => 'मोड़ों को क्षैतिज गाइड से मिलाएँ।';

  @override
  String get transcriptSareeBoxFold4 =>
      'हर परत में गहराई के लिए बगल से रोशनी लें।';

  @override
  String get transcriptSareeWornDrape1 =>
      'पहनी हुई फ़ोटो पूरी साड़ी दिखाती है — रंग, पैटर्न और सामग्री।';

  @override
  String get transcriptSareeWornDrape2 =>
      'रंग सही रहे इसलिए खुली छाया में खड़े हों।';

  @override
  String get transcriptSareeWornDrape3 => 'साड़ी ज़्यादातर फ्रेम ढक ले।';

  @override
  String get transcriptSareeWornDrape4 =>
      'ऊपरी बॉर्डर को ग्रिड के ऊपरी तिहाई से मिलाएँ।';

  @override
  String get transcriptSareeWornDrape5 =>
      'अगर प्लीट हों तो ऊर्ध्वाधर ग्रिड रेखाओं का अनुसरण करें।';

  @override
  String get transcriptSareeRollDisplay1 =>
      'साड़ी ऐसे रोल करें कि पल्लू और बॉर्डर कैमरे की ओर हों।';

  @override
  String get transcriptSareeRollDisplay2 => 'रोल ज़्यादातर फ्रेम ढक ले।';

  @override
  String get transcriptSareeRollDisplay3 =>
      'ऊपरी बॉर्डर को ग्रिड के ऊपरी तिहाई से मिलाएँ।';

  @override
  String get transcriptSareeRollDisplay4 =>
      'रंग सही रहे इसलिए नरम दिन की रोशनी लें।';

  @override
  String get transcriptCushionFlatLay1 => 'कुशन कवर को सादी सतह पर समतल रखें।';

  @override
  String get transcriptCushionFlatLay2 =>
      'समतल करें पर प्राकृतिक बनावट रहने दें।';

  @override
  String get transcriptCushionFlatLay3 => 'फ़ोन सीधे ऊपर रखें, कोण पर नहीं।';

  @override
  String get transcriptCushionFlatLay4 => 'किनारों को ग्रिड के साथ सीधा रखें।';

  @override
  String get transcriptCushionStackedPair1 =>
      'दो कवर ढेर करें ताकि खरीदार मोटाई देख सके।';

  @override
  String get transcriptCushionStackedPair2 => 'ढेर के किनारे कैमरे की ओर रखें।';

  @override
  String get transcriptCushionStackedPair3 =>
      'हर परत की छाया के लिए बगल की रोशनी लें।';

  @override
  String get transcriptCushionPropped1 =>
      'कुर्सी पर कुशन रखने से उसका असली आकार दिखता है।';

  @override
  String get transcriptCushionPropped2 =>
      'ऐसी सीट चुनें जो पैटर्न से टक्कर न करे।';

  @override
  String get transcriptCushionPropped3 => 'आँखों की ऊँचाई से लें, ऊपर से नहीं।';

  @override
  String get transcriptCushionCornerTuck1 =>
      'कोना आपकी सिलाई सबसे साफ़ दिखाता है।';

  @override
  String get transcriptCushionCornerTuck2 =>
      'पास जाएँ जब तक कोना छोटे फ्रेम को भर दे।';

  @override
  String get transcriptCushionCornerTuck3 =>
      'फोकस के लिए सिलाई पर स्क्रीन टैप करें।';

  @override
  String get transcriptShawlDrapedShoulder1 =>
      'कंधे पर शॉल लपेटने से उसका भार दिखता है।';

  @override
  String get transcriptShawlDrapedShoulder2 =>
      'एक सिरा दूसरे से नीचे लटकने दें।';

  @override
  String get transcriptShawlDrapedShoulder3 =>
      'पिन न करें — कपड़े को अपने आप गिरने दें।';

  @override
  String get transcriptShawlFoldedStack1 =>
      'शॉल को मोड़ दिखाई देने के साथ साफ़ ढेर करें।';

  @override
  String get transcriptShawlFoldedStack2 =>
      'मोड़ों को क्षैतिज रेखाओं के समानांतर रखें।';

  @override
  String get transcriptShawlFoldedStack3 => 'मोटाई के लिए शॉल का किनारा दिखे।';

  @override
  String get transcriptShawlFoldedStack4 =>
      'हर मोड़ में गहराई के लिए बगल की रोशनी लें।';

  @override
  String get transcriptShawlHungFlat1 =>
      'समतल लटकाने से पूरा डिज़ाइन एक साथ दिखता है।';

  @override
  String get transcriptShawlHungFlat2 =>
      'दोनों ऊपरी कोनों को पिन करें ताकि बीच में न झुके।';

  @override
  String get transcriptShawlHungFlat3 => 'सीधे सामने खड़े हों, एक तरफ़ नहीं।';

  @override
  String get transcriptShawlCornerTuck1 =>
      'कोने का क्लोज-अप बुनाई और बॉर्डर साथ दिखाता है।';

  @override
  String get transcriptShawlCornerTuck2 =>
      'एक कोना पीछे मोड़ें ताकि दोनों पहलू दिखें।';

  @override
  String get transcriptShawlCornerTuck3 => 'पास जाएँ जब तक बुनाई फ्रेम भर दे।';

  @override
  String get transcriptStoleNeckWrap1 =>
      'पहनी हुई फ़ोटो सबसे आम सवाल का जवाब देती है — कितना बड़ा है?';

  @override
  String get transcriptStoleNeckWrap2 =>
      'गर्दन पर एक बार लपेटें और दोनों सिरे लटकने दें।';

  @override
  String get transcriptStoleNeckWrap3 =>
      'सीने से ऊपर लें ताकि सिरे फ्रेम में रहें।';

  @override
  String get transcriptStoleFlatSpread1 => 'स्टोल फैलाएँ ताकि पूरी लंबाई दिखे।';

  @override
  String get transcriptStoleFlatSpread2 =>
      'प्राकृतिक सिलवटें रहने दें — वे कपड़े का स्वभाव दिखाती हैं।';

  @override
  String get transcriptStoleFlatSpread3 => 'फ़ोन सीधे बीच के ऊपर रखें।';

  @override
  String get transcriptStoleLooseKnot1 =>
      'ढीली गाँठ दिखाती है कि स्टोल कितना नरम और हल्का है।';

  @override
  String get transcriptStoleLooseKnot2 => 'ढीला बाँधें — कसकर कभी न खींचें।';

  @override
  String get transcriptStoleLooseKnot3 => 'गाँठ फ्रेम के केंद्र में रखें।';

  @override
  String get transcriptStoleRolledCoil1 =>
      'कुंडली में रोल करने से किनारा और मोटाई दिखते हैं।';

  @override
  String get transcriptStoleRolledCoil2 => 'ढीला रोल करें ताकि परतें अलग रहें।';

  @override
  String get transcriptStoleRolledCoil3 => 'कुंडली पर सीधे ऊपर से शूट करें।';

  @override
  String get guideSareeFullDisplay1 => 'साड़ी फ्रेम का ज़्यादातर हिस्सा ढक ले।';

  @override
  String get guideSareeFullDisplay2 =>
      'ऊपरी बॉर्डर ग्रिड के ऊपरी तिहाई से मिले।';

  @override
  String get guideSareeFullDisplay3 =>
      'ड्रेप में प्लीट्स ऊर्ध्वाधर ग्रिड से मिलें।';

  @override
  String get guideSareeTextureWeave1 => 'साड़ी पूरा फ्रेम भर दे।';

  @override
  String get guideSareeTextureWeave2 => 'बनावट बीच में रहे।';

  @override
  String get guideSareeTextureWeave3 => 'नरम रोशनी का इस्तेमाल करें।';

  @override
  String get guideSareeTextureWeave4 => 'तेज़ चमक से बचें।';

  @override
  String get guideSareeEmbroideryBorder1 => 'कढ़ाई फ्रेम के अंदर रहे।';

  @override
  String get guideSareeEmbroideryBorder2 => 'बगल से रोशनी लें।';

  @override
  String get guideSareeEmbroideryBorder3 =>
      'विवरण साफ़ और अच्छी रोशनी में रखें।';

  @override
  String get guideCushionTextureWeave1 => 'बुन फ्रेम भर दे।';

  @override
  String get guideCushionTextureWeave2 => 'बनावट बीच में रहे।';

  @override
  String get guideShawlFullDesign1 =>
      'शॉल समतल टाँगने से पूरा डिज़ाइन एक साथ दिखता है।';

  @override
  String get guideShawlFullDesign2 =>
      'दोनों ऊपरी कोने पिन करें ताकि बीच में न झुके।';

  @override
  String get guideShawlTextureWeave1 => 'बुन फ्रेम भर दे।';

  @override
  String get guideShawlTextureWeave2 => 'बनावट बीच में रहे।';

  @override
  String get guideStoleFullLength1 => 'स्टोल को फैलाएँ ताकि पूरी लंबाई दिखे।';

  @override
  String get guideStoleFullLength2 =>
      'प्राकृतिक सिलवटें रहने दें — वे कपड़े का स्वभाव दिखाती हैं।';

  @override
  String get guideStoleTextureWeave1 => 'बुन फ्रेम भर दे।';

  @override
  String get guideStoleTextureWeave2 => 'बनावट बीच में रहे।';

  @override
  String get authInvalidCredentials => 'गलत उपयोगकर्ता नाम या पासवर्ड।';

  @override
  String get authUserAlreadyRegistered =>
      'यह उपयोगकर्ता नाम पहले से लिया जा चुका है।';

  @override
  String get authEmailNotConfirmed => 'ईमेल की पुष्टि करें, फिर कोशिश करें।';

  @override
  String get authGeneric => 'साइन इन नहीं हो सका। फिर कोशिश करें।';

  @override
  String get languageAssamese => 'असमिया';

  @override
  String get languageHindi => 'हिन्दी';

  @override
  String get languageEnglish => 'अंग्रेज़ी';

  @override
  String get guideSareeDrapedLook1 => 'कपड़े को स्वाभाविक रूप से गिरने दें।';

  @override
  String get guideSareeDrapedLook2 => 'मोड़ विकर्ण के साथ चलें।';

  @override
  String get guideSareeDrapedLook3 => 'बगल से रोशनी लें।';

  @override
  String get guideSareeEmbroideryBorder4 => 'कंट्रास्ट वाला बैकग्राउंड लें।';

  @override
  String get guideSareeFoldedStack1 => 'मोड़ क्षैतिज रेखाओं के समानांतर रहें।';

  @override
  String get guideSareeFoldedStack2 => 'बगल से रोशनी लें।';

  @override
  String get guideSareeFoldedStack3 => 'किनारा दिखता रहे।';

  @override
  String get guideCushionFullCover1 =>
      'कवर को समतल रखें ताकि पूरा पैटर्न दिखे।';

  @override
  String get guideCushionFullCover2 => 'फ़ोन सीधे ऊपर से पकड़ें, तिरछा नहीं।';

  @override
  String get guideCushionFullCover3 => 'किनारे ग्रिड के साथ सीधे रखें।';

  @override
  String get guideCushionTextureWeave3 => 'नरम रोशनी का इस्तेमाल करें।';

  @override
  String get guideCushionTextureWeave4 => 'तेज़ चमक से बचें।';

  @override
  String get guideCushionStackedThickness1 =>
      'दो कवर इस तरह रखें कि मोटाई दिखे।';

  @override
  String get guideCushionStackedThickness2 => 'ढेर के किनारे कैमरे की ओर रखें।';

  @override
  String get guideCushionStackedThickness3 =>
      'बगल की रोशनी से हर परत की हल्की छाया बने।';

  @override
  String get guideCushionCornerStitching1 => 'कोने पर सिलाई सबसे साफ़ दिखे।';

  @override
  String get guideCushionCornerStitching2 =>
      'पास जाएँ जब तक कोना छोटे फ्रेम को भर दे।';

  @override
  String get guideCushionCornerStitching3 =>
      'सिलाई तेज़ और अच्छी रोशनी में रखें।';

  @override
  String get guideCushionInUse1 => 'कुर्सी पर रखने से असली आकार दिखता है।';

  @override
  String get guideCushionInUse2 => 'ऐसी सीट चुनें जो पैटर्न से न टकराए।';

  @override
  String get guideCushionInUse3 => 'आँखों की ऊँचाई से लें, ऊपर से नहीं।';

  @override
  String get guideShawlFullDesign3 => 'सीधे सामने खड़े हों, एक तरफ़ नहीं।';

  @override
  String get guideShawlTextureWeave3 => 'नरम रोशनी का इस्तेमाल करें।';

  @override
  String get guideShawlTextureWeave4 => 'तेज़ चमक से बचें।';

  @override
  String get guideShawlDrapedLook1 =>
      'कंधे पर शॉल ड्रेप करने से उसके वजन का अंदाज़ा मिलता है।';

  @override
  String get guideShawlDrapedLook2 => 'एक सिरा दूसरे से नीचे लटकने दें।';

  @override
  String get guideShawlDrapedLook3 =>
      'पिन न करें — कपड़े को अपने आप गिरने दें।';

  @override
  String get guideShawlBorderCorner1 =>
      'कोने का क्लोज-अप बुन और बॉर्डर एक साथ दिखाता है।';

  @override
  String get guideShawlBorderCorner2 =>
      'एक कोना पीछे मोड़ें ताकि दोनों तरफ़ दिखें।';

  @override
  String get guideShawlBorderCorner3 => 'पास जाएँ जब तक बुन फ्रेम भर दे।';

  @override
  String get guideShawlStackDisplay1 =>
      'शॉल को साफ़-सुथरे ढेर में रखें, मोड़ दिखते हुए।';

  @override
  String get guideShawlStackDisplay2 => 'मोड़ क्षैतिज रेखाओं के समानांतर रखें।';

  @override
  String get guideShawlStackDisplay3 => 'बगल की रोशनी से हर मोड़ में गहराई आए।';

  @override
  String get guideStoleFullLength3 => 'फ़ोन सीधे बीच के ऊपर पकड़ें।';

  @override
  String get guideStoleTextureWeave3 => 'नरम रोशनी का इस्तेमाल करें।';

  @override
  String get guideStoleTextureWeave4 => 'तेज़ चमक से बचें।';

  @override
  String get guideStoleWornNeckWrap1 =>
      'पहनकर ली गई तस्वीर से स्टोल का आकार पता चलता है।';

  @override
  String get guideStoleWornNeckWrap2 =>
      'गर्दन पर एक बार लपेटें और दोनों सिरे लटकने दें।';

  @override
  String get guideStoleWornNeckWrap3 =>
      'छाती से ऊपर से लें ताकि सिरे फ्रेम में रहें।';

  @override
  String get guideStoleSoftnessKnot1 =>
      'ढीली गाँठ से पता चलता है कि स्टोल कितनी नरम और हल्की है।';

  @override
  String get guideStoleSoftnessKnot2 => 'ढीला बाँधें — कभी कसकर न खींचें।';

  @override
  String get guideStoleSoftnessKnot3 => 'गाँठ फ्रेम के बीच में रखें।';

  @override
  String get guideStoleEdgeThickness1 =>
      'स्टोल को कुंडली में लपेटने से किनारा और मोटाई दिखती है।';

  @override
  String get guideStoleEdgeThickness2 => 'ढीला लपेटें ताकि परतें अलग रहें।';

  @override
  String get guideStoleEdgeThickness3 => 'कुंडली पर सीधे ऊपर से लें।';

  @override
  String get csNavLearn => 'सीखें';

  @override
  String get csNavPractice => 'अभ्यास';

  @override
  String get csNavProgress => 'प्रगति';

  @override
  String get csLearnerFallback => 'सीखने वाले';

  @override
  String get csClusterNotSelected => 'क्लस्टर चुना नहीं गया';

  @override
  String get csAntaranLearningTool => 'अंतरण · सीखने का साधन';

  @override
  String get csWorksOffline => 'बिना इंटरनेट चलता है';

  @override
  String get csClickAndSocial => 'CLICK &\nSOCIAL';

  @override
  String get csClickAndSocialInline => 'CLICK & SOCIAL';

  @override
  String get csOnboardingTagline =>
      'अपने हुनर की तस्वीर लें। उसकी कहानी सुनाएँ। उसे ऑनलाइन बेचें — सब इसी फ़ोन से।';

  @override
  String get csStepYourName => 'आपका नाम';

  @override
  String get csNameHint => 'अपना नाम लिखें';

  @override
  String get csStepYourLanguage => 'आपकी भाषा';

  @override
  String csLanguageChip(String label, String code) {
    return '$label ($code)';
  }

  @override
  String get csStepYourCluster => 'आपका क्लस्टर — जहाँ आप काम करते हैं';

  @override
  String get csClusterHint =>
      'एक बार चुनें। आपके पाठ, कहानियाँ और हैशटैग इसी के हिसाब से बनेंगे।';

  @override
  String get csSelected => 'चुना गया';

  @override
  String get csPick => 'चुनें';

  @override
  String get csStartLearning => 'सीखना शुरू करें';

  @override
  String get csOfflineReady => 'बिना इंटरनेट तैयार';

  @override
  String csHelloName(String name) {
    return 'नमस्ते, $name';
  }

  @override
  String get csChange => 'बदलें';

  @override
  String csLessonsDone(int done) {
    return '5 में से $done पाठ पूरे';
  }

  @override
  String get csLesson01Title => 'फ़ोटोग्राफ़ी';

  @override
  String get csLesson01Subtitle =>
      'उत्पाद · सामग्री · क्लस्टर · फ़्रेम · रोशनी';

  @override
  String get csLesson02Title => 'इंस्टाग्राम पर अपना पेज बनाएँ';

  @override
  String get csLesson02Subtitle => 'नाम · बायो · प्रोफ़ेशनल अकाउंट';

  @override
  String get csLesson03Title => 'पोस्ट बनाएँ';

  @override
  String get csLesson03Subtitle => 'कहानी · हैशटैग · प्रकाशित करें';

  @override
  String get csLesson04Title => 'पोस्ट करने की योजना';

  @override
  String get csLesson04Subtitle => 'कब पोस्ट करें · हफ़्ते की लय';

  @override
  String get csLesson05Title => 'आँकड़े पढ़ें';

  @override
  String get csLesson05Subtitle => 'पहुँच · क्या चला और क्यों';

  @override
  String get csLesson01Overline => 'पाठ 01';

  @override
  String get csLesson02Overline => 'पाठ 02';

  @override
  String get csLesson03Overline => 'पाठ 03';

  @override
  String get csLesson04Overline => 'पाठ 04';

  @override
  String get csLesson05Overline => 'पाठ 05';

  @override
  String csStepOfTotal(int step, int total) {
    return '$step / $total';
  }

  @override
  String get csPickYourUsername => 'अपना यूज़रनेम चुनें';

  @override
  String get csUsernameHint =>
      'छोटा हो। उसमें आपका हुनर दिखे। बोलने में आसान हो।';

  @override
  String get csNextEditProfile => 'आगे — EDIT PROFILE';

  @override
  String get csEditProfileIntroBefore => 'यह ';

  @override
  String get csEditProfileIntroBold => 'Edit profile';

  @override
  String get csEditProfileIntroAfter => ' स्क्रीन है। हर पंक्ति भरें।';

  @override
  String get csChangePhotoTip =>
      'फ़ोटो बदलें — अपना उत्पाद लगाएँ, सूरज ढलने की तस्वीर नहीं';

  @override
  String get csFieldName => 'Name';

  @override
  String get csFieldUsername => 'Username';

  @override
  String get csFieldBio => 'Bio';

  @override
  String get csBioPlaceholder => 'नीचे की पंक्तियाँ छूकर इसे बनाएँ…';

  @override
  String get csBioLinesPrompt =>
      'बायो की पंक्तियाँ — कम से कम 2 चुनें (जगह + हुनर + कैसे ख़रीदें)';

  @override
  String get csNextGoProfessional => 'आगे — प्रोफ़ेशनल बनें';

  @override
  String get csSettingsPrompt =>
      'ऐप में Settings खोलें। जो पंक्ति प्रोफ़ेशनल अकाउंट तक ले जाती है, उसे ढूँढें — लाल बिंदु के पीछे चलें।';

  @override
  String get csSettingsPromptAlmost => 'बस एक कदम और — एक बार और छुएँ।';

  @override
  String get csSettingsTitle => 'Settings';

  @override
  String get csAccountTypeAndTools => 'Account type and tools';

  @override
  String get csSettingsNotifications => 'Notifications';

  @override
  String get csSettingsNotificationsSub => 'लाइक, कमेंट, मैसेज';

  @override
  String get csSettingsPrivacy => 'Privacy';

  @override
  String get csSettingsPrivacySub => 'प्राइवेट अकाउंट, ब्लॉक किए लोग';

  @override
  String get csSettingsAccountTypeSub => 'प्रोफ़ेशनल अकाउंट पर जाएँ';

  @override
  String get csSettingsHelp => 'Help';

  @override
  String get csSettingsHelpSub => 'समस्या बताएँ';

  @override
  String get csSettingsSwitchProfessional => 'Switch to professional account';

  @override
  String get csSettingsSwitchProfessionalSub =>
      'मुफ़्त — क्रिएटर और कारोबार के लिए';

  @override
  String get csSettingsDeleteAccount => 'Delete account';

  @override
  String get csSettingsDeleteAccountSub => 'अपना अकाउंट हटाएँ';

  @override
  String get csSettingsPersonalInfo => 'Personal information';

  @override
  String get csSettingsPersonalInfoSub => 'जन्मदिन, ईमेल';

  @override
  String get csSettingsWrongPick => 'वह नहीं — लाल बिंदु के पीछे चलें।';

  @override
  String get csCategoryIntroBefore => 'आख़िरी कदम — ';

  @override
  String get csCategoryIntroBold => 'आप क्या हैं?';

  @override
  String get csCategoryIntroAfter => ' वह श्रेणी चुनें जो ख़रीदार देखेंगे।';

  @override
  String get csCategoryArtist => 'Artist';

  @override
  String get csCategoryShoppingRetail => 'Shopping & retail';

  @override
  String get csCategoryLocalBusiness => 'Local business';

  @override
  String get csCategoryEntrepreneur => 'Entrepreneur';

  @override
  String get csProAccountNote1 =>
      'प्रोफ़ेशनल अकाउंट मुफ़्त है। इससे खुलते हैं ';

  @override
  String get csProAccountInsights => 'insights';

  @override
  String get csProAccountNote2 => ' (आपकी पोस्ट कौन देखता है — पाठ 05), एक ';

  @override
  String get csProAccountContactButton => 'contact button';

  @override
  String get csProAccountNote3 => ', और आगे चलकर ';

  @override
  String get csProAccountAds => 'ads';

  @override
  String get csProAccountNote4 => '।';

  @override
  String get csSwitchToProfessional => 'प्रोफ़ेशनल पर जाएँ';

  @override
  String get csPreviewIntro => 'हो गया। ख़रीदार आपका पेज ऐसे देखेंगे:';

  @override
  String get csPostsFollowers => '0 पोस्ट   0 फ़ॉलोअर';

  @override
  String get csFollow => 'FOLLOW';

  @override
  String get csMessage => 'MESSAGE';

  @override
  String get csProfessionalAccount => 'प्रोफ़ेशनल अकाउंट';

  @override
  String get csPickANameFallback => 'pick_a_name';

  @override
  String get csCraftFallback => 'हुनर';

  @override
  String get csBioFallbackHandloomWeaver => 'हथकरघा बुनकर';

  @override
  String get csBioFallbackDmToOrder => 'ऑर्डर के लिए DM करें';

  @override
  String get csBioFallbackMadeByHand => 'हाथ से बना';

  @override
  String get csFormatPost => 'पोस्ट';

  @override
  String get csFormatStory => 'स्टोरी';

  @override
  String get csFormatReel => 'रील';

  @override
  String get csPhotoPlaceholder => 'पाठ 01 की आपकी फ़ोटो — या कोई फ़ोटो डालें';

  @override
  String get csExampleKotpad =>
      'उदाहरण: कोटपाड़ की एक पोस्ट — पास से ली गई फ़ोटो, फिर दो पंक्तियाँ जिनमें हुनर और बुनकरों का नाम हो।';

  @override
  String get csAddYourStory => 'अपनी कहानी जोड़ें — पंक्तियाँ छुएँ';

  @override
  String get csHashtagsPick => 'हैशटैग — 3 से 5 चुनें ';

  @override
  String csHashtagCount(int count) {
    return '$count/5';
  }

  @override
  String csHashtagCountFull(int count) {
    return '$count/5 — पाँच काफ़ी हैं';
  }

  @override
  String get csCaptionPreview => 'कैप्शन की झलक';

  @override
  String get csCaptionPlaceholder =>
      'ऊपर की कहानी पंक्तियाँ छूकर अपना कैप्शन लिखें।';

  @override
  String get csPostToPracticeFeed => 'अभ्यास फ़ीड पर पोस्ट करें';

  @override
  String get csPracticeFeedOnly =>
      'सिर्फ़ अभ्यास फ़ीड — कुछ भी आपके फ़ोन से बाहर नहीं जाता।';

  @override
  String get csStoryFallbackHeritage => 'मेरे गाँव में हाथ से बना।';

  @override
  String get csStoryFallbackMaterial => 'प्राकृतिक रेशा, ध्यान से रंगा।';

  @override
  String get csStoryFallbackProcess => 'घर के करघे पर बुना, एक-एक बूटी।';

  @override
  String get csTagFallback0 => '#handwoven';

  @override
  String get csTagFallback1 => '#vocalforlocal';

  @override
  String get csTagFallback2 => '#craftindia';

  @override
  String get csTagFallback3 => '#madeinindia';

  @override
  String get csTagFallback4 => '#handloom';

  @override
  String get csWhenDoBuyersScroll => 'ख़रीदार कब स्क्रॉल करते हैं?';

  @override
  String get csTimeMorning => 'सुबह 6–9 बजे';

  @override
  String get csTimeNight => 'रात 7–10 बजे';

  @override
  String get csTimeAfternoon => 'दोपहर 2 बजे';

  @override
  String get csTimeCorrectMsg =>
      'हाँ — शाम को, जब दिन का काम निपट जाता है, तभी लोग स्क्रॉल करते हैं और ख़रीदते हैं।';

  @override
  String get csTimeWrongMsg =>
      'उस समय लोग काम पर होते हैं। दिन ढलने के बाद देखें।';

  @override
  String get csPlanYourWeek => 'अपना हफ़्ता तय करें — 3 दिन चुनें';

  @override
  String get csSpreadThemOut =>
      'इन्हें फैलाकर रखें। ख़रीदार आपको पूरे हफ़्ते देखें।';

  @override
  String get csDayMon => 'सो';

  @override
  String get csDayTue => 'मं';

  @override
  String get csDayWed => 'बु';

  @override
  String get csDayThu => 'गु';

  @override
  String get csDayFri => 'शु';

  @override
  String get csDaySat => 'श';

  @override
  String get csDaySun => 'र';

  @override
  String get csGoodRhythm => 'अच्छी लय — तीन पोस्ट, पूरे हफ़्ते में फैली हुई।';

  @override
  String get csThreePostsOneWinner => 'तीन पोस्ट। एक विजेता।';

  @override
  String get csReachExplainer =>
      'पहुँच = कितने लोगों ने देखा। सबसे अच्छी पोस्ट छुएँ।';

  @override
  String get csResultPhotoOnly => 'सिर्फ़ फ़ोटो';

  @override
  String get csResultPhotoStory => 'फ़ोटो + कहानी वाला कैप्शन';

  @override
  String get csResultPhotoStoryTags => 'फ़ोटो + कहानी + हैशटैग';

  @override
  String get csBestCorrectMsg =>
      'सही — कहानी और हैशटैग ने अकेली फ़ोटो से 10 गुना ज़्यादा लोगों तक पहुँच बनाई।';

  @override
  String get csBestWrongMsg => 'फिर देखें — कौन-सी पट्टी सबसे लंबी है?';

  @override
  String get csYourWeekReached => 'आपका हफ़्ता — कितने लोगों तक पहुँचे';

  @override
  String get csTallBarsNote =>
      'ऊँची पट्टियाँ आपके पोस्ट वाले दिन हैं। योजना के मुताबिक पोस्ट करें — पहुँच अपने आप बढ़ेगी।';

  @override
  String get csPracticeFeed => 'अभ्यास फ़ीड';

  @override
  String get csStaysOnYourPhone => 'आपके फ़ोन में ही रहता है';

  @override
  String get csFeedTimeNow => 'अभी';

  @override
  String get csFeedSampleTime1 => '2 दि';

  @override
  String get csFeedSampleTime2 => '5 दि';

  @override
  String get csFeedYourPhotoPlaceholder => 'पाठों में ली गई आपकी फ़ोटो';

  @override
  String get csFeedSamplePlaceholder => 'एक नमूना फ़ोटो डालें';

  @override
  String get csFeedSampleUser1 => 'maya_ikat';

  @override
  String get csFeedSampleUser2 => 'looms_of_naga';

  @override
  String get csFeedSampleCaption1 =>
      'डबल इकत — बुनने से पहले हाथ से बाँधा और रंगा।';

  @override
  String get csFeedSampleTags1 => '#ikat #odishahandloom #handwoven';

  @override
  String get csFeedSampleCaption2 => 'कमर करघे की शॉल — हर धारी का एक मतलब है।';

  @override
  String get csFeedSampleTags2 => '#nagashawl #loinloom #handwoven';

  @override
  String get csFeedCommentUser1 => 'buyer_priya';

  @override
  String get csFeedCommentUser2 => 'craft.lover';

  @override
  String get csFeedCommentBuyer => 'बहुत सुंदर! दाम बताइए?';

  @override
  String get csFeedCommentCraftLover => 'कमाल का काम!';

  @override
  String get csFeedTapHeart => 'दिल छूकर देखें कि ख़रीदार कैसे जवाब देते हैं।';

  @override
  String get csYourProgress => 'आपकी प्रगति';

  @override
  String get csBadgesOfFive => '/ 5 बैज';

  @override
  String get csBadgePhotographer => 'फ़ोटोग्राफ़र';

  @override
  String get csBadgePageBuilder => 'पेज बनाने वाले';

  @override
  String get csBadgeStoryteller => 'कहानीकार';

  @override
  String get csBadgePlanner => 'योजनाकार';

  @override
  String get csBadgeAnalyst => 'विश्लेषक';

  @override
  String get csBadgeEarned => 'मिल गया';

  @override
  String get csBadgeLocked => 'अभी बंद';

  @override
  String get csEditNameLanguageCluster => 'नाम, भाषा या क्लस्टर बदलें';

  @override
  String get csAccountCloudBackup => 'अकाउंट और क्लाउड बैकअप';

  @override
  String get csStartOverClearProgress =>
      'फिर से शुरू करें — सारी प्रगति मिटाएँ';

  @override
  String get csStartOverTitle => 'फिर से शुरू करें?';

  @override
  String get csStartOverBody =>
      'इससे इस फ़ोन के पाठ बैज और अभ्यास पोस्ट मिट जाएँगे। आपने जो फ़ोटो ले ली हैं, वे फ़ोन में सुरक्षित रहेंगी।';

  @override
  String get csCancel => 'रहने दें';

  @override
  String get csClear => 'मिटाएँ';

  @override
  String get csStoryKickerHeritage => 'विरासत';

  @override
  String get csStoryKickerMaterial => 'सामग्री';

  @override
  String get csStoryKickerProcess => 'प्रक्रिया';

  @override
  String get csClusterAssamFabric => 'मेखला सादोर — मूगा और एरी रेशम';

  @override
  String get csClusterAssamShortName => 'मेखला सादोर';

  @override
  String get csClusterAssamPlace => 'कामरूप और नलबाड़ी, असम';

  @override
  String get csClusterAssamBio0 => 'हथकरघा बुनकर';

  @override
  String get csClusterAssamBio1 => 'कामरूप, असम';

  @override
  String get csClusterAssamBio2 => 'मेखला सादोर और स्टोल';

  @override
  String get csClusterAssamBio3 => 'ऑर्डर के लिए DM करें';

  @override
  String get csClusterAssamBio4 => 'तीसरी पीढ़ी का बुनकर';

  @override
  String get csClusterAssamStoryHeritage =>
      'मूगा — सुनहरा रेशम, जो सिर्फ़ असम में होता है।';

  @override
  String get csClusterAssamStoryMaterial =>
      'हाथ से काता एरी — शॉल जैसा मुलायम, ऊन जैसा गरम।';

  @override
  String get csClusterAssamStoryProcess =>
      'घर पर बुना, हफ़्तों करघे पर, एक-एक बूटी।';

  @override
  String get csClusterAssamTag0 => '#mekhelachador';

  @override
  String get csClusterAssamTag1 => '#mugasilk';

  @override
  String get csClusterAssamTag2 => '#erisilk';

  @override
  String get csClusterAssamTag3 => '#assamhandloom';

  @override
  String get csClusterAssamTag4 => '#handwoven';

  @override
  String get csClusterAssamTag5 => '#vocalforlocal';

  @override
  String get csClusterAssamTag6 => '#silksofindia';

  @override
  String get csClusterAssamTag7 => '#weaversofindia';

  @override
  String get csClusterSrikalahastiFabric =>
      'कलमकारी — हाथ से चित्रित सूती कपड़ा';

  @override
  String get csClusterSrikalahastiShortName => 'कलमकारी';

  @override
  String get csClusterSrikalahastiPlace => 'श्रीकालहस्ती, आंध्र प्रदेश';

  @override
  String get csClusterSrikalahastiBio0 => 'कलमकारी कलाकार';

  @override
  String get csClusterSrikalahastiBio1 => 'श्रीकालहस्ती, आंध्र प्रदेश';

  @override
  String get csClusterSrikalahastiBio2 => 'हाथ से चित्रित पैनल और साड़ियाँ';

  @override
  String get csClusterSrikalahastiBio3 => 'ऑर्डर के लिए DM करें';

  @override
  String get csClusterSrikalahastiBio4 => 'मंदिर कला वाला परिवार';

  @override
  String get csClusterSrikalahastiStoryHeritage =>
      'मंदिर की कहानियाँ, बाँस की कलम से बनाई गईं।';

  @override
  String get csClusterSrikalahastiStoryMaterial =>
      'सूती कपड़ा और प्राकृतिक रंग — हरड़, लोहा, फिटकरी।';

  @override
  String get csClusterSrikalahastiStoryProcess =>
      'एक-एक लकीर से बनी — कोई दो टुकड़े एक जैसे नहीं।';

  @override
  String get csClusterSrikalahastiTag0 => '#kalamkari';

  @override
  String get csClusterSrikalahastiTag1 => '#srikalahasti';

  @override
  String get csClusterSrikalahastiTag2 => '#naturaldyes';

  @override
  String get csClusterSrikalahastiTag3 => '#handpainted';

  @override
  String get csClusterSrikalahastiTag4 => '#craftindia';

  @override
  String get csClusterSrikalahastiTag5 => '#vocalforlocal';

  @override
  String get csClusterSrikalahastiTag6 => '#textileart';

  @override
  String get csClusterSrikalahastiTag7 => '#madeinindia';

  @override
  String get csClusterVenkatgiriFabric => 'वेंकटगिरी साड़ी — महीन सूती और ज़री';

  @override
  String get csClusterVenkatgiriShortName => 'वेंकटगिरी साड़ी';

  @override
  String get csClusterVenkatgiriPlace => 'वेंकटगिरी, आंध्र प्रदेश';

  @override
  String get csClusterVenkatgiriBio0 => 'हथकरघा बुनकर';

  @override
  String get csClusterVenkatgiriBio1 => 'वेंकटगिरी, आंध्र प्रदेश';

  @override
  String get csClusterVenkatgiriBio2 => 'महीन सूती और ज़री की साड़ियाँ';

  @override
  String get csClusterVenkatgiriBio3 => 'ऑर्डर के लिए DM करें';

  @override
  String get csClusterVenkatgiriBio4 => '1970 से बुनकरों का परिवार';

  @override
  String get csClusterVenkatgiriStoryHeritage =>
      'कभी वेंकटगिरी दरबार के लिए बुनी जाती थी।';

  @override
  String get csClusterVenkatgiriStoryMaterial =>
      'इतनी महीन सूती कि साड़ी हवा में तैरती है।';

  @override
  String get csClusterVenkatgiriStoryProcess =>
      'जामदानी बूटियाँ — तोता, आम, हंस — हाथ से बुनी गईं।';

  @override
  String get csClusterVenkatgiriTag0 => '#venkatagiri';

  @override
  String get csClusterVenkatgiriTag1 => '#jamdani';

  @override
  String get csClusterVenkatgiriTag2 => '#zari';

  @override
  String get csClusterVenkatgiriTag3 => '#handloomsaree';

  @override
  String get csClusterVenkatgiriTag4 => '#cottonsaree';

  @override
  String get csClusterVenkatgiriTag5 => '#vocalforlocal';

  @override
  String get csClusterVenkatgiriTag6 => '#sareesofinstagram';

  @override
  String get csClusterVenkatgiriTag7 => '#madeinindia';

  @override
  String get csClusterManiabandhaFabric => 'खंडुआ इकत — बाँधकर रंगा रेशम';

  @override
  String get csClusterManiabandhaShortName => 'खंडुआ इकत';

  @override
  String get csClusterManiabandhaPlace => 'मणिआबंधा, ओडिशा';

  @override
  String get csClusterManiabandhaBio0 => 'इकत बुनकर';

  @override
  String get csClusterManiabandhaBio1 => 'मणिआबंधा, ओडिशा';

  @override
  String get csClusterManiabandhaBio2 => 'खंडुआ साड़ियाँ और स्टोल';

  @override
  String get csClusterManiabandhaBio3 => 'ऑर्डर के लिए DM करें';

  @override
  String get csClusterManiabandhaBio4 => 'महानदी किनारे बुनकरों का गाँव';

  @override
  String get csClusterManiabandhaStoryHeritage =>
      'खंडुआ — भगवान जगन्नाथ के लिए बुनी जाती है।';

  @override
  String get csClusterManiabandhaStoryMaterial =>
      'रेशम के धागे करघे तक पहुँचने से पहले ही बाँधकर रंगे जाते हैं।';

  @override
  String get csClusterManiabandhaStoryProcess =>
      'नक़्शा धागे में ही रंगा जाता है, फिर हूबहू बुना जाता है।';

  @override
  String get csClusterManiabandhaTag0 => '#khandua';

  @override
  String get csClusterManiabandhaTag1 => '#ikat';

  @override
  String get csClusterManiabandhaTag2 => '#odishahandloom';

  @override
  String get csClusterManiabandhaTag3 => '#maniabandha';

  @override
  String get csClusterManiabandhaTag4 => '#handwoven';

  @override
  String get csClusterManiabandhaTag5 => '#tiedye';

  @override
  String get csClusterManiabandhaTag6 => '#vocalforlocal';

  @override
  String get csClusterManiabandhaTag7 => '#sareelove';

  @override
  String get csClusterGopalpurFabric => 'गोपालपुर तसर — जंगली रेशम';

  @override
  String get csClusterGopalpurShortName => 'तसर साड़ी';

  @override
  String get csClusterGopalpurPlace => 'गोपालपुर, जाजपुर, ओडिशा';

  @override
  String get csClusterGopalpurBio0 => 'तसर बुनकर';

  @override
  String get csClusterGopalpurBio1 => 'गोपालपुर, ओडिशा';

  @override
  String get csClusterGopalpurBio2 => 'साड़ियाँ, स्टोल और कपड़ा';

  @override
  String get csClusterGopalpurBio3 => 'ऑर्डर के लिए DM करें';

  @override
  String get csClusterGopalpurBio4 => 'GI टैग वाला हुनर';

  @override
  String get csClusterGopalpurStoryHeritage =>
      'गोपालपुर में 16वीं सदी से बुनी जा रही है — GI टैग वाली।';

  @override
  String get csClusterGopalpurStoryMaterial =>
      'जंगली तसर — इसका सुनहरापन प्राकृतिक है, रंग का नहीं।';

  @override
  String get csClusterGopalpurStoryProcess =>
      'हाथ से लपेटा, हाथ से काता, अतिरिक्त बाने की बूटियाँ।';

  @override
  String get csClusterGopalpurTag0 => '#tussarsilk';

  @override
  String get csClusterGopalpurTag1 => '#gopalpur';

  @override
  String get csClusterGopalpurTag2 => '#odishaweaves';

  @override
  String get csClusterGopalpurTag3 => '#wildsilk';

  @override
  String get csClusterGopalpurTag4 => '#handspun';

  @override
  String get csClusterGopalpurTag5 => '#vocalforlocal';

  @override
  String get csClusterGopalpurTag6 => '#silksofindia';

  @override
  String get csClusterGopalpurTag7 => '#handwoven';

  @override
  String get csClusterNagalandFabric => 'नगा शॉल — कमर करघा';

  @override
  String get csClusterNagalandShortName => 'नगा शॉल';

  @override
  String get csClusterNagalandPlace => 'नगालैंड के क्लस्टर';

  @override
  String get csClusterNagalandBio0 => 'कमर करघा बुनकर';

  @override
  String get csClusterNagalandBio1 => 'नगालैंड';

  @override
  String get csClusterNagalandBio2 => 'शॉल और मेखला';

  @override
  String get csClusterNagalandBio3 => 'ऑर्डर के लिए DM करें';

  @override
  String get csClusterNagalandBio4 => 'मेरे समुदाय की बुनाई';

  @override
  String get csClusterNagalandStoryHeritage =>
      'हर धारी और हर बूटी बताती है कि आप कौन हैं।';

  @override
  String get csClusterNagalandStoryMaterial =>
      'कमर करघे पर मोटा सूती, गहरा रंगा।';

  @override
  String get csClusterNagalandStoryProcess =>
      'पट्टी दर पट्टी बुनी, फिर सिलकर एक शॉल बनी।';

  @override
  String get csClusterNagalandTag0 => '#nagashawl';

  @override
  String get csClusterNagalandTag1 => '#loinloom';

  @override
  String get csClusterNagalandTag2 => '#nagaland';

  @override
  String get csClusterNagalandTag3 => '#handwoven';

  @override
  String get csClusterNagalandTag4 => '#tribaltextile';

  @override
  String get csClusterNagalandTag5 => '#vocalforlocal';

  @override
  String get csClusterNagalandTag6 => '#northeastindia';

  @override
  String get csClusterNagalandTag7 => '#craftindia';

  @override
  String get csNewProductTitle => 'नया उत्पाद';

  @override
  String get csHowIsItMade => 'यह कैसे बनता है?';

  @override
  String get csTechniqueSub => 'तकनीक तय करती है कि कैमरे को क्या दिखाना है।';

  @override
  String get csTechniqueWoven => 'बुना हुआ';

  @override
  String get csTechniqueHandPainted => 'हाथ से चित्रित';

  @override
  String get csNextMaterialType => 'आगे — सामग्री का प्रकार';

  @override
  String get csNextMaterial => 'आगे — सामग्री';

  @override
  String get csWhatArePhotographing => 'आप किसकी फ़ोटो ले रहे हैं?';

  @override
  String get csPickYourProduct => 'अपना उत्पाद चुनें।';

  @override
  String get csPickYourFrames => 'अपने फ़्रेम चुनें';

  @override
  String get csPickFramesSub => 'आप कौन-सी तस्वीरें लेंगे? कम से कम दो चुनें।';

  @override
  String get csNoTemplatesYet => 'इस उत्पाद के लिए अभी कोई टेम्पलेट नहीं है।';

  @override
  String get csNextFrameIt => 'आगे — फ़्रेम करें';

  @override
  String csFramingProgress(int index, int total) {
    return 'फ़्रेमिंग $index / $total';
  }

  @override
  String csFramingProgressNamed(int index, int total, String names) {
    return 'फ़्रेमिंग $index / $total — $names';
  }

  @override
  String get csFramingThirdsTitle => 'आपका उत्पाद कहाँ रखा जाए?';

  @override
  String get csFramingThirdsSub =>
      'सबसे अच्छा फ़्रेम छुएँ। ये लकीरें तिहाई का नियम हैं।';

  @override
  String get csFramingThirdsMsg0 =>
      'बिल्कुल बीच में रखने से तस्वीर सपाट लगती है। किसी कटान बिंदु पर रखकर देखें।';

  @override
  String get csFramingThirdsMsg1 =>
      'हाँ — जहाँ लकीरें कटती हैं, वहाँ रखें। तस्वीर में साँस आ जाती है।';

  @override
  String get csFramingThirdsMsg2 => 'किनारे के बहुत पास — उत्पाद कट जाता है।';

  @override
  String get csFramingCenterTitle => 'कितना पास जाएँ?';

  @override
  String get csFramingCenterSub =>
      'पास से ली गई, समतल रखी और टँगी हुई चीज़ें बीच में रहती हैं — बीच का ख़ाना भरें।';

  @override
  String get csFramingCenterMsg0 => 'बहुत दूर — बारीकी खो जाती है। पास आएँ।';

  @override
  String get csFramingCenterMsg1 =>
      'हाँ — बीच का ख़ाना भरें, किनारे फ़्रेम के समानांतर रखें।';

  @override
  String get csFramingCenterMsg2 =>
      'आधा फ़्रेम से बाहर — फ़ोटो लेने से पहले इसे बीच में लाएँ।';

  @override
  String get csFramingDiagTitle => 'कपड़ा किस तरह बहे?';

  @override
  String get csFramingDiagSub =>
      'लटकते कपड़े और बारीक तस्वीरें तिरछी लकीर पर चलती हैं — कपड़े को नज़र की राह बनने दें।';

  @override
  String get csFramingDiagMsg0 =>
      'सीधी कतार में कोई हलचल नहीं होती। इसे तिरछी लकीर पर गिरने दें।';

  @override
  String get csFramingDiagMsg1 =>
      'हाँ — सिलवटें तिरछी लकीर पर उतरती हैं और नज़र साथ चलती है।';

  @override
  String get csFramingDiagMsg2 => 'एक कोने में सिमटा हुआ — बहाव ख़त्म।';

  @override
  String get csFramingDetailTitle => 'फ़्रेम में किनारा कितना हो?';

  @override
  String get csFramingDetailSub =>
      'किनारा, बूटी और तह वाली तस्वीरें: बारीकी वाले फ़्रेम को काम से ही भरें।';

  @override
  String get csFramingDetailMsg0 =>
      'बहुत पतला, बहुत दूर — हुनर किसी को दिखता ही नहीं।';

  @override
  String get csFramingDetailMsg1 =>
      'हाँ — किनारा पूरा फ़्रेम भरता है, इतना पास कि धागे गिने जा सकें।';

  @override
  String get csFramingDetailMsg2 =>
      'हवा में तैरता चौकोर न किनारा दिखाता है, न बूटी। पट्टी के साथ चलें।';

  @override
  String get csNextFraming => 'अगली फ़्रेमिंग';

  @override
  String get csNextLightIt => 'आगे — रोशनी दें';

  @override
  String get csLightSide => 'बग़ल से रोशनी';

  @override
  String get csLightFront => 'सामने से नरम रोशनी';

  @override
  String get csLightBack => 'पीछे से रोशनी';

  @override
  String get csLightHeadingPanel => 'चित्रित पैनल को चमक पसंद नहीं।';

  @override
  String get csLightHeadingPainted => 'हाथ से चित्रित — रोशनी बराबर रखें।';

  @override
  String get csLightHeadingSilk => 'रेशम चमकता है। उसे दमकने दें।';

  @override
  String get csLightHeadingCotton => 'सूती नरम होती है। रोशनी भी नरम रखें।';

  @override
  String get csLightPromptPanel =>
      'कपड़े पर बनी पेंटिंग चमक लौटाती है। रोशनी सपाट और नरम रखें।';

  @override
  String get csLightPromptPainted =>
      'वह रोशनी चुनें जो चित्रित रंगों को सही रखे।';

  @override
  String get csLightPromptSilk =>
      'वह रोशनी चुनें जो आपके रेशम को सबसे अच्छा दिखाए।';

  @override
  String get csLightPromptDefault =>
      'वह रोशनी चुनें जो आपके उत्पाद को सबसे अच्छा दिखाए।';

  @override
  String get csLightWhyPanel =>
      'सही — सामने से नरम, बराबर, फैली हुई रोशनी। प्राकृतिक रंग सही दिखते हैं और कैमरे में कोई चमक नहीं आती। फ़्लैश कभी न चलाएँ।';

  @override
  String get csLightWhyPainted =>
      'सही — सामने से बराबर रोशनी रंगों को सही रखती है, चित्रित सतह पर कोई चमक नहीं।';

  @override
  String get csLightWhySilk => 'सही — बग़ल की रोशनी रेशम की चमक पकड़ लेती है।';

  @override
  String get csLightWhyCotton =>
      'सही — सामने से नरम रोशनी सूती को कोमल और उसके रंगों को सही रखती है।';

  @override
  String get csLightWrongPanel =>
      'बग़ल से पड़ती तिरछी रोशनी ब्रश के काम पर परछाइयाँ डालती है और सतह पर चमक ले आती है। रोशनी बराबर और फैली हुई रखें।';

  @override
  String get csLightWrongPainted =>
      'बग़ल की रोशनी चित्रित काम पर परछाइयाँ डालती है। रोशनी नरम और बराबर रखें।';

  @override
  String get csLightWrongSilk =>
      'सामने की सपाट रोशनी चमक मार देती है। रोशनी को बग़ल में ले आएँ।';

  @override
  String get csLightWrongCotton =>
      'बग़ल की तेज़ रोशनी सूती को खुरदरा दिखाती है। सामने से नरम रोशनी रखें।';

  @override
  String get csLightWrongBacklight =>
      'पीछे की रोशनी आपके उत्पाद को परछाईं बना देती है। इसे मोटाई वाली तस्वीर के लिए रखें।';

  @override
  String get csLightTipDoThisBadge => 'ऐसा करें';

  @override
  String get csLightTipDoThisBody =>
      'बड़ी खिड़की की नरम रोशनी, पर्दा खींचा हुआ। पूरे पैनल पर बराबर रोशनी — हर रंग सही, कोई चमक नहीं।';

  @override
  String get csLightTipNeverFlashBadge => 'फ़्लैश कभी नहीं';

  @override
  String get csLightTipNeverFlashBody =>
      'फ़्लैश सीधा लौटकर आता है — एक सफ़ेद चमकीला धब्बा पेंटिंग को जला देता है।';

  @override
  String get csLightTipAvoidSideBadge => 'तेज़ बग़ल की रोशनी से बचें';

  @override
  String get csLightTipAvoidSideBody =>
      'एक तरफ़ से आती लैंप या धूप ब्रश के काम पर परछाइयाँ खींच देती है और कपड़े की बुनावट पेंटिंग से टकराने लगती है।';

  @override
  String get csLightNowPick => 'अब सही रोशनी चुनें';

  @override
  String get csNextShootYours => 'आगे — अपनी फ़ोटो लें';

  @override
  String get csFinishEarnBadge => 'पूरा करें — बैज पाएँ';
}
