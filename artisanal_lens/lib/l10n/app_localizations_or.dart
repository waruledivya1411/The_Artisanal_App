// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class AppLocalizationsOr extends AppLocalizations {
  AppLocalizationsOr([String locale = 'or']) : super(locale);

  @override
  String get appTitle => 'ଆର୍ଟିସାନାଲ୍ ଲେନ୍ସ |';

  @override
  String get navHome => 'ଘର';

  @override
  String get navGallery => 'ଗ୍ୟାଲେରୀ';

  @override
  String get navNewProduct => 'ନୂତନ ଉତ୍ପାଦ |';

  @override
  String get navSettings => 'ସେଟିଂସମୂହ';

  @override
  String get continueAction => 'ଜାରି ରଖ |';

  @override
  String get openCamera => 'କ୍ୟାମେରା ଖୋଲନ୍ତୁ |';

  @override
  String get language => 'ଭାଷା';

  @override
  String get photographyGuide => 'ଫଟୋଗ୍ରାଫି ଗାଇଡ୍ |';

  @override
  String get photographyGuideSubtitle =>
      'ଏହି ଆପ୍ ଆପଣଙ୍କୁ ପ୍ରଦାନ କରୁଥିବା ପ୍ରତ୍ୟେକ ପ୍ରମ୍ପ୍ଟ ପଛରେ ଥିବା ନିୟମ |';

  @override
  String get whatPhotographing => 'ତୁମେ କଣ\nଆଜି ଫଟୋଗ୍ରାଫି?';

  @override
  String get continuePhotography => 'ଫଟୋଗ୍ରାଫି ଜାରି ରଖନ୍ତୁ |';

  @override
  String get previousSets => 'ପୂର୍ବ ସେଟ୍ |';

  @override
  String get filterAll => 'ସମସ୍ତ';

  @override
  String get filterFinished => 'ସମାପ୍ତ';

  @override
  String get filterPending => 'ବିଚାରାଧୀନ ଅଛି';

  @override
  String photosCompleted(int done, int total) {
    return '$total ଫଟୋଗୁଡ଼ିକର $done ସମାପ୍ତ ହୋଇଛି |';
  }

  @override
  String get emptyAll => 'ଏପର୍ଯ୍ୟନ୍ତ କ previous ଣସି ପୂର୍ବ ସେଟ୍ ନାହିଁ |';

  @override
  String get emptyFinished => 'ଏପର୍ଯ୍ୟନ୍ତ କ finished ଣସି ସମାପ୍ତ ସେଟ୍ ନାହିଁ |';

  @override
  String get emptyPending => 'କ pending ଣସି ବିଚାରାଧୀନ ସେଟ୍ ନାହିଁ |';

  @override
  String get newProduct => 'ନୂତନ ଉତ୍ପାଦ |';

  @override
  String get gallery => 'ଗ୍ୟାଲେରୀ';

  @override
  String get settings => 'ସେଟିଂସମୂହ';

  @override
  String get product => 'ଉତ୍ପାଦ';

  @override
  String get photos => 'ଫଟୋ';

  @override
  String get setup => 'ସେଟଅପ୍ |';

  @override
  String get tutorial => 'ଟ୍ୟୁଟୋରିଆଲ୍';

  @override
  String get review => 'ସମୀକ୍ଷା କରନ୍ତୁ |';

  @override
  String get materialHeadline => 'କେଉଁ ସାମଗ୍ରୀ |\nଆପଣ କାମ କରୁଛନ୍ତି କି?';

  @override
  String materialTypeHeadline(String material) {
    return 'କେଉଁ ପ୍ରକାର $material\nଆପଣ ବ୍ୟବହାର କରୁଛନ୍ତି କି?';
  }

  @override
  String get giveProductName => 'ତୁମର ଉତ୍ପାଦକୁ ଏକ ନାମ ଦିଅ |';

  @override
  String nameHint(String category) {
    return 'ଯଥା ନୀଳ ରେଶମ $category';
  }

  @override
  String get photosToCapture => 'କ୍ୟାପଚର କରିବାକୁ ଫଟୋ';

  @override
  String get photosToCaptureBody => 'ଏହି ଫଟୋଗୁଡ଼ିକ ଆପଣ ନେବାକୁ ଆବଶ୍ୟକ କରନ୍ତି |';

  @override
  String get sareePhotographyTemplatesTitle => 'ସାରି ଫଟୋଗ୍ରାଫି ଟେମ୍ପଲେଟ୍ |';

  @override
  String get sareePhotographyTemplatesBody =>
      'ଏଗୁଡ଼ିକ ନେବାକୁ ଥିବା ପାଞ୍ଚଟି ଫଟୋଗ୍ରାଫ୍ |';

  @override
  String get photographyTemplatesTitle => 'ଫଟୋଗ୍ରାଫି ଟେମ୍ପଲେଟ୍ |';

  @override
  String get photographyTemplatesBody =>
      'ଏଗୁଡ଼ିକ ନେବାକୁ ଥିବା ପାଞ୍ଚଟି ଫଟୋଗ୍ରାଫ୍ |';

  @override
  String get viewCompletedSet => 'ସମାପ୍ତ ସେଟ୍ ଦର୍ଶନ କରନ୍ତୁ |';

  @override
  String get allPhotosCaptured => 'ସମସ୍ତ ଫଟୋ କଏଦ ହୋଇଛି |';

  @override
  String takeNext(String label) {
    return 'ପରବର୍ତ୍ତୀ ନିଅ - $label';
  }

  @override
  String get productUnavailable => 'ଏହି ଉତ୍ପାଦ ଆଉ ଉପଲବ୍ଧ ନାହିଁ |';

  @override
  String get chooseAStyle => 'ଏକ ଶ style ଳୀ ବାଛନ୍ତୁ |';

  @override
  String get howShouldItLook => 'ଏହା କିପରି ଦେଖାଯିବା ଉଚିତ୍?';

  @override
  String get stylePickFirst => 'ତାଲିକାରୁ ପ୍ରଥମେ ଏକ ଫଟୋ ବାଛନ୍ତୁ |';

  @override
  String get styleNoNeeded =>
      'ଏହି ଫଟୋ ପାଇଁ କ style ଣସି ଶ style ଳୀ ଆବଶ୍ୟକ ନାହିଁ |';

  @override
  String styleSubtitleSaree(String template) {
    return 'ଏହି $template ଫଟୋ ପାଇଁ ବ୍ୟବସ୍ଥା ବାଛନ୍ତୁ |';
  }

  @override
  String styleSubtitleShot(String shot) {
    return 'ଏହି $shot ଫଟୋ ପାଇଁ ବ୍ୟବସ୍ଥା ବାଛନ୍ତୁ |';
  }

  @override
  String styleSubtitleCategory(String category, String shot) {
    return 'ଏହି $category $shot ଫଟୋ ପାଇଁ ବ୍ୟବସ୍ଥା ବାଛନ୍ତୁ |';
  }

  @override
  String get labelContent => 'ବିଷୟବସ୍ତୁ';

  @override
  String get labelNeeds => 'ଆବଶ୍ୟକତା';

  @override
  String get labelPlacement => 'ସ୍ଥାନ';

  @override
  String get labelLighting => 'ଆଲୋକ';

  @override
  String get labelGrid => 'ଗ୍ରୀଡ୍';

  @override
  String contentPrefixed(String value) {
    return 'ବିଷୟବସ୍ତୁ: $value';
  }

  @override
  String needsPrefixed(String value) {
    return 'ଆବଶ୍ୟକତା: $value';
  }

  @override
  String get lightingAndSetup => 'ଆଲୋକ ଏବଂ ସେଟଅପ୍ |';

  @override
  String get step1of2 => '2 ର ଷ୍ଟେପ୍ 1';

  @override
  String get step2of2 => '2 ର ଷ୍ଟେପ୍ 2';

  @override
  String get beforeYouShoot => 'ତୁମେ ଗୁଳି କରିବା ପୂର୍ବରୁ |';

  @override
  String get setupIllustrationPlaceholder => 'ଯୋଡିବାକୁ ସେଟଅପ୍ ଚିତ୍ରଣ |';

  @override
  String get placeTheProduct => 'ଉତ୍ପାଦ ରଖନ୍ତୁ |';

  @override
  String get setupSection => 'ସେଟଅପ୍ |';

  @override
  String get watchHowToSetUp => 'କିପରି ସେଟ୍ ଅପ୍ କରିବେ ଦେଖନ୍ତୁ |';

  @override
  String tutorialSubtitlePreset(String name) {
    return '$name କିପରି ସେଟ୍ ଅପ୍ କରିବେ ଦେଖନ୍ତୁ |';
  }

  @override
  String tutorialSubtitleTemplate(String name) {
    return '$name କିପରି ସେଟ୍ ଅପ୍ କରିବେ ଦେଖନ୍ତୁ |';
  }

  @override
  String get tutorialSubtitleFallback =>
      'ଏକ ଛୋଟ ଭିଡିଓ ଏହି ସେଟଅପ୍ ଯୋଡିବାବେଳେ ଦେଖାଇବ |';

  @override
  String get transcript => 'ଟ୍ରାନ୍ସକ୍ରିପ୍';

  @override
  String get transcriptPlaceholder =>
      'ଟ୍ୟୁଟୋରିଆଲ୍ ଭିଡିଓ ଯୋଡିବା ପରେ କଥିତ ଟ୍ରାନ୍ସକ୍ରିପ୍ଟ ଏଠାରେ ଦେଖାଯିବ |';

  @override
  String get tutorialVideoPlaceholder => 'ଯୋଡାଯିବାକୁ ଥିବା ଟ୍ୟୁଟୋରିଆଲ୍ ଭିଡିଓ |';

  @override
  String get referencePreset => 'ସନ୍ଦର୍ଭ ପ୍ରିସେଟ୍ |';

  @override
  String get retake => 'ପୁନ ake ଗ୍ରହଣ କରନ୍ତୁ |';

  @override
  String get usePhoto => 'ଫଟୋ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get greatFraming => 'ଉତ୍ତମ ଫ୍ରେମ୍';

  @override
  String get checkFraming => 'ଫ୍ରେମିଂ ଯାଞ୍ଚ କରନ୍ତୁ |';

  @override
  String get noPhotoToReview => 'ସମୀକ୍ଷା କରିବାକୁ କ photo ଣସି ଫଟୋ ନାହିଁ |';

  @override
  String get photoSetComplete => 'ତୁମର ଫଟୋ ସେଟ୍ ସଂପୂର୍ଣ୍ଣ 🎉';

  @override
  String get viewPhotoSet => 'View Photo Set';

  @override
  String get startNewProduct => 'ନୂତନ ଉତ୍ପାଦ ଆରମ୍ଭ କରନ୍ତୁ |';

  @override
  String get offlineBanner => 'ଅଫଲାଇନ୍ - ସଂଯୋଗ ହେଲେ ଫଟୋଗୁଡ଼ିକ ସିଙ୍କ ହେବ |';

  @override
  String get productNotFound => 'ଉତ୍ପାଦ ମିଳିଲା ନାହିଁ |';

  @override
  String get exportPhotoSet => 'ଫଟୋ ସେଟ୍ ରପ୍ତାନି କରନ୍ତୁ |';

  @override
  String continueCount(int done, int total) {
    return 'ଜାରି ରଖନ୍ତୁ - __$done __ / $total';
  }

  @override
  String get noPhotosToExport =>
      'ଏପର୍ଯ୍ୟନ୍ତ ରପ୍ତାନି କରିବାକୁ କ photos ଣସି ଫଟୋ ନାହିଁ |';

  @override
  String couldNotExport(String error) {
    return 'ରପ୍ତାନି ହୋଇପାରିଲା ନାହିଁ: $error';
  }

  @override
  String exportShareText(String name, int count) {
    return '$name - $count ଫଟୋ, ଆର୍ଟିସାନାଲ୍ ଲେନ୍ସ ସହିତ ସୁଟ୍ |';
  }

  @override
  String couldNotSavePhoto(String error) {
    return 'ଫଟୋ ସ save ୍ଚୟ କରିପାରିଲା ନାହିଁ: $error';
  }

  @override
  String get galleryEmpty =>
      'ଏପର୍ଯ୍ୟନ୍ତ କ photos ଣସି ଫଟୋ ସେଟ୍ ନାହିଁ |\nଆରମ୍ଭ କରିବାକୁ ଏକ ନୂତନ ଉତ୍ପାଦ ଆରମ୍ଭ କରନ୍ତୁ |';

  @override
  String get galleryEmptyFiltered => 'ଏହି ବର୍ଗରେ ଏପର୍ଯ୍ୟନ୍ତ କିଛି ନାହିଁ |';

  @override
  String get showAll => 'ସମସ୍ତ ଦେଖାନ୍ତୁ |';

  @override
  String get nextPill => 'ପରବର୍ତ୍ତୀ';

  @override
  String get templateOverline => 'ଟେମ୍ପଲେଟ୍ |';

  @override
  String get proTipGoodLight =>
      'ପ୍ରୋ-ଟିପ୍: ଉତ୍ପାଦ ସଟ ପାଇଁ ପ୍ରାକୃତିକ ଆଲୋକ ବର୍ତ୍ତମାନ ସର୍ବୋତ୍ତମ |';

  @override
  String get chipLight => 'ଆଲୋକ';

  @override
  String get chipDistance => 'ଦୂରତା |';

  @override
  String get chipCentre => 'କେନ୍ଦ୍ର';

  @override
  String get chipEmDash => '—';

  @override
  String get readingTheFrame => 'ଫ୍ରେମ୍ ପ Reading ଼ିବା…';

  @override
  String fillFrameWith(String slot) {
    return 'ଫ୍ରେମ୍ $slot ସହିତ ପୁରଣ କରନ୍ତୁ |';
  }

  @override
  String promptNoProduct(String product) {
    return '$product ଦୃଶ୍ୟରେ ରଖନ୍ତୁ |';
  }

  @override
  String promptMoveIntoFrame(String product) {
    return '$product କୁ ଫ୍ରେମ୍ କୁ ଘୁଞ୍ଚାନ୍ତୁ |';
  }

  @override
  String promptKeepInsideFrame(String product) {
    return '$product ଫ୍ରେମ୍ ଭିତରେ ରଖନ୍ତୁ |';
  }

  @override
  String get promptAlignHorizontal =>
      'ଭୂସମାନ୍ତର ଗାଇଡ୍ ସହିତ ଫୋଲ୍ଡଗୁଡ଼ିକୁ ଲାଇନ୍ କରନ୍ତୁ |';

  @override
  String get promptAlignDiagonal =>
      'କପଡାକୁ ଡାଇଗୋନାଲ୍ ଗାଇଡ୍ ଅନୁସରଣ କରିବାକୁ ଦିଅ |';

  @override
  String get promptHoldSteady => 'ଫୋନକୁ ସ୍ଥିର ରଖନ୍ତୁ |';

  @override
  String get promptMoveCloser => 'ନିକଟତର ହୁଅ |';

  @override
  String get promptMoveFurther => 'ବିଷୟଠାରୁ ଆଗକୁ ବ Move ନ୍ତୁ |';

  @override
  String promptCenterSubject(String product) {
    return '$product କେନ୍ଦ୍ର କରନ୍ତୁ |';
  }

  @override
  String get promptKeepTextureCentre => 'ଟେକ୍ସଚରକୁ କେନ୍ଦ୍ରରେ ରଖନ୍ତୁ |';

  @override
  String get promptKeepBorderInside => 'ଫ୍ରେମ୍ ଭିତରେ ସୀମା ରଖ |';

  @override
  String get promptKeepFoldsVisible => 'ଫୋଲ୍ଡଗୁଡିକ ଦୃଶ୍ୟମାନ ରଖନ୍ତୁ |';

  @override
  String get promptBacklight => 'ବ୍ୟାକ୍ ଲାଇଟ୍ ଚିହ୍ନଟ ହେଲା |';

  @override
  String get promptTooDark =>
      'ଅତ୍ୟଧିକ ଅନ୍ଧକାର - ଏକ window ରକା କିମ୍ବା ବାହାରେ ଗତି କର |';

  @override
  String get promptLowLight => 'ଆଲୋକ କମ୍ - ଏକ ୱିଣ୍ଡୋ ପାଖରେ ଗତି କର |';

  @override
  String get promptTooBright => 'ଅତ୍ୟଧିକ ଉଜ୍ଜ୍ୱଳ - ଖୋଲା ଛାଇକୁ ଯାଆନ୍ତୁ |';

  @override
  String get promptTiltPhone =>
      'ଆଙ୍ଗଲ୍ ଗାଇଡ୍ ସହିତ ମେଳ କରିବାକୁ ଫୋନ୍ ଟିଲ୍ଟ କରନ୍ତୁ |';

  @override
  String get promptReady => 'ଧରିବାକୁ ପ୍ରସ୍ତୁତ |';

  @override
  String get lightTooDark => 'ଅତ୍ୟଧିକ ଅନ୍ଧକାର |';

  @override
  String get lightLow => 'ନିମ୍ନ';

  @override
  String get lightOk => 'ଠିକ ଅଛି |';

  @override
  String get lightBright => 'ଉଜ୍ଜ୍ୱଳ |';

  @override
  String get distanceMoveCloser => 'ନିକଟତର ହୁଅ |';

  @override
  String get distanceOk => 'ଠିକ ଅଛି |';

  @override
  String get distanceMoveBack => 'ପଛକୁ ଯାଅ |';

  @override
  String get centreMoveIn => 'ଭିତରକୁ ଯାଅ |';

  @override
  String get centreOk => 'ଠିକ ଅଛି |';

  @override
  String get advisoryGoodHeadline => 'ବର୍ତ୍ତମାନ ଭଲ ଆଲୋକ |';

  @override
  String get advisoryGoodDetail =>
      'ସ୍ୱଚ୍ଛ, ପ୍ରକୃତ ରଙ୍ଗ ପାଇଁ ପ୍ରାକୃତିକ ଆଲୋକ ଯଥେଷ୍ଟ ନରମ |';

  @override
  String get advisoryOverheadHeadline => 'ଓଭରହେଡ୍ ସୂର୍ଯ୍ୟ |';

  @override
  String get advisoryOverheadDetail =>
      'ପରେ ସୂର୍ଯ୍ୟକିରଣ ନରମ ହେବା ପରେ ଫଟୋ ଉଠାଇବାକୁ ଚେଷ୍ଟା କରନ୍ତୁ | ବର୍ତ୍ତମାନ, ଓଭରହେଡ୍ ସୂର୍ଯ୍ୟ ଆପଣଙ୍କ ସେଟଅପ୍ ଉପରେ କଠୋର ଛାୟା ସୃଷ୍ଟି କରିପାରେ |';

  @override
  String get advisoryDarkHeadline => 'ପର୍ଯ୍ୟାପ୍ତ ଦୀପାବଳି ନୁହେଁ |';

  @override
  String get advisoryDarkDetail =>
      'ବର୍ତ୍ତମାନ ପର୍ଯ୍ୟାପ୍ତ ପ୍ରାକୃତିକ ଆଲୋକ ନାହିଁ | ଏକ window ରକା ନିକଟରେ ପ୍ରଭାତ ଆଲୋକ ସତ୍ୟ ରଙ୍ଗ ଦେଇଥାଏ |';

  @override
  String get openingTagline => 'ହସ୍ତତନ୍ତ ଉତ୍ପାଦଗୁଡ଼ିକ ପାଇଁ ଗାଇଡ୍ ଫଟୋଗ୍ରାଫି |';

  @override
  String get openingChipLight => 'ଆଲୋକ: ଭଲ |';

  @override
  String get openingChipAngle => 'କୋଣ: ଭଲ |';

  @override
  String get openingChipFrame => 'ଫ୍ରେମ୍: ପ୍ରସ୍ତୁତ |';

  @override
  String get guidelineG1Title => 'କ୍ଲୋଜ୍ ଅପ୍ ସଟ୍ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get guidelineG1Body =>
      'କପଡ଼ାର ସୂକ୍ଷ୍ମ ବିବରଣୀ, ଗଠନ, ଏବଂ କାରିଗରୀ କାବୁ କରନ୍ତୁ |';

  @override
  String get guidelineG2Title => 'କପଡା ଧାରକୁ ହାଇଲାଇଟ୍ କରନ୍ତୁ |';

  @override
  String get guidelineG2Body =>
      'କପଡ଼ାର ଧାରକୁ କ୍ୟାପଚର କରନ୍ତୁ, ଚିତ୍ରର 2/3 କପଡା ସହିତ ଆଚ୍ଛାଦନ କରନ୍ତୁ |';

  @override
  String get guidelineG3Title => 'ବିଭିନ୍ନ କୋଣରୁ ଗୁଳି |';

  @override
  String get guidelineG3Body =>
      'ଏହାର ଡିଜାଇନ୍ ଏବଂ ଗଠନକୁ ହାଇଲାଇଟ୍ କରିବାକୁ ଏକାଧିକ ଦୃଷ୍ଟିକୋଣରୁ ଉତ୍ପାଦକୁ ପ୍ରଦର୍ଶନ କରନ୍ତୁ |';

  @override
  String get guidelineG4Title => 'ବିବିଧ ଆଲୋକ ସହିତ ପରୀକ୍ଷା |';

  @override
  String get guidelineG4Body =>
      'କପଡ଼ାର ପ୍ରକୃତ ରଙ୍ଗ ଏବଂ ଗଭୀରତା ଆଣିବା ପାଇଁ ପ୍ରାକୃତିକ ଏବଂ କୃତ୍ରିମ ଆଲୋକ, ଭିତର ଏବଂ ବାହ୍ୟ ଆଲୋକ, ଆଗ ଏବଂ ପାର୍ଶ୍ୱ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get guidelineG5Title => 'ସଂପୃକ୍ତ ପୃଷ୍ଠଭୂମି ବାଛନ୍ତୁ |';

  @override
  String get guidelineG5Body =>
      'ପୃଷ୍ଠଭୂମି ବ୍ୟବହାର କରନ୍ତୁ ଯାହା କପଡ଼ାର ସ beauty ନ୍ଦର୍ଯ୍ୟକୁ ଅଧିକ ଶକ୍ତି ନକରି ବ enhance ାଇଥାଏ |';

  @override
  String get guidelineG6Title => 'ପ୍ରାକୃତିକ ସୃଷ୍ଟିଗୁଡିକ ଗ୍ରହଣ କରନ୍ତୁ |';

  @override
  String get guidelineG6Body =>
      'ସାମଗ୍ରୀର ଏକ ସ୍ପଷ୍ଟ ଧାରଣା ଦେବା ପାଇଁ କପଡାକୁ ଏହାର କଞ୍ଚା, ଅଣସଂରକ୍ଷିତ ଅବସ୍ଥାରେ ଫଟୋଗ୍ରାଫ୍ କରନ୍ତୁ |';

  @override
  String get guidelineG7Title => 'ଓଜନ ଏବଂ ପ୍ରବାହକୁ ପ୍ରତିନିଧିତ୍ୱ କରନ୍ତୁ |';

  @override
  String get guidelineG7Body =>
      'ଏହାର ଓଜନ ଏବଂ ଅନୁଭବ ପହଞ୍ଚାଇବା ପାଇଁ କପଡା କିପରି ଡ୍ରାପ୍, ଫୋଲ୍ଡ୍ ଏବଂ ପ୍ରବାହିତ ହୁଏ ତାହା କ୍ୟାପଚର୍ କରନ୍ତୁ |';

  @override
  String get guidelineG8Title => 'ଏକ କାହାଣୀ କୁହ |';

  @override
  String get guidelineG8Body =>
      'ଫ୍ରେମ୍ ସଟ୍ ଏକ ଉପାୟରେ ଯାହା କପଡାକୁ ଏହାର ସାଂସ୍କୃତିକ heritage ତିହ୍ୟ, କାରିଗର ଏବଂ ଉଦ୍ଦିଷ୍ଟ ବ୍ୟବହାର ସହିତ ସଂଯୋଗ କରେ |';

  @override
  String get categorySaree => 'ସାର୍';

  @override
  String get categoryCushionCover => 'କୁଶିଆ କଭର |';

  @override
  String get categoryShawl => 'ଶା w ୀ |';

  @override
  String get categoryStole => 'ଚୋରି';

  @override
  String get categorySarees => 'ସାରିସ୍ |';

  @override
  String get categoryCushionCovers => 'କୁଶିଆ କଭର |';

  @override
  String get categoryShawls => 'ଶା w ୀ |';

  @override
  String get categoryStoles => 'ଚୋରି';

  @override
  String get nounSaree => 'ସାର୍';

  @override
  String get nounCushionCover => 'କୁଶିଆ ଆବରଣ |';

  @override
  String get nounShawl => 'ଶା w ୀ |';

  @override
  String get nounStole => 'ଚୋରି କଲା |';

  @override
  String get nounProduct => 'ଉତ୍ପାଦ';

  @override
  String get materialSilk => 'ରେଶମ';

  @override
  String get materialCotton => 'କପା';

  @override
  String get materialWool => 'ପଶମ';

  @override
  String get materialJute => 'ଜଟ୍';

  @override
  String get materialSilkLower => 'ରେଶମ';

  @override
  String get materialCottonLower => 'କପା';

  @override
  String get materialWoolLower => 'ପଶମ';

  @override
  String get materialJuteLower => 'ଜଟ୍';

  @override
  String get silkMulberry => 'ମଲବେରି |';

  @override
  String get silkEri => 'ଏରି';

  @override
  String get silkTasar => 'ତସର |';

  @override
  String get silkMuga => 'ମୁଗା';

  @override
  String get cottonKhadi => 'ଖାଡି |';

  @override
  String get cottonMuslin => 'ମୁସଲିନ୍ |';

  @override
  String get cottonHandloom => 'ହ୍ୟାଣ୍ଡଲୁମ୍ |';

  @override
  String get cottonJamdani => 'ଜାମଦାନୀ |';

  @override
  String get woolPashmina => 'ପାଶ୍ମିନା';

  @override
  String get woolAngora => 'ଅଙ୍ଗୋରା |';

  @override
  String get woolMerino => 'ମେରିନୋ |';

  @override
  String get woolHandspun => 'ହ୍ୟାଣ୍ଡସପନ୍ |';

  @override
  String get juteGolden => 'ସୁବର୍ଣ୍ଣ |';

  @override
  String get juteTossa => 'ତୋସା |';

  @override
  String get juteHessian => 'ହେସିୟାନ୍ |';

  @override
  String get juteBlended => 'ମିଶ୍ରିତ |';

  @override
  String get shotProcess => 'ପ୍ରକ୍ରିୟା';

  @override
  String get shotProduct => 'ଉତ୍ପାଦ';

  @override
  String get shotDetail => 'ସବିଶେଷ |';

  @override
  String get shotLifestyle => 'Lifestyle';

  @override
  String get shotPhotography => 'ଫଟୋଗ୍ରାଫି';

  @override
  String get shotProcessChecklist => 'ତିଆରି ପ୍ରକ୍ରିୟା ଦେଖାନ୍ତୁ |';

  @override
  String get shotProductChecklist => 'ଆଇଟମ୍ ର ପୁରା ସଟ୍ |';

  @override
  String get shotDetailChecklist => 'ଟେକ୍ସଚର / ବୁଣାକାର ବନ୍ଦ |';

  @override
  String get shotLifestyleChecklist => 'ଏକ ପ୍ରାକୃତିକ ସେଟିଂରେ |';

  @override
  String get shotPhotographyChecklist => 'ସାରି ଫଟୋଗ୍ରାଫି ଟେମ୍ପଲେଟ୍ |';

  @override
  String get slotLoomSetup => 'ଲୁମ୍ ସେଟଅପ୍ |';

  @override
  String get slotDyeing => 'ରଙ୍ଗ କରିବା |';

  @override
  String get slotHeroShot => 'ହିରୋ ଗୁଳି |';

  @override
  String get slotBorder => 'ସୀମା';

  @override
  String get slotWeave => 'ବୁଣା';

  @override
  String get slotMotif => 'ମୋଟିଫ୍ |';

  @override
  String get slotStyledShot => 'ଷ୍ଟାଇଲ୍ ଶଟ୍';

  @override
  String get templateFullDisplay => 'ପୂର୍ଣ୍ଣ ସାରି ପ୍ରଦର୍ଶନ |';

  @override
  String get templateTextureWeave => 'ବସ୍ତ୍ର ଏବଂ ବୁଣା';

  @override
  String get templateDrapedLook => 'ଚିତ୍ରିତ ଲୁକ୍ |';

  @override
  String get templateEmbroideryBorder => 'ଏମ୍ବ୍ରୋଡେରୀ ଏବଂ ସୀମା ବିବରଣୀ |';

  @override
  String get templateFoldedStack => 'ଫୋଲଡ୍ ଷ୍ଟାକ / ସାରି ଷ୍ଟାକ |';

  @override
  String get templateFullDisplayLower => 'ପୂର୍ଣ୍ଣ ଶାରୀରୀ ପ୍ରଦର୍ଶନ |';

  @override
  String get templateTextureWeaveLower => 'ବସ୍ତ୍ର ଏବଂ ବୁଣା';

  @override
  String get templateDrapedLookLower => 'ଚିତ୍ରିତ ଲୁକ୍ |';

  @override
  String get templateEmbroideryBorderLower => 'ଏମ୍ବ୍ରୋଡେରୀ ଏବଂ ସୀମା ବିବରଣୀ |';

  @override
  String get templateFoldedStackLower => 'ଫୋଲଡ୍ ଷ୍ଟାକ / ସାର୍ ଷ୍ଟାକ |';

  @override
  String get templateFullDisplayContent => 'ରଙ୍ଗ, ନମୁନା, ସାମଗ୍ରୀ |';

  @override
  String get templateTextureWeaveContent => 'ଗଠନ, ଘନତା, ସାମଗ୍ରୀ, ସ୍ୱଚ୍ଛତା |';

  @override
  String get templateDrapedLookContent => 'ଫ୍ଲିମେସନ, ଶିନ, ଫ୍ଲୋ, ଓଜନ |';

  @override
  String get templateEmbroideryBorderContent => 'ଏମ୍ବ୍ରୋଡେରୀ, ଗୁଣବତ୍ତା |';

  @override
  String get templateFoldedStackContent => 'ମୋଟା, ସାମଗ୍ରୀର ଓଜନ |';

  @override
  String get templateFullDisplayNeeds =>
      'ପ୍ରାକୃତିକ ଦୀପାବଳି; ନିରପେକ୍ଷ କିମ୍ବା ବିପରୀତ ପୃଷ୍ଠଭୂମି |';

  @override
  String get templateTextureWeaveNeeds => 'ପସନ୍ଦ ପ୍ରାକୃତିକ ଆଲୋକ |';

  @override
  String get templateDrapedLookNeeds =>
      'ହ୍ୟାଙ୍ଗର୍, ବାଉଁଶ କିମ୍ବା ମେନେକ୍ଇନ୍; ପାର୍ଶ୍ୱ ଆଲୋକ';

  @override
  String get templateEmbroideryBorderNeeds =>
      'ପାର୍ଶ୍ୱ ଆଲୋକ; ବିପରୀତ ପୃଷ୍ଠଭୂମି |';

  @override
  String get templateFoldedStackNeeds => 'ପାର୍ଶ୍ୱ ଆଲୋକ';

  @override
  String get templateFullDisplayPlacement =>
      'ସାରି ସମତଳ ବିସ୍ତାର କରେ କିମ୍ବା ଏକ ପୃଷ୍ଠ ଉପରେ ଟାଣି ହୋଇଗଲା |';

  @override
  String get templateTextureWeavePlacement =>
      'ସାରୀର ଏକ ସୁସଜ୍ଜିତ ବିଭାଗ, ବିଶେଷତ natural ପ୍ରାକୃତିକ ଆଲୋକରେ |';

  @override
  String get templateDrapedLookPlacement =>
      'ହ୍ୟାଙ୍ଗର୍, ବାଉଁଶ କିମ୍ବା ମେନେକ୍ଇନ୍ |';

  @override
  String get templateEmbroideryBorderPlacement =>
      'ସାର୍ ସୀମା କିମ୍ବା ଏକ ଏମ୍ବ୍ରୋଡେଡ୍ ବିଭାଗ ବନ୍ଦ |';

  @override
  String get templateFoldedStackPlacement =>
      'ଦୃଶ୍ୟମାନ ଫୋଲ୍ଡ ସହିତ ସୁନ୍ଦର ଭାବରେ ଷ୍ଟାକ୍ ହୋଇଛି |';

  @override
  String get templateFullDisplayOverlay =>
      'ଉପର ସୀମାକୁ ଉପର ତୃତୀୟ ସହିତ ଲାଇନ୍ କରନ୍ତୁ |';

  @override
  String get templateTextureWeaveOverlay => 'ଟେକ୍ସଚରକୁ କେନ୍ଦ୍ରରେ ରଖନ୍ତୁ |';

  @override
  String get templateDrapedLookOverlay =>
      'ଫୋଲ୍ଡଗୁଡ଼ିକୁ ତ୍ରିକୋଣୀୟ ଅନୁସରଣ କରିବାକୁ ଦିଅ |';

  @override
  String get templateEmbroideryBorderOverlay =>
      'ଏମ୍ବ୍ରୋଡୋରୀକୁ ଫ୍ରେମ୍ ଭିତରେ ରଖ |';

  @override
  String get templateFoldedStackOverlay =>
      'ଭୂସମାନ୍ତର ରେଖା ସହିତ ସମାନ୍ତରାଳ ଭାବରେ ରଖନ୍ତୁ |';

  @override
  String get templateTextureWeaveLighting =>
      'କୋମଳ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ | କଠୋର ପ୍ରତିଫଳନରୁ ଦୂରେଇ ରୁହନ୍ତୁ |';

  @override
  String get templateCushionFullCover => 'ପୂର୍ଣ୍ଣ କଭର୍ ପ୍ରଦର୍ଶନ |';

  @override
  String get templateCushionTextureWeave => 'ବସ୍ତ୍ର ଏବଂ ବୁଣା';

  @override
  String get templateCushionStackedPair => 'ଷ୍ଟାକ୍ଡ୍ ଯୋଡି / ମୋଟା |';

  @override
  String get templateCushionCornerStitching => 'କୋଣ ଏବଂ ସିଲେଇ |';

  @override
  String get templateCushionInUse => 'ଆସନରେ ବ୍ୟବହାରରେ |';

  @override
  String get templateCushionFullCoverLower => 'ପୂର୍ଣ୍ଣ କଭର ପ୍ରଦର୍ଶନ |';

  @override
  String get templateCushionTextureWeaveLower => 'ବସ୍ତ୍ର ଏବଂ ବୁଣା';

  @override
  String get templateCushionStackedPairLower => 'ଷ୍ଟାକ୍ଡ୍ ଯୋଡି / ମୋଟା |';

  @override
  String get templateCushionCornerStitchingLower => 'କୋଣ ଏବଂ ସିଲେଇ |';

  @override
  String get templateCushionInUseLower => 'ବସିବାରେ ବ୍ୟବହାରରେ |';

  @override
  String get templateCushionFullCoverContent => 'ରଙ୍ଗ, ନମୁନା, ସାମଗ୍ରୀ |';

  @override
  String get templateCushionTextureWeaveContent => 'ଗଠନ, ଘନତା, ସାମଗ୍ରୀ |';

  @override
  String get templateCushionStackedPairContent => 'ଘନତା, ସାମଗ୍ରୀ, ଗଠନ |';

  @override
  String get templateCushionCornerStitchingContent =>
      'ଗୁଣବତ୍ତା, ଗଠନ, ଏମ୍ବ୍ରୋଡେରୀ |';

  @override
  String get templateCushionInUseContent => 'ରଙ୍ଗ, ନମୁନା, ଗୁଣବତ୍ତା |';

  @override
  String get templateCushionFullCoverNeeds => 'ପ୍ରାକୃତିକ ଦୀପାବଳି; ସାଧା ପୃଷ୍ଠ';

  @override
  String get templateCushionTextureWeaveNeeds => 'ପସନ୍ଦ ପ୍ରାକୃତିକ ଆଲୋକ |';

  @override
  String get templateCushionStackedPairNeeds =>
      'ପାର୍ଶ୍ୱ ଆଲୋକ; ଏକ ମେଳ ଖାଉଥିବା ଯୋଡି |';

  @override
  String get templateCushionCornerStitchingNeeds => 'ପାର୍ଶ୍ୱ ଆଲୋକ';

  @override
  String get templateCushionInUseNeeds => 'ଏକ ଚେୟାର, ସୋଫା କିମ୍ବା ଶଯ୍ୟା |';

  @override
  String get templateCushionFullCoverPlacement => 'ଏକ ସମତଳ ପୃଷ୍ଠରେ ସମତଳ ଆବରଣ |';

  @override
  String get templateCushionTextureWeavePlacement => 'କଭରର ଏକ ସୁସଜ୍ଜିତ ବିଭାଗ |';

  @override
  String get templateCushionStackedPairPlacement =>
      'ଦୁଇଟି କଭର କ୍ୟାମେରା ଆଡକୁ ଧାର ସହିତ ଷ୍ଟାକ୍ ହୋଇଛି |';

  @override
  String get templateCushionCornerStitchingPlacement => 'ଏକ ସିଲେଇ କୋଣର ବନ୍ଦ |';

  @override
  String get templateCushionInUsePlacement =>
      'କ୍ୟାମେରା ଆଡକୁ ମୁହାଁଇଥିବା ଏକ ସିଟ୍ ଉପରେ କଭର୍ |';

  @override
  String get templateCushionFullCoverOverlay =>
      'ଗ୍ରୀଡ୍ ସହିତ ଧାରକୁ ସିଧା ରଖନ୍ତୁ |';

  @override
  String get templateCushionTextureWeaveOverlay =>
      'ଟେକ୍ସଚରକୁ କେନ୍ଦ୍ରରେ ରଖନ୍ତୁ |';

  @override
  String get templateCushionStackedPairOverlay =>
      'ଭୂସମାନ୍ତର ରେଖା ସହିତ ସମାନ୍ତରାଳ ଭାବରେ ରଖନ୍ତୁ |';

  @override
  String get templateCushionCornerStitchingOverlay =>
      'ଫ୍ରେମ୍ ଭିତରେ ସିଲେଇ ରଖନ୍ତୁ |';

  @override
  String get templateCushionInUseOverlay => 'କଭରକୁ ଫ୍ରେମରେ ରଖନ୍ତୁ |';

  @override
  String get templateShawlFullDesign => 'ପୂର୍ଣ୍ଣ ଡିଜାଇନ୍ ପ୍ରଦର୍ଶନ |';

  @override
  String get templateShawlTextureWeave => 'ବସ୍ତ୍ର ଏବଂ ବୁଣା';

  @override
  String get templateShawlDrapedLook => 'ଚିତ୍ରିତ ଲୁକ୍ |';

  @override
  String get templateShawlBorderCorner => 'ସୀମା ଏବଂ କୋଣ';

  @override
  String get templateShawlFoldedStack => 'ଫୋଲଡ୍ ଷ୍ଟାକ |';

  @override
  String get templateShawlFullDesignLower => 'ପୂର୍ଣ୍ଣ ଡିଜାଇନ୍ ପ୍ରଦର୍ଶନ |';

  @override
  String get templateShawlTextureWeaveLower => 'ବସ୍ତ୍ର ଏବଂ ବୁଣା';

  @override
  String get templateShawlDrapedLookLower => 'ଚିତ୍ରିତ ଲୁକ୍ |';

  @override
  String get templateShawlBorderCornerLower => 'ସୀମା ଏବଂ କୋଣ';

  @override
  String get templateShawlFoldedStackLower => 'ଫୋଲଡ୍ ଷ୍ଟାକ |';

  @override
  String get templateShawlFullDesignContent => 'ନମୁନା, ରଙ୍ଗ, ସ୍ୱଚ୍ଛତା |';

  @override
  String get templateShawlTextureWeaveContent => 'ଗଠନ, ଘନତା, ସାମଗ୍ରୀ |';

  @override
  String get templateShawlDrapedLookContent => 'ଚମତ୍କାରତା, ସାମଗ୍ରୀ, ନମୁନା |';

  @override
  String get templateShawlBorderCornerContent => 'ଗଠନ, ଗୁଣବତ୍ତା, ଏମ୍ବ୍ରୋଡେରୀ |';

  @override
  String get templateShawlFoldedStackContent => 'ଘନତା, ସାମଗ୍ରୀ |';

  @override
  String get templateShawlFullDesignNeeds =>
      'ବିପକ୍ଷରେ ପିନ୍ କରିବା ପାଇଁ ଏକ ରେଖା, ବାଉଁଶ ପୋଲ କିମ୍ବା କାନ୍ଥ |';

  @override
  String get templateShawlTextureWeaveNeeds => 'ପସନ୍ଦ ପ୍ରାକୃତିକ ଆଲୋକ |';

  @override
  String get templateShawlDrapedLookNeeds => 'ଶା aw ୀ ପିନ୍ଧିବାକୁ କେହି ଜଣେ |';

  @override
  String get templateShawlBorderCornerNeeds => 'ପାର୍ଶ୍ୱ ଆଲୋକ';

  @override
  String get templateShawlFoldedStackNeeds => 'ପାର୍ଶ୍ୱ ଆଲୋକ';

  @override
  String get templateShawlFullDesignPlacement =>
      'ଶା aw ଼ି ଟାଙ୍ଗି ନଥିବା ଫ୍ଲାଟକୁ ଟାଙ୍ଗି ଦିଆଯାଏ |';

  @override
  String get templateShawlTextureWeavePlacement =>
      'ଶା w ୀର ଏକ ସୁସଜ୍ଜିତ ବିଭାଗ |';

  @override
  String get templateShawlDrapedLookPlacement =>
      'ଗୋଟିଏ କାନ୍ଧ ଉପରେ ଶା w ୀ, ସ୍ୱାଭାବିକ ଭାବରେ ପଡ଼ିବା |';

  @override
  String get templateShawlBorderCornerPlacement => 'କୋଣ ଏବଂ ସୀମା ବନ୍ଦ |';

  @override
  String get templateShawlFoldedStackPlacement =>
      'ଦୃଶ୍ୟମାନ ଫୋଲ୍ଡ ସହିତ ସୁନ୍ଦର ଭାବରେ ଷ୍ଟାକ୍ ହୋଇଛି |';

  @override
  String get templateShawlFullDesignOverlay =>
      'ଶୀର୍ଷ ତୃତୀୟ ସହିତ ସୀମାକୁ ଲାଇନ୍ କରନ୍ତୁ |';

  @override
  String get templateShawlTextureWeaveOverlay => 'ଟେକ୍ସଚରକୁ କେନ୍ଦ୍ରରେ ରଖନ୍ତୁ |';

  @override
  String get templateShawlDrapedLookOverlay =>
      'ଫୋଲ୍ଡଗୁଡ଼ିକୁ ତ୍ରିକୋଣୀୟ ଅନୁସରଣ କରିବାକୁ ଦିଅ |';

  @override
  String get templateShawlBorderCornerOverlay => 'ଫ୍ରେମ୍ ଭିତରେ ସୀମା ରଖ |';

  @override
  String get templateShawlFoldedStackOverlay =>
      'ଭୂସମାନ୍ତର ରେଖା ସହିତ ସମାନ୍ତରାଳ ଭାବରେ ରଖନ୍ତୁ |';

  @override
  String get templateStoleFullLength => 'ପୂର୍ଣ୍ଣ ଦ Length ର୍ଘ୍ୟ ପ୍ରଦର୍ଶନ |';

  @override
  String get templateStoleTextureWeave => 'ବସ୍ତ୍ର ଏବଂ ବୁଣା';

  @override
  String get templateStoleNeckWrap => 'ପିନ୍ଧିଥିବା ବେକ';

  @override
  String get templateStoleSoftnessKnot => 'କୋମଳତା / ଗଣ୍ଠି |';

  @override
  String get templateStoleEdgeThickness => 'ଧାର ଏବଂ ଘନତା |';

  @override
  String get templateStoleFullLengthLower =>
      'ପୂର୍ଣ୍ଣ ଦ length ର୍ଘ୍ୟ ପ୍ରଦର୍ଶନ |';

  @override
  String get templateStoleTextureWeaveLower => 'ବସ୍ତ୍ର ଏବଂ ବୁଣା';

  @override
  String get templateStoleNeckWrapLower => 'ପିନ୍ଧିଥିବା ବେକ ଗୁଡ଼ାଇ |';

  @override
  String get templateStoleSoftnessKnotLower => 'କୋମଳତା / ଗଣ୍ଠି';

  @override
  String get templateStoleEdgeThicknessLower => 'ଧାର ଏବଂ ଘନତା |';

  @override
  String get templateStoleFullLengthContent => 'ନମୁନା, ରଙ୍ଗ, ସାମଗ୍ରୀ |';

  @override
  String get templateStoleTextureWeaveContent => 'ଗଠନ, ଘନତା, ସାମଗ୍ରୀ |';

  @override
  String get templateStoleNeckWrapContent => 'Im ଲକ, ରଙ୍ଗ, ପାଟର୍ନ |';

  @override
  String get templateStoleSoftnessKnotContent => 'ଚମତ୍କାରତା, ଗଠନ, ସାମଗ୍ରୀ |';

  @override
  String get templateStoleEdgeThicknessContent => 'ଘନତା, ଗଠନ, ସାମଗ୍ରୀ |';

  @override
  String get templateStoleFullLengthNeeds => 'ପ୍ରାକୃତିକ ଦୀପାବଳି; ସାଧା ପୃଷ୍ଠ';

  @override
  String get templateStoleTextureWeaveNeeds => 'ପସନ୍ଦ ପ୍ରାକୃତିକ ଆଲୋକ |';

  @override
  String get templateStoleNeckWrapNeeds => 'ଚୋରି ପିନ୍ଧିବାକୁ କେହି ଜଣେ |';

  @override
  String get templateStoleSoftnessKnotNeeds => 'କୋମଳ ପାର୍ଶ୍ୱ ଆଲୋକ |';

  @override
  String get templateStoleEdgeThicknessNeeds => 'କୋମଳ ପାର୍ଶ୍ୱ ଆଲୋକ |';

  @override
  String get templateStoleFullLengthPlacement =>
      'ଚୋରି ବିସ୍ତାର ହୋଇଛି ତେଣୁ ଏହାର ସମ୍ପୂର୍ଣ୍ଣ ଦ length ର୍ଘ୍ୟ ଦୃଶ୍ୟମାନ ହେଉଛି |';

  @override
  String get templateStoleTextureWeavePlacement => 'ଚୋରିର ଏକ ସୁସଜ୍ଜିତ ବିଭାଗ |';

  @override
  String get templateStoleNeckWrapPlacement =>
      'ବେକରେ ଥରେ ଗୁଡ଼ାଇ ଉଭୟ ମୁଣ୍ଡ ଦୃଶ୍ୟମାନ ହୁଏ |';

  @override
  String get templateStoleSoftnessKnotPlacement =>
      'ମ in ିରେ ଗୋଟିଏ ଖାଲି ଗଣ୍ଠି |';

  @override
  String get templateStoleEdgeThicknessPlacement =>
      'ଚୋରି ଏକ କୋଇଲିରେ ଖାଲି ଗଡ଼ିଗଲା |';

  @override
  String get templateStoleFullLengthOverlay => 'ଚୋରିକୁ ଗ୍ରୀଡ୍ ପାଖରେ ରଖ |';

  @override
  String get templateStoleTextureWeaveOverlay => 'ଟେକ୍ସଚରକୁ କେନ୍ଦ୍ରରେ ରଖନ୍ତୁ |';

  @override
  String get templateStoleNeckWrapOverlay => 'ଫ୍ରେମ୍ ରେ ଗୁଡ଼ିକୁ ରଖନ୍ତୁ |';

  @override
  String get templateStoleSoftnessKnotOverlay => 'ଗଣ୍ଠିକୁ କେନ୍ଦ୍ରରେ ରଖନ୍ତୁ |';

  @override
  String get templateStoleEdgeThicknessOverlay => 'କୋଇଲିକୁ କେନ୍ଦ୍ରରେ ରଖନ୍ତୁ |';

  @override
  String get presetSareePalluDrapeName => 'ପାଲୁ ଡ୍ରାପ୍ (ହ୍ୟାଙ୍ଗର୍)';

  @override
  String get presetSareeBoxFoldName => 'ବାକ୍ସ / ଫ୍ଲାଟ ଫୋଲ୍ଡ |';

  @override
  String get presetSareeWornDrapeName => 'ପିନ୍ଧିଥିବା ଡ୍ରାପ୍ (ମଡେଲ୍)';

  @override
  String get presetSareeRollDisplayName => 'ରୋଲ୍ ପ୍ରଦର୍ଶନ';

  @override
  String get presetCushionFlatLayName => 'ଫ୍ଲାଟ ଲେ';

  @override
  String get presetCushionStackedPairName => 'ଷ୍ଟାକ୍ଡ୍ ଯୋଡି |';

  @override
  String get presetCushionProppedName => 'ବସିବା ଉପରେ ଅଟକାଇଲେ |';

  @override
  String get presetCushionCornerTuckName => 'କୋଣାର୍କ ବନ୍ଦ |';

  @override
  String get presetShawlDrapedShoulderName => 'କାନ୍ଧରେ ଅଙ୍କିତ |';

  @override
  String get presetShawlFoldedStackName => 'ଫୋଲଡ୍ ଷ୍ଟାକ |';

  @override
  String get presetShawlHungFlatName => 'ହଙ୍ଗ / ପିନ୍ ଫ୍ଲାଟ |';

  @override
  String get presetShawlCornerTuckName => 'କୋଣାର୍କ ବନ୍ଦ |';

  @override
  String get presetStoleNeckWrapName => 'ବେକ ଗୁଡ଼େଇ (ପିନ୍ଧାଯାଇଥିବା)';

  @override
  String get presetStoleFlatSpreadName => 'ଫ୍ଲାଟ ବିସ୍ତାର |';

  @override
  String get presetStoleLooseKnotName => 'ଖାଲି ଗଣ୍ଠି |';

  @override
  String get presetStoleRolledCoilName => 'ଗଡ଼ାଯାଇଥିବା କୋଇଲ୍ |';

  @override
  String get presetSareePalluDrapePurpose =>
      'Im ଲକତା, ଶିନ, ପ୍ରବାହ ଏବଂ ଓଜନ ଦେଖାଏ |';

  @override
  String get presetSareeBoxFoldPurpose => 'ଘନତା ଏବଂ ସାମଗ୍ରୀର ଓଜନ ଦେଖାଏ |';

  @override
  String get presetSareeWornDrapePurpose =>
      'ପିନ୍ଧିବା ସମୟରେ ରଙ୍ଗ, pattern ାଞ୍ଚା ଏବଂ ପଦାର୍ଥ ଦେଖାଏ |';

  @override
  String get presetSareeRollDisplayPurpose =>
      'ଏକ କମ୍ପାକ୍ଟ ରୋଲରେ ରଙ୍ଗ, pattern ାଞ୍ଚା ଏବଂ ପଦାର୍ଥ ଦେଖାଏ |';

  @override
  String get presetCushionFlatLayPurpose =>
      'ବିକୃତି ବିନା ସମ୍ପୂର୍ଣ୍ଣ pattern ାଞ୍ଚା ଏବଂ ରଙ୍ଗ ଦେଖାନ୍ତୁ |';

  @override
  String get presetCushionStackedPairPurpose =>
      'ଘନତା ଦେଖାନ୍ତୁ ଏବଂ ଏକ ଯୋଡି କିପରି ଏକତ୍ର ଦେଖାଯାଏ |';

  @override
  String get presetCushionProppedPurpose =>
      'ପ୍ରକୃତ ସ୍କେଲରେ ବ୍ୟବହାରରେ ଥିବା କଭର ଦେଖାନ୍ତୁ |';

  @override
  String get presetCushionCornerTuckPurpose =>
      'କୋଣରେ ସିଲେଇ ଗୁଣ ଏବଂ ଫିନିଶ୍ ଦେଖାନ୍ତୁ |';

  @override
  String get presetShawlDrapedShoulderPurpose =>
      'ଡ୍ରାପ୍, ଓଜନ ଏବଂ ପିନ୍ଧିବାବେଳେ ଏହା କିପରି ବସିଥାଏ ଦେଖାନ୍ତୁ |';

  @override
  String get presetShawlFoldedStackPurpose =>
      'ଘନତା ଏବଂ ସାମଗ୍ରୀର ଓଜନ ଦେଖାନ୍ତୁ |';

  @override
  String get presetShawlHungFlatPurpose =>
      'ଏକାସାଙ୍ଗରେ ସମ୍ପୂର୍ଣ୍ଣ ଡିଜାଇନ୍, ରଙ୍ଗ ଏବଂ ସୀମା ଦେଖାନ୍ତୁ |';

  @override
  String get presetShawlCornerTuckPurpose =>
      'ବୁଣା, ସୀମା ସବିଶେଷ ଏବଂ କାରିଗରୀ ପ୍ରଦର୍ଶନ କରନ୍ତୁ |';

  @override
  String get presetStoleNeckWrapPurpose =>
      'ସ୍କେଲ ଦେଖାନ୍ତୁ ଏବଂ ପିନ୍ଧିବା ସମୟରେ ଚୋରି କିପରି ବସିଥାଏ |';

  @override
  String get presetStoleFlatSpreadPurpose =>
      'ପୂର୍ଣ୍ଣ ଦ length ର୍ଘ୍ୟ, pattern ାଞ୍ଚା ଏବଂ ଉଭୟ ସୀମା ଦେଖାନ୍ତୁ |';

  @override
  String get presetStoleLooseKnotPurpose =>
      'କପଡା କେତେ ନରମ ଏବଂ ଏହା କେତେ ସହଜରେ ଗଣ୍ଠି ହୁଏ ତାହା ଦେଖାନ୍ତୁ |';

  @override
  String get presetStoleRolledCoilPurpose =>
      'ବୁଣାକାର ଧାର, ଘନତା ଏବଂ ଶେଷ ଦେଖାନ୍ତୁ |';

  @override
  String get presetSareePalluDrapeContent => 'ଫ୍ଲିମେସନ, ଶିନ, ଫ୍ଲୋ, ଓଜନ |';

  @override
  String get presetSareeBoxFoldContent => 'ମୋଟା, ସାମଗ୍ରୀର ଓଜନ |';

  @override
  String get presetSareeWornDrapeContent => 'ରଙ୍ଗ, ନମୁନା, ସାମଗ୍ରୀ |';

  @override
  String get presetSareeRollDisplayContent => 'ରଙ୍ଗ, ନମୁନା, ସାମଗ୍ରୀ |';

  @override
  String get presetSareePalluDrapeNeeds =>
      'ହ୍ୟାଙ୍ଗର୍, ବାଉଁଶ କିମ୍ବା ମେନେକ୍ଇନ୍; ପାର୍ଶ୍ୱ ଆଲୋକ';

  @override
  String get presetSareeBoxFoldNeeds => 'ପାର୍ଶ୍ୱ ଆଲୋକ';

  @override
  String get presetSareeWornDrapeNeeds =>
      'ଶାରୀରୀ ପିନ୍ଧିବାକୁ କେହି; ପ୍ରାକୃତିକ ଦୀପାବଳି; ନିରପେକ୍ଷ କିମ୍ବା ବିପରୀତ ପୃଷ୍ଠଭୂମି |';

  @override
  String get presetSareeRollDisplayNeeds =>
      'ପ୍ରାକୃତିକ ଦୀପାବଳି; ନିରପେକ୍ଷ କିମ୍ବା ବିପରୀତ ପୃଷ୍ଠଭୂମି |';

  @override
  String get presetSareePalluDrapeLower => 'ପାଲୁ ଡ୍ରାପ୍ (ହ୍ୟାଙ୍ଗର୍)';

  @override
  String get presetSareeBoxFoldLower => 'ବାକ୍ସ / ଫ୍ଲାଟ ଫୋଲ୍ଡ |';

  @override
  String get presetSareeWornDrapeLower => 'ପିନ୍ଧାଯାଇଥିବା ଡ୍ରାପ୍ (ମଡେଲ୍)';

  @override
  String get presetSareeRollDisplayLower => 'ରୋଲ୍ ପ୍ରଦର୍ଶନ';

  @override
  String get presetCushionFlatLayLower => 'ଫ୍ଲାଟ ଲେ';

  @override
  String get presetCushionStackedPairLower => 'ଷ୍ଟାକ୍ଡ୍ ଯୋଡି |';

  @override
  String get presetCushionProppedLower => 'ବସିବା ଉପରେ ପ୍ରପୋଜ୍ |';

  @override
  String get presetCushionCornerTuckLower => 'କୋଣାର୍କ ଟକ୍ କ୍ଲୋଜ ଅପ୍ |';

  @override
  String get presetShawlDrapedShoulderLower => 'କାନ୍ଧରେ ଅଙ୍କିତ |';

  @override
  String get presetShawlFoldedStackLower => 'ଫୋଲଡ୍ ଷ୍ଟାକ |';

  @override
  String get presetShawlHungFlatLower => 'ଟଙ୍ଗାଯାଇଥିବା ଫ୍ଲାଟ';

  @override
  String get presetShawlCornerTuckLower => 'କୋଣାର୍କ ଟକ୍ କ୍ଲୋଜ ଅପ୍ |';

  @override
  String get presetStoleNeckWrapLower => 'ବେକ ଗୁଡ଼େଇ (ପିନ୍ଧାଯାଇଥିବା)';

  @override
  String get presetStoleFlatSpreadLower => 'ସମତଳ ବିସ୍ତାର |';

  @override
  String get presetStoleLooseKnotLower => 'ଖାଲି ଗଣ୍ଠି |';

  @override
  String get presetStoleRolledCoilLower => 'rolled coil';

  @override
  String get shotProcessLower => 'ପ୍ରକ୍ରିୟା';

  @override
  String get shotProductLower => 'ଉତ୍ପାଦ';

  @override
  String get shotDetailLower => 'ସବିଶେଷ';

  @override
  String get shotLifestyleLower => 'ଜୀବନଶ lifestyle ଳୀ';

  @override
  String get shotPhotographyLower => 'ଫଟୋଗ୍ରାଫି |';

  @override
  String get categorySareeLower => 'ସାର୍';

  @override
  String get categoryCushionCoverLower => 'କୁଶିଆ ଆବରଣ |';

  @override
  String get categoryShawlLower => 'ଶା w ୀ |';

  @override
  String get categoryStoleLower => 'ଚୋରି କଲା |';

  @override
  String get propertyColour => 'ରଙ୍ଗ';

  @override
  String get propertyMaterial => 'ସାମଗ୍ରୀ';

  @override
  String get propertyQuality => 'ଗୁଣବତ୍ତା';

  @override
  String get propertyFlimsiness => 'Fl ଲକ';

  @override
  String get propertyTexture => 'ଗଠନ';

  @override
  String get propertyThickness => 'ମୋଟା |';

  @override
  String get propertyTransparency => 'ସ୍ୱଚ୍ଛତା';

  @override
  String get propertyPattern => 'ନମୁନା';

  @override
  String get propertySheen => 'ଶେନ୍ / ଗ୍ଲୋସ୍ |';

  @override
  String get propertyEmbroidery => 'ଏମ୍ବ୍ରୋଡେରୀ |';

  @override
  String get angleEyeLevel => 'ଆଖି ସ୍ତର';

  @override
  String get angleEyeLevelHint => 'ଫୋନ୍ କୁ ଉତ୍ପାଦର ଉଚ୍ଚତାରେ ଧରି ରଖନ୍ତୁ |';

  @override
  String get angleOverhead => 'ଓଭରହେଡ୍ (ଫ୍ଲାଟ ଲେ)';

  @override
  String get angleOverheadHint =>
      'ଉତ୍ପାଦ ଉପରେ ଠିଆ ହୁଅ ଏବଂ ଫୋନକୁ ସିଧା ତଳକୁ ଦେଖ |';

  @override
  String get angleLow => 'ନିମ୍ନ କୋଣ';

  @override
  String get angleLowHint =>
      'ଉତ୍ପାଦ ତଳେ ଫୋନକୁ ତଳକୁ ଓହ୍ଲାଇ ଟିକିଏ ଉପରକୁ ଟାଣନ୍ତୁ |';

  @override
  String get angleMacro => 'ମାକ୍ରୋ କ୍ଲୋଜ ଅପ୍ |';

  @override
  String get angleMacroHint =>
      'ବୁଣା ଫ୍ରେମ୍ ଭରିବା ପର୍ଯ୍ୟନ୍ତ ବନ୍ଦ କରନ୍ତୁ, ତାପରେ ଧ୍ୟାନ ଦେବାକୁ ଟ୍ୟାପ୍ କରନ୍ତୁ |';

  @override
  String get lightingSoftWindow => 'ନରମ ୱିଣ୍ଡୋ ଆଲୋକ |';

  @override
  String get lightingSoftWindowHint =>
      'ଉତ୍ପାଦକୁ ଏକ ୱିଣ୍ଡୋ ପାଖରେ ରଖନ୍ତୁ, ବଲ୍ବ ତଳେ ନୁହେଁ |';

  @override
  String get lightingDiffused => 'ବିଭାଜିତ ଦୀପାବଳି |';

  @override
  String get lightingDiffusedHint =>
      'ଗୋଟିଏ ପାର୍ଶ୍ୱରୁ ଆଲୋକ ଆସିବା ସହିତ ଖୋଲା ଛାଇରେ ବାହାରେ ଗୁଳି ଚଳାନ୍ତୁ |';

  @override
  String get lightingAvoidMidday => 'କଠିନ ମଧ୍ୟାହ୍ନ ସୂର୍ଯ୍ୟଠାରୁ ଦୂରେଇ ରୁହନ୍ତୁ |';

  @override
  String get lightingAvoidMiddayHint =>
      '3 PM ପରେ ଅପେକ୍ଷା କରନ୍ତୁ - ଓଭରହେଡ୍ ସୂର୍ଯ୍ୟ ରଙ୍ଗ ଧୋଇଦିଏ |';

  @override
  String get lightingBacklight => 'ଶିରା କପଡା ପାଇଁ ବ୍ୟାକ୍ ଲାଇଟ୍ |';

  @override
  String get lightingBacklightHint =>
      'କେତେ ଗତି କରେ ତାହା ଦେଖାଇବା ପାଇଁ କପଡା ପଛରେ ଆଲୋକ ରଖ |';

  @override
  String get compositionRuleOfThirds => 'ତୃତୀୟାଂଶର ନିୟମ |';

  @override
  String get compositionRuleOfThirdsHint =>
      'ଗ୍ରୀଡର ଉପର ତୃତୀୟାଂଶ ସହିତ ସୀମାକୁ ଲାଇନ୍ କରନ୍ତୁ |';

  @override
  String get compositionCentered => 'କେନ୍ଦ୍ରିତ ଉତ୍ପାଦ |';

  @override
  String get compositionCenteredHint =>
      'ଉତ୍ପାଦକୁ ଗ୍ରୀଡର ମ box ି ବାକ୍ସରେ ରଖନ୍ତୁ |';

  @override
  String get compositionNegativeSpace => 'ଫୋଲ୍ଡର ଚାରିପାଖରେ ନକାରାତ୍ମକ ସ୍ଥାନ |';

  @override
  String get compositionNegativeSpaceHint =>
      'ଫୋଲ୍ଡର ଚାରିପାଖରେ ଖାଲି ସ୍ଥାନ ଛାଡିଦିଅ, ତେଣୁ ସେମାନେ ସ୍ପଷ୍ଟ ଭାବରେ ପ read ନ୍ତି |';

  @override
  String get compositionLeadingLines => 'ଅଗ୍ରଣୀ କପଡା ରେଖା |';

  @override
  String get compositionLeadingLinesHint =>
      'ତ୍ରିକୋଣୀୟ ଗାଇଡ୍ ସହିତ ଫୋଲ୍ଡଗୁଡିକ ରଖନ୍ତୁ |';

  @override
  String get compositionCentreFocus => 'କେନ୍ଦ୍ର ଫୋକସ୍ |';

  @override
  String get compositionCentreFocusHint => 'ଟେକ୍ସଚରକୁ ଫ୍ରେମର ମ in ିରେ ରଖନ୍ତୁ |';

  @override
  String get compositionDetailFrame => 'ବିସ୍ତୃତ ଫ୍ରେମ୍ |';

  @override
  String get compositionDetailFrameHint =>
      'ହାଇଲାଇଟ୍ ହୋଇଥିବା ଫ୍ରେମ୍ ଭିତରେ ଏମ୍ବ୍ରୋଡୋରୀ ରଖନ୍ତୁ |';

  @override
  String get accountBackup => 'ଖାତା ଏବଂ ବ୍ୟାକଅପ୍ |';

  @override
  String get accountBackupSubtitle =>
      'ଅନ୍ଲାଇନ୍ରେ ପ୍ରଗତି ସଞ୍ଚୟ କରିବାକୁ ଏକ ଉପଯୋଗକର୍ତ୍ତା ନାମ ଏବଂ ପାସୱାର୍ଡ ସୃଷ୍ଟି କରନ୍ତୁ |';

  @override
  String get cloudBackupNotConfigured => 'କ୍ଲାଉଡ୍ ବ୍ୟାକଅପ୍ ବିନ୍ୟାସ ହୋଇନାହିଁ |';

  @override
  String get cloudBackupNotConfiguredBody =>
      'ଏହି ବିଲ୍ଡର କ cloud ଣସି କ୍ଲାଉଡ୍ ସଂଯୋଗ ନାହିଁ | ପ୍ରଗତି କେବଳ ଏହି ଫୋନରେ ରହିଥାଏ |';

  @override
  String get signedInAs => 'ଭାବରେ ସାଇନ୍ ଇନ୍ ହୋଇଛି |';

  @override
  String get artisanFallback => 'କାରିଗର';

  @override
  String get syncNow => 'ବର୍ତ୍ତମାନ ସିଙ୍କ୍ କରନ୍ତୁ |';

  @override
  String get signOut => 'Sign out';

  @override
  String get createAccountPrompt =>
      'ଅନଲାଇନ୍ରେ ଆପଣଙ୍କର କାର୍ଯ୍ୟ ସଞ୍ଚୟ କରିବାକୁ ଏକ ଆକାଉଣ୍ଟ୍ ସୃଷ୍ଟି କରନ୍ତୁ |';

  @override
  String get signInPrompt =>
      'ଆପଣଙ୍କର ସଞ୍ଚିତ ଉତ୍ପାଦ ଏବଂ ଫଟୋ ଲୋଡ୍ କରିବାକୁ ସାଇନ୍ ଇନ୍ କରନ୍ତୁ |';

  @override
  String get username => 'ଉପଯୋଗକର୍ତ୍ତା ନାମ';

  @override
  String get usernameHint => 'ଯଥା priya_weaver';

  @override
  String get password => 'ପାସୱାର୍ଡ';

  @override
  String get createAccount => 'ଖାତା ସୃଷ୍ଟି କରନ୍ତୁ |';

  @override
  String get signIn => 'ସାଇନ୍ ଇନ୍ କରନ୍ତୁ |';

  @override
  String get alreadyHaveAccount => 'ପୂର୍ବରୁ ଏକ ଖାତା ଅଛି କି? ସାଇନ୍ ଇନ୍ କରନ୍ତୁ |';

  @override
  String get needAccount => 'ଏକ ଖାତା ଦରକାର କି? ଗୋଟିଏ ସୃଷ୍ଟି କରନ୍ତୁ |';

  @override
  String get accountCreated =>
      'ଖାତା ସୃଷ୍ଟି | ଆପଣଙ୍କର ଅଗ୍ରଗତି ଅନ୍ଲାଇନ୍ରେ ସିଙ୍କ ହେବ |';

  @override
  String get signedInSuccess =>
      'ସାଇନ୍ ଇନ୍ ହୋଇଛି | ଆପଣଙ୍କର ସଞ୍ଚିତ କାର୍ଯ୍ୟ ଏହି ଫୋନରେ ଅଛି |';

  @override
  String get signedOutSuccess => 'ସାଇନ୍ ଆଉଟ୍ | ସ୍ଥାନୀୟ ଫଟୋ ଏହି ଫୋନରେ ରହିଥାଏ |';

  @override
  String get syncOffline =>
      'କ internet ଣସି ଇଣ୍ଟରନେଟ୍ ନାହିଁ - ଯେତେବେଳେ ଆପଣ ଅନଲାଇନ୍ ଫେରିବେ |';

  @override
  String syncDone(int sets, int shots) {
    return 'ସିଙ୍କ୍ ହୋଇଛି: $sets ଉତ୍ପାଦ ଅପଲୋଡ୍ ହୋଇଛି, $shots ଫଟୋ ଅପଲୋଡ୍ ହୋଇଛି |';
  }

  @override
  String get syncUpToDate => 'ସବୁକିଛି ଅପଡେଟ୍ ହୋଇସାରିଛି |';

  @override
  String syncFailed(String error) {
    return 'ସିଙ୍କ ବିଫଳ ହେଲା: $error';
  }

  @override
  String get yourProgress => 'ତୁମର ଅଗ୍ରଗତି';

  @override
  String get productsStarted => 'ଉତ୍ପାଦ ଆରମ୍ଭ ହେଲା |';

  @override
  String get finishedSets => 'ସମାପ୍ତ ସେଟ୍ |';

  @override
  String get inProgressSets => 'ଚାଲିଛି |';

  @override
  String get photosCaptured => 'ଫଟୋଗୁଡ଼ିକ କଏଦ ହୋଇଛି |';

  @override
  String get usernameTooShort =>
      'ଉପଯୋଗକର୍ତ୍ତା ନାମ ଅତିକମରେ 3 ଅକ୍ଷର କିମ୍ବା ସଂଖ୍ୟା ହେବା ଜରୁରୀ |';

  @override
  String get usernameTooLong =>
      'ଉପଯୋଗକର୍ତ୍ତା ନାମ 32 ଅକ୍ଷର କିମ୍ବା କମ୍ ହେବା ଜରୁରୀ |';

  @override
  String get passwordTooShort => 'ପାସୱାର୍ଡ ଅତିକମରେ 6 ଅକ୍ଷର ହେବା ଜରୁରୀ |';

  @override
  String get fullScreen => 'ପୂର୍ଣ୍ଣ ପରଦା |';

  @override
  String get tapToSkip => 'ଏଡ଼ାଇବାକୁ ଟ୍ୟାପ୍ କରନ୍ତୁ |';

  @override
  String get cameraPermissionNeeded =>
      'ଫଟୋ ଉଠାଇବା ପାଇଁ କ୍ୟାମେରା ଅନୁମତି ଆବଶ୍ୟକ |\nଦୟାକରି ସେଟିଂସମୂହରେ କ୍ୟାମେରା ପ୍ରବେଶକୁ ଅନୁମତି ଦିଅନ୍ତୁ |';

  @override
  String get cameraUnavailable => 'କ୍ୟାମେରା ଉପଲବ୍ଧ ନାହିଁ |';

  @override
  String get noCameraFound =>
      'ଏହି ଡିଭାଇସରେ କ camera ଣସି କ୍ୟାମେରା ମିଳିଲା ନାହିଁ |';

  @override
  String get accountCreateFailed =>
      'ଆପଣଙ୍କର ଖାତା ସୃଷ୍ଟି କରିପାରିଲା ନାହିଁ | ପୁନର୍ବାର ଚେଷ୍ଟା କରନ୍ତୁ |';

  @override
  String get enterValidUsername =>
      'ଏକ ବ valid ଧ ଉପଯୋଗକର୍ତ୍ତା ନାମ ପ୍ରବେଶ କରନ୍ତୁ |';

  @override
  String get monthJan => 'ଜାନୁଆରୀ';

  @override
  String get monthFeb => 'ଫେବୃଆରୀ';

  @override
  String get monthMar => 'ମାର୍ଚ୍ଚ';

  @override
  String get monthApr => 'ଏପ୍ରିଲ୍';

  @override
  String get monthMay => 'ମେ';

  @override
  String get monthJun => 'ଜୁନ୍ |';

  @override
  String get monthJul => 'ଜୁଲାଇ';

  @override
  String get monthAug => 'ଅଗଷ୍ଟ';

  @override
  String get monthSep => 'ସେପ୍ଟେମ୍ବର';

  @override
  String get monthOct => 'ଅକ୍ଟୋବର';

  @override
  String get monthNov => 'ନଭେମ୍ବର';

  @override
  String get monthDec => 'ଡିସେମ୍ବର';

  @override
  String get presetCushionFlatLayNeeds => 'ସମତଳ ଅବିଭକ୍ତ ପୃଷ୍ଠ |';

  @override
  String get presetCushionStackedPairNeeds => 'ଦୁଇଟି କଭର; ପାର୍ଶ୍ୱ ଆଲୋକ';

  @override
  String get presetCushionProppedNeeds => 'ଏକ ଚେୟାର, ସୋଫା କିମ୍ବା ଶଯ୍ୟା |';

  @override
  String get presetCushionCornerTuckNeeds => 'ବନ୍ଦ ଆଲୋକ |';

  @override
  String get presetShawlDrapedShoulderNeeds => 'ଶା aw ୀ ପିନ୍ଧିବାକୁ କେହି ଜଣେ |';

  @override
  String get presetShawlFoldedStackNeeds => 'ପାର୍ଶ୍ୱ ଆଲୋକ';

  @override
  String get presetShawlHungFlatNeeds =>
      'ବିପକ୍ଷରେ ପିନ୍ କରିବା ପାଇଁ ଏକ ରେଖା, ବାଉଁଶ ପୋଲ କିମ୍ବା କାନ୍ଥ |';

  @override
  String get presetShawlCornerTuckNeeds => 'ବନ୍ଦ ଆଲୋକ |';

  @override
  String get presetStoleNeckWrapNeeds => 'ଚୋରି ପିନ୍ଧିବାକୁ କେହି ଜଣେ |';

  @override
  String get presetStoleFlatSpreadNeeds => 'ସମତଳ ପୃଷ୍ଠ; ଓଭରହେଡ୍ ଭ୍ୟୁ |';

  @override
  String get presetStoleLooseKnotNeeds => 'କୋମଳ ପାର୍ଶ୍ୱ ଆଲୋକ |';

  @override
  String get presetStoleRolledCoilNeeds => 'କୋମଳ ପାର୍ଶ୍ୱ ଆଲୋକ |';

  @override
  String get placementSareePalluDrape =>
      'ଏକ ହ୍ୟାଙ୍ଗର୍, ବାଉଁଶ କିମ୍ବା ମାନ୍ନାକ୍ଇନ୍ ଉପରେ ସାରିକୁ ଟାଣନ୍ତୁ ତେଣୁ ପାଲୁ ମୁକ୍ତ ଭାବରେ ଖସିଯାଏ |';

  @override
  String get placementSareeBoxFold =>
      'ସାରୀକୁ ଏପରିକି ସ୍ତରରେ ଫୋଲ୍ କରନ୍ତୁ ଏବଂ ସେଗୁଡିକୁ ଷ୍ଟାକ କରନ୍ତୁ ଯାହାଫଳରେ ଧାର ଦୃଶ୍ୟମାନ ହେବ |';

  @override
  String get placementSareeWornDrape =>
      'ସେହି ବ୍ୟକ୍ତିଙ୍କ ଉପରେ ଶାରୀରୀକୁ ରଙ୍ଗ କରନ୍ତୁ, ରଙ୍ଗ, pattern ାଞ୍ଚା ଏବଂ ସୀମା ଶୋ ସ୍ପଷ୍ଟ ଭାବରେ |';

  @override
  String get placementSareeRollDisplay =>
      'ସାରୀକୁ ଗଡ଼ନ୍ତୁ ତେଣୁ ପାଲୁ ଏବଂ ସୀମା କ୍ୟାମେରା ଆଡକୁ |';

  @override
  String get placementCushionFlatLay => 'କଭରକୁ ସମତଳ, ଅବିଭକ୍ତ ପୃଷ୍ଠରେ ରଖନ୍ତୁ |';

  @override
  String get placementCushionStackedPair =>
      'ଗୋଟିଏ କଭରକୁ ଅନ୍ୟର ଉପରେ ସୁନ୍ଦର ଭାବରେ ରଖନ୍ତୁ |';

  @override
  String get placementCushionPropped =>
      'ଆଗକୁ ମୁହଁ କରି ଏକ ଚେୟାର କିମ୍ବା ସୋଫାରେ କୁଶିକୁ ପ୍ରପୋଜ୍ କରନ୍ତୁ |';

  @override
  String get placementCushionCornerTuck =>
      'କଭରକୁ ବୁଲାନ୍ତୁ ତେଣୁ ଗୋଟିଏ ସିଲେଇ କୋଣ ଆପଣଙ୍କ ଆଡକୁ |';

  @override
  String get placementShawlDrapedShoulder =>
      'ଶା w ିକୁ ଗୋଟିଏ କାନ୍ଧ ଉପରେ ରଖ, ଏହାକୁ ଖସିଯିବାକୁ ଦିଅ |';

  @override
  String get placementShawlFoldedStack =>
      'ଶା aw ଼ୀକୁ ଏପରିକି ସ୍ତରରେ ଗୁଣ୍ଡ କରି ଭଲ ଭାବରେ ଷ୍ଟକ୍ କରନ୍ତୁ |';

  @override
  String get placementShawlHungFlat =>
      'ଉଭୟ ଉପର କୋଣକୁ ପିନ୍ କରନ୍ତୁ ତେଣୁ ଶା aw ୀ ବିନା ସାଙ୍ଗରେ hang ୁଲିବ |';

  @override
  String get placementShawlCornerTuck =>
      'ବୁଣାକାର ଉଭୟ ପାର୍ଶ୍ୱ ଦେଖାଇବାକୁ ଗୋଟିଏ କୋଣକୁ ପଛକୁ ଫୋଲ୍ କରନ୍ତୁ |';

  @override
  String get placementStoleNeckWrap =>
      'ଏହାକୁ ଦୁଇଥର hang ୁଲିବାକୁ ବେକରେ ଥରେ ଗୁଡ଼ାଇ ରଖନ୍ତୁ |';

  @override
  String get placementStoleFlatSpread =>
      'ଚୋରି ହୋଇଥିବା ଫ୍ଲାଟକୁ ବିସ୍ତାର କରନ୍ତୁ ତେଣୁ ଏହାର ସମ୍ପୂର୍ଣ୍ଣ ଲମ୍ବ ଦୃଶ୍ୟମାନ ହେବ |';

  @override
  String get placementStoleLooseKnot =>
      'ମ one ିରେ ଗୋଟିଏ ଖାଲି ଗଣ୍ଠି ବାନ୍ଧନ୍ତୁ - ଟାଣନ୍ତୁ ନାହିଁ |';

  @override
  String get placementStoleRolledCoil =>
      'ଚୋରିକୁ ଏକ ସମତଳ କୋଇଲିରେ ଖାଲି ଭାବରେ ଗଡ଼ |';

  @override
  String get transcriptSareePalluDrape1 =>
      'ଶାରୀରୀକୁ ଟାଙ୍ଗନ୍ତୁ ତେଣୁ ଏହାର ପତନ ସ୍ପଷ୍ଟ ଦେଖାଯାଏ |';

  @override
  String get transcriptSareePalluDrape2 =>
      'କାନ୍ଧର ଉଚ୍ଚତାରେ ଏକ ହ୍ୟାଙ୍ଗର, ବାଉଁଶ ପୋଲ କିମ୍ବା ମାନେକେନ୍ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get transcriptSareePalluDrape3 =>
      'ପାଲୁକୁ ମୁକ୍ତ ଭାବରେ hang ୁଲିବାକୁ ଦିଅନ୍ତୁ - ଏହାକୁ ସିଧା ଟାଣନ୍ତୁ ନାହିଁ |';

  @override
  String get transcriptSareePalluDrape4 =>
      'ଫୋଲ୍ଡଗୁଡ଼ିକୁ ତୁମର ସ୍କ୍ରିନରେ ଥିବା ତ୍ରିକୋଣୀୟ ରେଖା ଅନୁସରଣ କରିବାକୁ ଦିଅ |';

  @override
  String get transcriptSareePalluDrape5 =>
      'ଗୋଟିଏ ଆଲୋକ ଉତ୍ସକୁ ପାର୍ଶ୍ୱରେ ରଖନ୍ତୁ ତେଣୁ ଶେନ୍ ଦେଖାଏ |';

  @override
  String get transcriptSareeBoxFold1 =>
      'ସାରିକୁ ଏକ ସଫା ଷ୍ଟାକରେ ଫୋଲ୍ କରନ୍ତୁ ଯାହା ଦ୍ the ାରା ସ୍ତରଗୁଡିକ ଦୃଶ୍ୟମାନ ରହିବ |';

  @override
  String get transcriptSareeBoxFold2 =>
      'କ୍ୟାମେରା ଆଡକୁ ଫୋଲଡ୍ ଧାର ରଖନ୍ତୁ - ସେହି ଧାର ମୋଟା ଦେଖାଏ |';

  @override
  String get transcriptSareeBoxFold3 =>
      'ଭୂସମାନ୍ତର ଗାଇଡ୍ ସହିତ ଫୋଲ୍ଡଗୁଡ଼ିକୁ ଲାଇନ୍ କରନ୍ତୁ |';

  @override
  String get transcriptSareeBoxFold4 =>
      'ପାର୍ଶ୍ୱରୁ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ ତେଣୁ ପ୍ରତ୍ୟେକ ସ୍ତରର ଗଭୀରତା ଅଛି |';

  @override
  String get transcriptSareeWornDrape1 =>
      'ଏକ ପିନ୍ଧିଥିବା ଶଟଟି ପୁରା ସାର୍ - ରଙ୍ଗ, pattern ାଞ୍ଚା ଏବଂ ସାମଗ୍ରୀ ଦେଖାଏ |';

  @override
  String get transcriptSareeWornDrape2 =>
      'ଖୋଲା ଛାଇରେ ଛିଡା ହୁଅନ୍ତୁ ତେଣୁ ରଙ୍ଗ ସତ୍ୟ ରହିବ |';

  @override
  String get transcriptSareeWornDrape3 =>
      'ସାରୀକୁ ଫ୍ରେମର ଅଧିକାଂଶ ଅଂଶକୁ ଆଚ୍ଛାଦନ କରିବାକୁ ଦିଅ |';

  @override
  String get transcriptSareeWornDrape4 =>
      'ଗ୍ରୀଡର ଉପର ତୃତୀୟାଂଶ ସହିତ ଉପର ସୀମାକୁ ଲାଇନ୍ କରନ୍ତୁ |';

  @override
  String get transcriptSareeWornDrape5 =>
      'ଯଦି ପ୍ଲେଟ୍ ଅଛି, ଭୂଲମ୍ବ ଗ୍ରୀଡ୍ ରେଖା ଅନୁସରଣ କରନ୍ତୁ |';

  @override
  String get transcriptSareeRollDisplay1 =>
      'ସାରୀକୁ ଗଡ଼ନ୍ତୁ ତେଣୁ ପାଲୁ ଏବଂ ସୀମା କ୍ୟାମେରା ଆଡକୁ |';

  @override
  String get transcriptSareeRollDisplay2 =>
      'ରୋଲର ଅଧିକାଂଶ ଫ୍ରେମ୍ କୁ ଆଚ୍ଛାଦନ କର |';

  @override
  String get transcriptSareeRollDisplay3 =>
      'ଗ୍ରୀଡର ଉପର ତୃତୀୟାଂଶ ସହିତ ଉପର ସୀମାକୁ ଲାଇନ୍ କରନ୍ତୁ |';

  @override
  String get transcriptSareeRollDisplay4 =>
      'ନରମ ଦୀପାବଳି ବ୍ୟବହାର କରନ୍ତୁ ତେଣୁ ରଙ୍ଗ ସତ୍ୟ ରହିବ |';

  @override
  String get transcriptCushionFlatLay1 =>
      'ଏକ ସରଳ ପୃଷ୍ଠରେ କୁଶିଆ କଭରକୁ ସମତଳ ରଖନ୍ତୁ |';

  @override
  String get transcriptCushionFlatLay2 =>
      'ଏହାକୁ ମସୃଣ କରନ୍ତୁ କିନ୍ତୁ ପ୍ରାକୃତିକ ଗଠନକୁ ଦୃଶ୍ୟମାନ କରନ୍ତୁ |';

  @override
  String get transcriptCushionFlatLay3 =>
      'ଫୋନକୁ ସିଧାସଳଖ ଉପରେ ଧରି ରଖନ୍ତୁ, ଏକ କୋଣରେ ନୁହେଁ |';

  @override
  String get transcriptCushionFlatLay4 => 'ଗ୍ରୀଡ୍ ସହିତ ଧାରକୁ ସିଧା ରଖନ୍ତୁ |';

  @override
  String get transcriptCushionStackedPair1 =>
      'ଦୁଇଟି କଭର ଷ୍ଟକ୍ କରନ୍ତୁ ଯାହା ଦ୍ the ାରା କ୍ରେତା ଘନତା ଦେଖିପାରିବେ |';

  @override
  String get transcriptCushionStackedPair2 =>
      'ଷ୍ଟାକ୍ ହୋଇଥିବା ଧାରଗୁଡିକ କ୍ୟାମେରା ଆଡକୁ ରଖନ୍ତୁ |';

  @override
  String get transcriptCushionStackedPair3 =>
      'ପାର୍ଶ୍ୱ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ ତେଣୁ ପ୍ରତ୍ୟେକ ସ୍ତର ଏକ ନରମ ଛାୟା ଧାରଣ କରେ |';

  @override
  String get transcriptCushionPropped1 =>
      'କୁଶିକୁ ଏକ ଚେୟାରରେ ରଖିବା ଏହାର ପ୍ରକୃତ ଆକାର ଦେଖାଏ |';

  @override
  String get transcriptCushionPropped2 =>
      'ଏକ ସିଟ୍ ବାଛନ୍ତୁ ଯାହା pattern ାଞ୍ଚା ସହିତ ପ୍ରତିଦ୍ୱନ୍ଦ୍ୱିତା କରେ ନାହିଁ |';

  @override
  String get transcriptCushionPropped3 =>
      'ଉପର ସ୍ତରରେ ନୁହେଁ ଆଖି ସ୍ତରରେ ଗୁଳି କରନ୍ତୁ |';

  @override
  String get transcriptCushionCornerTuck1 =>
      'କୋଣାର୍କ ତୁମର ସିଲେଇକୁ ଅଧିକ ସ୍ପଷ୍ଟ ଭାବରେ ଦେଖାଏ |';

  @override
  String get transcriptCushionCornerTuck2 =>
      'କୋଣ ଛୋଟ ଫ୍ରେମ୍ ଭରିବା ପର୍ଯ୍ୟନ୍ତ ବନ୍ଦ କରନ୍ତୁ |';

  @override
  String get transcriptCushionCornerTuck3 =>
      'ଧ୍ୟାନ ଦେବା ପାଇଁ ସିଲେଇ ଉପରେ ସ୍କ୍ରିନ୍ ଟ୍ୟାପ୍ କରନ୍ତୁ |';

  @override
  String get transcriptShawlDrapedShoulder1 =>
      'ଶା aw ୀକୁ କାନ୍ଧରେ ଟାଣିବା ଦ୍ୱାରା ଏହା କେତେ ଭାରୀ ତାହା ଦର୍ଶାଏ |';

  @override
  String get transcriptShawlDrapedShoulder2 =>
      'ଗୋଟିଏ ମୁଣ୍ଡ ଅନ୍ୟ ମୁଣ୍ଡଠାରୁ କମ୍ hang ୁଲିବାକୁ ଦିଅ |';

  @override
  String get transcriptShawlDrapedShoulder3 =>
      'ଏହାକୁ ପିନ୍ କରନ୍ତୁ ନାହିଁ - କପଡାକୁ ନିଜେ ପଡ଼ିବାକୁ ଦିଅନ୍ତୁ |';

  @override
  String get transcriptShawlFoldedStack1 =>
      'ଦୃଶ୍ୟମାନ ହେଉଥିବା ଫୋଲ୍ଡଗୁଡ଼ିକ ସହିତ ଶା aw ିକୁ ସୁନ୍ଦର ଭାବରେ ଷ୍ଟକ୍ କରନ୍ତୁ |';

  @override
  String get transcriptShawlFoldedStack2 =>
      'ଭୂସମାନ୍ତର ରେଖା ସହିତ ସମାନ୍ତରାଳ ଭାବରେ ରଖନ୍ତୁ |';

  @override
  String get transcriptShawlFoldedStack3 =>
      'ନିଶ୍ଚିତ କରନ୍ତୁ ଯେ ଶାଲର ଧାର ମୋଟା ପାଇଁ ଦୃଶ୍ୟମାନ ହେଉଛି |';

  @override
  String get transcriptShawlFoldedStack4 =>
      'ପାର୍ଶ୍ୱ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ ତେଣୁ ପ୍ରତ୍ୟେକ ଫୋଲ୍ଡର ଗଭୀରତା ଅଛି |';

  @override
  String get transcriptShawlHungFlat1 =>
      'ଶାଲ ଫ୍ଲାଟକୁ ଟାଙ୍ଗିବା ଦ୍ୱାରା ସମଗ୍ର ଡିଜାଇନ୍ ଏକାସାଙ୍ଗରେ ଦେଖାଯାଏ |';

  @override
  String get transcriptShawlHungFlat2 =>
      'ଉଭୟ ଉପର କୋଣକୁ ପିନ୍ କରନ୍ତୁ ଯାହା ଦ୍ it ାରା ଏହା ମଧ୍ୟଭାଗରେ ସାଗ୍ ହୋଇନଥାଏ |';

  @override
  String get transcriptShawlHungFlat3 =>
      'ଗୋଟିଏ ପାର୍ଶ୍ୱରେ ନୁହେଁ, ସିଧା ସାମ୍ନାରେ ଛିଡା ହୁଅନ୍ତୁ |';

  @override
  String get transcriptShawlCornerTuck1 =>
      'କୋଣାର୍କର ଏକ କ୍ଲୋଜ ଅପ୍ ବୁଣା ଏବଂ ସୀମାକୁ ଏକତ୍ର ଦେଖାଏ |';

  @override
  String get transcriptShawlCornerTuck2 =>
      'ଗୋଟିଏ କୋଣକୁ ପଛକୁ ଫୋଲ୍ କରନ୍ତୁ ତେଣୁ ଉଭୟ ପାର୍ଶ୍ୱ ଦୃଶ୍ୟମାନ ହେବ |';

  @override
  String get transcriptShawlCornerTuck3 =>
      'ବୁଣା ଫ୍ରେମ୍ ଭରିବା ପର୍ଯ୍ୟନ୍ତ ବନ୍ଦ କରନ୍ତୁ |';

  @override
  String get transcriptStoleNeckWrap1 =>
      'ଏକ ପିନ୍ଧିଥିବା ଶଟ ସବୁଠାରୁ ସାଧାରଣ ପ୍ରଶ୍ନର ଉତ୍ତର ଦେଇଥାଏ - ଏହା କେତେ ବଡ଼?';

  @override
  String get transcriptStoleNeckWrap2 =>
      'ଏହାକୁ ଥରେ ବେକରେ ଗୁଡ଼ାଇ ଉଭୟ ମୁଣ୍ଡକୁ ଟାଙ୍ଗିବାକୁ ଦିଅ |';

  @override
  String get transcriptStoleNeckWrap3 =>
      'ଛାତିରୁ ଉପରକୁ ଗୁଳି କରନ୍ତୁ ତେଣୁ ଶେଷଗୁଡ଼ିକ ଫ୍ରେମରେ ରହିବ |';

  @override
  String get transcriptStoleFlatSpread1 =>
      'ଚୋରି ବିସ୍ତାର କରନ୍ତୁ ତେଣୁ ଏହାର ସମ୍ପୂର୍ଣ୍ଣ ଦ length ର୍ଘ୍ୟ ଦୃଶ୍ୟମାନ ହେବ |';

  @override
  String get transcriptStoleFlatSpread2 =>
      'ପ୍ରାକୃତିକ କ୍ରିଜ୍ ଛାଡିଦିଅ - କପଡା କ’ଣ ତାହା ସେମାନେ ଦେଖାନ୍ତି |';

  @override
  String get transcriptStoleFlatSpread3 =>
      'ଫୋନକୁ ସିଧାସଳଖ ମ middle ିରେ ରଖନ୍ତୁ |';

  @override
  String get transcriptStoleLooseKnot1 =>
      'ଚୋରି କେତେ ନରମ ଏବଂ ହାଲୁକା ତାହା ଏକ ଖାଲି ଗଣ୍ଠି ଦର୍ଶାଏ |';

  @override
  String get transcriptStoleLooseKnot2 =>
      'ଏହାକୁ ଖାଲି ଭାବରେ ବାନ୍ଧନ୍ତୁ - ଏହାକୁ କଦାପି ଟାଣନ୍ତୁ ନାହିଁ |';

  @override
  String get transcriptStoleLooseKnot3 => 'ଗଣ୍ଠିକୁ ଫ୍ରେମର ମ in ିରେ ରଖନ୍ତୁ |';

  @override
  String get transcriptStoleRolledCoil1 =>
      'ଚୋରିକୁ ଏକ କୋଇଲିରେ ଗଡ଼ାଇବା ଧାର ଏବଂ ଘନତା ଦେଖାଏ |';

  @override
  String get transcriptStoleRolledCoil2 =>
      'ଏହାକୁ ଖାଲି ଭାବରେ ଗଡ଼ନ୍ତୁ ତେଣୁ ସ୍ତରଗୁଡ଼ିକ ଅଲଗା ରୁହନ୍ତୁ |';

  @override
  String get transcriptStoleRolledCoil3 => 'ସିଧା କୋଇଲି ଉପରେ ଗୁଳି ଚଳାନ୍ତୁ |';

  @override
  String get guideSareeFullDisplay1 => 'ଶାରୀରୀ ଫ୍ରେମର ଅଧିକାଂଶ ଅଂଶକୁ ଆବୃତ କରେ |';

  @override
  String get guideSareeFullDisplay2 =>
      'ଉପର ସୀମା ଗ୍ରୀଡର ଉପର ତୃତୀୟାଂଶ ସହିତ ସମାନ୍ତରାଳ |';

  @override
  String get guideSareeFullDisplay3 =>
      'ଡ୍ରାପ୍ ହେବାବେଳେ, ଭର୍ଟିକାଲ୍ ଗ୍ରୀଡ୍ ସହିତ ସମାନ୍ତରାଳ |';

  @override
  String get guideSareeTextureWeave1 => 'ସାର୍ ଫ୍ରେମ୍ ଭରିଦିଏ |';

  @override
  String get guideSareeTextureWeave2 => 'ଟେକ୍ସଚର କେନ୍ଦ୍ରରେ ରହିଥାଏ |';

  @override
  String get guideSareeTextureWeave3 => 'କୋମଳ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get guideSareeTextureWeave4 => 'କଠୋର ପ୍ରତିଫଳନରୁ ଦୂରେଇ ରୁହନ୍ତୁ |';

  @override
  String get guideSareeEmbroideryBorder1 => 'ଏମ୍ବ୍ରୋଡେରୀ ଫ୍ରେମ୍ ଭିତରେ ରହିଥାଏ |';

  @override
  String get guideSareeEmbroideryBorder2 => 'ପାର୍ଶ୍ୱ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get guideSareeEmbroideryBorder3 =>
      'ସବିଶେଷ ତୀକ୍ଷ୍ଣ ଏବଂ ସୁସଜ୍ଜିତ ରଖନ୍ତୁ |';

  @override
  String get guideCushionTextureWeave1 => 'ବୁଣା ଫ୍ରେମ୍ ଭରିଦିଏ |';

  @override
  String get guideCushionTextureWeave2 => 'ଟେକ୍ସଚର କେନ୍ଦ୍ରରେ ରହିଥାଏ |';

  @override
  String get guideShawlFullDesign1 =>
      'ଶାଲ ଫ୍ଲାଟକୁ ଟାଙ୍ଗିବା ଦ୍ୱାରା ସମଗ୍ର ଡିଜାଇନ୍ ଏକାସାଙ୍ଗରେ ଦେଖାଯାଏ |';

  @override
  String get guideShawlFullDesign2 =>
      'ଉଭୟ ଉପର କୋଣକୁ ପିନ୍ କରନ୍ତୁ ଯାହା ଦ୍ it ାରା ଏହା ମଧ୍ୟଭାଗରେ ସାଗ୍ ହୋଇନଥାଏ |';

  @override
  String get guideShawlTextureWeave1 => 'ବୁଣା ଫ୍ରେମ୍ ଭରିଦିଏ |';

  @override
  String get guideShawlTextureWeave2 => 'ଟେକ୍ସଚର କେନ୍ଦ୍ରରେ ରହିଥାଏ |';

  @override
  String get guideStoleFullLength1 =>
      'ଚୋରି ବିସ୍ତାର କରନ୍ତୁ ତେଣୁ ଏହାର ସମ୍ପୂର୍ଣ୍ଣ ଦ length ର୍ଘ୍ୟ ଦୃଶ୍ୟମାନ ହେବ |';

  @override
  String get guideStoleFullLength2 =>
      'ପ୍ରାକୃତିକ କ୍ରିଜ୍ ଛାଡିଦିଅ - କପଡା କ’ଣ ତାହା ସେମାନେ ଦେଖାନ୍ତି |';

  @override
  String get guideStoleTextureWeave1 => 'ବୁଣା ଫ୍ରେମ୍ ଭରିଦିଏ |';

  @override
  String get guideStoleTextureWeave2 => 'ଟେକ୍ସଚର କେନ୍ଦ୍ରରେ ରହିଥାଏ |';

  @override
  String get authInvalidCredentials => 'ଭୁଲ ଉପଯୋଗକର୍ତ୍ତା ନାମ କିମ୍ବା ପାସୱାର୍ଡ |';

  @override
  String get authUserAlreadyRegistered =>
      'ସେହି ଉପଯୋଗକର୍ତ୍ତା ନାମ ପୂର୍ବରୁ ନିଆଯାଇଛି |';

  @override
  String get authEmailNotConfirmed =>
      'ଆପଣଙ୍କର ଇମେଲ୍ ନିଶ୍ଚିତ କରନ୍ତୁ, ତାପରେ ପୁନର୍ବାର ଚେଷ୍ଟା କରନ୍ତୁ |';

  @override
  String get authGeneric =>
      'ସାଇନ୍ ଇନ୍ କରିପାରିଲା ନାହିଁ | ପୁନର୍ବାର ଚେଷ୍ଟା କରନ୍ତୁ |';

  @override
  String get languageAssamese => 'ଆସାମୀୟ |';

  @override
  String get languageEnglish => 'English';

  @override
  String get guideSareeDrapedLook1 => 'କପଡାକୁ ସ୍ୱାଭାବିକ ଭାବରେ ପଡ଼ିବାକୁ ଦିଅ |';

  @override
  String get guideSareeDrapedLook2 => 'ଫୋଲ୍ଡଗୁଡ଼ିକ ତ୍ରିକୋଣୀୟ ଅନୁସରଣ କରନ୍ତି |';

  @override
  String get guideSareeDrapedLook3 => 'ପାର୍ଶ୍ୱ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get guideSareeEmbroideryBorder4 =>
      'ଏକ ବିପରୀତ ପୃଷ୍ଠଭୂମି ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get guideSareeFoldedStack1 =>
      'ଭୂସମାନ୍ତର ରେଖା ସହିତ ସମାନ୍ତରାଳ ଭାବରେ ରହିଥାଏ |';

  @override
  String get guideSareeFoldedStack2 => 'ପାର୍ଶ୍ୱ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get guideSareeFoldedStack3 => 'ଧାରକୁ ଦୃଶ୍ୟମାନ ରଖନ୍ତୁ |';

  @override
  String get guideCushionFullCover1 =>
      'କଭରକୁ ଫ୍ଲାଟ ରଖନ୍ତୁ ତେଣୁ ପୂର୍ଣ୍ଣ pattern ାଞ୍ଚା ଦୃଶ୍ୟମାନ ହେବ |';

  @override
  String get guideCushionFullCover2 =>
      'ଫୋନକୁ ସିଧାସଳଖ ଉପରେ ଧରି ରଖନ୍ତୁ, ଏକ କୋଣରେ ନୁହେଁ |';

  @override
  String get guideCushionFullCover3 => 'ଗ୍ରୀଡ୍ ସହିତ ଧାରକୁ ସିଧା ରଖନ୍ତୁ |';

  @override
  String get guideCushionTextureWeave3 => 'କୋମଳ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get guideCushionTextureWeave4 => 'କଠୋର ପ୍ରତିଫଳନରୁ ଦୂରେଇ ରୁହନ୍ତୁ |';

  @override
  String get guideCushionStackedThickness1 =>
      'ଦୁଇଟି କଭର ଷ୍ଟକ୍ କରନ୍ତୁ ଯାହା ଦ୍ the ାରା କ୍ରେତା ଘନତା ଦେଖିପାରିବେ |';

  @override
  String get guideCushionStackedThickness2 =>
      'ଷ୍ଟାକ୍ ହୋଇଥିବା ଧାରଗୁଡିକ କ୍ୟାମେରା ଆଡକୁ ରଖନ୍ତୁ |';

  @override
  String get guideCushionStackedThickness3 =>
      'ପାର୍ଶ୍ୱ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ ତେଣୁ ପ୍ରତ୍ୟେକ ସ୍ତର ଏକ ନରମ ଛାୟା ଧାରଣ କରେ |';

  @override
  String get guideCushionCornerStitching1 =>
      'କୋଣଟି ଅଧିକ ସ୍ପଷ୍ଟ ଭାବରେ ସିଲେଇ ଦେଖାଏ |';

  @override
  String get guideCushionCornerStitching2 =>
      'କୋଣ ଛୋଟ ଫ୍ରେମ୍ ଭରିବା ପର୍ଯ୍ୟନ୍ତ ବନ୍ଦ କରନ୍ତୁ |';

  @override
  String get guideCushionCornerStitching3 =>
      'ସିଲେଇକୁ ତୀକ୍ଷ୍ଣ ଏବଂ ସୁସଜ୍ଜିତ ରଖନ୍ତୁ |';

  @override
  String get guideCushionInUse1 =>
      'କୁଶିକୁ ଏକ ଚେୟାରରେ ରଖିବା ଏହାର ପ୍ରକୃତ ଆକାର ଦେଖାଏ |';

  @override
  String get guideCushionInUse2 =>
      'ଏକ ସିଟ୍ ବାଛନ୍ତୁ ଯାହା pattern ାଞ୍ଚା ସହିତ ପ୍ରତିଦ୍ୱନ୍ଦ୍ୱିତା କରେ ନାହିଁ |';

  @override
  String get guideCushionInUse3 => 'ଉପର ସ୍ତରରେ ନୁହେଁ ଆଖି ସ୍ତରରେ ଗୁଳି କରନ୍ତୁ |';

  @override
  String get guideShawlFullDesign3 =>
      'ଗୋଟିଏ ପାର୍ଶ୍ୱରେ ନୁହେଁ, ସିଧା ସାମ୍ନାରେ ଛିଡା ହୁଅନ୍ତୁ |';

  @override
  String get guideShawlTextureWeave3 => 'କୋମଳ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get guideShawlTextureWeave4 => 'କଠୋର ପ୍ରତିଫଳନରୁ ଦୂରେଇ ରୁହନ୍ତୁ |';

  @override
  String get guideShawlDrapedLook1 =>
      'ଶା aw ୀକୁ କାନ୍ଧରେ ଟାଣିବା ଦ୍ୱାରା ଏହା କେତେ ଭାରୀ ତାହା ଦର୍ଶାଏ |';

  @override
  String get guideShawlDrapedLook2 =>
      'ଗୋଟିଏ ମୁଣ୍ଡ ଅନ୍ୟ ମୁଣ୍ଡଠାରୁ କମ୍ hang ୁଲିବାକୁ ଦିଅ |';

  @override
  String get guideShawlDrapedLook3 =>
      'ଏହାକୁ ପିନ୍ କରନ୍ତୁ ନାହିଁ - କପଡାକୁ ନିଜେ ପଡ଼ିବାକୁ ଦିଅନ୍ତୁ |';

  @override
  String get guideShawlBorderCorner1 =>
      'କୋଣାର୍କର ଏକ କ୍ଲୋଜ ଅପ୍ ବୁଣା ଏବଂ ସୀମାକୁ ଏକତ୍ର ଦେଖାଏ |';

  @override
  String get guideShawlBorderCorner2 =>
      'ଗୋଟିଏ କୋଣକୁ ପଛକୁ ଫୋଲ୍ କରନ୍ତୁ ତେଣୁ ଉଭୟ ପାର୍ଶ୍ୱ ଦୃଶ୍ୟମାନ ହେବ |';

  @override
  String get guideShawlBorderCorner3 =>
      'ବୁଣା ଫ୍ରେମ୍ ଭରିବା ପର୍ଯ୍ୟନ୍ତ ବନ୍ଦ କରନ୍ତୁ |';

  @override
  String get guideShawlStackDisplay1 =>
      'ଦୃଶ୍ୟମାନ ହେଉଥିବା ଫୋଲ୍ଡଗୁଡ଼ିକ ସହିତ ଶା aw ିକୁ ସୁନ୍ଦର ଭାବରେ ଷ୍ଟକ୍ କରନ୍ତୁ |';

  @override
  String get guideShawlStackDisplay2 =>
      'ଭୂସମାନ୍ତର ରେଖା ସହିତ ସମାନ୍ତରାଳ ଭାବରେ ରଖନ୍ତୁ |';

  @override
  String get guideShawlStackDisplay3 =>
      'ପାର୍ଶ୍ୱ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ ତେଣୁ ପ୍ରତ୍ୟେକ ଫୋଲ୍ଡର ଗଭୀରତା ଅଛି |';

  @override
  String get guideStoleFullLength3 => 'ଫୋନକୁ ସିଧାସଳଖ ମ middle ିରେ ରଖନ୍ତୁ |';

  @override
  String get guideStoleTextureWeave3 => 'କୋମଳ ଆଲୋକ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get guideStoleTextureWeave4 => 'କଠୋର ପ୍ରତିଫଳନରୁ ଦୂରେଇ ରୁହନ୍ତୁ |';

  @override
  String get guideStoleWornNeckWrap1 =>
      'ଚୋରି ହୋଇଥିବା ଶଟ ଉତ୍ତର ଦେଇଥାଏ ଯେ ଚୋରି କେତେ ବଡ |';

  @override
  String get guideStoleWornNeckWrap2 =>
      'ଏହାକୁ ଥରେ ବେକରେ ଗୁଡ଼ାଇ ଉଭୟ ମୁଣ୍ଡକୁ ଟାଙ୍ଗିବାକୁ ଦିଅ |';

  @override
  String get guideStoleWornNeckWrap3 =>
      'ଛାତିରୁ ଉପରକୁ ଗୁଳି କରନ୍ତୁ ତେଣୁ ଶେଷଗୁଡ଼ିକ ଫ୍ରେମରେ ରହିବ |';

  @override
  String get guideStoleSoftnessKnot1 =>
      'ଚୋରି କେତେ ନରମ ଏବଂ ହାଲୁକା ତାହା ଏକ ଖାଲି ଗଣ୍ଠି ଦର୍ଶାଏ |';

  @override
  String get guideStoleSoftnessKnot2 =>
      'ଏହାକୁ ଖାଲି ଭାବରେ ବାନ୍ଧନ୍ତୁ - ଏହାକୁ କଦାପି ଟାଣନ୍ତୁ ନାହିଁ |';

  @override
  String get guideStoleSoftnessKnot3 => 'ଗଣ୍ଠିକୁ ଫ୍ରେମର ମ in ିରେ ରଖନ୍ତୁ |';

  @override
  String get guideStoleEdgeThickness1 =>
      'ଚୋରିକୁ ଏକ କୋଇଲିରେ ଗଡ଼ାଇବା ଧାର ଏବଂ ଘନତା ଦେଖାଏ |';

  @override
  String get guideStoleEdgeThickness2 =>
      'ଏହାକୁ ଖାଲି ଭାବରେ ଗଡ଼ନ୍ତୁ ତେଣୁ ସ୍ତରଗୁଡ଼ିକ ଅଲଗା ରୁହନ୍ତୁ |';

  @override
  String get guideStoleEdgeThickness3 => 'ସିଧା କୋଇଲି ଉପରେ ଗୁଳି ଚଳାନ୍ତୁ |';

  @override
  String get csNavLearn => 'ଶିଖନ୍ତୁ |';

  @override
  String get csNavPractice => 'ଅଭ୍ୟାସ';

  @override
  String get csNavProgress => 'ପ୍ରଗତି';

  @override
  String get csLearnerFallback => 'ଶିକ୍ଷାର୍ଥୀ';

  @override
  String get csClusterNotSelected => 'କ୍ଲଷ୍ଟର ଚୟନ ହୋଇନାହିଁ |';

  @override
  String get csAntaranLearningTool => 'ଆଣ୍ଟାରାନ୍ · ଶିକ୍ଷଣ ଉପକରଣ |';

  @override
  String get csWorksOffline => 'କାର୍ଯ୍ୟ ଅଫଲାଇନ୍ |';

  @override
  String get csClickAndSocial => 'କ୍ଲିକ୍ &\nସାମାଜିକ |';

  @override
  String get csClickAndSocialInline => 'କ୍ଲିକ୍ ଏବଂ ସାମାଜିକ |';

  @override
  String get csOnboardingTagline =>
      'ତୁମର ଶିଳ୍ପକୁ ଫଟୋଗ୍ରାଫ୍ କର | ଏହାର କାହାଣୀ କୁହ | ଏହାକୁ ଅନଲାଇନରେ ବିକ୍ରି କରନ୍ତୁ - ଏହି ଫୋନରୁ |';

  @override
  String get csStepYourName => 'ତୁମର ନାମ';

  @override
  String get csNameHint => 'Type your name';

  @override
  String get csStepYourLanguage => 'ତୁମର ଭାଷା';

  @override
  String csLanguageChip(String label, String code) {
    return '$label ($code)';
  }

  @override
  String get csStepYourCluster => 'ତୁମର କ୍ଲଷ୍ଟର - ଯେଉଁଠାରେ ତୁମେ କାମ କର |';

  @override
  String get csClusterHint =>
      'ଥରେ ମନୋନୀତ | ତୁମର ପାଠ୍ୟ, କାହାଣୀ ଏବଂ ହ୍ୟାସଟ୍ୟାଗଗୁଡ଼ିକ ଏଥିରେ ସଜାଯାଇଛି |';

  @override
  String get csSelected => 'ମନୋନୀତ |';

  @override
  String get csPick => 'PICK';

  @override
  String get csStartLearning => 'ଶିକ୍ଷା ଆରମ୍ଭ କରନ୍ତୁ |';

  @override
  String get csOfflineReady => 'ଅଫଲାଇନ୍ ପ୍ରସ୍ତୁତ |';

  @override
  String csHelloName(String name) {
    return 'ନମସ୍କାର, $name';
  }

  @override
  String get csChange => 'ପରିବର୍ତ୍ତନ';

  @override
  String csLessonsDone(int done) {
    return '5 ଟି ପାଠ୍ୟର $done ସମାପ୍ତ |';
  }

  @override
  String get csLesson01Title => 'ଫଟୋଗ୍ରାଫି';

  @override
  String get csLesson01Subtitle =>
      'ଉତ୍ପାଦ · ସାମଗ୍ରୀ · କ୍ଲଷ୍ଟର · ଫ୍ରେମ୍ · ଆଲୋକ |';

  @override
  String get csLesson02Title => 'ଇନଷ୍ଟାଗ୍ରାମରେ ତୁମର ପୃଷ୍ଠା ସେଟ୍ ଅପ୍ କର |';

  @override
  String get csLesson02Subtitle => 'ନାମ · ବାୟୋ · ବୃତ୍ତିଗତ ଖାତା |';

  @override
  String get csLesson03Title => 'ଏକ ପୋଷ୍ଟ ସୃଷ୍ଟି କରନ୍ତୁ |';

  @override
  String get csLesson03Subtitle => 'କାହାଣୀ · ହ୍ୟାସଟ୍ୟାଗ୍ · ପ୍ରକାଶନ |';

  @override
  String get csLesson04Title => 'ପୋଷ୍ଟିଂ ଯୋଜନା';

  @override
  String get csLesson04Subtitle => 'କେତେବେଳେ ପୋଷ୍ଟ କରିବେ · ସାପ୍ତାହିକ ଗୀତ |';

  @override
  String get csLesson05Title => 'ସଂଖ୍ୟାଗୁଡିକ ପ Read ନ୍ତୁ |';

  @override
  String get csLesson05Subtitle => 'କ’ଣ କାମ କଲା ଏବଂ କାହିଁକି?';

  @override
  String get csLesson01Overline => 'ଶିକ୍ଷା 01';

  @override
  String get csLesson02Overline => 'ପାଠ 02';

  @override
  String get csLesson03Overline => 'ପାଠ 03';

  @override
  String get csLesson04Overline => 'ପାଠ 04';

  @override
  String get csLesson05Overline => 'ଶିକ୍ଷା 05';

  @override
  String csStepOfTotal(int step, int total) {
    return '$step / $total';
  }

  @override
  String get csPickYourUsername => 'ଆପଣଙ୍କର ଉପଯୋଗକର୍ତ୍ତା ନାମ ବାଛନ୍ତୁ |';

  @override
  String get csUsernameHint =>
      'ସଂକ୍ଷିପ୍ତ ଏଥିରେ ତୁମର ଶିଳ୍ପ ଉଚ୍ଚ ସ୍ୱରରେ କହିବା ସହଜ |';

  @override
  String get csNextEditProfile => 'ପରବର୍ତ୍ତୀ - ପ୍ରୋଫାଇଲ୍ ସଂପାଦନ କରନ୍ତୁ |';

  @override
  String get csEditProfileIntroBefore => 'ଏହା ହେଉଛି';

  @override
  String get csEditProfileIntroBold => 'ପ୍ରୋଫାଇଲ୍ ସଂପାଦନ କରନ୍ତୁ |';

  @override
  String get csEditProfileIntroAfter => 'ସ୍କ୍ରିନ୍ ପ୍ରତ୍ୟେକ ଧାଡି ପୁରଣ କରନ୍ତୁ |';

  @override
  String get csChangePhotoTip =>
      'ଫଟୋ ପରିବର୍ତ୍ତନ କରନ୍ତୁ - ସୂର୍ଯ୍ୟୋଦୟ ନୁହେଁ, ଆପଣଙ୍କର ଉତ୍ପାଦ ବ୍ୟବହାର କରନ୍ତୁ |';

  @override
  String get csFieldName => 'ନାମ';

  @override
  String get csFieldUsername => 'ଉପଯୋଗକର୍ତ୍ତା ନାମ';

  @override
  String get csFieldBio => 'ବାୟୋ |';

  @override
  String get csBioPlaceholder =>
      'ଏହାକୁ ନିର୍ମାଣ କରିବା ପାଇଁ ନିମ୍ନରେ ରେଖା ଟ୍ୟାପ୍ କରନ୍ତୁ…';

  @override
  String get csBioLinesPrompt =>
      'ବାୟୋ ଲାଇନ୍ - ଅତିକମରେ 2 ବାଛନ୍ତୁ (ସ୍ଥାନ + ଶିଳ୍ପ + କିପରି କିଣିବେ)';

  @override
  String get csNextGoProfessional => 'ପରବର୍ତ୍ତୀ - ପ୍ରଫେସନାଲ୍ ଯାଆନ୍ତୁ |';

  @override
  String get csSettingsPrompt =>
      'ଆପରେ, ସେଟିଂସମୂହ ଖୋଲନ୍ତୁ | ଧାଡି ଖୋଜ ଯାହାକି ଏକ ବୃତ୍ତିଗତ ଆକାଉଣ୍ଟକୁ ଯାଏ - ଲାଲ୍ ବିନ୍ଦୁ ଅନୁସରଣ କର |';

  @override
  String get csSettingsPromptAlmost => 'ପ୍ରାୟ ସେଠାରେ - ଆଉ ଗୋଟିଏ ଟ୍ୟାପ୍ |';

  @override
  String get csSettingsTitle => 'ସେଟିଂସମୂହ';

  @override
  String get csAccountTypeAndTools => 'ଖାତା ପ୍ରକାର ଏବଂ ଉପକରଣଗୁଡ଼ିକ |';

  @override
  String get csSettingsNotifications => 'ବିଜ୍ଞପ୍ତିଗୁଡିକ';

  @override
  String get csSettingsNotificationsSub => 'ପସନ୍ଦ, ମନ୍ତବ୍ୟ, ବାର୍ତ୍ତା |';

  @override
  String get csSettingsPrivacy => 'ଗୋପନୀୟତା';

  @override
  String get csSettingsPrivacySub =>
      'ବ୍ୟକ୍ତିଗତ ଆକାଉଣ୍ଟ୍, ଲୋକଙ୍କୁ ଅବରୋଧ କରିଥିଲେ |';

  @override
  String get csSettingsAccountTypeSub => 'ଏକ ବୃତ୍ତିଗତ ଖାତାକୁ ଯାଆନ୍ତୁ |';

  @override
  String get csSettingsHelp => 'ସାହାଯ୍ୟ';

  @override
  String get csSettingsHelpSub => 'ଏକ ସମସ୍ୟା ରିପୋର୍ଟ କରନ୍ତୁ |';

  @override
  String get csSettingsSwitchProfessional =>
      'ବୃତ୍ତିଗତ ଆକାଉଣ୍ଟକୁ ସୁଇଚ୍ କରନ୍ତୁ |';

  @override
  String get csSettingsSwitchProfessionalSub =>
      'ମାଗଣା - ସୃଷ୍ଟିକର୍ତ୍ତା ଏବଂ ବ୍ୟବସାୟ ପାଇଁ |';

  @override
  String get csSettingsDeleteAccount => 'ଖାତା ବିଲୋପ କରନ୍ତୁ |';

  @override
  String get csSettingsDeleteAccountSub => 'ଆପଣଙ୍କର ଖାତା ଅପସାରଣ କରନ୍ତୁ |';

  @override
  String get csSettingsPersonalInfo => 'ବ୍ୟକ୍ତିଗତ ସୂଚନା';

  @override
  String get csSettingsPersonalInfoSub => 'ଜନ୍ମଦିନ, ଇମେଲ୍ |';

  @override
  String get csSettingsWrongPick => 'ତାହା ନୁହେଁ - ଲାଲ୍ ବିନ୍ଦୁ ଅନୁସରଣ କରନ୍ତୁ |';

  @override
  String get csCategoryIntroBefore => 'ଶେଷ ପଦକ୍ଷେପ -';

  @override
  String get csCategoryIntroBold => 'ତୁମେ କଣ?';

  @override
  String get csCategoryIntroAfter => 'ବର୍ଗର କ୍ରେତାମାନେ ଦେଖିବେ ବାଛନ୍ତୁ |';

  @override
  String get csCategoryArtist => 'କଳାକାର';

  @override
  String get csCategoryShoppingRetail => 'ସପିଂ ଏବଂ ଖୁଚୁରା |';

  @override
  String get csCategoryLocalBusiness => 'ସ୍ଥାନୀୟ ବ୍ୟବସାୟ |';

  @override
  String get csCategoryEntrepreneur => 'ଉଦ୍ୟୋଗୀ';

  @override
  String get csProAccountNote1 => 'ଏକ ବୃତ୍ତିଗତ ଖାତା ମାଗଣା | ଏହା ଅନଲକ୍ କରେ |';

  @override
  String get csProAccountInsights => 'ଅନ୍ତର୍ଦୃଷ୍ଟି |';

  @override
  String get csProAccountNote2 => '(କିଏ ତୁମର ପୋଷ୍ଟଗୁଡିକ ଦେଖେ - ଶିକ୍ଷା 05), a';

  @override
  String get csProAccountContactButton => 'ଯୋଗାଯୋଗ ବଟନ୍';

  @override
  String get csProAccountNote3 => ', ଏବଂ';

  @override
  String get csProAccountAds => 'ବିଜ୍ଞାପନଗୁଡିକ |';

  @override
  String get csProAccountNote4 => 'ପରେ';

  @override
  String get csSwitchToProfessional => 'ପ୍ରଫେସନାଲ୍ କୁ ସ୍ୱିଚ୍ କରନ୍ତୁ |';

  @override
  String get csPreviewIntro =>
      'ସମାପ୍ତ ଏହିପରି କ୍ରେତାମାନେ ଆପଣଙ୍କର ପୃଷ୍ଠା ଦେଖିବେ:';

  @override
  String get csPostsFollowers => '0 ପୋଷ୍ଟ 0 ଅନୁସରଣକାରୀ |';

  @override
  String get csFollow => 'ଅନୁସରଣ କରନ୍ତୁ |';

  @override
  String get csMessage => 'ବାର୍ତ୍ତା |';

  @override
  String get csProfessionalAccount => 'ପ୍ରଫେସନାଲ୍ ଆକାଉଣ୍ଟ୍ |';

  @override
  String get csPickANameFallback => 'pick_a_name';

  @override
  String get csCraftFallback => 'ହସ୍ତଶିଳ୍ପ';

  @override
  String get csBioFallbackHandloomWeaver => 'ହ୍ୟାଣ୍ଡଲୁମ୍ ବୁଣାକାର |';

  @override
  String get csBioFallbackDmToOrder => 'ଅର୍ଡର କରିବାକୁ DM |';

  @override
  String get csBioFallbackMadeByHand => 'ହାତରେ ତିଆରି |';

  @override
  String get csFormatPost => 'ପୋଷ୍ଟ';

  @override
  String get csFormatStory => 'କାହାଣୀ';

  @override
  String get csFormatReel => 'REEL';

  @override
  String get csPhotoPlaceholder =>
      'ପାଠ୍ୟ 01 ରୁ ଆପଣଙ୍କର ଫଟୋ - କିମ୍ବା ଏକ ଫଟୋ କିମ୍ବା ଭିଡିଓ ଡ୍ରପ୍ କରନ୍ତୁ |';

  @override
  String get csExampleKotpad =>
      'ଉଦାହରଣ: ଏକ କୋଟପ୍ୟାଡ୍ ପୋଷ୍ଟ - ଫଟୋ ବନ୍ଦ, ତା’ପରେ ଶିଳ୍ପ ଏବଂ ଏହାର ବୁଣାକାରଙ୍କ ନାମ ଦୁଇଟି ରେଖା |';

  @override
  String get csAddYourStory => 'ଆପଣଙ୍କର କାହାଣୀ ଯୋଡନ୍ତୁ - ରେଖା ଟ୍ୟାପ୍ କରନ୍ତୁ |';

  @override
  String get csHashtagsPick => 'ହ୍ୟାସଟ୍ୟାଗ୍ - to ରୁ pick ବାଛନ୍ତୁ |';

  @override
  String csHashtagCount(int count) {
    return '__$count __ / 5';
  }

  @override
  String csHashtagCountFull(int count) {
    return '__$count __ / 5 - ପାଞ୍ଚଟି ଯଥେଷ୍ଟ |';
  }

  @override
  String get csCaptionPreview => 'କ୍ୟାପସନ୍ ପୂର୍ବାବଲୋକନ |';

  @override
  String get csCaptionPlaceholder =>
      'ଆପଣଙ୍କର କ୍ୟାପସନ୍ ଲେଖିବାକୁ ଉପରୋକ୍ତ କାହାଣୀ ରେଖା ଟ୍ୟାପ୍ କରନ୍ତୁ |';

  @override
  String get csPostToPracticeFeed => 'ଅଭ୍ୟାସ ଫିଡ୍ ପାଇଁ ପୋଷ୍ଟ |';

  @override
  String get csPracticeFeedOnly =>
      'କେବଳ ଫିଡ୍ ଅଭ୍ୟାସ କର - କିଛି ଆପଣଙ୍କ ଫୋନ ଛାଡିବ ନାହିଁ |';

  @override
  String get csStoryFallbackHeritage => 'ମୋ ଗାଁରେ ହାତରେ ତିଆରି |';

  @override
  String get csStoryFallbackMaterial =>
      'ପ୍ରାକୃତିକ ଫାଇବର, ଯତ୍ନର ସହିତ ରଙ୍ଗ କରାଯାଏ |';

  @override
  String get csStoryFallbackProcess =>
      'ଏକ ହୋମ୍ ଲୁମ୍ରେ ବୁଣା ହୋଇଛି, ମୋଟିଫ୍ ଦ୍ୱାରା ମୋଟିଫ୍ |';

  @override
  String get csTagFallback0 => '# ହାତ';

  @override
  String get csTagFallback1 => '#vocalforlocal';

  @override
  String get csTagFallback2 => '#craftindia';

  @override
  String get csTagFallback3 => '# ମେଡେନିଣ୍ଡିଆ |';

  @override
  String get csTagFallback4 => '# ହ୍ୟାଣ୍ଡଲୁମ୍ |';

  @override
  String get csWhenDoBuyersScroll => 'କ୍ରେତାମାନେ କେବେ ସ୍କ୍ରୋଲ୍ କରନ୍ତି?';

  @override
  String get csTimeMorning => '6–9 ସକାଳେ |';

  @override
  String get csTimeNight => 'ରାତିରେ 7-10';

  @override
  String get csTimeAfternoon => '2 ଅପରାହ୍ନରେ |';

  @override
  String get csTimeCorrectMsg =>
      'ହଁ - ସନ୍ଧ୍ୟା, ଯେତେବେଳେ ଦିନର କାମ ସରିଯାଏ, ଯେତେବେଳେ ଲୋକମାନେ ସ୍କ୍ରୋଲ୍ କରି ଦୋକାନ କରନ୍ତି |';

  @override
  String get csTimeWrongMsg =>
      'ଲୋକମାନେ ସେତେବେଳେ କାମ କରୁଛନ୍ତି | ଦିନ ସରିବା ପରେ ଚେଷ୍ଟା କରନ୍ତୁ |';

  @override
  String get csPlanYourWeek => 'ଆପଣଙ୍କର ସପ୍ତାହ ଯୋଜନା କରନ୍ତୁ - 3 ଦିନ ବାଛନ୍ତୁ |';

  @override
  String get csSpreadThemOut =>
      'ସେଗୁଡିକୁ ବିସ୍ତାର କର | କ୍ରେତାମାନେ ଆପଣଙ୍କୁ ସପ୍ତାହସାରା ଦେଖିବା ଉଚିତ୍ |';

  @override
  String get csDayMon => 'ମି';

  @override
  String get csDayTue => 'ଟି';

  @override
  String get csDayWed => 'W।';

  @override
  String get csDayThu => 'ଟି';

  @override
  String get csDayFri => 'F।';

  @override
  String get csDaySat => 'S।';

  @override
  String get csDaySun => 'S।';

  @override
  String get csGoodRhythm => 'ଭଲ ଲୀଳା - ତିନିଟି ପୋଷ୍ଟ, ସପ୍ତାହରେ ବ୍ୟାପିଥାଏ |';

  @override
  String get csThreePostsOneWinner => 'ତିନୋଟି ପୋଷ୍ଟ | ଜଣେ ବିଜେତା |';

  @override
  String get csReachExplainer =>
      'ପହଞ୍ଚ = କେତେ ଲୋକ ଏହା ଦେଖିଲେ | ସର୍ବୋତ୍ତମ ପୋଷ୍ଟ ଟ୍ୟାପ୍ କରନ୍ତୁ |';

  @override
  String get csResultPhotoOnly => 'କେବଳ ଫଟୋ |';

  @override
  String get csResultPhotoStory => 'ଫଟୋ + କାହାଣୀ କ୍ୟାପସନ୍ |';

  @override
  String get csResultPhotoStoryTags => 'ଫଟୋ + କାହାଣୀ + ହ୍ୟାସଟ୍ୟାଗ୍ |';

  @override
  String get csBestCorrectMsg =>
      'ଠିକ୍ - ଏକ ଫଟୋ ପ୍ଲସ୍ ହ୍ୟାସଟ୍ୟାଗ୍ କେବଳ ଫଟୋ ଅପେକ୍ଷା 10 × ଅଧିକ ଲୋକଙ୍କ ପାଖରେ ପହଞ୍ଚିଛି |';

  @override
  String get csBestWrongMsg => 'ପୁନର୍ବାର ଦେଖନ୍ତୁ - କେଉଁ ଦଣ୍ଡଟି ଲମ୍ବା?';

  @override
  String get csYourWeekReached => 'ଆପଣଙ୍କର ସପ୍ତାହ - ଲୋକମାନେ ପହଞ୍ଚିଛନ୍ତି |';

  @override
  String get csTallBarsNote =>
      'ଲମ୍ବା ବାର୍ ଗୁଡିକ ତୁମର ପୋଷ୍ଟିଂ ଦିନ | ତୁମର ଯୋଜନାରେ ପୋଷ୍ଟ କର - ନିମ୍ନରେ ପହଞ୍ଚ |';

  @override
  String get csPracticeFeed => 'ଅଭ୍ୟାସ ଫିଡ୍ |';

  @override
  String get csStaysOnYourPhone => 'ଆପଣଙ୍କ ଫୋନରେ ରୁହନ୍ତୁ |';

  @override
  String get csFeedTimeNow => 'ବର୍ତ୍ତମାନ';

  @override
  String get csFeedSampleTime1 => '2 d';

  @override
  String get csFeedSampleTime2 => '5 d';

  @override
  String get csFeedYourPhotoPlaceholder => 'ପାଠ୍ୟରୁ ଆପଣଙ୍କର ଫଟୋ |';

  @override
  String get csFeedSamplePlaceholder => 'ଏକ ନମୁନା ଫଟୋ ଡ୍ରପ୍ କରନ୍ତୁ |';

  @override
  String get csFeedSampleUser1 => 'maya_ikat';

  @override
  String get csFeedSampleUser2 => 'looms_of_naga';

  @override
  String get csFeedSampleCaption1 =>
      'ଦୁଇଥର ଇକାଟ, ବୁଣା ପୂର୍ବରୁ ହାତରେ ବନ୍ଧା ଏବଂ ରଙ୍ଗ କରାଯାଏ |';

  @override
  String get csFeedSampleTags1 => '#ikat #odishahandloom #handwoven';

  @override
  String get csFeedSampleCaption2 =>
      'ଲୋନ୍ ଲୁମ୍ ଶାଲ୍ - ପ୍ରତ୍ୟେକ ଷ୍ଟ୍ରାଇପ୍ ଏକ ଅର୍ଥ ବହନ କରେ |';

  @override
  String get csFeedSampleTags2 => '# ନାଗାଶାଲ୍ # ଲୋନ୍ଲୁମ୍ # ହ୍ୟାଣ୍ଡୱୋଭେନ୍ |';

  @override
  String get csFeedCommentUser1 => 'buyer_priya';

  @override
  String get csFeedCommentUser2 => 'craft.lover';

  @override
  String get csFeedCommentBuyer => 'ସୁନ୍ଦର! ମୂଲ୍ୟ ଦୟାକରି?';

  @override
  String get csFeedCommentCraftLover => 'ଚମତ୍କାର କାମ!';

  @override
  String get csFeedTapHeart =>
      'କ୍ରେତାମାନେ କିପରି ପ୍ରତିକ୍ରିୟା କରନ୍ତି ଦେଖିବା ପାଇଁ ହୃଦୟକୁ ଟ୍ୟାପ୍ କରନ୍ତୁ |';

  @override
  String get csYourProgress => 'ତୁମର ଅଗ୍ରଗତି';

  @override
  String get csBadgesOfFive => '/ 5 ବ୍ୟାଜ୍';

  @override
  String get csBadgePhotographer => 'ଫଟୋଗ୍ରାଫର';

  @override
  String get csBadgePageBuilder => 'ପୃଷ୍ଠା ନିର୍ମାଣକାରୀ |';

  @override
  String get csBadgeStoryteller => 'କାହାଣୀକାର';

  @override
  String get csBadgePlanner => 'ଯୋଜନାକାରୀ |';

  @override
  String get csBadgeAnalyst => 'ବିଶ୍ଳେଷକ |';

  @override
  String get csBadgeEarned => 'କର୍ଣ୍ଣ';

  @override
  String get csBadgeLocked => 'ଲକ୍ ହୋଇଛି |';

  @override
  String get csEditNameLanguageCluster =>
      'ନାମ, ଭାଷା କିମ୍ବା କ୍ଲଷ୍ଟର ସଂପାଦନ କରନ୍ତୁ |';

  @override
  String get csAccountCloudBackup => 'ଆକାଉଣ୍ଟ୍ ଏବଂ କ୍ଲାଉଡ୍ ବ୍ୟାକ୍ଅପ୍ |';

  @override
  String get csStartOverClearProgress =>
      'ଆରମ୍ଭ କରନ୍ତୁ - ସମସ୍ତ ପ୍ରୋଗ୍ରାମ୍ ସଫା କରନ୍ତୁ |';

  @override
  String get csStartOverTitle => 'ଆରମ୍ଭ କରିବେ?';

  @override
  String get csStartOverBody =>
      'ଏହା ଏହି ଫୋନରେ ପାଠ୍ୟ ବ୍ୟାଜ୍ ଏବଂ ଅଭ୍ୟାସ ପୋଷ୍ଟଗୁଡିକ ସଫା କରେ | ଆପଣ ପୂର୍ବରୁ ନେଇଥିବା ଫଟୋ ସ୍ଥାନୀୟ ଷ୍ଟୋରେଜ୍ ରେ ରହିଲେ |';

  @override
  String get csCancel => 'ବାତିଲ୍';

  @override
  String get csClear => 'ସଫା କର |';

  @override
  String get csStoryKickerHeritage => 'ଉତ୍ତରାଧିକାରୀ';

  @override
  String get csStoryKickerMaterial => 'ସାମଗ୍ରୀ';

  @override
  String get csStoryKickerProcess => 'ପ୍ରୋସେସ୍';

  @override
  String get csClusterAssamFabric => 'ମେକେଲା ସାଦୋର - ମୁଗା ଏବଂ ଏରି ରେଶମ |';

  @override
  String get csClusterAssamShortName => 'ମେକେଲା ସାଦୋର |';

  @override
  String get csClusterAssamPlace => 'କାମ୍ରୁପ୍ ଏବଂ ନାଲବାରୀ, ଆସାମ |';

  @override
  String get csClusterAssamBio0 => 'ହ୍ୟାଣ୍ଡଲୁମ୍ ବୁଣାକାର |';

  @override
  String get csClusterAssamBio1 => 'କାମ୍ରୁପ, ଆସାମ |';

  @override
  String get csClusterAssamBio2 => 'ମେକେଲା ସାଦୋର ଏବଂ ଚୋରି |';

  @override
  String get csClusterAssamBio3 => 'ଅର୍ଡର କରିବାକୁ DM |';

  @override
  String get csClusterAssamBio4 => 'ତୃତୀୟ ପି generation ି ବୁଣାକାର |';

  @override
  String get csClusterAssamStoryHeritage => 'ମୁଗା - ସୁନା ରେଶମ କେବଳ ଆସାମ ବ .େ |';

  @override
  String get csClusterAssamStoryMaterial =>
      'ହ୍ୟାଣ୍ଡସପନ୍ ଏରି - ଶା aw ୀ ପରି ନରମ, ପଶମ ପରି ଉଷ୍ମ |';

  @override
  String get csClusterAssamStoryProcess =>
      'ଘରେ ବୁଣା, ଲୁମ୍ ଉପରେ ସପ୍ତାହ, ମୋଟିଫ୍ ଦ୍ୱାରା ମୋଟିଫ୍ |';

  @override
  String get csClusterAssamTag0 => '#mekhelachador';

  @override
  String get csClusterAssamTag1 => '# ମୁଗାସିଲ୍କ |';

  @override
  String get csClusterAssamTag2 => '#erisilk';

  @override
  String get csClusterAssamTag3 => '#assamhandloom';

  @override
  String get csClusterAssamTag4 => '# ହାତ';

  @override
  String get csClusterAssamTag5 => '#vocalforlocal';

  @override
  String get csClusterAssamTag6 => '# ସିଲକ୍ସୋଫିଣ୍ଡିଆ |';

  @override
  String get csClusterAssamTag7 => '# ଓଭରସୋଫିଣ୍ଡିଆ |';

  @override
  String get csClusterSrikalahastiFabric => 'କଲାମକାରି - ହାତରେ ଚିତ୍ରିତ ସୂତା |';

  @override
  String get csClusterSrikalahastiShortName => 'କଲାମକାରି |';

  @override
  String get csClusterSrikalahastiPlace => 'ଶ୍ରୀକାଲାହାଷ୍ଟୀ, ଆନ୍ଧ୍ରପ୍ରଦେଶ |';

  @override
  String get csClusterSrikalahastiBio0 => 'କଲାମକାରି କଳାକାର |';

  @override
  String get csClusterSrikalahastiBio1 => 'ଶ୍ରୀକାଲାହାଷ୍ଟୀ, ଆନ୍ଧ୍ରପ୍ରଦେଶ |';

  @override
  String get csClusterSrikalahastiBio2 => 'ହାତରେ ଚିତ୍ରିତ ପ୍ୟାନେଲ୍ ଏବଂ ସାରିସ୍ |';

  @override
  String get csClusterSrikalahastiBio3 => 'ଅର୍ଡର କରିବାକୁ DM |';

  @override
  String get csClusterSrikalahastiBio4 => 'ମନ୍ଦିର-କଳା ପରିବାର |';

  @override
  String get csClusterSrikalahastiStoryHeritage =>
      'ଏକ ବାଉଁଶ କଲାମ ସହିତ ଅଙ୍କିତ ମନ୍ଦିର କାହାଣୀ |';

  @override
  String get csClusterSrikalahastiStoryMaterial =>
      'କପା ଏବଂ ପ୍ରାକୃତିକ ରଙ୍ଗ - ମାଇରୋବାଲାନ୍, ଲୁହା, ଆଲୁମ୍ |';

  @override
  String get csClusterSrikalahastiStoryProcess =>
      'ରେଖା ଦ୍ୱାରା ଅଙ୍କିତ ରେଖା - ଦୁଇଟି ଖଣ୍ଡ ସମାନ ନୁହେଁ |';

  @override
  String get csClusterSrikalahastiTag0 => '# କାଲାମକରୀ |';

  @override
  String get csClusterSrikalahastiTag1 => '#srikalahasti';

  @override
  String get csClusterSrikalahastiTag2 => '#naturaldyes';

  @override
  String get csClusterSrikalahastiTag3 => '# ଚିତ୍ରିତ |';

  @override
  String get csClusterSrikalahastiTag4 => '#craftindia';

  @override
  String get csClusterSrikalahastiTag5 => '#vocalforlocal';

  @override
  String get csClusterSrikalahastiTag6 => '#textileart';

  @override
  String get csClusterSrikalahastiTag7 => '# ମେଡେନିଣ୍ଡିଆ |';

  @override
  String get csClusterVenkatgiriFabric =>
      'ଭେଙ୍କଟଗିରି ସାରୀ - ସୂକ୍ଷ୍ମ ସୂତା ଏବଂ ଜରି |';

  @override
  String get csClusterVenkatgiriShortName => 'ଭେଙ୍କଟଗିରି ଶାରୀରୀ |';

  @override
  String get csClusterVenkatgiriPlace => 'ଭେଙ୍କଟଗିରି, ଆନ୍ଧ୍ରପ୍ରଦେଶ |';

  @override
  String get csClusterVenkatgiriBio0 => 'ହ୍ୟାଣ୍ଡଲୁମ୍ ବୁଣାକାର |';

  @override
  String get csClusterVenkatgiriBio1 => 'ଭେଙ୍କଟଗିରି, ଆନ୍ଧ୍ରପ୍ରଦେଶ |';

  @override
  String get csClusterVenkatgiriBio2 => 'ସୂକ୍ଷ୍ମ ସୂତା ଏବଂ ଜରି ସାରି |';

  @override
  String get csClusterVenkatgiriBio3 => 'ଅର୍ଡର କରିବାକୁ DM |';

  @override
  String get csClusterVenkatgiriBio4 => '1970 ରୁ ବୁଣା ପରିବାର |';

  @override
  String get csClusterVenkatgiriStoryHeritage =>
      'ଥରେ ଭେଙ୍କଟାଗିରି କୋର୍ଟ ପାଇଁ ବୁଣା |';

  @override
  String get csClusterVenkatgiriStoryMaterial => 'ସୂତା ଏତେ ସୂତା ଭାସୁଛି |';

  @override
  String get csClusterVenkatgiriStoryProcess =>
      'ଜାମଦାନୀ ମୋଟିଫ୍ - ପାରା, ଆମ୍ବ, ସ୍ swan ାନ୍ - ହାତରେ ବୁଣା |';

  @override
  String get csClusterVenkatgiriTag0 => '#venkatagiri';

  @override
  String get csClusterVenkatgiriTag1 => '#jamdani';

  @override
  String get csClusterVenkatgiriTag2 => '#zari';

  @override
  String get csClusterVenkatgiriTag3 => '#handloomsaree';

  @override
  String get csClusterVenkatgiriTag4 => '# କଟନ୍ସାରି';

  @override
  String get csClusterVenkatgiriTag5 => '#vocalforlocal';

  @override
  String get csClusterVenkatgiriTag6 => '#sareesofinstagram';

  @override
  String get csClusterVenkatgiriTag7 => '# ମେଡେନିଣ୍ଡିଆ |';

  @override
  String get csClusterManiabandhaFabric => 'ଖଣ୍ଡୁଆ ଇକାଟ - ବାନ୍ଧାଯାଇଥିବା ରେଶମ |';

  @override
  String get csClusterManiabandhaShortName => 'ଖଣ୍ଡୁଆ ଇକାଟ |';

  @override
  String get csClusterManiabandhaPlace => 'ମଣିବନ୍ଧ, ଓଡ଼ିଶା';

  @override
  String get csClusterManiabandhaBio0 => 'ଇକାଟ ବୁଣାକାର |';

  @override
  String get csClusterManiabandhaBio1 => 'ମଣିବନ୍ଧ, ଓଡ଼ିଶା';

  @override
  String get csClusterManiabandhaBio2 => 'ଖଣ୍ଡୁଆ ସାରି ଏବଂ ଚୋରି |';

  @override
  String get csClusterManiabandhaBio3 => 'ଅର୍ଡର କରିବାକୁ DM |';

  @override
  String get csClusterManiabandhaBio4 => 'ମହାନଦୀ ଉପରେ ବୁଣାକାର ଗାଁ |';

  @override
  String get csClusterManiabandhaStoryHeritage =>
      'ଖଣ୍ଡୁଆ - ଭଗବାନ ଜଗନ୍ନାଥଙ୍କ ପାଇଁ ବୁଣା |';

  @override
  String get csClusterManiabandhaStoryMaterial =>
      'ରେଶମ ସୂତା ବାନ୍ଧିବା ପୂର୍ବରୁ ବାନ୍ଧିବା ପୂର୍ବରୁ |';

  @override
  String get csClusterManiabandhaStoryProcess =>
      'ନମୁନାକୁ ସୂତ୍ରରେ ରଙ୍ଗ କରାଯାଏ, ତାପରେ ସତ୍ୟ ବୁଣା ହୁଏ |';

  @override
  String get csClusterManiabandhaTag0 => '# ଖଣ୍ଡୁଆ';

  @override
  String get csClusterManiabandhaTag1 => '#ikat';

  @override
  String get csClusterManiabandhaTag2 => '#odishahandloom';

  @override
  String get csClusterManiabandhaTag3 => '# ମାନିଆବାନ୍ଧା |';

  @override
  String get csClusterManiabandhaTag4 => '# ହାତ';

  @override
  String get csClusterManiabandhaTag5 => '# ଟାଇଡେ';

  @override
  String get csClusterManiabandhaTag6 => '#vocalforlocal';

  @override
  String get csClusterManiabandhaTag7 => '#sareelove';

  @override
  String get csClusterGopalpurFabric => 'ଗୋପାଳପୁର ତୁସର - ବଣୁଆ ରେଶମ |';

  @override
  String get csClusterGopalpurShortName => 'ତୁଷାର ସାରି |';

  @override
  String get csClusterGopalpurPlace => 'ଗୋପାଳପୁର, ଜଜପୁର, ଓଡିଶା';

  @override
  String get csClusterGopalpurBio0 => 'ତୁସର ବୁଣାକାର |';

  @override
  String get csClusterGopalpurBio1 => 'ଗୋପାଳପୁର, ଓଡିଶା';

  @override
  String get csClusterGopalpurBio2 => 'ସାରିସ୍, ଚୋରି ଏବଂ କପଡା |';

  @override
  String get csClusterGopalpurBio3 => 'ଅର୍ଡର କରିବାକୁ DM |';

  @override
  String get csClusterGopalpurBio4 => 'GI- ଟ୍ୟାଗ୍ ହୋଇଥିବା ଶିଳ୍ପ |';

  @override
  String get csClusterGopalpurStoryHeritage =>
      'ଷୋଡଶ ଶତାବ୍ଦୀରୁ ଗୋପାଳପୁରରେ ବୁଣା ହୋଇଛି - GI ଟ୍ୟାଗ୍ ହୋଇଛି |';

  @override
  String get csClusterGopalpurStoryMaterial =>
      'ବନ୍ୟ ତୁଷାର - ଏହାର ସୁନା ପ୍ରାକୃତିକ, ରଙ୍ଗ ନୁହେଁ |';

  @override
  String get csClusterGopalpurStoryProcess =>
      'ହ୍ୟାଣ୍ଡ-ରିଲ୍, ହ୍ୟାଣ୍ଡ-ସ୍ପନ୍, ଅତିରିକ୍ତ-ବୁଣା ମୋଟିଫ୍ |';

  @override
  String get csClusterGopalpurTag0 => '#tussarsilk';

  @override
  String get csClusterGopalpurTag1 => '# ଗୋପାଳପୁର';

  @override
  String get csClusterGopalpurTag2 => '#odishaweaves';

  @override
  String get csClusterGopalpurTag3 => '# ୱିଲ୍ଡସିଲ୍କ |';

  @override
  String get csClusterGopalpurTag4 => '# ହ୍ୟାଣ୍ଡସପନ୍ |';

  @override
  String get csClusterGopalpurTag5 => '#vocalforlocal';

  @override
  String get csClusterGopalpurTag6 => '# ସିଲକ୍ସୋଫିଣ୍ଡିଆ |';

  @override
  String get csClusterGopalpurTag7 => '# ହାତ';

  @override
  String get csClusterNagalandFabric => 'ନାଗା ଶା aw ୀ - ଲୋନ୍ ଲୁମ୍ |';

  @override
  String get csClusterNagalandShortName => 'ନାଗା ଶା w ୀ |';

  @override
  String get csClusterNagalandPlace => 'ନାଗାଲାଣ୍ଡ କ୍ଲଷ୍ଟରଗୁଡିକ |';

  @override
  String get csClusterNagalandBio0 => 'ଲୁନ୍ ବୁଣା ବୁଣାକାର |';

  @override
  String get csClusterNagalandBio1 => 'ନାଗାଲାଣ୍ଡ |';

  @override
  String get csClusterNagalandBio2 => 'ଶା w ୀ ଏବଂ ମେକଲାସ୍ |';

  @override
  String get csClusterNagalandBio3 => 'ଅର୍ଡର କରିବାକୁ DM |';

  @override
  String get csClusterNagalandBio4 => 'ମୋର ଜାତିର ବୁଣା';

  @override
  String get csClusterNagalandStoryHeritage =>
      'ପ୍ରତ୍ୟେକ ଷ୍ଟ୍ରାଇପ୍ ଏବଂ ମୋଟିଫ୍ ଆପଣ କିଏ ବୋଲି କୁହନ୍ତି |';

  @override
  String get csClusterNagalandStoryMaterial =>
      'ଅଣ୍ଟା ବୁଣା ଉପରେ ମୋଟା ସୂତା, ଗଭୀର ରଙ୍ଗ |';

  @override
  String get csClusterNagalandStoryProcess =>
      'ଷ୍ଟ୍ରିପ୍ ଦ୍ୱାରା ବୁଣା ହୋଇଥିବା ଷ୍ଟ୍ରିପ୍, ଗୋଟିଏ ଶା w ୀରେ ସିଲେଇ |';

  @override
  String get csClusterNagalandTag0 => '# ନାଗାଶୱଲ୍ |';

  @override
  String get csClusterNagalandTag1 => '#loinloom';

  @override
  String get csClusterNagalandTag2 => '# ନାଗାଲାଣ୍ଡ |';

  @override
  String get csClusterNagalandTag3 => '# ହାତ';

  @override
  String get csClusterNagalandTag4 => '#tribaltextile';

  @override
  String get csClusterNagalandTag5 => '#vocalforlocal';

  @override
  String get csClusterNagalandTag6 => '# ଉତ୍ତରପୂର୍ବ';

  @override
  String get csClusterNagalandTag7 => '#craftindia';

  @override
  String get csNewProductTitle => 'ନୂତନ ଉତ୍ପାଦ |';

  @override
  String get csHowIsItMade => 'ଏହା କିପରି ତିଆରି ହୁଏ?';

  @override
  String get csTechniqueSub => 'କ୍ୟାମେରା କ’ଣ ଦେଖାଇବ ତାହା କ The ଶଳ ସ୍ଥିର କରେ |';

  @override
  String get csTechniqueWoven => 'WOVEN';

  @override
  String get csTechniqueHandPainted => 'ହାତ-ଚିତ୍ରିତ |';

  @override
  String get csNextMaterialType => 'ପରବର୍ତ୍ତୀ - ମ୍ୟାଟେରିଆଲ୍ ପ୍ରକାର |';

  @override
  String get csNextMaterial => 'ପରବର୍ତ୍ତୀ - ମ୍ୟାଟେରିଆଲ୍ |';

  @override
  String get csWhatArePhotographing => 'ଆପଣ କ’ଣ ଫଟୋଗ୍ରାଫି କରୁଛନ୍ତି?';

  @override
  String get csPickYourProduct => 'ତୁମର ଉତ୍ପାଦ ବାଛ |';

  @override
  String get csPickYourFrames => 'ତୁମର ଫ୍ରେମ୍ ବାଛ |';

  @override
  String get csPickFramesSub => 'ଆପଣ କେଉଁ ଶଟ ନେବେ? ଅତିକମରେ ଦୁଇଟି ବାଛନ୍ତୁ |';

  @override
  String get csNoTemplatesYet =>
      'ଏହି ଉତ୍ପାଦ ପାଇଁ ଏପର୍ଯ୍ୟନ୍ତ କ temp ଣସି ଟେମ୍ପଲେଟ୍ ନାହିଁ |';

  @override
  String get csNextFrameIt => 'ପରବର୍ତ୍ତୀ - ଏହାକୁ ଫ୍ରେମ୍ କରନ୍ତୁ |';

  @override
  String csFramingProgress(int index, int total) {
    return 'ଫ୍ରେମ୍ $index ର $total |';
  }

  @override
  String csFramingProgressNamed(int index, int total, String names) {
    return 'ଫ୍ରେମ୍ $index ର $total - $names |';
  }

  @override
  String get csFramingThirdsTitle => 'ତୁମର ଉତ୍ପାଦ କେଉଁଠାରେ ବସିବା ଉଚିତ୍?';

  @override
  String get csFramingThirdsSub =>
      'ସର୍ବୋତ୍ତମ ଫ୍ରେମ୍ ଟ୍ୟାପ୍ କରନ୍ତୁ | ରେଖାଗୁଡ଼ିକ ହେଉଛି ତୃତୀୟାଂଶର ନିୟମ |';

  @override
  String get csFramingThirdsMsg0 =>
      'ମୃତ କେନ୍ଦ୍ର ସମତଳ ଅନୁଭବ କରେ | ଏକ କ୍ରସିଂ ପଏଣ୍ଟ ଚେଷ୍ଟା କରନ୍ତୁ |';

  @override
  String get csFramingThirdsMsg1 =>
      'ହଁ - ଯେଉଁଠାରେ ରେଖା ଅତିକ୍ରମ କରେ ଏହାକୁ ସେଟ୍ କରନ୍ତୁ | ଫଟୋ ନିଶ୍ୱାସ ପ୍ରଶ୍ୱାସ କରେ |';

  @override
  String get csFramingThirdsMsg2 => 'ଧାରର ଅତି ନିକଟ - ଉତ୍ପାଦଟି କଟିଯାଏ |';

  @override
  String get csFramingCenterTitle => 'ତୁମେ କେତେ ନିକଟତର ହେବା ଉଚିତ୍?';

  @override
  String get csFramingCenterSub =>
      'କ୍ଲୋଜ ଅପ୍ସ, ଫ୍ଲାଟ ଲେ ଏବଂ ହ୍ୟାଙ୍ଗ ଖଣ୍ଡଗୁଡ଼ିକ କେନ୍ଦ୍ରୀଭୂତ ହୋଇ ବସିଥାଏ - ମଧ୍ୟମ ବାକ୍ସ ଭରନ୍ତୁ |';

  @override
  String get csFramingCenterMsg0 =>
      'ବହୁତ ଦୂରରେ - ସବିଶେଷ ତଥ୍ୟ ହଜିଯାଇଛି | ପାଦ ଦିଅନ୍ତୁ |';

  @override
  String get csFramingCenterMsg1 =>
      'ହଁ - ଫ୍ରେମ୍ ସହିତ ସମାନ୍ତରାଳ ଭାବରେ କେନ୍ଦ୍ର ବାକ୍ସ, ଧାରଗୁଡିକ ପୂରଣ କରନ୍ତୁ |';

  @override
  String get csFramingCenterMsg2 =>
      'ଫ୍ରେମ୍ର ଅଧା ବାହାରେ - ଆପଣ ଶୁଟ୍ କରିବା ପୂର୍ବରୁ ଏହାକୁ କେନ୍ଦ୍ର କରନ୍ତୁ |';

  @override
  String get csFramingDiagTitle => 'କପଡା କିପରି ପ୍ରବାହିତ ହେବା ଉଚିତ୍?';

  @override
  String get csFramingDiagSub =>
      'ଡ୍ରାପ୍ସ ଏବଂ ମାକ୍ରୋ ସଟଗୁଡିକ ଡାଇଗୋନାଲ୍ ସହିତ ଗତି କରେ - କପଡା ଆଖିକୁ ଆଗେଇ ନେବାକୁ ଦିଅ |';

  @override
  String get csFramingDiagMsg0 =>
      'ଏକ ସମତଳ ଧାଡିରେ କ movement ଣସି ଗତି ନାହିଁ | ଏହାକୁ ଧାଡ଼ିରେ ପଡ଼ିବାକୁ ଦିଅ |';

  @override
  String get csFramingDiagMsg1 =>
      'ହଁ - ଫୋଲ୍ଡଗୁଡ଼ିକ ତ୍ରିକୋଣୀୟ ତଳକୁ ଓହ୍ଲାଇଥାଏ ଏବଂ ଆଖି ଅନୁସରଣ କରେ |';

  @override
  String get csFramingDiagMsg2 => 'ଏକ କୋଣରେ ବନ୍ଧା - ପ୍ରବାହ ଚାଲିଗଲା |';

  @override
  String get csFramingDetailTitle => 'ଫ୍ରେମରେ କେତେ ସୀମା?';

  @override
  String get csFramingDetailSub =>
      'ସୀମା, ମୋଟିଫ୍ ଏବଂ ଫୋଲଡ୍ ସଟଗୁଡିକ: କାର୍ଯ୍ୟଟି ସହିତ ସବିଶେଷ ଫ୍ରେମ୍ ପୁରଣ କରନ୍ତୁ |';

  @override
  String get csFramingDetailMsg0 =>
      'ଅତ୍ୟଧିକ ପତଳା, ବହୁତ ଦୂରରେ - ଶିଳ୍ପକୁ କେହି ଦେଖି ପାରିବେ ନାହିଁ |';

  @override
  String get csFramingDetailMsg1 =>
      'ହଁ - ସୀମା ଫ୍ରେମ୍ ଭରିଦିଏ, ଥ୍ରେଡ୍ ଗଣିବା ପାଇଁ ଯଥେଷ୍ଟ ବନ୍ଦ |';

  @override
  String get csFramingDetailMsg2 =>
      'ଏକ ଭାସମାନ ବର୍ଗ ସୀମା କିମ୍ବା ମୋଟିଫ୍ ଦେଖାଏ ନାହିଁ | ବ୍ୟାଣ୍ଡକୁ ଅନୁସରଣ କରନ୍ତୁ |';

  @override
  String get csNextFraming => 'ପରବର୍ତ୍ତୀ ଫ୍ରେମ୍';

  @override
  String get csNextLightIt => 'ପରବର୍ତ୍ତୀ - ଏହାକୁ ହାଲୁକା କରନ୍ତୁ |';

  @override
  String get csLightSide => 'ପାର୍ଶ୍ୱରୁ ଆଲୋକ |';

  @override
  String get csLightFront => 'ଆଗରୁ କୋମଳ ଆଲୋକ |';

  @override
  String get csLightBack => 'ପଛରୁ ଆଲୋକ |';

  @override
  String get csLightHeadingPanel => 'ଏକ ଚିତ୍ରିତ ପ୍ୟାନେଲ୍ ଚମକକୁ ଘୃଣା କରେ |';

  @override
  String get csLightHeadingPainted => 'ହାତରେ ରଙ୍ଗିତ - ଏହାକୁ ମଧ୍ୟ ରଖନ୍ତୁ |';

  @override
  String get csLightHeadingSilk => 'ରେଶମ ଉଜ୍ଜ୍ୱଳ | ଏହାକୁ ଚମକାନ୍ତୁ |';

  @override
  String get csLightHeadingCotton => 'କପା ନରମ ଅଟେ | ଆଲୋକକୁ ନରମ ରଖନ୍ତୁ |';

  @override
  String get csLightPromptPanel =>
      'କପଡା ଉପରେ ଏକ ଚିତ୍ର ପ୍ରତିଫଳିତ ହୁଏ | ଏହାକୁ ସମତଳ ଏବଂ ନରମ ହାଲୁକା କରନ୍ତୁ |';

  @override
  String get csLightPromptPainted => 'ଆଲୋକ ବାଛନ୍ତୁ ଯାହା ରଙ୍ଗୀନ ରଙ୍ଗକୁ ସତ ରଖେ |';

  @override
  String get csLightPromptSilk => 'ତୁମର ରେଶମକୁ ସର୍ବୋତ୍ତମ ଦେଖାଉଥିବା ଆଲୋକ ବାଛ |';

  @override
  String get csLightPromptDefault =>
      'ତୁମର ଉତ୍ପାଦକୁ ସର୍ବୋତ୍ତମ ଦେଖାଉଥିବା ଆଲୋକ ବାଛ |';

  @override
  String get csLightWhyPanel =>
      'ଡାହାଣ - ନରମ, ଏପରିକି, ଆଗରୁ ବିସ୍ତାରିତ ଆଲୋକ | ପ୍ରାକୃତିକ ରଙ୍ଗର ରଙ୍ଗ ସତ୍ୟ ରହେ ଏବଂ କ୍ୟାମେରାରେ କିଛି ଜ୍ୟୋତି ହୁଏ ନାହିଁ | କଦାପି ଫ୍ଲାସ ବ୍ୟବହାର କରନ୍ତୁ ନାହିଁ |';

  @override
  String get csLightWhyPainted =>
      'ଡାହାଣ - ଏପରିକି ଆଗ ଆଲୋକ ମଧ୍ୟ ରଙ୍ଗକୁ ସତ୍ୟ ରଖେ, ଚିତ୍ରିତ ପୃଷ୍ଠରେ କ lar ଣସି ଚମକ ନାହିଁ |';

  @override
  String get csLightWhySilk => 'ଡାହାଣ ପାର୍ଶ୍ୱ ଆଲୋକ ରେଶମର ଉଜ୍ଜ୍ୱଳତା ଧରିଥାଏ |';

  @override
  String get csLightWhyCotton =>
      'ଡାହାଣ - ନରମ ସାମ୍ନା ଆଲୋକ ସୂତା କୋମଳ ଏବଂ ଏହାର ରଙ୍ଗ ସତ୍ୟ ରଖେ |';

  @override
  String get csLightWrongPanel =>
      'ପାର୍ଶ୍ୱ ଆଲୋକକୁ ବ୍ରଶ୍ ୱାର୍କରେ ଛାଇ ପକାଇଥାଏ ଏବଂ ଭୂପୃଷ୍ଠରେ lar ଲକ ଧରିଥାଏ | ଏହାକୁ ସମାନ ଏବଂ ବିସ୍ତାର କରନ୍ତୁ |';

  @override
  String get csLightWrongPainted =>
      'ସାଇଡ୍ ଲାଇଟ୍ ଚିତ୍ରିତ କାର୍ଯ୍ୟରେ ଛାୟା ପକାଇଥାଏ | ଏହାକୁ ନରମ ଏବଂ ଏପରିକି ରଖନ୍ତୁ |';

  @override
  String get csLightWrongSilk =>
      'ଫ୍ଲାଟ ସାମ୍ନା ଆଲୋକ ଉଜ୍ଜ୍ୱଳତାକୁ ମାରିଦିଏ | ଆଲୋକକୁ ପାର୍ଶ୍ୱକୁ ଆଣ |';

  @override
  String get csLightWrongCotton =>
      'କଠିନ ପାର୍ଶ୍ୱ ଆଲୋକ ସୂତାକୁ ରୁଗ୍ଣ ଦେଖାଏ | ଏହାକୁ ଆଗରୁ ନରମ ରଖନ୍ତୁ |';

  @override
  String get csLightWrongBacklight =>
      'ବ୍ୟାକ୍ ଲାଇଟ୍ ଆପଣଙ୍କ ଉତ୍ପାଦକୁ ଏକ ଛାଇରେ ପରିଣତ କରେ | ମୋଟା ଶଟ ପାଇଁ ଏହାକୁ ସେଭ୍ କରନ୍ତୁ |';

  @override
  String get csLightTipDoThisBadge => 'ଏହା କର |';

  @override
  String get csLightTipDoThisBody =>
      'ବଡ ନରମ ୱିଣ୍ଡୋ, ପରଦା ଅଙ୍କିତ | ଏପରିକି ସମଗ୍ର ପ୍ୟାନେଲରେ ଆଲୋକ - ପ୍ରତ୍ୟେକ ରଙ୍ଗ ସତ୍ୟ, ଉଜ୍ଜ୍ୱଳ ନୁହେଁ |';

  @override
  String get csLightTipNeverFlashBadge => 'କେବେବି ଫ୍ଲାସ୍ କରନ୍ତୁ ନାହିଁ |';

  @override
  String get csLightTipNeverFlashBody =>
      'ଫ୍ଲାସ୍ ସିଧା ପଛକୁ ବାଉନ୍ସ ହୁଏ - ଏକ ଧଳା ରଙ୍ଗର ଦାଗ ଚିତ୍ରକୁ ପୋଡି ଦିଏ |';

  @override
  String get csLightTipAvoidSideBadge =>
      'ହାର୍ଡ ସାଇଡ୍ ଲାଇଟ୍ ଠାରୁ ଦୂରେଇ ରୁହନ୍ତୁ |';

  @override
  String get csLightTipAvoidSideBody =>
      'ଗୋଟିଏ ପାର୍ଶ୍ୱରୁ ଏକ ଦୀପ କିମ୍ବା ସୂର୍ଯ୍ୟ ବ୍ରଶ୍ ୱାର୍କରେ ଛାୟା ଟାଣିଥାଏ ଏବଂ କପଡା ଟେକ୍ସଚର୍ ପେଣ୍ଟିଂ ସହିତ ଲ ights େ |';

  @override
  String get csLightNowPick => 'ବର୍ତ୍ତମାନ ସଠିକ୍ ଆଲୋକ ବାଛନ୍ତୁ |';

  @override
  String get csNextShootYours => 'ପରବର୍ତ୍ତୀ - ତୁମକୁ ଗୁଳି କର |';

  @override
  String get csFinishEarnBadge => 'ଶେଷ - ବ୍ୟାଡ୍ ରୋଜଗାର କରନ୍ତୁ |';

  @override
  String get languageOdia => 'ଓଡ଼ିଆ';

  @override
  String get languageTelugu => 'ତେଲୁଗୁ';

  @override
  String get csWhatIsItMadeOf => 'ଏହା କ’ଣ ତିଆରି ହୋଇଛି?';

  @override
  String get csMaterialDecidesLight => 'ପଦାର୍ଥ ଆଲୋକ ସ୍ଥିର କରେ |';

  @override
  String get csNextTechnique => 'ପରବର୍ତ୍ତୀ - ଟେକ୍ନିକ୍ |';

  @override
  String get csNextPickYourFrames =>
      'ପରବର୍ତ୍ତୀ - ଆପଣଙ୍କର ଫ୍ରେମ୍ଗୁଡିକୁ ବାଛନ୍ତୁ |';

  @override
  String get csMaterialCotton => 'କୋଟନ୍ |';

  @override
  String get csMaterialSilk => 'ସିଲ୍କ |';

  @override
  String get csPhotosToCaptureHeading => 'କ୍ୟାପଚର କରିବାକୁ ଫଟୋ';

  @override
  String get csOpenGuideDropTick =>
      'ଗାଇଡ୍ ଖୋଲ, ସଟ ନିଅ, ଏହାକୁ ଛାଡିଦିଅ, ଏହାକୁ ଟିକ୍ କର |';

  @override
  String get csMarkAsTaken => 'ନିଆଯାଇଥିବା ମାର୍କ |';

  @override
  String get csTickedUndo => 'ଟିକେଟ୍ - UNDO |';

  @override
  String get csDropFirstShot => 'ଆରମ୍ଭ କରିବାକୁ ତୁମର ପ୍ରଥମ ସଟ ଛାଡିଦିଅ |';

  @override
  String csShotsLeft(int count) {
    return '$count ଶଟଗୁଡିକ ବାକି ଅଛି |';
  }

  @override
  String get csAllShotsSaved => 'ସମସ୍ତ ଗୁଳି ସଞ୍ଚୟ ହୋଇଛି |';

  @override
  String csShotSavedLeft(int count) {
    return 'ସଟ ସଞ୍ଚୟ - $count LEFT |';
  }

  @override
  String csDropYourShotHere(String name) {
    return 'ତୁମର $name ସୁଟ୍ ଏଠାରେ ଛାଡିଦିଅ |';
  }

  @override
  String get csChoosePhoto => 'ଫଟୋ';

  @override
  String get csChooseVideo => 'ଭିଡିଓ';

  @override
  String get csDropPhotoOrVideo =>
      'ପାଠ୍ୟ 01 ରୁ ଆପଣଙ୍କର ଫଟୋ - କିମ୍ବା ଏକ ଫଟୋ କିମ୍ବା ଭିଡିଓ ଡ୍ରପ୍ କରନ୍ତୁ |';

  @override
  String get csVideoSelected =>
      'ଭିଡିଓ ମନୋନୀତ - ପରିବର୍ତ୍ତନ କରିବାକୁ ଟ୍ୟାପ୍ କରନ୍ତୁ |';
}
