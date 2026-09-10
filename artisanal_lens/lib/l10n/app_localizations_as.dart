// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Assamese (`as`).
class AppLocalizationsAs extends AppLocalizations {
  AppLocalizationsAs([String locale = 'as']) : super(locale);

  @override
  String get appTitle => 'দ্য আৰ্টিছানেল লেন্স';

  @override
  String get navHome => 'ঘৰ';

  @override
  String get navGallery => 'গেলাৰী';

  @override
  String get navNewProduct => 'নতুন সামগ্ৰী';

  @override
  String get navSettings => 'ছেটিংছ';

  @override
  String get continueAction => 'আগবাঢ়ক';

  @override
  String get openCamera => 'কেমেৰা খোলক';

  @override
  String get language => 'ভাষা';

  @override
  String get photographyGuide => 'ফটোগ্ৰাফী গাইড';

  @override
  String get photographyGuideSubtitle =>
      'এই এপে দিয়া প্ৰতিটো পৰামৰ্শৰ আঁৰৰ নিয়ম।';

  @override
  String get whatPhotographing => 'আজি আপুনি কিৰ\nফটো তুলিব?';

  @override
  String get continuePhotography => 'ফটোগ্ৰাফী অব্যাহত ৰাখক';

  @override
  String get previousSets => 'আগৰ ছেটসমূহ।';

  @override
  String get filterAll => 'সকলো';

  @override
  String get filterFinished => 'সম্পূৰ্ণ';

  @override
  String get filterPending => 'বাকী';

  @override
  String photosCompleted(int done, int total) {
    return '$total খনৰ $done খন ফটো সম্পূৰ্ণ';
  }

  @override
  String get emptyAll => 'এতিয়াও কোনো আগৰ ছেট নাই।';

  @override
  String get emptyFinished => 'এতিয়াও কোনো সম্পূৰ্ণ ছেট নাই।';

  @override
  String get emptyPending => 'কোনো অসম্পূৰ্ণ ছেট নাই।';

  @override
  String get newProduct => 'নতুন সামগ্ৰী';

  @override
  String get gallery => 'গেলাৰী';

  @override
  String get settings => 'ছেটিংছ';

  @override
  String get product => 'সামগ্ৰী';

  @override
  String get photos => 'ফটো';

  @override
  String get setup => 'ছেটআপ';

  @override
  String get tutorial => 'টিউটৰিয়েল';

  @override
  String get review => 'পৰ্যালোচনা';

  @override
  String get materialHeadline => 'আপুনি কোনবিধ কাপোৰৰ\nসৈতে কাম কৰি আছে?';

  @override
  String materialTypeHeadline(String material) {
    return 'আপুনি কি ধৰণৰ $material\nব্যৱহাৰ কৰিছে?';
  }

  @override
  String get giveProductName => 'আপোনাৰ সামগ্ৰীৰ নাম দিয়ক';

  @override
  String nameHint(String category) {
    return 'যেনে নীলা পট $category';
  }

  @override
  String get photosToCapture => 'তুলিবলগীয়া ফটো';

  @override
  String get photosToCaptureBody => 'এইকেইখন ফটো আপুনি তুলিব লাগিব।';

  @override
  String get sareePhotographyTemplatesTitle => 'শাড়ী ফটোগ্ৰাফী টেমপ্লেট';

  @override
  String get sareePhotographyTemplatesBody => 'এই পাঁচখন ফটো তুলিব লাগিব।';

  @override
  String get photographyTemplatesTitle => 'ফটোগ্ৰাফী টেমপ্লেট';

  @override
  String get photographyTemplatesBody => 'এই পাঁচখন ফটো তুলিব লাগিব।';

  @override
  String get viewCompletedSet => 'সম্পূৰ্ণ ছেট চাওক';

  @override
  String get allPhotosCaptured => 'সকলো ফটো তোলা হৈছে';

  @override
  String takeNext(String label) {
    return 'পৰৱৰ্তী তোলক — $label';
  }

  @override
  String get productUnavailable => 'এই সামগ্ৰী এতিয়া উপলব্ধ নহয়।';

  @override
  String get chooseAStyle => 'এটা শৈলী বাছক';

  @override
  String get howShouldItLook => 'ই কেনেকুৱা দেখাব লাগে?';

  @override
  String get stylePickFirst => 'প্ৰথমে তালিকাৰ পৰা এখন ফটো বাছক।';

  @override
  String get styleNoNeeded => 'এই ফটোৰ বাবে কোনো শৈলীৰ প্ৰয়োজন নাই।';

  @override
  String styleSubtitleSaree(String template) {
    return 'এই $template ফটোৰ সজাওক বাছক।';
  }

  @override
  String styleSubtitleShot(String shot) {
    return 'এই $shot ফটোৰ সজাওক বাছক।';
  }

  @override
  String styleSubtitleCategory(String category, String shot) {
    return 'এই $category $shot ফটোৰ সজাওক বাছক।';
  }

  @override
  String get labelContent => 'বিষয়';

  @override
  String get labelNeeds => 'প্ৰয়োজন';

  @override
  String get labelPlacement => 'ৰখাৰ ধৰণ';

  @override
  String get labelLighting => 'পোহৰ';

  @override
  String get labelGrid => 'গ্ৰিড';

  @override
  String contentPrefixed(String value) {
    return 'বিষয়: $value';
  }

  @override
  String needsPrefixed(String value) {
    return 'প্ৰয়োজন: $value';
  }

  @override
  String get lightingAndSetup => 'পোহৰ আৰু ছেটআপ';

  @override
  String get step1of2 => 'পদক্ষেপ ১ৰ ২';

  @override
  String get step2of2 => 'পদক্ষেপ ২ৰ ২';

  @override
  String get beforeYouShoot => 'ফটোৰ আগত';

  @override
  String get setupIllustrationPlaceholder => 'ছেটআপৰ ছবি পিছত যোগ কৰা হ\'ব';

  @override
  String get placeTheProduct => 'সামগ্ৰী ৰাখক';

  @override
  String get setupSection => 'ছেটআপ';

  @override
  String get watchHowToSetUp => 'ছেটআপ কেনেকৈ কৰিব চাওক';

  @override
  String tutorialSubtitlePreset(String name) {
    return '$name কেনেকৈ ছেটআপ কৰিব চাওক।';
  }

  @override
  String tutorialSubtitleTemplate(String name) {
    return '$name কেনেকৈ ছেটআপ কৰিব চাওক।';
  }

  @override
  String get tutorialSubtitleFallback =>
      'ভিডিঅ\' যোগ হোৱাৰ পিছত এই ছেটআপ দেখুওৱা হ\'ব।';

  @override
  String get transcript => 'ট্ৰান্সক্ৰিপ্ট';

  @override
  String get transcriptPlaceholder =>
      'টিউটৰিয়েল ভিডিঅ\' যোগ হোৱাৰ পিছত কোৱা কথা ইয়াত দেখা যাব।';

  @override
  String get tutorialVideoPlaceholder => 'টিউটৰিয়েল ভিডিঅ\' পিছত যোগ কৰা হ\'ব';

  @override
  String get referencePreset => 'সন্দৰ্ভ প্ৰিছেট';

  @override
  String get retake => 'পুনৰ তোলক';

  @override
  String get usePhoto => 'ফটো ব্যৱহাৰ কৰক';

  @override
  String get greatFraming => 'ফ্ৰেম ভাল';

  @override
  String get checkFraming => 'ফ্ৰেম চাওক';

  @override
  String get noPhotoToReview => 'পৰ্যালোচনাৰ বাবে কোনো ফটো নাই।';

  @override
  String get photoSetComplete => 'আপোনাৰ ফটো ছেট সম্পূৰ্ণ হ\'ল 🎉';

  @override
  String get viewPhotoSet => 'ফটো ছেট চাওক';

  @override
  String get startNewProduct => 'নতুন সামগ্ৰী আৰম্ভ কৰক';

  @override
  String get offlineBanner => 'অফলাইন — সংযোগ হ\'লে ফটো ছিংক হ\'ব';

  @override
  String get productNotFound => 'সামগ্ৰী পোৱা নগ\'ল।';

  @override
  String get exportPhotoSet => 'ফটো ছেট পঠিয়াওক';

  @override
  String continueCount(int done, int total) {
    return 'আগবাঢ়ক — $done/$total';
  }

  @override
  String get noPhotosToExport => 'পঠিয়াবলৈ এতিয়াও কোনো ফটো নাই।';

  @override
  String couldNotExport(String error) {
    return 'পঠিয়াব পৰা নগ\'ল: $error';
  }

  @override
  String exportShareText(String name, int count) {
    return '$name — $count খন ফটো, দ্য আৰ্টিছানেল লেন্সৰে তোলা';
  }

  @override
  String couldNotSavePhoto(String error) {
    return 'ফটো ছেভ কৰিব পৰা নগ\'ল: $error';
  }

  @override
  String get galleryEmpty =>
      'এতিয়াও কোনো ফটো ছেট নাই।\nআৰম্ভ কৰিবলৈ নতুন সামগ্ৰী বনাওক।';

  @override
  String get galleryEmptyFiltered => 'এই শ্ৰেণীত এতিয়াও একো নাই।';

  @override
  String get showAll => 'সকলো দেখুৱাওক';

  @override
  String get nextPill => 'পৰৱৰ্তী';

  @override
  String get templateOverline => 'টেমপ্লেট';

  @override
  String get proTipGoodLight =>
      'পৰামৰ্শ: সামগ্ৰীৰ ফটোৰ বাবে এতিয়া প্ৰাকৃতিক পোহৰেই শ্ৰেষ্ঠ।';

  @override
  String get chipLight => 'পোহৰ';

  @override
  String get chipDistance => 'দূৰত্ব';

  @override
  String get chipCentre => 'কেন্দ্ৰ';

  @override
  String get chipEmDash => '—';

  @override
  String get readingTheFrame => 'ফ্ৰেম পঢ়ি আছে…';

  @override
  String fillFrameWith(String slot) {
    return '$slotৰে ফ্ৰেম ভৰাওক';
  }

  @override
  String promptNoProduct(String product) {
    return '$productখন সন্মুখত ৰাখক';
  }

  @override
  String promptMoveIntoFrame(String product) {
    return '$productখন ফ্ৰেমৰ ভিতৰলৈ আনক';
  }

  @override
  String promptKeepInsideFrame(String product) {
    return '$productখন ফ্ৰেমৰ ভিতৰত ৰাখক';
  }

  @override
  String get promptAlignHorizontal => 'ভাঁজবোৰ আনুভূমিক গাইডৰ সৈতে মিলাওক';

  @override
  String get promptAlignDiagonal => 'কাপোৰক তিৰ্যক গাইডৰ সৈতে যাবলৈ দিয়ক';

  @override
  String get promptHoldSteady => 'ফোন স্থিৰকৈ ধৰক';

  @override
  String get promptMoveCloser => 'ওচৰলৈ যাওক';

  @override
  String get promptMoveFurther => 'বিষয়ৰ পৰা আৰু আঁতৰলৈ যাওক';

  @override
  String promptCenterSubject(String product) {
    return '$productখন মাজত ৰাখক';
  }

  @override
  String get promptKeepTextureCentre => 'গঠনটো কেন্দ্ৰত ৰাখক';

  @override
  String get promptKeepBorderInside => 'বৰ্ডাৰ ফ্ৰেমৰ ভিতৰত ৰাখক';

  @override
  String get promptKeepFoldsVisible => 'ভাঁজবোৰ দেখা থাকক';

  @override
  String get promptBacklight => 'পিছফালৰ পোহৰ ধৰা পৰিছে';

  @override
  String get promptTooDark => 'বৰ আন্ধাৰ — খিৰিকীৰ ওচৰলৈ বা বাহিৰলৈ যাওক';

  @override
  String get promptLowLight => 'পোহৰ কম — খিৰিকীৰ আৰু ওচৰলৈ যাওক';

  @override
  String get promptTooBright => 'বৰ উজ্জ্বল — খোলা ছাঁত যাওক';

  @override
  String get promptTiltPhone => 'কোণৰ গাইড অনুসৰি ফোন হেলনীয়া কৰক';

  @override
  String get promptReady => 'ফটো তুলিবলৈ সাজু';

  @override
  String get lightTooDark => 'বৰ আন্ধাৰ';

  @override
  String get lightLow => 'কম';

  @override
  String get lightOk => 'ঠিক আছে';

  @override
  String get lightBright => 'উজ্জ্বল';

  @override
  String get distanceMoveCloser => 'ওচৰলৈ যাওক';

  @override
  String get distanceOk => 'ঠিক আছে';

  @override
  String get distanceMoveBack => 'পিছলৈ যাওক';

  @override
  String get centreMoveIn => 'ভিতৰলৈ আনক';

  @override
  String get centreOk => 'ঠিক আছে';

  @override
  String get advisoryGoodHeadline => 'এতিয়া পোহৰ ভাল';

  @override
  String get advisoryGoodDetail =>
      'প্ৰাকৃতিক পোহৰ কোমল, ৰং স্পষ্ট আৰু সঁচা দেখা যাব।';

  @override
  String get advisoryOverheadHeadline => 'মূৰৰ ওপৰৰ ৰ\'দ';

  @override
  String get advisoryOverheadDetail =>
      'পোহৰ কোমল হোৱাৰ পিছত ফটো তোলক। এতিয়া ওপৰৰ ৰ\'দে ছেটআপত কঠিন ছাঁ পেলাব পাৰে।';

  @override
  String get advisoryDarkHeadline => 'দিনৰ পোহৰ যথেষ্ট নহয়';

  @override
  String get advisoryDarkDetail =>
      'এতিয়া প্ৰাকৃতিক পোহৰ কম। ৰাতিপুৱা খিৰিকীৰ ওচৰত ৰং সকলোতকৈ সঁচা দেখা যায়।';

  @override
  String get openingTagline => 'হস্তশিল্প সামগ্ৰীৰ বাবে নিৰ্দেশিত ফটোগ্ৰাফী';

  @override
  String get openingChipLight => 'পোহৰ: ভাল';

  @override
  String get openingChipAngle => 'কোণ: ঠিক';

  @override
  String get openingChipFrame => 'ফ্ৰেম: সাজু';

  @override
  String get guidelineG1Title => 'ক্ল\'জ-আপ শ্বট লওক';

  @override
  String get guidelineG1Body =>
      'কাপোৰৰ সূক্ষ্ম গঠন, বিৱৰণ আৰু কাৰুকাৰ্য দেখুৱাওক।';

  @override
  String get guidelineG2Title => 'কাপোৰৰ কাষ দেখুৱাওক';

  @override
  String get guidelineG2Body =>
      'কাপোৰৰ কাষ তোলক, ছবিৰ দুই-তৃতীয়াংশ কাপোৰেৰে ভৰা থাকক।';

  @override
  String get guidelineG3Title => 'কেইবাটাও কোণৰ পৰা তোলক';

  @override
  String get guidelineG3Body =>
      'ডিজাইন আৰু গঠন দেখুৱাবলৈ সামগ্ৰীক কেইবাটাও দৃষ্টিৰে দেখুৱাওক।';

  @override
  String get guidelineG4Title => 'বিভিন্ন পোহৰ চেষ্টা কৰক';

  @override
  String get guidelineG4Body =>
      'প্ৰাকৃতিক আৰু কৃত্ৰিম পোহৰ, ঘৰৰ ভিতৰত আৰু বাহিৰত, সন্মুখ আৰু কাষৰ পোহৰ — যাতে কাপোৰৰ সঁচা ৰং আৰু গভীৰতা ওলায়।';

  @override
  String get guidelineG5Title => 'সহযোগী পৃষ্ঠভূমি বাছক';

  @override
  String get guidelineG5Body =>
      'এনে পৃষ্ঠভূমি ৰাখক যি কাপোৰৰ সৌন্দৰ্য বাঢ়ায়, কিন্তু তাৰ ওপৰত জয়ী নহয়।';

  @override
  String get guidelineG6Title => 'প্ৰাকৃতিক ভাঁজ থাকিবলৈ দিয়ক';

  @override
  String get guidelineG6Body =>
      'ইস্ত্ৰি নকৰা অৱস্থাতে কাপোৰৰ ফটো তোলক যাতে সামগ্ৰী স্পষ্টকৈ বুজা যায়।';

  @override
  String get guidelineG7Title => 'ওজন আৰু প্ৰবাহ দেখুৱাওক';

  @override
  String get guidelineG7Body =>
      'কাপোৰ কেনেকৈ ওলমে, ভাঁজ খায় আৰু বৈ যায়, সেয়াই তাৰ ওজন আৰু অনুভৱ কয়।';

  @override
  String get guidelineG8Title => 'এটা কাহিনী কওক';

  @override
  String get guidelineG8Body =>
      'এনেদৰে ফ্ৰেম কৰক যাতে কাপোৰ নিজৰ সংস্কৃতি, শিল্পী আৰু ব্যৱহাৰৰ সৈতে জড়িত দেখা যায়।';

  @override
  String get categorySaree => 'শাড়ী';

  @override
  String get categoryCushionCover => 'কুশ্বন কভাৰ';

  @override
  String get categoryShawl => 'শাল';

  @override
  String get categoryStole => 'ষ্টোল';

  @override
  String get categorySarees => 'শাড়ী';

  @override
  String get categoryCushionCovers => 'কুশ্বন কভাৰ';

  @override
  String get categoryShawls => 'শাল';

  @override
  String get categoryStoles => 'ষ্টোল';

  @override
  String get nounSaree => 'শাড়ী';

  @override
  String get nounCushionCover => 'কুশ্বন কভাৰ';

  @override
  String get nounShawl => 'শাল';

  @override
  String get nounStole => 'ষ্টোল';

  @override
  String get nounProduct => 'সামগ্ৰী';

  @override
  String get materialSilk => 'পাট';

  @override
  String get materialCotton => 'কপাহ';

  @override
  String get materialWool => 'উল';

  @override
  String get materialJute => 'পাটশণ';

  @override
  String get materialSilkLower => 'পাট';

  @override
  String get materialCottonLower => 'কপাহ';

  @override
  String get materialWoolLower => 'উল';

  @override
  String get materialJuteLower => 'পাটশণ';

  @override
  String get silkMulberry => 'মালবেৰী';

  @override
  String get silkEri => 'এৰি';

  @override
  String get silkTasar => 'তছৰ';

  @override
  String get silkMuga => 'মুগা';

  @override
  String get cottonKhadi => 'খাদী';

  @override
  String get cottonMuslin => 'মলমল';

  @override
  String get cottonHandloom => 'হাতে তোৰা';

  @override
  String get cottonJamdani => 'জমদানি';

  @override
  String get woolPashmina => 'পশ্মিনা';

  @override
  String get woolAngora => 'এংগোৰা';

  @override
  String get woolMerino => 'মেৰিনো';

  @override
  String get woolHandspun => 'হাতে কটা';

  @override
  String get juteGolden => 'সোণালী';

  @override
  String get juteTossa => 'টোছা';

  @override
  String get juteHessian => 'হেছিয়ান';

  @override
  String get juteBlended => 'মিশ্ৰিত';

  @override
  String get shotProcess => 'প্ৰক্ৰিয়া';

  @override
  String get shotProduct => 'সামগ্ৰী';

  @override
  String get shotDetail => 'বিৱৰণ';

  @override
  String get shotLifestyle => 'লাইফষ্টাইল';

  @override
  String get shotPhotography => 'ফটোগ্ৰাফী';

  @override
  String get shotProcessChecklist => 'বনোৱাৰ প্ৰক্ৰিয়া দেখুৱাওক';

  @override
  String get shotProductChecklist => 'সম্পূৰ্ণ বস্তুৰ ফটো';

  @override
  String get shotDetailChecklist => 'গঠন/বয়নৰ ক্ল\'জ-আপ';

  @override
  String get shotLifestyleChecklist => 'প্ৰাকৃতিক পৰিৱেশত';

  @override
  String get shotPhotographyChecklist => 'শাড়ী ফটোগ্ৰাফী টেমপ্লেট';

  @override
  String get slotLoomSetup => 'তাঁত ছেটআপ';

  @override
  String get slotDyeing => 'ৰং কৰা';

  @override
  String get slotHeroShot => 'মূল ফটো';

  @override
  String get slotBorder => 'বৰ্ডাৰ';

  @override
  String get slotWeave => 'বয়ন';

  @override
  String get slotMotif => 'মটিফ';

  @override
  String get slotStyledShot => 'শৈলীৰ ফটো';

  @override
  String get templateFullDisplay => 'সম্পূৰ্ণ শাড়ী প্ৰদৰ্শন';

  @override
  String get templateTextureWeave => 'গঠন আৰু বয়ন';

  @override
  String get templateDrapedLook => 'ড্ৰেপ লুক';

  @override
  String get templateEmbroideryBorder => 'এমব্ৰয়ডাৰী আৰু বৰ্ডাৰৰ বিৱৰণ';

  @override
  String get templateFoldedStack => 'ভাঁজ কৰা দ\'ম / শাড়ী ষ্টেক';

  @override
  String get templateFullDisplayLower => 'সম্পূৰ্ণ শাড়ী প্ৰদৰ্শন';

  @override
  String get templateTextureWeaveLower => 'গঠন আৰু বয়ন';

  @override
  String get templateDrapedLookLower => 'ড্ৰেপ লুক';

  @override
  String get templateEmbroideryBorderLower => 'এমব্ৰয়ডাৰী আৰু বৰ্ডাৰৰ বিৱৰণ';

  @override
  String get templateFoldedStackLower => 'ভাঁজ কৰা দ\'ম / শাড়ী ষ্টেক';

  @override
  String get templateFullDisplayContent => 'ৰং, আৰ্হি, সামগ্ৰী';

  @override
  String get templateTextureWeaveContent => 'গঠন, ডাঠতা, সামগ্ৰী, স্বচ্ছতা';

  @override
  String get templateDrapedLookContent => 'পাতলতা, চিকমিকনি, প্ৰবাহ, ওজন';

  @override
  String get templateEmbroideryBorderContent => 'এমব্ৰয়ডাৰী, গুণগত মান';

  @override
  String get templateFoldedStackContent => 'ডাঠতা, সামগ্ৰীৰ ওজন';

  @override
  String get templateFullDisplayNeeds =>
      'প্ৰাকৃতিক দিনৰ পোহৰ; নিৰপেক্ষ বা বিপৰীত পৃষ্ঠভূমি';

  @override
  String get templateTextureWeaveNeeds => 'যিমান পাৰি প্ৰাকৃতিক পোহৰ';

  @override
  String get templateDrapedLookNeeds => 'হেংগাৰ, বাঁহ বা পুতলা; কাষৰ পোহৰ';

  @override
  String get templateEmbroideryBorderNeeds => 'কাষৰ পোহৰ; বিপৰীত পৃষ্ঠভূমি';

  @override
  String get templateFoldedStackNeeds => 'কাষৰ পোহৰ';

  @override
  String get templateFullDisplayPlacement =>
      'শাড়ী সমতলকৈ মেলি বা পৃষ্ঠত ওলোমাই ৰাখক';

  @override
  String get templateTextureWeavePlacement =>
      'শাড়ীৰ ভালকৈ পোহৰ পৰা অংশ, ভাল হয় প্ৰাকৃতিক পোহৰত';

  @override
  String get templateDrapedLookPlacement => 'হেংগাৰ, বাঁহ বা পুতলা';

  @override
  String get templateEmbroideryBorderPlacement =>
      'শাড়ীৰ বৰ্ডাৰ বা এমব্ৰয়ডাৰী অংশৰ ক্ল\'জ-আপ';

  @override
  String get templateFoldedStackPlacement => 'চাফা দ\'ম, ভাঁজ দেখা যায়';

  @override
  String get templateFullDisplayOverlay =>
      'ওপৰৰ বৰ্ডাৰ গ্ৰিডৰ ওপৰৰ তৃতীয়াংশৰ সৈতে মিলাওক';

  @override
  String get templateTextureWeaveOverlay => 'গঠনটো কেন্দ্ৰত ৰাখক';

  @override
  String get templateDrapedLookOverlay =>
      'ভাঁজবোৰ তিৰ্যক ৰেখাৰ সৈতে যাবলৈ দিয়ক';

  @override
  String get templateEmbroideryBorderOverlay => 'এমব্ৰয়ডাৰী ফ্ৰেমৰ ভিতৰত ৰাখক';

  @override
  String get templateFoldedStackOverlay =>
      'ভাঁজবোৰ আনুভূমিক ৰেখাৰ সমান্তৰাল ৰাখক';

  @override
  String get templateTextureWeaveLighting =>
      'কোমল পোহৰ ব্যৱহাৰ কৰক। তীব্ৰ প্ৰতিফলন এৰাই চলক।';

  @override
  String get templateCushionFullCover => 'সম্পূৰ্ণ কভাৰ প্ৰদৰ্শন';

  @override
  String get templateCushionTextureWeave => 'গঠন আৰু বয়ন';

  @override
  String get templateCushionStackedPair => 'যোৰাৰ দ\'ম / ডাঠতা';

  @override
  String get templateCushionCornerStitching => 'কোণ আৰু চিলাই';

  @override
  String get templateCushionInUse => 'আসনত ব্যৱহাৰত';

  @override
  String get templateCushionFullCoverLower => 'সম্পূৰ্ণ কভাৰ প্ৰদৰ্শন';

  @override
  String get templateCushionTextureWeaveLower => 'গঠন আৰু বয়ন';

  @override
  String get templateCushionStackedPairLower => 'যোৰাৰ দ\'ম / ডাঠতা';

  @override
  String get templateCushionCornerStitchingLower => 'কোণ আৰু চিলাই';

  @override
  String get templateCushionInUseLower => 'আসনত ব্যৱহাৰত';

  @override
  String get templateCushionFullCoverContent => 'ৰং, আৰ্হি, সামগ্ৰী';

  @override
  String get templateCushionTextureWeaveContent => 'গঠন, ডাঠতা, সামগ্ৰী';

  @override
  String get templateCushionStackedPairContent => 'ডাঠতা, সামগ্ৰী, গঠন';

  @override
  String get templateCushionCornerStitchingContent =>
      'গুণগত মান, গঠন, এমব্ৰয়ডাৰী';

  @override
  String get templateCushionInUseContent => 'ৰং, আৰ্হি, গুণগত মান';

  @override
  String get templateCushionFullCoverNeeds =>
      'প্ৰাকৃতিক দিনৰ পোহৰ; সাধাৰণ পৃষ্ঠ';

  @override
  String get templateCushionTextureWeaveNeeds => 'যিমান পাৰি প্ৰাকৃতিক পোহৰ';

  @override
  String get templateCushionStackedPairNeeds => 'কাষৰ পোহৰ; এযোৰ কভাৰ';

  @override
  String get templateCushionCornerStitchingNeeds => 'কাষৰ পোহৰ';

  @override
  String get templateCushionInUseNeeds => 'কুৰ্ছী, ছোফা বা বিচনা';

  @override
  String get templateCushionFullCoverPlacement =>
      'কভাৰখন সাধাৰণ পৃষ্ঠত সমতলকৈ ৰাখক';

  @override
  String get templateCushionTextureWeavePlacement => 'কভাৰৰ ভালকৈ পোহৰ পৰা অংশ';

  @override
  String get templateCushionStackedPairPlacement =>
      'দুখন কভাৰ এনেদৰে থাপক যাতে কাষবোৰ কেমেৰাৰ ফালে থাকে';

  @override
  String get templateCushionCornerStitchingPlacement =>
      'চিলাই কৰা কোণৰ ক্ল\'জ-আপ';

  @override
  String get templateCushionInUsePlacement =>
      'কভাৰখন আসনত থিয় কৰাই কেমেৰাৰ ফালে ৰাখক';

  @override
  String get templateCushionFullCoverOverlay => 'কাষবোৰ গ্ৰিডৰ সৈতে পোনকৈ ৰাখক';

  @override
  String get templateCushionTextureWeaveOverlay => 'গঠনটো কেন্দ্ৰত ৰাখক';

  @override
  String get templateCushionStackedPairOverlay =>
      'ভাঁজবোৰ আনুভূমিক ৰেখাৰ সমান্তৰাল ৰাখক';

  @override
  String get templateCushionCornerStitchingOverlay => 'চিলাই ফ্ৰেমৰ ভিতৰত ৰাখক';

  @override
  String get templateCushionInUseOverlay => 'কভাৰখন ফ্ৰেমত ৰাখক';

  @override
  String get templateShawlFullDesign => 'সম্পূৰ্ণ ডিজাইন প্ৰদৰ্শন';

  @override
  String get templateShawlTextureWeave => 'গঠন আৰু বয়ন';

  @override
  String get templateShawlDrapedLook => 'ড্ৰেপ লুক';

  @override
  String get templateShawlBorderCorner => 'বৰ্ডাৰ আৰু কোণ';

  @override
  String get templateShawlFoldedStack => 'ভাঁজ কৰা দ\'ম';

  @override
  String get templateShawlFullDesignLower => 'সম্পূৰ্ণ ডিজাইন প্ৰদৰ্শন';

  @override
  String get templateShawlTextureWeaveLower => 'গঠন আৰু বয়ন';

  @override
  String get templateShawlDrapedLookLower => 'ড্ৰেপ লুক';

  @override
  String get templateShawlBorderCornerLower => 'বৰ্ডাৰ আৰু কোণ';

  @override
  String get templateShawlFoldedStackLower => 'ভাঁজ কৰা দ\'ম';

  @override
  String get templateShawlFullDesignContent => 'আৰ্হি, ৰং, স্বচ্ছতা';

  @override
  String get templateShawlTextureWeaveContent => 'গঠন, ডাঠতা, সামগ্ৰী';

  @override
  String get templateShawlDrapedLookContent => 'পাতলতা, সামগ্ৰী, আৰ্হি';

  @override
  String get templateShawlBorderCornerContent => 'গঠন, গুণগত মান, এমব্ৰয়ডাৰী';

  @override
  String get templateShawlFoldedStackContent => 'ডাঠতা, সামগ্ৰী';

  @override
  String get templateShawlFullDesignNeeds => 'ৰছী, বাঁহ বা দেৱাল য\'ত পিন কৰিব';

  @override
  String get templateShawlTextureWeaveNeeds => 'যিমান পাৰি প্ৰাকৃতিক পোহৰ';

  @override
  String get templateShawlDrapedLookNeeds => 'শাল পিন্ধা কোনোবা';

  @override
  String get templateShawlBorderCornerNeeds => 'কাষৰ পোহৰ';

  @override
  String get templateShawlFoldedStackNeeds => 'কাষৰ পোহৰ';

  @override
  String get templateShawlFullDesignPlacement =>
      'শাল নামি নোযোৱাকৈ সমতলকৈ ওলোমাই বা পিন কৰক';

  @override
  String get templateShawlTextureWeavePlacement => 'শালৰ ভালকৈ পোহৰ পৰা অংশ';

  @override
  String get templateShawlDrapedLookPlacement =>
      'শাল এখন কান্ধত, স্বাভাৱিকভাৱে সৰি পৰা';

  @override
  String get templateShawlBorderCornerPlacement => 'কোণ আৰু বৰ্ডাৰৰ ক্ল\'জ-আপ';

  @override
  String get templateShawlFoldedStackPlacement => 'চাফা দ\'ম, ভাঁজ দেখা যায়';

  @override
  String get templateShawlFullDesignOverlay =>
      'বৰ্ডাৰ গ্ৰিডৰ ওপৰৰ তৃতীয়াংশৰ সৈতে মিলাওক';

  @override
  String get templateShawlTextureWeaveOverlay => 'গঠনটো কেন্দ্ৰত ৰাখক';

  @override
  String get templateShawlDrapedLookOverlay =>
      'ভাঁজবোৰ তিৰ্যক ৰেখাৰ সৈতে যাবলৈ দিয়ক';

  @override
  String get templateShawlBorderCornerOverlay => 'বৰ্ডাৰ ফ্ৰেমৰ ভিতৰত ৰাখক';

  @override
  String get templateShawlFoldedStackOverlay =>
      'ভাঁজবোৰ আনুভূমিক ৰেখাৰ সমান্তৰাল ৰাখক';

  @override
  String get templateStoleFullLength => 'সম্পূৰ্ণ দৈৰ্ঘ্যৰ প্ৰদৰ্শন';

  @override
  String get templateStoleTextureWeave => 'গঠন আৰু বয়ন';

  @override
  String get templateStoleNeckWrap => 'পৰিধান কৰা ডিঙি ৰেপ';

  @override
  String get templateStoleSoftnessKnot => 'কোমলতা / গাঁঠি';

  @override
  String get templateStoleEdgeThickness => 'কাষ আৰু ডাঠতা';

  @override
  String get templateStoleFullLengthLower => 'সম্পূৰ্ণ দৈৰ্ঘ্যৰ প্ৰদৰ্শন';

  @override
  String get templateStoleTextureWeaveLower => 'গঠন আৰু বয়ন';

  @override
  String get templateStoleNeckWrapLower => 'পৰিধান কৰা ডিঙি ৰেপ';

  @override
  String get templateStoleSoftnessKnotLower => 'কোমলতা / গাঁঠি';

  @override
  String get templateStoleEdgeThicknessLower => 'কাষ আৰু ডাঠতা';

  @override
  String get templateStoleFullLengthContent => 'আৰ্হি, ৰং, সামগ্ৰী';

  @override
  String get templateStoleTextureWeaveContent => 'গঠন, ডাঠতা, সামগ্ৰী';

  @override
  String get templateStoleNeckWrapContent => 'পাতলতা, ৰং, আৰ্হি';

  @override
  String get templateStoleSoftnessKnotContent => 'পাতলতা, গঠন, সামগ্ৰী';

  @override
  String get templateStoleEdgeThicknessContent => 'ডাঠতা, গঠন, সামগ্ৰী';

  @override
  String get templateStoleFullLengthNeeds =>
      'প্ৰাকৃতিক দিনৰ পোহৰ; সাধাৰণ পৃষ্ঠ';

  @override
  String get templateStoleTextureWeaveNeeds => 'যিমান পাৰি প্ৰাকৃতিক পোহৰ';

  @override
  String get templateStoleNeckWrapNeeds => 'ষ্টোল পিন্ধা কোনোবা';

  @override
  String get templateStoleSoftnessKnotNeeds => 'কোমল কাষৰ পোহৰ';

  @override
  String get templateStoleEdgeThicknessNeeds => 'কোমল কাষৰ পোহৰ';

  @override
  String get templateStoleFullLengthPlacement =>
      'ষ্টোল সম্পূৰ্ণ দৈৰ্ঘ্য দেখা পোৱাকৈ মেলি দিয়ক';

  @override
  String get templateStoleTextureWeavePlacement => 'ষ্টোলৰ ভালকৈ পোহৰ পৰা অংশ';

  @override
  String get templateStoleNeckWrapPlacement =>
      'ডিঙিত এবাৰ মেৰিয়াই দুয়ো মূৰ দেখা যায়';

  @override
  String get templateStoleSoftnessKnotPlacement => 'মাজত এটা ঢিলা গাঁঠি';

  @override
  String get templateStoleEdgeThicknessPlacement => 'ষ্টোল ঢিলাকৈ কুণ্ডলিত কৰক';

  @override
  String get templateStoleFullLengthOverlay => 'ষ্টোল গ্ৰিডৰ সৈতে ৰাখক';

  @override
  String get templateStoleTextureWeaveOverlay => 'গঠনটো কেন্দ্ৰত ৰাখক';

  @override
  String get templateStoleNeckWrapOverlay => 'ৰেপ ফ্ৰেমত ৰাখক';

  @override
  String get templateStoleSoftnessKnotOverlay => 'গাঁঠি কেন্দ্ৰত ৰাখক';

  @override
  String get templateStoleEdgeThicknessOverlay => 'কুণ্ডলী কেন্দ্ৰত ৰাখক';

  @override
  String get presetSareePalluDrapeName => 'পল্লু ড্ৰেপ (হেংগাৰ)';

  @override
  String get presetSareeBoxFoldName => 'বাকচ / সমতল ভাঁজ';

  @override
  String get presetSareeWornDrapeName => 'পৰিধান কৰা ড্ৰেপ (মডেল)';

  @override
  String get presetSareeRollDisplayName => 'ৰোল প্ৰদৰ্শন';

  @override
  String get presetCushionFlatLayName => 'ফ্লেট লে';

  @override
  String get presetCushionStackedPairName => 'যোৰা দ\'ম';

  @override
  String get presetCushionProppedName => 'আসনত থিয় কৰাই';

  @override
  String get presetCushionCornerTuckName => 'কোণৰ ক্ল\'জ-আপ';

  @override
  String get presetShawlDrapedShoulderName => 'কান্ধত ওলোমাই';

  @override
  String get presetShawlFoldedStackName => 'ভাঁজ কৰা দ\'ম';

  @override
  String get presetShawlHungFlatName => 'ওলোমাই / সমতল পিন কৰা';

  @override
  String get presetShawlCornerTuckName => 'কোণৰ ক্ল\'জ-আপ';

  @override
  String get presetStoleNeckWrapName => 'ডিঙিত মেৰাই (পৰিধান)';

  @override
  String get presetStoleFlatSpreadName => 'সমতলকৈ মেলা';

  @override
  String get presetStoleLooseKnotName => 'ঢিলা গাঁঠি';

  @override
  String get presetStoleRolledCoilName => 'ৰোল কুণ্ডলী';

  @override
  String get presetSareePalluDrapePurpose =>
      'পাতলতা, চিকমিকনি, প্ৰবাহ আৰু ওজন দেখুৱায়।';

  @override
  String get presetSareeBoxFoldPurpose => 'ডাঠতা আৰু সামগ্ৰীৰ ওজন দেখুৱায়।';

  @override
  String get presetSareeWornDrapePurpose =>
      'পৰিধান কৰোঁতে ৰং, আৰ্হি আৰু সামগ্ৰী দেখুৱায়।';

  @override
  String get presetSareeRollDisplayPurpose =>
      'সৰু ৰোলত ৰং, আৰ্হি আৰু সামগ্ৰী দেখুৱায়।';

  @override
  String get presetCushionFlatLayPurpose =>
      'সম্পূৰ্ণ আৰ্হি আৰু ৰং বিকৃত নকৰাকৈ দেখুৱাওক।';

  @override
  String get presetCushionStackedPairPurpose =>
      'ডাঠতা আৰু যোৰা কেনেকুৱা দেখা যায়, দেখুৱাওক।';

  @override
  String get presetCushionProppedPurpose =>
      'কভাৰ ব্যৱহাৰত, প্ৰকৃত আকাৰত দেখুৱাওক।';

  @override
  String get presetCushionCornerTuckPurpose => 'কোণত চিলাই আৰু ফিনিচ দেখুৱাওক।';

  @override
  String get presetShawlDrapedShoulderPurpose =>
      'ড্ৰেপ, ওজন আৰু পৰিধানত কেনেকৈ বহে দেখুৱাওক।';

  @override
  String get presetShawlFoldedStackPurpose =>
      'ডাঠতা আৰু সামগ্ৰীৰ ওজন দেখুৱাওক।';

  @override
  String get presetShawlHungFlatPurpose =>
      'সম্পূৰ্ণ ডিজাইন, ৰং আৰু বৰ্ডাৰ একেলগে দেখুৱাওক।';

  @override
  String get presetShawlCornerTuckPurpose =>
      'বয়ন, বৰ্ডাৰ আৰু কাৰুকাৰ্য দেখুৱাওক।';

  @override
  String get presetStoleNeckWrapPurpose =>
      'আকাৰ আৰু পৰিধানত ষ্টোল কেনেকৈ বহে দেখুৱাওক।';

  @override
  String get presetStoleFlatSpreadPurpose =>
      'সম্পূৰ্ণ দৈৰ্ঘ্য, আৰ্হি আৰু দুয়োখন বৰ্ডাৰ দেখুৱাওক।';

  @override
  String get presetStoleLooseKnotPurpose =>
      'কাপোৰ কিমান কোমল আৰু কিমান সহজে গাঁঠি হয় দেখুৱাওক।';

  @override
  String get presetStoleRolledCoilPurpose =>
      'কাষ, ডাঠতা আৰু বয়নৰ ফিনিচ দেখুৱাওক।';

  @override
  String get presetSareePalluDrapeContent => 'পাতলতা, চিকমিকনি, প্ৰবাহ, ওজন';

  @override
  String get presetSareeBoxFoldContent => 'ডাঠতা, সামগ্ৰীৰ ওজন';

  @override
  String get presetSareeWornDrapeContent => 'ৰং, আৰ্হি, সামগ্ৰী';

  @override
  String get presetSareeRollDisplayContent => 'ৰং, আৰ্হি, সামগ্ৰী';

  @override
  String get presetSareePalluDrapeNeeds => 'হেংগাৰ, বাঁহ বা পুতলা; কাষৰ পোহৰ';

  @override
  String get presetSareeBoxFoldNeeds => 'কাষৰ পোহৰ';

  @override
  String get presetSareeWornDrapeNeeds =>
      'শাড়ী পিন্ধিবলৈ কোনোবা; প্ৰাকৃতিক দিনৰ পোহৰ; নিৰপেক্ষ বা বিপৰীত পৃষ্ঠভূমি';

  @override
  String get presetSareeRollDisplayNeeds =>
      'প্ৰাকৃতিক দিনৰ পোহৰ; নিৰপেক্ষ বা বিপৰীত পৃষ্ঠভূমি';

  @override
  String get presetSareePalluDrapeLower => 'পল্লু ড্ৰেপ (হেংগাৰ)';

  @override
  String get presetSareeBoxFoldLower => 'বাকচ / সমতল ভাঁজ';

  @override
  String get presetSareeWornDrapeLower => 'পৰিধান কৰা ড্ৰেপ (মডেল)';

  @override
  String get presetSareeRollDisplayLower => 'ৰোল প্ৰদৰ্শন';

  @override
  String get presetCushionFlatLayLower => 'ফ্লেট লে';

  @override
  String get presetCushionStackedPairLower => 'যোৰা দ\'ম';

  @override
  String get presetCushionProppedLower => 'আসনত থিয় কৰাই';

  @override
  String get presetCushionCornerTuckLower => 'কোণৰ ক্ল\'জ-আপ';

  @override
  String get presetShawlDrapedShoulderLower => 'কান্ধত ওলোমাই';

  @override
  String get presetShawlFoldedStackLower => 'ভাঁজ কৰা দ\'ম';

  @override
  String get presetShawlHungFlatLower => 'ওলোমাই / সমতল পিন কৰা';

  @override
  String get presetShawlCornerTuckLower => 'কোণৰ ক্ল\'জ-আপ';

  @override
  String get presetStoleNeckWrapLower => 'ডিঙিত মেৰাই (পৰিধান)';

  @override
  String get presetStoleFlatSpreadLower => 'সমতলকৈ মেলা';

  @override
  String get presetStoleLooseKnotLower => 'ঢিলা গাঁঠি';

  @override
  String get presetStoleRolledCoilLower => 'ৰোল কুণ্ডলী';

  @override
  String get shotProcessLower => 'প্ৰক্ৰিয়া';

  @override
  String get shotProductLower => 'সামগ্ৰী';

  @override
  String get shotDetailLower => 'বিৱৰণ';

  @override
  String get shotLifestyleLower => 'লাইফষ্টাইল';

  @override
  String get shotPhotographyLower => 'ফটোগ্ৰাফী';

  @override
  String get categorySareeLower => 'শাড়ী';

  @override
  String get categoryCushionCoverLower => 'কুশ্বন কভাৰ';

  @override
  String get categoryShawlLower => 'শাল';

  @override
  String get categoryStoleLower => 'ষ্টোল';

  @override
  String get propertyColour => 'ৰং';

  @override
  String get propertyMaterial => 'সামগ্ৰী';

  @override
  String get propertyQuality => 'গুণগত মান';

  @override
  String get propertyFlimsiness => 'পাতলতা';

  @override
  String get propertyTexture => 'গঠন';

  @override
  String get propertyThickness => 'ডাঠতা';

  @override
  String get propertyTransparency => 'স্বচ্ছতা';

  @override
  String get propertyPattern => 'আৰ্হি';

  @override
  String get propertySheen => 'চিকমিকনি';

  @override
  String get propertyEmbroidery => 'এমব্ৰয়ডাৰী';

  @override
  String get angleEyeLevel => 'চকুৰ উচ্চতা';

  @override
  String get angleEyeLevelHint => 'ফোন সামগ্ৰীৰ উচ্চতাত, পোনকৈ সন্মুখত ৰাখক।';

  @override
  String get angleOverhead => 'ওপৰৰ পৰা (ফ্লেট লে)';

  @override
  String get angleOverheadHint => 'সামগ্ৰীৰ ওপৰত থিয় হৈ ফোন পোনকৈ তললৈ কৰক।';

  @override
  String get angleLow => 'তলৰ কোণ';

  @override
  String get angleLowHint => 'ফোন সামগ্ৰীতকৈ তললৈ কৰি অলপ ওপৰলৈ হেলনীয়া কৰক।';

  @override
  String get angleMacro => 'মেক্ৰ\' ক্ল\'জ-আপ';

  @override
  String get angleMacroHint =>
      'বয়নে ফ্ৰেম ভৰোৱালৈকে ওচৰলৈ যাওক, তাৰ পিছত ফ\'কাছৰ বাবে টেপ কৰক।';

  @override
  String get lightingSoftWindow => 'কোমল খিৰিকীৰ পোহৰ';

  @override
  String get lightingSoftWindowHint =>
      'সামগ্ৰী খিৰিকীৰ কাষত ৰাখক, বাল্বৰ তলত নহয়।';

  @override
  String get lightingDiffused => 'বিস্তৃত দিনৰ পোহৰ';

  @override
  String get lightingDiffusedHint =>
      'বাহিৰৰ খোলা ছাঁত তোলক, পোহৰ এফালৰ পৰা আহক।';

  @override
  String get lightingAvoidMidday => 'দুপৰীয়াৰ তীব্ৰ ৰ\'দ এৰাই চলক';

  @override
  String get lightingAvoidMiddayHint =>
      'দুপৰীয়া ৩ বজাৰ পিছত তোলক — ওপৰৰ ৰ\'দে ৰং উৰাই দিয়ে।';

  @override
  String get lightingBacklight => 'পাতল কাপোৰৰ বাবে পিছফালৰ পোহৰ';

  @override
  String get lightingBacklightHint =>
      'পোহৰ কাপোৰৰ পিছফালে ৰাখক যাতে স্বচ্ছতা দেখা যায়।';

  @override
  String get compositionRuleOfThirds => 'তৃতীয়াংশৰ নিয়ম';

  @override
  String get compositionRuleOfThirdsHint =>
      'বৰ্ডাৰ গ্ৰিডৰ ওপৰৰ তৃতীয়াংশৰ সৈতে মিলাওক।';

  @override
  String get compositionCentered => 'কেন্দ্ৰত সামগ্ৰী';

  @override
  String get compositionCenteredHint => 'সামগ্ৰী গ্ৰিডৰ মাজৰ বাকচত ৰাখক।';

  @override
  String get compositionNegativeSpace => 'ভাঁজৰ চাৰিওফালে খালী ঠাই';

  @override
  String get compositionNegativeSpaceHint =>
      'ভাঁজবোৰ স্পষ্টকৈ দেখাবলৈ চাৰিওফালে খালী ঠাই এৰক।';

  @override
  String get compositionLeadingLines => 'কাপোৰৰ তিৰ্যক ৰেখা';

  @override
  String get compositionLeadingLinesHint =>
      'ভাঁজবোৰ তিৰ্যক গাইডৰ সৈতে মেলি ৰাখক।';

  @override
  String get compositionCentreFocus => 'কেন্দ্ৰ ফ\'কাছ';

  @override
  String get compositionCentreFocusHint => 'গঠনটো ফ্ৰেমৰ কেন্দ্ৰত ৰাখক।';

  @override
  String get compositionDetailFrame => 'বিৱৰণ ফ্ৰেম';

  @override
  String get compositionDetailFrameHint =>
      'এমব্ৰয়ডাৰী হাইলাইট কৰা ফ্ৰেমৰ ভিতৰত ৰাখক।';

  @override
  String get accountBackup => 'একাউণ্ট আৰু বেকআপ';

  @override
  String get accountBackupSubtitle =>
      'অগ্ৰগতি অনলাইন সংৰক্ষণ কৰিবলৈ ব্যৱহাৰকাৰী নাম আৰু পাছৱৰ্ড সৃষ্টি কৰক।';

  @override
  String get cloudBackupNotConfigured => 'ক্লাউড বেকআপ সাজু নহয়';

  @override
  String get cloudBackupNotConfiguredBody =>
      'এই বিল্ডত ক্লাউড সংযোগ নাই। অগ্ৰগতি কেৱল এই ফোনতে থাকিব।';

  @override
  String get signedInAs => 'ছাইন ইন আছে';

  @override
  String get artisanFallback => 'কাৰিকৰ';

  @override
  String get syncNow => 'এতিয়া ছিংক কৰক';

  @override
  String get signOut => 'ছাইন আউট';

  @override
  String get createAccountPrompt =>
      'আপোনাৰ কাম অনলাইন সংৰক্ষণ কৰিবলৈ একাউণ্ট সৃষ্টি কৰক।';

  @override
  String get signInPrompt => 'সংৰক্ষিত সামগ্ৰী আৰু ফটো লোড কৰিবলৈ ছাইন ইন কৰক।';

  @override
  String get username => 'ব্যৱহাৰকাৰী নাম';

  @override
  String get usernameHint => 'যেনে priya_weaver';

  @override
  String get password => 'পাছৱৰ্ড';

  @override
  String get createAccount => 'একাউণ্ট সৃষ্টি কৰক';

  @override
  String get signIn => 'ছাইন ইন';

  @override
  String get alreadyHaveAccount => 'ইতিমধ্যে একাউণ্ট আছে? ছাইন ইন কৰক';

  @override
  String get needAccount => 'একাউণ্ট লাগে? এটা সৃষ্টি কৰক';

  @override
  String get accountCreated =>
      'একাউণ্ট সৃষ্টি হ’ল। আপোনাৰ অগ্ৰগতি অনলাইন ছিংক হ’ব।';

  @override
  String get signedInSuccess => 'ছাইন ইন হ’ল। আপোনাৰ সংৰক্ষিত কাম এই ফোনত আছে।';

  @override
  String get signedOutSuccess => 'ছাইন আউট হ’ল। স্থানীয় ফটো এই ফোনতে থাকিব।';

  @override
  String get syncOffline => 'ইণ্টাৰনেট নাই — অনলাইন হ’লে ছিংক কৰক।';

  @override
  String syncDone(int sets, int shots) {
    return 'ছিংক হ’ল: $sets সামগ্ৰী আপলোড, $shots ফটো আপলোড।';
  }

  @override
  String get syncUpToDate => 'সকলো ইতিমধ্যে আপডেট আছে।';

  @override
  String syncFailed(String error) {
    return 'ছিংক ব্যৰ্থ: $error';
  }

  @override
  String get yourProgress => 'আপোনাৰ অগ্ৰগতি';

  @override
  String get productsStarted => 'আৰম্ভ কৰা সামগ্ৰী';

  @override
  String get finishedSets => 'সম্পূৰ্ণ ছেট';

  @override
  String get inProgressSets => 'চলি আছে';

  @override
  String get photosCaptured => 'তোলা ফটো';

  @override
  String get usernameTooShort =>
      'ব্যৱহাৰকাৰী নাম কমেও ৩টা আখৰ বা সংখ্যা হ’ব লাগিব।';

  @override
  String get usernameTooLong => 'ব্যৱহাৰকাৰী নাম ৩২ আখৰতকৈ বেছি হ’ব নোৱাৰে।';

  @override
  String get passwordTooShort => 'পাছৱৰ্ড কমেও ৬টা আখৰ হ’ব লাগিব।';

  @override
  String get fullScreen => 'সম্পূৰ্ণ স্ক্ৰীন';

  @override
  String get tapToSkip => 'এৰিবলৈ টেপ কৰক';

  @override
  String get cameraPermissionNeeded =>
      'ফটো তুলিবলৈ কেমেৰাৰ অনুমতি লাগে।\nঅনুগ্ৰহ কৰি ছেটিংছত কেমেৰা এক্সেছ দিয়ক।';

  @override
  String get cameraUnavailable => 'কেমেৰা উপলব্ধ নহয়।';

  @override
  String get noCameraFound => 'এই ডিভাইচত কোনো কেমেৰা পোৱা নগ’ল।';

  @override
  String get accountCreateFailed =>
      'একাউণ্ট সৃষ্টি কৰিব পৰা নগ’ল। পুনৰ চেষ্টা কৰক।';

  @override
  String get enterValidUsername => 'সঠিক ব্যৱহাৰকাৰী নাম দিয়ক।';

  @override
  String get monthJan => 'জানু';

  @override
  String get monthFeb => 'ফেব্ৰু';

  @override
  String get monthMar => 'মাৰ্চ';

  @override
  String get monthApr => 'এপ্ৰিল';

  @override
  String get monthMay => 'মে’';

  @override
  String get monthJun => 'জুন';

  @override
  String get monthJul => 'জুলাই';

  @override
  String get monthAug => 'আগ';

  @override
  String get monthSep => 'চেপ্টে';

  @override
  String get monthOct => 'অক্টো';

  @override
  String get monthNov => 'নৱে';

  @override
  String get monthDec => 'ডিচে';

  @override
  String get presetCushionFlatLayNeeds => 'সৰল, পৰিষ্কাৰ পৃষ্ঠ';

  @override
  String get presetCushionStackedPairNeeds => 'দুটা কভাৰ; কাষৰ পোহৰ';

  @override
  String get presetCushionProppedNeeds => 'চকী, ছোফা বা বিচনা';

  @override
  String get presetCushionCornerTuckNeeds => 'ক্ল’জ-আপ পোহৰ';

  @override
  String get presetShawlDrapedShoulderNeeds => 'শাল পিন্ধোৱা কোনো ব্যক্তি';

  @override
  String get presetShawlFoldedStackNeeds => 'কাষৰ পোহৰ';

  @override
  String get presetShawlHungFlatNeeds => 'ৰছী, বাঁহ বা দেৱাল য’ত পিন কৰিব';

  @override
  String get presetShawlCornerTuckNeeds => 'ক্ল’জ-আপ পোহৰ';

  @override
  String get presetStoleNeckWrapNeeds => 'ষ্টোল পিন্ধোৱা কোনো ব্যক্তি';

  @override
  String get presetStoleFlatSpreadNeeds => 'সৰল পৃষ্ঠ; ওপৰৰ পৰা দৃশ্য';

  @override
  String get presetStoleLooseKnotNeeds => 'কোমল কাষৰ পোহৰ';

  @override
  String get presetStoleRolledCoilNeeds => 'কোমল কাষৰ পোহৰ';

  @override
  String get placementSareePalluDrape =>
      'শাড়ী হেংগাৰ, বাঁহ বা মেনেকিনত ওলোৱাওক যাতে পল্লু মুক্তকৈ ওলমে।';

  @override
  String get placementSareeBoxFold =>
      'শাড়ী সমান স্তৰত ভাঁজ কৰি দ’ম কৰক যাতে কাষ দেখা যায়।';

  @override
  String get placementSareeWornDrape =>
      'ব্যক্তিত শাড়ী এনেদৰে মেৰাই দিয়ক যাতে ৰং, আৰ্হি আৰু বৰ্ডাৰ স্পষ্ট দেখা যায়।';

  @override
  String get placementSareeRollDisplay =>
      'শাড়ী এনেদৰে ৰোল কৰক যাতে পল্লু আৰু বৰ্ডাৰ কেমেৰাৰ ফালে থাকে।';

  @override
  String get placementCushionFlatLay =>
      'কভাৰ সৰল, পৰিষ্কাৰ পৃষ্ঠত সমতলকৈ ৰাখক।';

  @override
  String get placementCushionStackedPair =>
      'এটা কভাৰ আনটোৰ ওপৰত পৰিষ্কাৰকৈ ৰাখক।';

  @override
  String get placementCushionPropped =>
      'কুশ্বন চকী বা ছোফাত আগফালে থিয় কৰাই ৰাখক।';

  @override
  String get placementCushionCornerTuck =>
      'কভাৰ ঘূৰাওক যাতে চিলাই কৰা এটা কোণ আপোনাৰ সন্মুখত থাকে।';

  @override
  String get placementShawlDrapedShoulder =>
      'শাল এখন কান্ধত ৰাখি ওলোমাই দিয়ক।';

  @override
  String get placementShawlFoldedStack =>
      'শাল সমান স্তৰত ভাঁজ কৰি পৰিষ্কাৰকৈ দ’ম কৰক।';

  @override
  String get placementShawlHungFlat =>
      'দুয়োটা ওপৰৰ কোণ পিন কৰক যাতে শাল মাজত নামি নাযায়।';

  @override
  String get placementShawlCornerTuck =>
      'এটা কোণ পাছলৈ ভাঁজ কৰক যাতে বয়নৰ দুয়োফাল দেখা যায়।';

  @override
  String get placementStoleNeckWrap =>
      'ডিঙিত এবাৰ মেৰাই দুয়োটা মূৰ ওলোমাই দিয়ক।';

  @override
  String get placementStoleFlatSpread =>
      'ষ্টোল সমতলকৈ মেলি দিয়ক যাতে সম্পূৰ্ণ দৈৰ্ঘ্য দেখা যায়।';

  @override
  String get placementStoleLooseKnot =>
      'মাজত এটা ঢিলা গাঁঠি বান্ধক — টানি টান নকৰিব।';

  @override
  String get placementStoleRolledCoil => 'ষ্টোল ঢিলাকৈ সমতল কুণ্ডলীত ৰোল কৰক।';

  @override
  String get transcriptSareePalluDrape1 =>
      'শাড়ী এনেদৰে ওলোৱাওক যাতে ইয়াৰ পতন স্পষ্ট দেখা যায়।';

  @override
  String get transcriptSareePalluDrape2 =>
      'কান্ধৰ উচ্চতাত হেংগাৰ, বাঁহ বা মেনেকিন ব্যৱহাৰ কৰক।';

  @override
  String get transcriptSareePalluDrape3 =>
      'পল্লু মুক্তকৈ ওলোমাই দিয়ক — পোনকৈ টানি নধৰিব।';

  @override
  String get transcriptSareePalluDrape4 =>
      'ভাঁজবোৰে স্ক্ৰীনৰ তিৰ্যক ৰেখা অনুসৰণ কৰক।';

  @override
  String get transcriptSareePalluDrape5 =>
      'চিকমিকনি দেখুৱাবলৈ এটা পোহৰ কাষত ৰাখক।';

  @override
  String get transcriptSareeBoxFold1 =>
      'শাড়ী পৰিষ্কাৰ দ’মত ভাঁজ কৰক যাতে স্তৰবোৰ দেখা যায়।';

  @override
  String get transcriptSareeBoxFold2 =>
      'ভাঁজ কৰা কাষ কেমেৰাৰ ফালে ৰাখক — সেই কাষে ডাঠতা দেখুৱায়।';

  @override
  String get transcriptSareeBoxFold3 => 'ভাঁজবোৰ আনুভূমিক গাইডৰ সৈতে মিলাওক।';

  @override
  String get transcriptSareeBoxFold4 =>
      'প্ৰতিটো স্তৰত গভীৰতাৰ বাবে কাষৰ পৰা পোহৰ লওক।';

  @override
  String get transcriptSareeWornDrape1 =>
      'পৰিধান কৰা ফটোৱে সম্পূৰ্ণ শাড়ী দেখুৱায় — ৰং, আৰ্হি আৰু সামগ্ৰী।';

  @override
  String get transcriptSareeWornDrape2 => 'ৰং সঠিক থাকিবলৈ খোলা ছাঁত থিয় হওক।';

  @override
  String get transcriptSareeWornDrape3 => 'শাড়ীয়ে ফ্ৰেমৰ বেছিভাগ ঢাকক।';

  @override
  String get transcriptSareeWornDrape4 =>
      'ওপৰৰ বৰ্ডাৰ গ্ৰিডৰ ওপৰৰ তৃতীয়াংশৰ সৈতে মিলাওক।';

  @override
  String get transcriptSareeWornDrape5 =>
      'প্লিট থাকিলে উলম্ব গ্ৰিড ৰেখা অনুসৰণ কৰক।';

  @override
  String get transcriptSareeRollDisplay1 =>
      'শাড়ী এনেদৰে ৰোল কৰক যাতে পল্লু আৰু বৰ্ডাৰ কেমেৰাৰ ফালে থাকে।';

  @override
  String get transcriptSareeRollDisplay2 => 'ৰোলে ফ্ৰেমৰ বেছিভাগ ঢাকক।';

  @override
  String get transcriptSareeRollDisplay3 =>
      'ওপৰৰ বৰ্ডাৰ গ্ৰিডৰ ওপৰৰ তৃতীয়াংশৰ সৈতে মিলাওক।';

  @override
  String get transcriptSareeRollDisplay4 =>
      'ৰং সঠিক থাকিবলৈ কোমল দিনৰ পোহৰ লওক।';

  @override
  String get transcriptCushionFlatLay1 => 'কুশ্বন কভাৰ সৰল পৃষ্ঠত সমতলকৈ ৰাখক।';

  @override
  String get transcriptCushionFlatLay2 =>
      'সমতল কৰক কিন্তু প্ৰাকৃতিক গঠন থাকিব দিয়ক।';

  @override
  String get transcriptCushionFlatLay3 => 'ফোন পোনকৈ ওপৰত ৰাখক, কোণত নহয়।';

  @override
  String get transcriptCushionFlatLay4 => 'কাষবোৰ গ্ৰিডৰ সৈতে পোনকৈ ৰাখক।';

  @override
  String get transcriptCushionStackedPair1 =>
      'দুটা কভাৰ দ’ম কৰক যাতে ক্ৰেতাই ডাঠতা দেখিব পাৰে।';

  @override
  String get transcriptCushionStackedPair2 => 'দ’মৰ কাষ কেমেৰাৰ ফালে ৰাখক।';

  @override
  String get transcriptCushionStackedPair3 =>
      'প্ৰতিটো স্তৰৰ ছাঁৰ বাবে কাষৰ পোহৰ লওক।';

  @override
  String get transcriptCushionPropped1 =>
      'চকীত কুশ্বন ৰাখিলে ইয়াৰ প্ৰকৃত আকাৰ দেখা যায়।';

  @override
  String get transcriptCushionPropped2 =>
      'আৰ্হিৰ সৈতে প্ৰতিযোগিতা নকৰা আসন বাছক।';

  @override
  String get transcriptCushionPropped3 =>
      'চকুৰ উচ্চতাৰ পৰা তোলক, ওপৰৰ পৰা নহয়।';

  @override
  String get transcriptCushionCornerTuck1 =>
      'কোণে আপোনাৰ চিলাই সৰ্বাধিক স্পষ্টকৈ দেখুৱায়।';

  @override
  String get transcriptCushionCornerTuck2 =>
      'কোণে সৰু ফ্ৰেম ভৰোৱালৈকে ওচৰলৈ যাওক।';

  @override
  String get transcriptCushionCornerTuck3 =>
      'ফ’কাছৰ বাবে চিলাইত স্ক্ৰীন টেপ কৰক।';

  @override
  String get transcriptShawlDrapedShoulder1 =>
      'কান্ধত শাল ওলোৱাই ইয়াৰ ওজন দেখুৱায়।';

  @override
  String get transcriptShawlDrapedShoulder2 =>
      'এটা মূৰ আনটোতকৈ তললৈ ওলোমাই দিয়ক।';

  @override
  String get transcriptShawlDrapedShoulder3 =>
      'পিন নকৰিব — কাপোৰ নিজেই পৰিব দিয়ক।';

  @override
  String get transcriptShawlFoldedStack1 =>
      'ভাঁজ দেখা যোৱাকৈ শাল পৰিষ্কাৰকৈ দ’ম কৰক।';

  @override
  String get transcriptShawlFoldedStack2 =>
      'ভাঁজবোৰ আনুভূমিক ৰেখাৰ সমান্তৰাল ৰাখক।';

  @override
  String get transcriptShawlFoldedStack3 => 'ডাঠতাৰ বাবে শালৰ কাষ দেখা যাওক।';

  @override
  String get transcriptShawlFoldedStack4 =>
      'প্ৰতিটো ভাঁজত গভীৰতাৰ বাবে কাষৰ পোহৰ লওক।';

  @override
  String get transcriptShawlHungFlat1 =>
      'সমতলকৈ ওলোৱাই সম্পূৰ্ণ ডিজাইন একেলগে দেখুৱায়।';

  @override
  String get transcriptShawlHungFlat2 =>
      'দুয়োটা ওপৰৰ কোণ পিন কৰক যাতে মাজত নামি নাযায়।';

  @override
  String get transcriptShawlHungFlat3 => 'পোনকৈ সন্মুখত থিয় হওক, এফালে নহয়।';

  @override
  String get transcriptShawlCornerTuck1 =>
      'কোণৰ ক্ল’জ-আপে বয়ন আৰু বৰ্ডাৰ একেলগে দেখুৱায়।';

  @override
  String get transcriptShawlCornerTuck2 =>
      'এটা কোণ পাছলৈ ভাঁজ কৰক যাতে দুয়োফাল দেখা যায়।';

  @override
  String get transcriptShawlCornerTuck3 => 'বয়নে ফ্ৰেম ভৰোৱালৈকে ওচৰলৈ যাওক।';

  @override
  String get transcriptStoleNeckWrap1 =>
      'পৰিধান কৰা ফটোৱে সাধাৰণ প্ৰশ্নৰ উত্তৰ দিয়ে — কিমান ডাঙৰ?';

  @override
  String get transcriptStoleNeckWrap2 =>
      'ডিঙিত এবাৰ মেৰাই দুয়োটা মূৰ ওলোমাই দিয়ক।';

  @override
  String get transcriptStoleNeckWrap3 =>
      'বুকুৰ পৰা ওপৰলৈ তোলক যাতে মূৰবোৰ ফ্ৰেমত থাকে।';

  @override
  String get transcriptStoleFlatSpread1 =>
      'ষ্টোল মেলি দিয়ক যাতে সম্পূৰ্ণ দৈৰ্ঘ্য দেখা যায়।';

  @override
  String get transcriptStoleFlatSpread2 =>
      'প্ৰাকৃতিক ভাঁজ থাকিব দিয়ক — সেইবোৰে কাপোৰৰ স্বভাৱ দেখুৱায়।';

  @override
  String get transcriptStoleFlatSpread3 => 'ফোন পোনকৈ মাজৰ ওপৰত ৰাখক।';

  @override
  String get transcriptStoleLooseKnot1 =>
      'ঢিলা গাঁঠিয়ে ষ্টোল কিমান কোমল আৰু পাতল দেখুৱায়।';

  @override
  String get transcriptStoleLooseKnot2 =>
      'ঢিলাকৈ বান্ধক — কেতিয়াও টানি টান নকৰিব।';

  @override
  String get transcriptStoleLooseKnot3 => 'গাঁঠি ফ্ৰেমৰ কেন্দ্ৰত ৰাখক।';

  @override
  String get transcriptStoleRolledCoil1 =>
      'কুণ্ডলীত ৰোল কৰিলে কাষ আৰু ডাঠতা দেখা যায়।';

  @override
  String get transcriptStoleRolledCoil2 =>
      'ঢিলাকৈ ৰোল কৰক যাতে স্তৰবোৰ পৃথক থাকে।';

  @override
  String get transcriptStoleRolledCoil3 => 'কুণ্ডলীৰ ওপৰত পোনকৈ তললৈ তোলক।';

  @override
  String get guideSareeFullDisplay1 => 'শাড়ীয়ে ফ্ৰেমৰ বেছিভাগ অংশ ঢাকে।';

  @override
  String get guideSareeFullDisplay2 =>
      'ওপৰৰ বৰ্ডাৰ গ্ৰিডৰ ওপৰৰ তৃতীয়াংশৰ সৈতে মিলে।';

  @override
  String get guideSareeFullDisplay3 =>
      'ড্ৰেপত প্লীটবোৰ উলম্ব গ্ৰিডৰ সৈতে মিলে।';

  @override
  String get guideSareeTextureWeave1 => 'শাড়ীয়ে গোটেই ফ্ৰেম ভৰায়।';

  @override
  String get guideSareeTextureWeave2 => 'বয়ন মাজত থাকে।';

  @override
  String get guideSareeTextureWeave3 => 'কোমল পোহৰ ব্যৱহাৰ কৰক।';

  @override
  String get guideSareeTextureWeave4 => 'কঠোৰ প্ৰতিফলন এৰাই চলক।';

  @override
  String get guideSareeEmbroideryBorder1 => 'এমব্ৰয়ডাৰী ফ্ৰেমৰ ভিতৰত থাকে।';

  @override
  String get guideSareeEmbroideryBorder2 => 'কাষৰ পৰা পোহৰ লওক।';

  @override
  String get guideSareeEmbroideryBorder3 =>
      'বিৱৰণ তীক্ষ্ণ আৰু ভালকৈ পোহৰত ৰাখক।';

  @override
  String get guideCushionTextureWeave1 => 'বয়নে ফ্ৰেম ভৰায়।';

  @override
  String get guideCushionTextureWeave2 => 'বয়ন মাজত থাকে।';

  @override
  String get guideShawlFullDesign1 =>
      'শাল সমতলকৈ ওলোমাই গোটেই ডিজাইন একেলগে দেখা যায়।';

  @override
  String get guideShawlFullDesign2 =>
      'দুয়োটা ওপৰৰ কোণ পিন কৰক যাতে মাজত নামি নাযায়।';

  @override
  String get guideShawlTextureWeave1 => 'বয়নে ফ্ৰেম ভৰায়।';

  @override
  String get guideShawlTextureWeave2 => 'বয়ন মাজত থাকে।';

  @override
  String get guideStoleFullLength1 =>
      'ষ্টোল মেলি দিয়ক যাতে সম্পূৰ্ণ দৈৰ্ঘ্য দেখা যায়।';

  @override
  String get guideStoleFullLength2 =>
      'স্বাভাৱিক ভাঁজ থাকিবলৈ দিয়ক — সেইবোৰে কাপোৰৰ স্বভাৱ দেখুৱায়।';

  @override
  String get guideStoleTextureWeave1 => 'বয়নে ফ্ৰেম ভৰায়।';

  @override
  String get guideStoleTextureWeave2 => 'বয়ন মাজত থাকে।';

  @override
  String get authInvalidCredentials => 'ভুল ব্যৱহাৰকাৰী নাম বা পাছৱৰ্ড।';

  @override
  String get authUserAlreadyRegistered =>
      'এই ব্যৱহাৰকাৰী নাম ইতিমধ্যে লোৱা হৈছে।';

  @override
  String get authEmailNotConfirmed => 'ইমেইল নিশ্চিত কৰক, তাৰ পিছত চেষ্টা কৰক।';

  @override
  String get authGeneric => 'ছাইন ইন কৰিব পৰা নগ’ল। পুনৰ চেষ্টা কৰক।';

  @override
  String get languageAssamese => 'অসমীয়া';

  @override
  String get languageEnglish => 'ইংৰাজী';

  @override
  String get guideSareeDrapedLook1 => 'কাপোৰ স্বাভাৱিকভাৱে পৰিবলৈ দিয়ক।';

  @override
  String get guideSareeDrapedLook2 => 'ভাঁজবোৰ তিৰ্যক ৰেখাৰে যায়।';

  @override
  String get guideSareeDrapedLook3 => 'কাষৰ পৰা পোহৰ লওক।';

  @override
  String get guideSareeEmbroideryBorder4 =>
      'কনট্ৰাষ্ট বেকগ্ৰাউণ্ড ব্যৱহাৰ কৰক।';

  @override
  String get guideSareeFoldedStack1 => 'ভাঁজবোৰ আনুভূমিক ৰেখাৰ সমান্তৰাল থাকে।';

  @override
  String get guideSareeFoldedStack2 => 'কাষৰ পৰা পোহৰ লওক।';

  @override
  String get guideSareeFoldedStack3 => 'কাষ দেখা যায়।';

  @override
  String get guideCushionFullCover1 =>
      'কভাৰ সমতলকৈ ৰাখক যাতে সম্পূৰ্ণ নক্সা দেখা যায়।';

  @override
  String get guideCushionFullCover2 =>
      'ফোন পোনপটীয়াকৈ ওপৰৰ পৰা ধৰক, কোণত নহয়।';

  @override
  String get guideCushionFullCover3 => 'কাষবোৰ গ্ৰিডৰ সৈতে পোনকৈ ৰাখক।';

  @override
  String get guideCushionTextureWeave3 => 'কোমল পোহৰ ব্যৱহাৰ কৰক।';

  @override
  String get guideCushionTextureWeave4 => 'কঠোৰ প্ৰতিফলন এৰাই চলক।';

  @override
  String get guideCushionStackedThickness1 =>
      'দুটা কভাৰ এনেকৈ ৰাখক যাতে ডাঠতা দেখা যায়।';

  @override
  String get guideCushionStackedThickness2 => 'স্তূপৰ কাষ কেমেৰাৰ ফালে ৰাখক।';

  @override
  String get guideCushionStackedThickness3 =>
      'কাষৰ পোহৰে প্ৰতিটো স্তৰৰ কোমল ছাঁ পেলায়।';

  @override
  String get guideCushionCornerStitching1 => 'কোণত চিলাই স্পষ্টকৈ দেখা যায়।';

  @override
  String get guideCushionCornerStitching2 =>
      'কাষ চাপি যাওক যেতিয়ালৈকে কোণে সৰু ফ্ৰেম ভৰায়।';

  @override
  String get guideCushionCornerStitching3 =>
      'চিলাই তীক্ষ্ণ আৰু ভালকৈ পোহৰত ৰাখক।';

  @override
  String get guideCushionInUse1 => 'চেয়াৰত ৰাখিলে প্ৰকৃত আকাৰ দেখা যায়।';

  @override
  String get guideCushionInUse2 =>
      'এনে আসন বাছি লওক যি নক্সাৰ সৈতে প্ৰতিযোগিতা নকৰে।';

  @override
  String get guideCushionInUse3 => 'চকুৰ স্তৰত তোলক, ওপৰৰ পৰা নহয়।';

  @override
  String get guideShawlFullDesign3 =>
      'পোনপটীয়াকৈ সন্মুখত থিয় হওক, এফালে নহয়।';

  @override
  String get guideShawlTextureWeave3 => 'কোমল পোহৰ ব্যৱহাৰ কৰক।';

  @override
  String get guideShawlTextureWeave4 => 'কঠোৰ প্ৰতিফলন এৰাই চলক।';

  @override
  String get guideShawlDrapedLook1 =>
      'কান্ধত শাল ড্ৰেপ কৰিলে ই কিমান গধুৰ তাক দেখুৱায়।';

  @override
  String get guideShawlDrapedLook2 => 'এটা মূৰ আনটোতকৈ তললৈ ওলমিবলৈ দিয়ক।';

  @override
  String get guideShawlDrapedLook3 => 'পিন নকৰিব — কাপোৰ নিজে পৰিবলৈ দিয়ক।';

  @override
  String get guideShawlBorderCorner1 =>
      'কোণৰ ক্ল\'জ-আপে বয়ন আৰু বৰ্ডাৰ একেলগে দেখুৱায়।';

  @override
  String get guideShawlBorderCorner2 =>
      'এটা কোণ পাছলৈ ভাঁজ কৰক যাতে দুয়োফাল দেখা যায়।';

  @override
  String get guideShawlBorderCorner3 =>
      'কাষ চাপি যাওক যেতিয়ালৈকে বয়নে ফ্ৰেম ভৰায়।';

  @override
  String get guideShawlStackDisplay1 =>
      'শাল পৰিষ্কাৰকৈ স্তূপ কৰক, ভাঁজ দেখা যায়।';

  @override
  String get guideShawlStackDisplay2 => 'ভাঁজ আনুভূমিক ৰেখাৰ সমান্তৰাল ৰাখক।';

  @override
  String get guideShawlStackDisplay3 => 'কাষৰ পোহৰে প্ৰতিটো ভাঁজত গভীৰতা আনে।';

  @override
  String get guideStoleFullLength3 => 'ফোন পোনপটীয়াকৈ মাজৰ ওপৰত ধৰক।';

  @override
  String get guideStoleTextureWeave3 => 'কোমল পোহৰ ব্যৱহাৰ কৰক।';

  @override
  String get guideStoleTextureWeave4 => 'কঠোৰ প্ৰতিফলন এৰাই চলক।';

  @override
  String get guideStoleWornNeckWrap1 =>
      'পৰিধান কৰা শটে ষ্টোল কিমান ডাঙৰ তাক উত্তৰ দিয়ে।';

  @override
  String get guideStoleWornNeckWrap2 =>
      'ডিঙিত এবাৰ মেৰিয়াই দুয়োটা মূৰ ওলমিবলৈ দিয়ক।';

  @override
  String get guideStoleWornNeckWrap3 =>
      'বুকৰ পৰা ওপৰলৈ তোলক যাতে মূৰবোৰ ফ্ৰেমত থাকে।';

  @override
  String get guideStoleSoftnessKnot1 =>
      'ঢিলা গাঁঠিয়ে ষ্টোল কিমান কোমল আৰু পাতল তাক দেখুৱায়।';

  @override
  String get guideStoleSoftnessKnot2 => 'ঢিলাকৈ বান্ধক — কেতিয়াও টান নকৰিব।';

  @override
  String get guideStoleSoftnessKnot3 => 'গাঁঠি ফ্ৰেমৰ মাজত ৰাখক।';

  @override
  String get guideStoleEdgeThickness1 =>
      'ষ্টোল কুণ্ডলিত কৰিলে কাষ আৰু ডাঠতা দেখা যায়।';

  @override
  String get guideStoleEdgeThickness2 =>
      'ঢিলাকৈ মেৰিয়াওক যাতে স্তৰবোৰ পৃথক থাকে।';

  @override
  String get guideStoleEdgeThickness3 => 'কুণ্ডলীৰ ওপৰৰ পৰা পোনকৈ তোলক।';

  @override
  String get csNavLearn => 'শিকক';

  @override
  String get csNavPractice => 'অনুশীলন';

  @override
  String get csNavProgress => 'প্ৰগতি';

  @override
  String get csLearnerFallback => 'শিকাৰু';

  @override
  String get csClusterNotSelected => 'ক্লাষ্টাৰ বাছনি কৰা হোৱা নাই';

  @override
  String get csAntaranLearningTool => 'অন্তৰণ · শিকাৰ সঁজুলি';

  @override
  String get csWorksOffline => 'ইণ্টাৰনেট নোহোৱাকৈও চলে';

  @override
  String get csClickAndSocial => 'CLICK &\nSOCIAL';

  @override
  String get csClickAndSocialInline => 'CLICK & SOCIAL';

  @override
  String get csOnboardingTagline =>
      'নিজৰ শিল্পৰ ফটো তোলক। ইয়াৰ কাহিনী কওক। অনলাইনত বিক্ৰী কৰক — সকলো এই ফোনৰ পৰাই।';

  @override
  String get csStepYourName => 'আপোনাৰ নাম';

  @override
  String get csNameHint => 'আপোনাৰ নাম লিখক';

  @override
  String get csStepYourLanguage => 'আপোনাৰ ভাষা';

  @override
  String csLanguageChip(String label, String code) {
    return '$label ($code)';
  }

  @override
  String get csStepYourCluster => 'আপোনাৰ ক্লাষ্টাৰ — য\'ত আপুনি কাম কৰে';

  @override
  String get csClusterHint =>
      'এবাৰ বাছনি কৰক। আপোনাৰ পাঠ, কাহিনী আৰু হেছটেগ ইয়াৰ ওপৰতে ঠিক হ\'ব।';

  @override
  String get csSelected => 'বাছি লোৱা হ\'ল';

  @override
  String get csPick => 'বাছক';

  @override
  String get csStartLearning => 'শিকা আৰম্ভ কৰক';

  @override
  String get csOfflineReady => 'ইণ্টাৰনেট অবিহনে সাজু';

  @override
  String csHelloName(String name) {
    return 'নমস্কাৰ, $name';
  }

  @override
  String get csChange => 'সলনি কৰক';

  @override
  String csLessonsDone(int done) {
    return '৫ টাৰ ভিতৰত $done টা পাঠ সম্পূৰ্ণ';
  }

  @override
  String get csLesson01Title => 'ফটোগ্ৰাফী';

  @override
  String get csLesson01Subtitle =>
      'সামগ্ৰী · উপাদান · ক্লাষ্টাৰ · ফ্ৰেম · পোহৰ';

  @override
  String get csLesson02Title => 'ইনষ্টাগ্ৰামত আপোনাৰ পেজ সাজক';

  @override
  String get csLesson02Subtitle => 'নাম · বায়ো · প্ৰফেচনেল একাউণ্ট';

  @override
  String get csLesson03Title => 'পোষ্ট বনাওক';

  @override
  String get csLesson03Subtitle => 'কাহিনী · হেছটেগ · প্ৰকাশ';

  @override
  String get csLesson04Title => 'পোষ্ট কৰাৰ পৰিকল্পনা';

  @override
  String get csLesson04Subtitle => 'কেতিয়া পোষ্ট কৰিব · সাপ্তাহিক ছন্দ';

  @override
  String get csLesson05Title => 'সংখ্যাবোৰ পঢ়ক';

  @override
  String get csLesson05Subtitle => 'পৰিসৰ · কি সফল হ\'ল আৰু কিয়';

  @override
  String get csLesson01Overline => 'পাঠ ০১';

  @override
  String get csLesson02Overline => 'পাঠ ০২';

  @override
  String get csLesson03Overline => 'পাঠ ০৩';

  @override
  String get csLesson04Overline => 'পাঠ ০৪';

  @override
  String get csLesson05Overline => 'পাঠ ০৫';

  @override
  String csStepOfTotal(int step, int total) {
    return '$step / $total';
  }

  @override
  String get csPickYourUsername => 'আপোনাৰ ইউজাৰনেম বাছক';

  @override
  String get csUsernameHint =>
      'চুটি হওক। ইয়াত আপোনাৰ শিল্প থাকক। ক\'বলৈ সহজ হওক।';

  @override
  String get csNextEditProfile => 'পৰৱৰ্তী — EDIT PROFILE';

  @override
  String get csEditProfileIntroBefore => 'এইখনেই ';

  @override
  String get csEditProfileIntroBold => 'Edit profile';

  @override
  String get csEditProfileIntroAfter => ' স্ক্ৰীন। প্ৰতিটো শাৰী পূৰণ কৰক।';

  @override
  String get csChangePhotoTip =>
      'ফটো সলনি কৰক — আপোনাৰ সামগ্ৰীৰ ফটো দিয়ক, সূৰ্যাস্তৰ নহয়';

  @override
  String get csFieldName => 'Name';

  @override
  String get csFieldUsername => 'Username';

  @override
  String get csFieldBio => 'Bio';

  @override
  String get csBioPlaceholder => 'তলৰ শাৰীবোৰত টিপি ইয়াক সাজক…';

  @override
  String get csBioLinesPrompt =>
      'বায়োৰ শাৰী — কমেও ২ টা বাছক (ঠাই + শিল্প + কেনেকৈ কিনিব)';

  @override
  String get csNextGoProfessional => 'পৰৱৰ্তী — প্ৰফেচনেল হওক';

  @override
  String get csSettingsPrompt =>
      'এপটোত Settings খোলক। প্ৰফেচনেল একাউণ্টলৈ লৈ যোৱা শাৰীটো বিচাৰক — ৰঙা বিন্দুটোৰ পিছে পিছে যাওক।';

  @override
  String get csSettingsPromptAlmost => 'প্ৰায় হৈ গ\'ল — আৰু এবাৰ টিপক।';

  @override
  String get csSettingsTitle => 'Settings';

  @override
  String get csAccountTypeAndTools => 'Account type and tools';

  @override
  String get csSettingsNotifications => 'Notifications';

  @override
  String get csSettingsNotificationsSub => 'লাইক, কমেণ্ট, মেছেজ';

  @override
  String get csSettingsPrivacy => 'Privacy';

  @override
  String get csSettingsPrivacySub => 'প্ৰাইভেট একাউণ্ট, ব্লক কৰা মানুহ';

  @override
  String get csSettingsAccountTypeSub => 'প্ৰফেচনেল একাউণ্টলৈ যাওক';

  @override
  String get csSettingsHelp => 'Help';

  @override
  String get csSettingsHelpSub => 'সমস্যা জনাওক';

  @override
  String get csSettingsSwitchProfessional => 'Switch to professional account';

  @override
  String get csSettingsSwitchProfessionalSub =>
      'বিনামূলীয়া — ক্ৰিয়েটৰ আৰু ব্যৱসায়ৰ বাবে';

  @override
  String get csSettingsDeleteAccount => 'Delete account';

  @override
  String get csSettingsDeleteAccountSub => 'আপোনাৰ একাউণ্ট আঁতৰাওক';

  @override
  String get csSettingsPersonalInfo => 'Personal information';

  @override
  String get csSettingsPersonalInfoSub => 'জন্মদিন, ইমেইল';

  @override
  String get csSettingsWrongPick =>
      'সেইটো নহয় — ৰঙা বিন্দুটোৰ পিছে পিছে যাওক।';

  @override
  String get csCategoryIntroBefore => 'শেষ পদক্ষেপ — ';

  @override
  String get csCategoryIntroBold => 'আপুনি কি?';

  @override
  String get csCategoryIntroAfter => ' গ্ৰাহকে দেখা শ্ৰেণীটো বাছক।';

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
      'প্ৰফেচনেল একাউণ্ট বিনামূলীয়া। ইয়াৰ দ্বাৰা খোল খায় ';

  @override
  String get csProAccountInsights => 'insights';

  @override
  String get csProAccountNote2 => ' (আপোনাৰ পোষ্ট কোনে দেখে — পাঠ ০৫), এটা ';

  @override
  String get csProAccountContactButton => 'contact button';

  @override
  String get csProAccountNote3 => ', আৰু পিছলৈ ';

  @override
  String get csProAccountAds => 'ads';

  @override
  String get csProAccountNote4 => '।';

  @override
  String get csSwitchToProfessional => 'প্ৰফেচনেললৈ যাওক';

  @override
  String get csPreviewIntro => 'হ\'ল। গ্ৰাহকে আপোনাৰ পেজখন এনেদৰে দেখিব:';

  @override
  String get csPostsFollowers => '০ পোষ্ট   ০ ফলোৱাৰ';

  @override
  String get csFollow => 'FOLLOW';

  @override
  String get csMessage => 'MESSAGE';

  @override
  String get csProfessionalAccount => 'প্ৰফেচনেল একাউণ্ট';

  @override
  String get csPickANameFallback => 'pick_a_name';

  @override
  String get csCraftFallback => 'শিল্প';

  @override
  String get csBioFallbackHandloomWeaver => 'হাতঁতশাল বয়নশিল্পী';

  @override
  String get csBioFallbackDmToOrder => 'অৰ্ডাৰৰ বাবে DM কৰক';

  @override
  String get csBioFallbackMadeByHand => 'হাতেৰে বনোৱা';

  @override
  String get csFormatPost => 'পোষ্ট';

  @override
  String get csFormatStory => 'ষ্ট\'ৰী';

  @override
  String get csFormatReel => 'ৰীল';

  @override
  String get csPhotoPlaceholder =>
      'পাঠ ০১ ৰ পৰা আপোনাৰ ফটো — বা ফটো বা ভিডিঅ\' ড্ৰপ কৰক';

  @override
  String get csExampleKotpad =>
      'উদাহৰণ: এটা কোটপাড় পোষ্ট — ওচৰৰ পৰা তোলা ফটো, তাৰ পিছত দুটা শাৰীত শিল্প আৰু বয়নশিল্পীৰ নাম।';

  @override
  String get csAddYourStory => 'আপোনাৰ কাহিনী যোগ কৰক — শাৰীবোৰত টিপক';

  @override
  String get csHashtagsPick => 'হেছটেগ — ৩ৰ পৰা ৫ টা বাছক ';

  @override
  String csHashtagCount(int count) {
    return '$count/5';
  }

  @override
  String csHashtagCountFull(int count) {
    return '$count/5 — পাঁচটাই যথেষ্ট';
  }

  @override
  String get csCaptionPreview => 'কেপচনৰ পূৰ্বদৰ্শন';

  @override
  String get csCaptionPlaceholder =>
      'ওপৰৰ কাহিনীৰ শাৰীবোৰত টিপি আপোনাৰ কেপচন লিখক।';

  @override
  String get csPostToPracticeFeed => 'অনুশীলন ফিডত পোষ্ট কৰক';

  @override
  String get csPracticeFeedOnly =>
      'কেৱল অনুশীলন ফিড — একোৱেই আপোনাৰ ফোনৰ পৰা বাহিৰলৈ নাযায়।';

  @override
  String get csStoryFallbackHeritage => 'মোৰ গাঁৱত হাতেৰে বনোৱা।';

  @override
  String get csStoryFallbackMaterial => 'প্ৰাকৃতিক আঁহ, যতনেৰে ৰং কৰা।';

  @override
  String get csStoryFallbackProcess => 'ঘৰৰ তাঁতত বোৱা, এটা এটাকৈ ফুল।';

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
  String get csWhenDoBuyersScroll => 'গ্ৰাহকে কেতিয়া স্ক্ৰল কৰে?';

  @override
  String get csTimeMorning => 'ৰাতিপুৱা ৬–৯ বজাত';

  @override
  String get csTimeNight => 'ৰাতি ৭–১০ বজাত';

  @override
  String get csTimeAfternoon => 'দুপৰীয়া ২ বজাত';

  @override
  String get csTimeCorrectMsg =>
      'হয় — সন্ধিয়া, যেতিয়া দিনটোৰ কাম শেষ হয়, তেতিয়াই মানুহে স্ক্ৰল কৰে আৰু কিনে।';

  @override
  String get csTimeWrongMsg =>
      'সেই সময়ত মানুহ কামত থাকে। দিনটো শেষ হোৱাৰ পিছত চাওক।';

  @override
  String get csPlanYourWeek => 'আপোনাৰ সপ্তাহ ঠিক কৰক — ৩ দিন বাছক';

  @override
  String get csSpreadThemOut =>
      'দিনবোৰ সিঁচৰতি কৰি ৰাখক। গ্ৰাহকে গোটেই সপ্তাহ আপোনাক দেখা পাওক।';

  @override
  String get csDayMon => 'সো';

  @override
  String get csDayTue => 'মঙ';

  @override
  String get csDayWed => 'বু';

  @override
  String get csDayThu => 'বৃ';

  @override
  String get csDayFri => 'শু';

  @override
  String get csDaySat => 'শ';

  @override
  String get csDaySun => 'দে';

  @override
  String get csGoodRhythm => 'ভাল ছন্দ — তিনিটা পোষ্ট, গোটেই সপ্তাহত সিঁচৰতি।';

  @override
  String get csThreePostsOneWinner => 'তিনিটা পোষ্ট। এটা বিজয়ী।';

  @override
  String get csReachExplainer =>
      'পৰিসৰ = কিমান মানুহে দেখিলে। আটাইতকৈ ভাল পোষ্টটোত টিপক।';

  @override
  String get csResultPhotoOnly => 'কেৱল ফটো';

  @override
  String get csResultPhotoStory => 'ফটো + কাহিনীৰ কেপচন';

  @override
  String get csResultPhotoStoryTags => 'ফটো + কাহিনী + হেছটেগ';

  @override
  String get csBestCorrectMsg =>
      'শুদ্ধ — কাহিনী আৰু হেছটেগে অকল ফটোতকৈ ১০ গুণ বেছি মানুহৰ ওচৰ পালে।';

  @override
  String get csBestWrongMsg => 'আকৌ চাওক — কোনটো দণ্ড আটাইতকৈ দীঘল?';

  @override
  String get csYourWeekReached => 'আপোনাৰ সপ্তাহ — কিমান মানুহৰ ওচৰ পালে';

  @override
  String get csTallBarsNote =>
      'ওখ দণ্ডবোৰেই আপোনাৰ পোষ্ট কৰা দিন। পৰিকল্পনা মতে পোষ্ট কৰক — পৰিসৰ নিজেই বাঢ়িব।';

  @override
  String get csPracticeFeed => 'অনুশীলন ফিড';

  @override
  String get csStaysOnYourPhone => 'আপোনাৰ ফোনতে থাকে';

  @override
  String get csFeedTimeNow => 'এতিয়া';

  @override
  String get csFeedSampleTime1 => '২ দিন';

  @override
  String get csFeedSampleTime2 => '৫ দিন';

  @override
  String get csFeedYourPhotoPlaceholder => 'পাঠবোৰত তোলা আপোনাৰ ফটো';

  @override
  String get csFeedSamplePlaceholder => 'এখন নমুনা ফটো দিয়ক';

  @override
  String get csFeedSampleUser1 => 'maya_ikat';

  @override
  String get csFeedSampleUser2 => 'looms_of_naga';

  @override
  String get csFeedSampleCaption1 =>
      'ডাবল ইকাট — বোৱাৰ আগতে হাতেৰে বান্ধি ৰং কৰা।';

  @override
  String get csFeedSampleTags1 => '#ikat #odishahandloom #handwoven';

  @override
  String get csFeedSampleCaption2 =>
      'কঁকাল তাঁতৰ চাদৰ — প্ৰতিটো ৰেখাৰ এটা অৰ্থ আছে।';

  @override
  String get csFeedSampleTags2 => '#nagashawl #loinloom #handwoven';

  @override
  String get csFeedCommentUser1 => 'buyer_priya';

  @override
  String get csFeedCommentUser2 => 'craft.lover';

  @override
  String get csFeedCommentBuyer => 'অতি সুন্দৰ! দাম কিমান?';

  @override
  String get csFeedCommentCraftLover => 'অসাধাৰণ কাম!';

  @override
  String get csFeedTapHeart =>
      'হৃদয়টোত টিপি চাওক গ্ৰাহকে কেনেকৈ সঁহাৰি দিয়ে।';

  @override
  String get csYourProgress => 'আপোনাৰ প্ৰগতি';

  @override
  String get csBadgesOfFive => '/ ৫ বেজ';

  @override
  String get csBadgePhotographer => 'ফটোগ্ৰাফাৰ';

  @override
  String get csBadgePageBuilder => 'পেজ নিৰ্মাতা';

  @override
  String get csBadgeStoryteller => 'কাহিনীকাৰ';

  @override
  String get csBadgePlanner => 'পৰিকল্পক';

  @override
  String get csBadgeAnalyst => 'বিশ্লেষক';

  @override
  String get csBadgeEarned => 'পোৱা হ\'ল';

  @override
  String get csBadgeLocked => 'এতিয়াও বন্ধ';

  @override
  String get csEditNameLanguageCluster => 'নাম, ভাষা বা ক্লাষ্টাৰ সলনি কৰক';

  @override
  String get csAccountCloudBackup => 'একাউণ্ট আৰু ক্লাউড বেকআপ';

  @override
  String get csStartOverClearProgress => 'নতুনকৈ আৰম্ভ কৰক — সকলো প্ৰগতি মচক';

  @override
  String get csStartOverTitle => 'নতুনকৈ আৰম্ভ কৰিবনে?';

  @override
  String get csStartOverBody =>
      'ইয়াৰ দ্বাৰা এই ফোনৰ পাঠৰ বেজ আৰু অনুশীলন পোষ্টবোৰ মচি যাব। আপুনি ইতিমধ্যে তোলা ফটোবোৰ ফোনতে থাকিব।';

  @override
  String get csCancel => 'বাতিল কৰক';

  @override
  String get csClear => 'মচক';

  @override
  String get csStoryKickerHeritage => 'পৰম্পৰা';

  @override
  String get csStoryKickerMaterial => 'উপাদান';

  @override
  String get csStoryKickerProcess => 'প্ৰক্ৰিয়া';

  @override
  String get csClusterAssamFabric => 'মেখেলা চাদৰ — মুগা আৰু এৰী পাট';

  @override
  String get csClusterAssamShortName => 'মেখেলা চাদৰ';

  @override
  String get csClusterAssamPlace => 'কামৰূপ আৰু নলবাৰী, অসম';

  @override
  String get csClusterAssamBio0 => 'হাতঁতশাল বয়নশিল্পী';

  @override
  String get csClusterAssamBio1 => 'কামৰূপ, অসম';

  @override
  String get csClusterAssamBio2 => 'মেখেলা চাদৰ আৰু ষ্ট\'ল';

  @override
  String get csClusterAssamBio3 => 'অৰ্ডাৰৰ বাবে DM কৰক';

  @override
  String get csClusterAssamBio4 => 'তৃতীয় প্ৰজন্মৰ বয়নশিল্পী';

  @override
  String get csClusterAssamStoryHeritage =>
      'মুগা — সোণালী পাট, কেৱল অসমতেই হয়।';

  @override
  String get csClusterAssamStoryMaterial =>
      'হাতেৰে কটা এৰী — চাদৰৰ দৰে কোমল, ঊলৰ দৰে উম।';

  @override
  String get csClusterAssamStoryProcess =>
      'ঘৰতে বোৱা, সপ্তাহজুৰি তাঁতত, এটা এটাকৈ ফুল।';

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
  String get csClusterSrikalahastiFabric => 'কলমকাৰী — হাতেৰে অঁকা কপাহী কাপোৰ';

  @override
  String get csClusterSrikalahastiShortName => 'কলমকাৰী';

  @override
  String get csClusterSrikalahastiPlace => 'শ্ৰীকালাহস্তী, অন্ধ্ৰপ্ৰদেশ';

  @override
  String get csClusterSrikalahastiBio0 => 'কলমকাৰী শিল্পী';

  @override
  String get csClusterSrikalahastiBio1 => 'শ্ৰীকালাহস্তী, অন্ধ্ৰপ্ৰদেশ';

  @override
  String get csClusterSrikalahastiBio2 => 'হাতেৰে অঁকা পেনেল আৰু শাড়ী';

  @override
  String get csClusterSrikalahastiBio3 => 'অৰ্ডাৰৰ বাবে DM কৰক';

  @override
  String get csClusterSrikalahastiBio4 => 'মন্দিৰ-শিল্পৰ পৰিয়াল';

  @override
  String get csClusterSrikalahastiStoryHeritage =>
      'মন্দিৰৰ কাহিনী, বাঁহৰ কলমেৰে অঁকা।';

  @override
  String get csClusterSrikalahastiStoryMaterial =>
      'কপাহী কাপোৰ আৰু প্ৰাকৃতিক ৰং — শিলিখা, লো, ফটিকিৰি।';

  @override
  String get csClusterSrikalahastiStoryProcess =>
      'এটা এটাকৈ ৰেখা টানি অঁকা — দুখন কাপোৰ একে নহয়।';

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
  String get csClusterVenkatgiriFabric => 'ভেংকটগিৰি শাড়ী — মিহি কপাহ আৰু জৰি';

  @override
  String get csClusterVenkatgiriShortName => 'ভেংকটগিৰি শাড়ী';

  @override
  String get csClusterVenkatgiriPlace => 'ভেংকটগিৰি, অন্ধ্ৰপ্ৰদেশ';

  @override
  String get csClusterVenkatgiriBio0 => 'হাতঁতশাল বয়নশিল্পী';

  @override
  String get csClusterVenkatgiriBio1 => 'ভেংকটগিৰি, অন্ধ্ৰপ্ৰদেশ';

  @override
  String get csClusterVenkatgiriBio2 => 'মিহি কপাহ আৰু জৰিৰ শাড়ী';

  @override
  String get csClusterVenkatgiriBio3 => 'অৰ্ডাৰৰ বাবে DM কৰক';

  @override
  String get csClusterVenkatgiriBio4 => '১৯৭০ চনৰ পৰা বয়নশিল্পীৰ পৰিয়াল';

  @override
  String get csClusterVenkatgiriStoryHeritage =>
      'এসময়ত ভেংকটগিৰি ৰাজদৰবাৰৰ বাবে বোৱা হৈছিল।';

  @override
  String get csClusterVenkatgiriStoryMaterial =>
      'ইমান মিহি কপাহ যে শাড়ীখন বতাহত ভাঁহে।';

  @override
  String get csClusterVenkatgiriStoryProcess =>
      'জামদানি ফুল — শুৱা, আম, ৰাজহাঁহ — হাতেৰে বোৱা।';

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
  String get csClusterManiabandhaFabric => 'খণ্ডুৱা ইকাট — বান্ধি ৰং কৰা পাট';

  @override
  String get csClusterManiabandhaShortName => 'খণ্ডুৱা ইকাট';

  @override
  String get csClusterManiabandhaPlace => 'মণিয়াবন্ধা, ওড়িশা';

  @override
  String get csClusterManiabandhaBio0 => 'ইকাট বয়নশিল্পী';

  @override
  String get csClusterManiabandhaBio1 => 'মণিয়াবন্ধা, ওড়িশা';

  @override
  String get csClusterManiabandhaBio2 => 'খণ্ডুৱা শাড়ী আৰু ষ্ট\'ল';

  @override
  String get csClusterManiabandhaBio3 => 'অৰ্ডাৰৰ বাবে DM কৰক';

  @override
  String get csClusterManiabandhaBio4 => 'মহানদীৰ পাৰৰ বয়নশিল্পীৰ গাঁও';

  @override
  String get csClusterManiabandhaStoryHeritage =>
      'খণ্ডুৱা — ভগৱান জগন্নাথৰ বাবে বোৱা।';

  @override
  String get csClusterManiabandhaStoryMaterial =>
      'পাটৰ সূতা তাঁতলৈ যোৱাৰ আগতেই বান্ধি ৰং কৰা হয়।';

  @override
  String get csClusterManiabandhaStoryProcess =>
      'নক্সাটো সূতাতে ৰং কৰা হয়, তাৰ পিছত হুবহু বোৱা হয়।';

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
  String get csClusterGopalpurFabric => 'গোপালপুৰ তচৰ — বনৰীয়া পাট';

  @override
  String get csClusterGopalpurShortName => 'তচৰ শাড়ী';

  @override
  String get csClusterGopalpurPlace => 'গোপালপুৰ, যাজপুৰ, ওড়িশা';

  @override
  String get csClusterGopalpurBio0 => 'তচৰ বয়নশিল্পী';

  @override
  String get csClusterGopalpurBio1 => 'গোপালপুৰ, ওড়িশা';

  @override
  String get csClusterGopalpurBio2 => 'শাড়ী, ষ্ট\'ল আৰু কাপোৰ';

  @override
  String get csClusterGopalpurBio3 => 'অৰ্ডাৰৰ বাবে DM কৰক';

  @override
  String get csClusterGopalpurBio4 => 'GI টেগ পোৱা শিল্প';

  @override
  String get csClusterGopalpurStoryHeritage =>
      'গোপালপুৰত ষোড়শ শতিকাৰ পৰা বোৱা হৈ আহিছে — GI টেগ পোৱা।';

  @override
  String get csClusterGopalpurStoryMaterial =>
      'বনৰীয়া তচৰ — ইয়াৰ সোণালী ৰং প্ৰাকৃতিক, ৰং দি কৰা নহয়।';

  @override
  String get csClusterGopalpurStoryProcess =>
      'হাতেৰে ঘূৰোৱা, হাতেৰে কটা, অতিৰিক্ত বানাৰ ফুল।';

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
  String get csClusterNagalandFabric => 'নগা চাদৰ — কঁকাল তাঁত';

  @override
  String get csClusterNagalandShortName => 'নগা চাদৰ';

  @override
  String get csClusterNagalandPlace => 'নাগালেণ্ডৰ ক্লাষ্টাৰ';

  @override
  String get csClusterNagalandBio0 => 'কঁকাল তাঁতৰ বয়নশিল্পী';

  @override
  String get csClusterNagalandBio1 => 'নাগালেণ্ড';

  @override
  String get csClusterNagalandBio2 => 'চাদৰ আৰু মেখেলা';

  @override
  String get csClusterNagalandBio3 => 'অৰ্ডাৰৰ বাবে DM কৰক';

  @override
  String get csClusterNagalandBio4 => 'মোৰ জনগোষ্ঠীৰ বোৱা কাপোৰ';

  @override
  String get csClusterNagalandStoryHeritage =>
      'প্ৰতিটো ৰেখা আৰু ফুলে কয় আপুনি কোন।';

  @override
  String get csClusterNagalandStoryMaterial =>
      'কঁকাল তাঁতত ডাঠ কপাহ, গাঢ় ৰঙেৰে ৰঙোৱা।';

  @override
  String get csClusterNagalandStoryProcess =>
      'এডাল এডালকৈ পাত বোৱা, তাৰ পিছত জোৰা লগাই এখন চাদৰ।';

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
  String get csNewProductTitle => 'নতুন সামগ্ৰী';

  @override
  String get csHowIsItMade => 'এইটো কেনেকৈ বনোৱা হয়?';

  @override
  String get csTechniqueSub => 'কৌশলেই ঠিক কৰে কেমেৰাই কি দেখুৱাব লাগে।';

  @override
  String get csTechniqueWoven => 'বোৱা';

  @override
  String get csTechniqueHandPainted => 'হাতেৰে অঁকা';

  @override
  String get csNextMaterialType => 'পৰৱৰ্তী — উপাদানৰ ধৰণ';

  @override
  String get csNextMaterial => 'পৰৱৰ্তী — উপাদান';

  @override
  String get csWhatArePhotographing => 'আপুনি কিহৰ ফটো তুলিছে?';

  @override
  String get csPickYourProduct => 'আপোনাৰ সামগ্ৰী বাছক।';

  @override
  String get csPickYourFrames => 'আপোনাৰ ফ্ৰেম বাছক';

  @override
  String get csPickFramesSub => 'আপুনি কোনবোৰ ফটো তুলিব? কমেও দুটা বাছক।';

  @override
  String get csNoTemplatesYet =>
      'এই সামগ্ৰীৰ বাবে এতিয়ালৈকে কোনো টেমপ্লেট নাই।';

  @override
  String get csNextFrameIt => 'পৰৱৰ্তী — ফ্ৰেম কৰক';

  @override
  String csFramingProgress(int index, int total) {
    return 'ফ্ৰেমিং $index / $total';
  }

  @override
  String csFramingProgressNamed(int index, int total, String names) {
    return 'ফ্ৰেমিং $index / $total — $names';
  }

  @override
  String get csFramingThirdsTitle => 'আপোনাৰ সামগ্ৰীটো ক\'ত থাকিব লাগে?';

  @override
  String get csFramingThirdsSub =>
      'সৰ্বোত্তম ফ্ৰেমটোত টিপক। ৰেখাবোৰেই হ\'ল তিনিভাগৰ নিয়ম।';

  @override
  String get csFramingThirdsMsg0 =>
      'একেবাৰে মাজত ৰাখিলে ফটোখন সমান লাগে। ৰেখা লগ লগা বিন্দুত ৰাখি চাওক।';

  @override
  String get csFramingThirdsMsg1 =>
      'হয় — য\'ত ৰেখাবোৰ লগ লাগে তাতে ৰাখক। ফটোখনে উশাহ ল\'ব।';

  @override
  String get csFramingThirdsMsg2 => 'কাষৰ বৰ ওচৰত — সামগ্ৰীটো কাটি যায়।';

  @override
  String get csFramingCenterTitle => 'কিমান ওচৰলৈ যাব?';

  @override
  String get csFramingCenterSub =>
      'ওচৰৰ ফটো, সমানকৈ পাৰি থোৱা আৰু ওলোমাই থোৱা সামগ্ৰী মাজত থাকে — মাজৰ বাকচটো ভৰাওক।';

  @override
  String get csFramingCenterMsg0 =>
      'বৰ দূৰত — সূক্ষ্মতা হেৰাই যায়। ওচৰলৈ আহক।';

  @override
  String get csFramingCenterMsg1 =>
      'হয় — মাজৰ বাকচটো ভৰাওক, প্ৰান্তবোৰ ফ্ৰেমৰ সমান্তৰালকৈ ৰাখক।';

  @override
  String get csFramingCenterMsg2 =>
      'আধা ফ্ৰেমৰ বাহিৰত — ফটো তোলাৰ আগতে মাজলৈ আনক।';

  @override
  String get csFramingDiagTitle => 'কাপোৰখন কেনেকৈ বৈ যাব লাগে?';

  @override
  String get csFramingDiagSub =>
      'ওলোমা কাপোৰ আৰু সূক্ষ্ম ফটো কোণাকৈ যায় — কাপোৰখনকে চকুৰ বাট হ\'বলৈ দিয়ক।';

  @override
  String get csFramingDiagMsg0 =>
      'পোনে পোনে শাৰীত কোনো গতি নাই। কোণৰ ৰেখাত পৰিবলৈ দিয়ক।';

  @override
  String get csFramingDiagMsg1 =>
      'হয় — ভাঁজবোৰ কোণৰ ৰেখাত নামি যায় আৰু চকুৱে সেই বাটেৰে যায়।';

  @override
  String get csFramingDiagMsg2 =>
      'এটা চুকত গোট খাই আছে — বৈ যোৱা ভাবটো নাইকিয়া।';

  @override
  String get csFramingDetailTitle => 'ফ্ৰেমত আঁচল কিমান থাকিব?';

  @override
  String get csFramingDetailSub =>
      'আঁচল, ফুল আৰু ভাঁজ কৰা ফটো: সূক্ষ্ম ফ্ৰেমটো কামটোৰেই ভৰাওক।';

  @override
  String get csFramingDetailMsg0 =>
      'বৰ পাতল, বৰ দূৰ — শিল্পটো কোনেও দেখা নাপায়।';

  @override
  String get csFramingDetailMsg1 =>
      'হয় — আঁচলে গোটেই ফ্ৰেম ভৰাইছে, ইমান ওচৰ যে সূতা গণিব পাৰি।';

  @override
  String get csFramingDetailMsg2 =>
      'বতাহত ভাঁহি থকা চতুৰ্ভুজে আঁচলো নেদেখুৱায়, ফুলো নেদেখুৱায়। পাতটোৰ লগে লগে যাওক।';

  @override
  String get csNextFraming => 'পৰৱৰ্তী ফ্ৰেমিং';

  @override
  String get csNextLightIt => 'পৰৱৰ্তী — পোহৰ দিয়ক';

  @override
  String get csLightSide => 'কাষৰ পৰা পোহৰ';

  @override
  String get csLightFront => 'সন্মুখৰ পৰা কোমল পোহৰ';

  @override
  String get csLightBack => 'পিছফালৰ পৰা পোহৰ';

  @override
  String get csLightHeadingPanel => 'অঁকা পেনেলে চিকমিকনি নিবিচাৰে।';

  @override
  String get csLightHeadingPainted => 'হাতেৰে অঁকা — পোহৰ সমানে ৰাখক।';

  @override
  String get csLightHeadingSilk => 'পাট চিকমিকায়। ইয়াক জিলিকিবলৈ দিয়ক।';

  @override
  String get csLightHeadingCotton => 'কপাহ কোমল। পোহৰো কোমল ৰাখক।';

  @override
  String get csLightPromptPanel =>
      'কাপোৰত অঁকা ছবিয়ে পোহৰ ওভতাই দিয়ে। পোহৰ সমান আৰু কোমল ৰাখক।';

  @override
  String get csLightPromptPainted => 'অঁকা ৰংবোৰ সঁচা কৰি ৰখা পোহৰটো বাছক।';

  @override
  String get csLightPromptSilk =>
      'আপোনাৰ পাট আটাইতকৈ ভালকৈ দেখুৱা পোহৰটো বাছক।';

  @override
  String get csLightPromptDefault =>
      'আপোনাৰ সামগ্ৰী আটাইতকৈ ভালকৈ দেখুৱা পোহৰটো বাছক।';

  @override
  String get csLightWhyPanel =>
      'শুদ্ধ — সন্মুখৰ পৰা কোমল, সমান, বিয়পি পৰা পোহৰ। প্ৰাকৃতিক ৰংবোৰ সঁচা থাকে আৰু কেমেৰালৈ একো চিকমিকনি নাহে। কেতিয়াও ফ্লেচ নিদিব।';

  @override
  String get csLightWhyPainted =>
      'শুদ্ধ — সন্মুখৰ সমান পোহৰে ৰংবোৰ সঁচা কৰি ৰাখে, অঁকা পৃষ্ঠত চিকমিকনি নাথাকে।';

  @override
  String get csLightWhySilk => 'শুদ্ধ — কাষৰ পোহৰে পাটৰ জিলিকনি ধৰি লয়।';

  @override
  String get csLightWhyCotton =>
      'শুদ্ধ — সন্মুখৰ কোমল পোহৰে কপাহক কোমল আৰু ইয়াৰ ৰং সঁচা কৰি ৰাখে।';

  @override
  String get csLightWrongPanel =>
      'কাষৰ পৰা পৰা তীব্ৰ পোহৰে বুৰুচৰ কামত ছাঁ পেলায় আৰু পৃষ্ঠত চিকমিকনি আনে। পোহৰ সমান আৰু বিয়পি পৰা ৰাখক।';

  @override
  String get csLightWrongPainted =>
      'কাষৰ পোহৰে অঁকা কামত ছাঁ পেলায়। পোহৰ কোমল আৰু সমান ৰাখক।';

  @override
  String get csLightWrongSilk =>
      'সন্মুখৰ সমান পোহৰে জিলিকনি মাৰি পেলায়। পোহৰটো কাষলৈ আনক।';

  @override
  String get csLightWrongCotton =>
      'কাষৰ কঠিন পোহৰে কপাহক ৰুক্ষ দেখুৱায়। সন্মুখৰ পৰা কোমল পোহৰ ৰাখক।';

  @override
  String get csLightWrongBacklight =>
      'পিছফালৰ পোহৰে আপোনাৰ সামগ্ৰীক ছাঁলৈ পৰিণত কৰে। ইয়াক ডাঠৰ ফটোৰ বাবে ৰাখক।';

  @override
  String get csLightTipDoThisBadge => 'এইদৰে কৰক';

  @override
  String get csLightTipDoThisBody =>
      'ডাঙৰ খিৰিকীৰ কোমল পোহৰ, পৰ্দা টনা। গোটেই পেনেলত সমান পোহৰ — প্ৰতিটো ৰং সঁচা, চিকমিকনি নাই।';

  @override
  String get csLightTipNeverFlashBadge => 'কেতিয়াও ফ্লেচ নহয়';

  @override
  String get csLightTipNeverFlashBody =>
      'ফ্লেচ পোনে পোনে ওভতি আহে — এটা বগা চিকমিকনিৰ দাগে ছবিখন পুৰি পেলায়।';

  @override
  String get csLightTipAvoidSideBadge => 'কাষৰ কঠিন পোহৰ এৰাই চলক';

  @override
  String get csLightTipAvoidSideBody =>
      'এফালৰ পৰা অহা বাতি বা ৰ\'দে বুৰুচৰ কামত ছাঁ টানি আনে আৰু কাপোৰৰ বুননিয়ে ছবিখনৰ লগত যুঁজ লগায়।';

  @override
  String get csLightNowPick => 'এতিয়া সঠিক পোহৰটো বাছক';

  @override
  String get csNextShootYours => 'পৰৱৰ্তী — নিজৰ ফটো তোলক';

  @override
  String get csFinishEarnBadge => 'সম্পূৰ্ণ কৰক — বেজ পাওক';

  @override
  String get languageOdia => 'ଓଡ଼ିଆ';

  @override
  String get languageTelugu => 'తెలుగు';

  @override
  String get csWhatIsItMadeOf => 'কিহৰ পৰা তৈয়াৰ কৰা হৈছে?';

  @override
  String get csMaterialDecidesLight => 'সামগ্ৰীয়ে পোহৰৰ সিদ্ধান্ত লয়।';

  @override
  String get csNextTechnique => 'পৰৱৰ্তী — কৌশল';

  @override
  String get csNextPickYourFrames => 'পৰৱৰ্তী — আপোনাৰ ফ্ৰেম বাছি লওক';

  @override
  String get csMaterialCotton => 'কপাহ';

  @override
  String get csMaterialSilk => 'ৰেশম';

  @override
  String get csPhotosToCaptureHeading => 'ফটোবোৰ ধৰি ৰাখিবলৈ';

  @override
  String get csOpenGuideDropTick =>
      'গাইডখন খুলিব, শ্বটটো লওক, ড্ৰপ ইন কৰক, টিক অফ কৰক।';

  @override
  String get csMarkAsTaken => 'MARK AS TAKEN বুলি চিহ্নিত কৰক';

  @override
  String get csTickedUndo => 'টিকড — UNDO';

  @override
  String get csDropFirstShot => 'আৰম্ভ কৰিবলৈ আপোনাৰ প্ৰথম শ্বটটো ড্ৰপ কৰক।';

  @override
  String csShotsLeft(int count) {
    return '$count শ্বট বাকী আছে।';
  }

  @override
  String get csAllShotsSaved => 'ALL SHOTS SAVED কৰা হৈছে';

  @override
  String csShotSavedLeft(int count) {
    return 'SHOT SAVED — $count বাওঁফালে';
  }

  @override
  String csDropYourShotHere(String name) {
    return 'আপোনাৰ $name শ্বট ইয়াত ড্ৰপ কৰক';
  }

  @override
  String get csChoosePhoto => 'ফটো';

  @override
  String get csChooseVideo => 'ভিডিঅ';

  @override
  String get csDropPhotoOrVideo =>
      'পাঠ ০১ ৰ পৰা আপোনাৰ ফটো — বা ফটো বা ভিডিঅ\' ড্ৰপ কৰক';

  @override
  String get csVideoSelected =>
      'ভিডিঅ\' নিৰ্বাচিত কৰা হৈছে — সলনি কৰিবলৈ টেপ কৰক';
}
