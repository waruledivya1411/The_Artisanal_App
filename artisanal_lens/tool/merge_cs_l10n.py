"""Merge Click & Social (cs*) localization keys into the ARB files.

Adds English / Hindi / Assamese strings for the Click & Social learning flow
(shell nav, onboarding hub, lessons 01-05, clusters, framing and light quizzes)
into lib/l10n/app_en.arb, app_hi.arb and app_as.arb.

Existing keys are left untouched; only cs* keys are added or refreshed.

Run from anywhere:  python artisanal_lens/tool/merge_cs_l10n.py
"""

from __future__ import annotations

import json
from collections import OrderedDict
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
L10N_DIR = REPO_ROOT / "lib" / "l10n"

STR = {"type": "String"}
INT = {"type": "int"}


def same(text: str) -> tuple[str, str, str]:
    """Brand names, hashtags and handles stay identical in every language."""
    return (text, text, text)


# (key, english, hindi, assamese, placeholders-or-None)
ENTRIES: list[tuple[str, str, str, str, "OrderedDict | None"]] = []


def add(key: str, en: str, hi: str, asm: str, placeholders=None) -> None:
    ENTRIES.append((key, en, hi, asm, placeholders))


def add_same(key: str, text: str, placeholders=None) -> None:
    en, hi, asm = same(text)
    add(key, en, hi, asm, placeholders)


# ---------------------------------------------------------------- shell nav
add("csNavLearn", "LEARN", "सीखें", "শিকক")
add("csNavPractice", "PRACTICE", "अभ्यास", "অনুশীলন")
add("csNavProgress", "PROGRESS", "प्रगति", "প্ৰগতি")

# ------------------------------------------------ home onboarding + the hub
add("csLearnerFallback", "Learner", "सीखने वाले", "শিকাৰু")
add(
    "csClusterNotSelected",
    "Cluster not selected",
    "क्लस्टर चुना नहीं गया",
    "ক্লাষ্টাৰ বাছনি কৰা হোৱা নাই",
)
add(
    "csAntaranLearningTool",
    "Antaran · Learning tool",
    "अंतरण · सीखने का साधन",
    "অন্তৰণ · শিকাৰ সঁজুলি",
)
add(
    "csWorksOffline",
    "WORKS OFFLINE",
    "बिना इंटरनेट चलता है",
    "ইণ্টাৰনেট নোহোৱাকৈও চলে",
)
add_same("csClickAndSocial", "CLICK &\nSOCIAL")
add_same("csClickAndSocialInline", "CLICK & SOCIAL")
add(
    "csOnboardingTagline",
    "Photograph your craft. Tell its story. Sell it online — all from this phone.",
    "अपने हुनर की तस्वीर लें। उसकी कहानी सुनाएँ। उसे ऑनलाइन बेचें — सब इसी फ़ोन से।",
    "নিজৰ শিল্পৰ ফটো তোলক। ইয়াৰ কাহিনী কওক। অনলাইনত বিক্ৰী কৰক — সকলো এই ফোনৰ পৰাই।",
)
add("csStepYourName", "Your name", "आपका नाम", "আপোনাৰ নাম")
add("csNameHint", "Type your name", "अपना नाम लिखें", "আপোনাৰ নাম লিখক")
add("csStepYourLanguage", "Your language", "आपकी भाषा", "আপোনাৰ ভাষা")
add_same(
    "csLanguageChip",
    "{label} ({code})",
    OrderedDict([("label", STR), ("code", STR)]),
)
add(
    "csStepYourCluster",
    "Your cluster — where you work",
    "आपका क्लस्टर — जहाँ आप काम करते हैं",
    "আপোনাৰ ক্লাষ্টাৰ — য'ত আপুনি কাম কৰে",
)
add(
    "csClusterHint",
    "Chosen once. Your lessons, stories and hashtags are tuned to it.",
    "एक बार चुनें। आपके पाठ, कहानियाँ और हैशटैग इसी के हिसाब से बनेंगे।",
    "এবাৰ বাছনি কৰক। আপোনাৰ পাঠ, কাহিনী আৰু হেছটেগ ইয়াৰ ওপৰতে ঠিক হ'ব।",
)
add("csSelected", "SELECTED", "चुना गया", "বাছি লোৱা হ'ল")
add("csPick", "PICK", "चुनें", "বাছক")
add("csStartLearning", "START LEARNING", "सीखना शुरू करें", "শিকা আৰম্ভ কৰক")
add("csOfflineReady", "OFFLINE READY", "बिना इंटरनेट तैयार", "ইণ্টাৰনেট অবিহনে সাজু")
add(
    "csHelloName",
    "Hello, {name}",
    "नमस्ते, {name}",
    "নমস্কাৰ, {name}",
    OrderedDict([("name", STR)]),
)
add("csChange", "CHANGE", "बदलें", "সলনি কৰক")
add(
    "csLessonsDone",
    "{done} OF 5 LESSONS DONE",
    "5 में से {done} पाठ पूरे",
    "৫ টাৰ ভিতৰত {done} টা পাঠ সম্পূৰ্ণ",
    OrderedDict([("done", INT)]),
)

add("csLesson01Title", "Photography", "फ़ोटोग्राफ़ी", "ফটোগ্ৰাফী")
add(
    "csLesson01Subtitle",
    "Product · Material · Cluster · Frames · Light",
    "उत्पाद · सामग्री · क्लस्टर · फ़्रेम · रोशनी",
    "সামগ্ৰী · উপাদান · ক্লাষ্টাৰ · ফ্ৰেম · পোহৰ",
)
add(
    "csLesson02Title",
    "Set Up Your Page on Instagram",
    "इंस्टाग्राम पर अपना पेज बनाएँ",
    "ইনষ্টাগ্ৰামত আপোনাৰ পেজ সাজক",
)
add(
    "csLesson02Subtitle",
    "Name · Bio · Professional account",
    "नाम · बायो · प्रोफ़ेशनल अकाउंट",
    "নাম · বায়ো · প্ৰফেচনেল একাউণ্ট",
)
add("csLesson03Title", "Create a Post", "पोस्ट बनाएँ", "পোষ্ট বনাওক")
add(
    "csLesson03Subtitle",
    "Story · Hashtags · Publish",
    "कहानी · हैशटैग · प्रकाशित करें",
    "কাহিনী · হেছটেগ · প্ৰকাশ",
)
add("csLesson04Title", "Posting Plan", "पोस्ट करने की योजना", "পোষ্ট কৰাৰ পৰিকল্পনা")
add(
    "csLesson04Subtitle",
    "When to post · Weekly rhythm",
    "कब पोस्ट करें · हफ़्ते की लय",
    "কেতিয়া পোষ্ট কৰিব · সাপ্তাহিক ছন্দ",
)
add("csLesson05Title", "Read the Numbers", "आँकड़े पढ़ें", "সংখ্যাবোৰ পঢ়ক")
add(
    "csLesson05Subtitle",
    "Reach · What worked and why",
    "पहुँच · क्या चला और क्यों",
    "পৰিসৰ · কি সফল হ'ল আৰু কিয়",
)

# ------------------------------------------------------------- lesson chrome
add("csLesson01Overline", "LESSON 01", "पाठ 01", "পাঠ ০১")
add("csLesson02Overline", "LESSON 02", "पाठ 02", "পাঠ ০২")
add("csLesson03Overline", "LESSON 03", "पाठ 03", "পাঠ ০৩")
add("csLesson04Overline", "LESSON 04", "पाठ 04", "পাঠ ০৪")
add("csLesson05Overline", "LESSON 05", "पाठ 05", "পাঠ ০৫")
add_same(
    "csStepOfTotal",
    "{step} / {total}",
    OrderedDict([("step", INT), ("total", INT)]),
)

# ------------------------------------------- lesson 02 — Instagram page setup
add(
    "csPickYourUsername",
    "Pick your username",
    "अपना यूज़रनेम चुनें",
    "আপোনাৰ ইউজাৰনেম বাছক",
)
add(
    "csUsernameHint",
    "Short. Your craft in it. Easy to say out loud.",
    "छोटा हो। उसमें आपका हुनर दिखे। बोलने में आसान हो।",
    "চুটি হওক। ইয়াত আপোনাৰ শিল্প থাকক। ক'বলৈ সহজ হওক।",
)
add(
    "csNextEditProfile",
    "NEXT — EDIT PROFILE",
    "आगे — EDIT PROFILE",
    "পৰৱৰ্তী — EDIT PROFILE",
)
add("csEditProfileIntroBefore", "This is the ", "यह ", "এইখনেই ")
add_same("csEditProfileIntroBold", "Edit profile")
add(
    "csEditProfileIntroAfter",
    " screen. Fill each row.",
    " स्क्रीन है। हर पंक्ति भरें।",
    " স্ক্ৰীন। প্ৰতিটো শাৰী পূৰণ কৰক।",
)
add(
    "csChangePhotoTip",
    "Change photo — use your product, not a sunset",
    "फ़ोटो बदलें — अपना उत्पाद लगाएँ, सूरज ढलने की तस्वीर नहीं",
    "ফটো সলনি কৰক — আপোনাৰ সামগ্ৰীৰ ফটো দিয়ক, সূৰ্যাস্তৰ নহয়",
)
add_same("csFieldName", "Name")
add_same("csFieldUsername", "Username")
add_same("csFieldBio", "Bio")
add(
    "csBioPlaceholder",
    "Tap lines below to build it…",
    "नीचे की पंक्तियाँ छूकर इसे बनाएँ…",
    "তলৰ শাৰীবোৰত টিপি ইয়াক সাজক…",
)
add(
    "csBioLinesPrompt",
    "Bio lines — pick at least 2 (place + craft + how to buy)",
    "बायो की पंक्तियाँ — कम से कम 2 चुनें (जगह + हुनर + कैसे ख़रीदें)",
    "বায়োৰ শাৰী — কমেও ২ টা বাছক (ঠাই + শিল্প + কেনেকৈ কিনিব)",
)
add(
    "csNextGoProfessional",
    "NEXT — GO PROFESSIONAL",
    "आगे — प्रोफ़ेशनल बनें",
    "পৰৱৰ্তী — প্ৰফেচনেল হওক",
)
add(
    "csSettingsPrompt",
    "In the app, open Settings. Find the row that leads to a professional "
    "account — follow the red dot.",
    "ऐप में Settings खोलें। जो पंक्ति प्रोफ़ेशनल अकाउंट तक ले जाती है, उसे ढूँढें — "
    "लाल बिंदु के पीछे चलें।",
    "এপটোত Settings খোলক। প্ৰফেচনেল একাউণ্টলৈ লৈ যোৱা শাৰীটো বিচাৰক — ৰঙা "
    "বিন্দুটোৰ পিছে পিছে যাওক।",
)
add(
    "csSettingsPromptAlmost",
    "Almost there — one more tap.",
    "बस एक कदम और — एक बार और छुएँ।",
    "প্ৰায় হৈ গ'ল — আৰু এবাৰ টিপক।",
)
add_same("csSettingsTitle", "Settings")
add_same("csAccountTypeAndTools", "Account type and tools")
add_same("csSettingsNotifications", "Notifications")
add(
    "csSettingsNotificationsSub",
    "Likes, comments, messages",
    "लाइक, कमेंट, मैसेज",
    "লাইক, কমেণ্ট, মেছেজ",
)
add_same("csSettingsPrivacy", "Privacy")
add(
    "csSettingsPrivacySub",
    "Private account, blocked people",
    "प्राइवेट अकाउंट, ब्लॉक किए लोग",
    "প্ৰাইভেট একাউণ্ট, ব্লক কৰা মানুহ",
)
add(
    "csSettingsAccountTypeSub",
    "Switch to a professional account",
    "प्रोफ़ेशनल अकाउंट पर जाएँ",
    "প্ৰফেচনেল একাউণ্টলৈ যাওক",
)
add_same("csSettingsHelp", "Help")
add("csSettingsHelpSub", "Report a problem", "समस्या बताएँ", "সমস্যা জনাওক")
add_same("csSettingsSwitchProfessional", "Switch to professional account")
add(
    "csSettingsSwitchProfessionalSub",
    "Free — for creators and businesses",
    "मुफ़्त — क्रिएटर और कारोबार के लिए",
    "বিনামূলীয়া — ক্ৰিয়েটৰ আৰু ব্যৱসায়ৰ বাবে",
)
add_same("csSettingsDeleteAccount", "Delete account")
add(
    "csSettingsDeleteAccountSub",
    "Remove your account",
    "अपना अकाउंट हटाएँ",
    "আপোনাৰ একাউণ্ট আঁতৰাওক",
)
add_same("csSettingsPersonalInfo", "Personal information")
add("csSettingsPersonalInfoSub", "Birthday, email", "जन्मदिन, ईमेल", "জন্মদিন, ইমেইল")
add(
    "csSettingsWrongPick",
    "Not that one — follow the red dot.",
    "वह नहीं — लाल बिंदु के पीछे चलें।",
    "সেইটো নহয় — ৰঙা বিন্দুটোৰ পিছে পিছে যাওক।",
)
add("csCategoryIntroBefore", "Last step — ", "आख़िरी कदम — ", "শেষ পদক্ষেপ — ")
add("csCategoryIntroBold", "what are you?", "आप क्या हैं?", "আপুনি কি?")
add(
    "csCategoryIntroAfter",
    " Pick the category buyers will see.",
    " वह श्रेणी चुनें जो ख़रीदार देखेंगे।",
    " গ্ৰাহকে দেখা শ্ৰেণীটো বাছক।",
)
add_same("csCategoryArtist", "Artist")
add_same("csCategoryShoppingRetail", "Shopping & retail")
add_same("csCategoryLocalBusiness", "Local business")
add_same("csCategoryEntrepreneur", "Entrepreneur")
add(
    "csProAccountNote1",
    "A professional account is free. It unlocks ",
    "प्रोफ़ेशनल अकाउंट मुफ़्त है। इससे खुलते हैं ",
    "প্ৰফেচনেল একাউণ্ট বিনামূলীয়া। ইয়াৰ দ্বাৰা খোল খায় ",
)
add_same("csProAccountInsights", "insights")
add(
    "csProAccountNote2",
    " (who sees your posts — Lesson 05), a ",
    " (आपकी पोस्ट कौन देखता है — पाठ 05), एक ",
    " (আপোনাৰ পোষ্ট কোনে দেখে — পাঠ ০৫), এটা ",
)
add_same("csProAccountContactButton", "contact button")
add("csProAccountNote3", ", and ", ", और आगे चलकर ", ", আৰু পিছলৈ ")
add_same("csProAccountAds", "ads")
add("csProAccountNote4", " later.", "।", "।")
add(
    "csSwitchToProfessional",
    "SWITCH TO PROFESSIONAL",
    "प्रोफ़ेशनल पर जाएँ",
    "প্ৰফেচনেললৈ যাওক",
)
add(
    "csPreviewIntro",
    "Done. This is how buyers will see your page:",
    "हो गया। ख़रीदार आपका पेज ऐसे देखेंगे:",
    "হ'ল। গ্ৰাহকে আপোনাৰ পেজখন এনেদৰে দেখিব:",
)
add("csPostsFollowers", "0 posts   0 followers", "0 पोस्ट   0 फ़ॉलोअर", "০ পোষ্ট   ০ ফলোৱাৰ")
add_same("csFollow", "FOLLOW")
add_same("csMessage", "MESSAGE")
add(
    "csProfessionalAccount",
    "PROFESSIONAL ACCOUNT",
    "प्रोफ़ेशनल अकाउंट",
    "প্ৰফেচনেল একাউণ্ট",
)
add_same("csPickANameFallback", "pick_a_name")
add("csCraftFallback", "craft", "हुनर", "শিল্প")
add("csBioFallbackHandloomWeaver", "Handloom weaver", "हथकरघा बुनकर", "হাতঁতশাল বয়নশিল্পী")
add("csBioFallbackDmToOrder", "DM to order", "ऑर्डर के लिए DM करें", "অৰ্ডাৰৰ বাবে DM কৰক")
add("csBioFallbackMadeByHand", "Made by hand", "हाथ से बना", "হাতেৰে বনোৱা")

# ---------------------------------------------------- lesson 03 — create post
add("csFormatPost", "POST", "पोस्ट", "পোষ্ট")
add("csFormatStory", "STORY", "स्टोरी", "ষ্ট'ৰী")
add("csFormatReel", "REEL", "रील", "ৰীল")
add(
    "csPhotoPlaceholder",
    "Your photo from Lesson 01 — or drop one",
    "पाठ 01 की आपकी फ़ोटो — या कोई फ़ोटो डालें",
    "পাঠ ০১ৰ আপোনাৰ ফটো — বা এখন ফটো দিয়ক",
)
add(
    "csExampleKotpad",
    "Example: a Kotpad post — photo up close, then two lines naming the craft "
    "and its weavers.",
    "उदाहरण: कोटपाड़ की एक पोस्ट — पास से ली गई फ़ोटो, फिर दो पंक्तियाँ जिनमें हुनर "
    "और बुनकरों का नाम हो।",
    "উদাহৰণ: এটা কোটপাড় পোষ্ট — ওচৰৰ পৰা তোলা ফটো, তাৰ পিছত দুটা শাৰীত শিল্প "
    "আৰু বয়নশিল্পীৰ নাম।",
)
add(
    "csAddYourStory",
    "Add your story — tap lines",
    "अपनी कहानी जोड़ें — पंक्तियाँ छुएँ",
    "আপোনাৰ কাহিনী যোগ কৰক — শাৰীবোৰত টিপক",
)
add(
    "csHashtagsPick",
    "Hashtags — pick 3 to 5 ",
    "हैशटैग — 3 से 5 चुनें ",
    "হেছটেগ — ৩ৰ পৰা ৫ টা বাছক ",
)
add_same("csHashtagCount", "{count}/5", OrderedDict([("count", INT)]))
add(
    "csHashtagCountFull",
    "{count}/5 — five is enough",
    "{count}/5 — पाँच काफ़ी हैं",
    "{count}/5 — পাঁচটাই যথেষ্ট",
    OrderedDict([("count", INT)]),
)
add("csCaptionPreview", "CAPTION PREVIEW", "कैप्शन की झलक", "কেপচনৰ পূৰ্বদৰ্শন")
add(
    "csCaptionPlaceholder",
    "Tap story lines above to write your caption.",
    "ऊपर की कहानी पंक्तियाँ छूकर अपना कैप्शन लिखें।",
    "ওপৰৰ কাহিনীৰ শাৰীবোৰত টিপি আপোনাৰ কেপচন লিখক।",
)
add(
    "csPostToPracticeFeed",
    "POST TO PRACTICE FEED",
    "अभ्यास फ़ीड पर पोस्ट करें",
    "অনুশীলন ফিডত পোষ্ট কৰক",
)
add(
    "csPracticeFeedOnly",
    "Practice feed only — nothing leaves your phone.",
    "सिर्फ़ अभ्यास फ़ीड — कुछ भी आपके फ़ोन से बाहर नहीं जाता।",
    "কেৱল অনুশীলন ফিড — একোৱেই আপোনাৰ ফোনৰ পৰা বাহিৰলৈ নাযায়।",
)
add(
    "csStoryFallbackHeritage",
    "Made by hand in my village.",
    "मेरे गाँव में हाथ से बना।",
    "মোৰ গাঁৱত হাতেৰে বনোৱা।",
)
add(
    "csStoryFallbackMaterial",
    "Natural fibre, dyed with care.",
    "प्राकृतिक रेशा, ध्यान से रंगा।",
    "প্ৰাকৃতিক আঁহ, যতনেৰে ৰং কৰা।",
)
add(
    "csStoryFallbackProcess",
    "Woven on a home loom, motif by motif.",
    "घर के करघे पर बुना, एक-एक बूटी।",
    "ঘৰৰ তাঁতত বোৱা, এটা এটাকৈ ফুল।",
)
for i, tag in enumerate(
    ["#handwoven", "#vocalforlocal", "#craftindia", "#madeinindia", "#handloom"]
):
    add_same(f"csTagFallback{i}", tag)

# ---------------------------------------------------- lesson 04 — posting plan
add(
    "csWhenDoBuyersScroll",
    "When do buyers scroll?",
    "ख़रीदार कब स्क्रॉल करते हैं?",
    "গ্ৰাহকে কেতিয়া স্ক্ৰল কৰে?",
)
add("csTimeMorning", "6–9 in the morning", "सुबह 6–9 बजे", "ৰাতিপুৱা ৬–৯ বজাত")
add("csTimeNight", "7–10 at night", "रात 7–10 बजे", "ৰাতি ৭–১০ বজাত")
add("csTimeAfternoon", "2 in the afternoon", "दोपहर 2 बजे", "দুপৰীয়া ২ বজাত")
add(
    "csTimeCorrectMsg",
    "Yes — evenings, when the day's work is done, is when people scroll and shop.",
    "हाँ — शाम को, जब दिन का काम निपट जाता है, तभी लोग स्क्रॉल करते हैं और ख़रीदते हैं।",
    "হয় — সন্ধিয়া, যেতিয়া দিনটোৰ কাম শেষ হয়, তেতিয়াই মানুহে স্ক্ৰল কৰে আৰু কিনে।",
)
add(
    "csTimeWrongMsg",
    "People are working then. Try when the day is done.",
    "उस समय लोग काम पर होते हैं। दिन ढलने के बाद देखें।",
    "সেই সময়ত মানুহ কামত থাকে। দিনটো শেষ হোৱাৰ পিছত চাওক।",
)
add(
    "csPlanYourWeek",
    "Plan your week — pick 3 days",
    "अपना हफ़्ता तय करें — 3 दिन चुनें",
    "আপোনাৰ সপ্তাহ ঠিক কৰক — ৩ দিন বাছক",
)
add(
    "csSpreadThemOut",
    "Spread them out. Buyers should see you all week.",
    "इन्हें फैलाकर रखें। ख़रीदार आपको पूरे हफ़्ते देखें।",
    "দিনবোৰ সিঁচৰতি কৰি ৰাখক। গ্ৰাহকে গোটেই সপ্তাহ আপোনাক দেখা পাওক।",
)
add("csDayMon", "M", "सो", "সো")
add("csDayTue", "T", "मं", "মঙ")
add("csDayWed", "W", "बु", "বু")
add("csDayThu", "T", "गु", "বৃ")
add("csDayFri", "F", "शु", "শু")
add("csDaySat", "S", "श", "শ")
add("csDaySun", "S", "र", "দে")
add(
    "csGoodRhythm",
    "Good rhythm — three posts, spread across the week.",
    "अच्छी लय — तीन पोस्ट, पूरे हफ़्ते में फैली हुई।",
    "ভাল ছন্দ — তিনিটা পোষ্ট, গোটেই সপ্তাহত সিঁচৰতি।",
)

# ------------------------------------------------- lesson 05 — read the numbers
add(
    "csThreePostsOneWinner",
    "Three posts. One winner.",
    "तीन पोस्ट। एक विजेता।",
    "তিনিটা পোষ্ট। এটা বিজয়ী।",
)
add(
    "csReachExplainer",
    "Reach = how many people saw it. Tap the best post.",
    "पहुँच = कितने लोगों ने देखा। सबसे अच्छी पोस्ट छुएँ।",
    "পৰিসৰ = কিমান মানুহে দেখিলে। আটাইতকৈ ভাল পোষ্টটোত টিপক।",
)
add("csResultPhotoOnly", "Photo only", "सिर्फ़ फ़ोटो", "কেৱল ফটো")
add(
    "csResultPhotoStory",
    "Photo + story caption",
    "फ़ोटो + कहानी वाला कैप्शन",
    "ফটো + কাহিনীৰ কেপচন",
)
add(
    "csResultPhotoStoryTags",
    "Photo + story + hashtags",
    "फ़ोटो + कहानी + हैशटैग",
    "ফটো + কাহিনী + হেছটেগ",
)
add(
    "csBestCorrectMsg",
    "Right — a story plus hashtags reached 10× more people than the photo alone.",
    "सही — कहानी और हैशटैग ने अकेली फ़ोटो से 10 गुना ज़्यादा लोगों तक पहुँच बनाई।",
    "শুদ্ধ — কাহিনী আৰু হেছটেগে অকল ফটোতকৈ ১০ গুণ বেছি মানুহৰ ওচৰ পালে।",
)
add(
    "csBestWrongMsg",
    "Look again — which bar is longest?",
    "फिर देखें — कौन-सी पट्टी सबसे लंबी है?",
    "আকৌ চাওক — কোনটো দণ্ড আটাইতকৈ দীঘল?",
)
add(
    "csYourWeekReached",
    "YOUR WEEK — PEOPLE REACHED",
    "आपका हफ़्ता — कितने लोगों तक पहुँचे",
    "আপোনাৰ সপ্তাহ — কিমান মানুহৰ ওচৰ পালে",
)
add(
    "csTallBarsNote",
    "Tall bars are your posting days. Post on your plan — reach follows.",
    "ऊँची पट्टियाँ आपके पोस्ट वाले दिन हैं। योजना के मुताबिक पोस्ट करें — पहुँच अपने आप बढ़ेगी।",
    "ওখ দণ্ডবোৰেই আপোনাৰ পোষ্ট কৰা দিন। পৰিকল্পনা মতে পোষ্ট কৰক — পৰিসৰ নিজেই বাঢ়িব।",
)

# ----------------------------------------------------------- practice feed tab
add("csPracticeFeed", "PRACTICE FEED", "अभ्यास फ़ीड", "অনুশীলন ফিড")
add(
    "csStaysOnYourPhone",
    "STAYS ON YOUR PHONE",
    "आपके फ़ोन में ही रहता है",
    "আপোনাৰ ফোনতে থাকে",
)
add("csFeedTimeNow", "Now", "अभी", "এতিয়া")
add("csFeedSampleTime1", "2 d", "2 दि", "২ দিন")
add("csFeedSampleTime2", "5 d", "5 दि", "৫ দিন")
add(
    "csFeedYourPhotoPlaceholder",
    "Your photo from the lessons",
    "पाठों में ली गई आपकी फ़ोटो",
    "পাঠবোৰত তোলা আপোনাৰ ফটো",
)
add(
    "csFeedSamplePlaceholder",
    "Drop a sample photo",
    "एक नमूना फ़ोटो डालें",
    "এখন নমুনা ফটো দিয়ক",
)
add_same("csFeedSampleUser1", "maya_ikat")
add_same("csFeedSampleUser2", "looms_of_naga")
add(
    "csFeedSampleCaption1",
    "Double ikat, tied and dyed by hand before weaving.",
    "डबल इकत — बुनने से पहले हाथ से बाँधा और रंगा।",
    "ডাবল ইকাট — বোৱাৰ আগতে হাতেৰে বান্ধি ৰং কৰা।",
)
add_same("csFeedSampleTags1", "#ikat #odishahandloom #handwoven")
add(
    "csFeedSampleCaption2",
    "Loin loom shawl — every stripe carries a meaning.",
    "कमर करघे की शॉल — हर धारी का एक मतलब है।",
    "কঁকাল তাঁতৰ চাদৰ — প্ৰতিটো ৰেখাৰ এটা অৰ্থ আছে।",
)
add_same("csFeedSampleTags2", "#nagashawl #loinloom #handwoven")
add_same("csFeedCommentUser1", "buyer_priya")
add_same("csFeedCommentUser2", "craft.lover")
add(
    "csFeedCommentBuyer",
    "Beautiful! Price please?",
    "बहुत सुंदर! दाम बताइए?",
    "অতি সুন্দৰ! দাম কিমান?",
)
add("csFeedCommentCraftLover", "Stunning work!", "कमाल का काम!", "অসাধাৰণ কাম!")
add(
    "csFeedTapHeart",
    "Tap the heart to see how buyers respond.",
    "दिल छूकर देखें कि ख़रीदार कैसे जवाब देते हैं।",
    "হৃদয়টোত টিপি চাওক গ্ৰাহকে কেনেকৈ সঁহাৰি দিয়ে।",
)

# --------------------------------------------------------------- progress tab
add("csYourProgress", "Your progress", "आपकी प्रगति", "আপোনাৰ প্ৰগতি")
add("csBadgesOfFive", "/ 5 badges", "/ 5 बैज", "/ ৫ বেজ")
add("csBadgePhotographer", "Photographer", "फ़ोटोग्राफ़र", "ফটোগ্ৰাফাৰ")
add("csBadgePageBuilder", "Page Builder", "पेज बनाने वाले", "পেজ নিৰ্মাতা")
add("csBadgeStoryteller", "Storyteller", "कहानीकार", "কাহিনীকাৰ")
add("csBadgePlanner", "Planner", "योजनाकार", "পৰিকল্পক")
add("csBadgeAnalyst", "Analyst", "विश्लेषक", "বিশ্লেষক")
add("csBadgeEarned", "EARNED", "मिल गया", "পোৱা হ'ল")
add("csBadgeLocked", "LOCKED", "अभी बंद", "এতিয়াও বন্ধ")
add(
    "csEditNameLanguageCluster",
    "EDIT NAME, LANGUAGE OR CLUSTER",
    "नाम, भाषा या क्लस्टर बदलें",
    "নাম, ভাষা বা ক্লাষ্টাৰ সলনি কৰক",
)
add(
    "csAccountCloudBackup",
    "ACCOUNT & CLOUD BACKUP",
    "अकाउंट और क्लाउड बैकअप",
    "একাউণ্ট আৰু ক্লাউড বেকআপ",
)
add(
    "csStartOverClearProgress",
    "START OVER — CLEAR ALL PROGRESS",
    "फिर से शुरू करें — सारी प्रगति मिटाएँ",
    "নতুনকৈ আৰম্ভ কৰক — সকলো প্ৰগতি মচক",
)
add("csStartOverTitle", "Start over?", "फिर से शुरू करें?", "নতুনকৈ আৰম্ভ কৰিবনে?")
add(
    "csStartOverBody",
    "This clears lesson badges and practice posts on this phone. Photos you "
    "already took stay in local storage.",
    "इससे इस फ़ोन के पाठ बैज और अभ्यास पोस्ट मिट जाएँगे। आपने जो फ़ोटो ले ली हैं, "
    "वे फ़ोन में सुरक्षित रहेंगी।",
    "ইয়াৰ দ্বাৰা এই ফোনৰ পাঠৰ বেজ আৰু অনুশীলন পোষ্টবোৰ মচি যাব। আপুনি ইতিমধ্যে "
    "তোলা ফটোবোৰ ফোনতে থাকিব।",
)
add("csCancel", "CANCEL", "रहने दें", "বাতিল কৰক")
add("csClear", "CLEAR", "मिटाएँ", "মচক")

# ------------------------------------------------------------- story kickers
add("csStoryKickerHeritage", "HERITAGE", "विरासत", "পৰম্পৰা")
add("csStoryKickerMaterial", "MATERIAL", "सामग्री", "উপাদান")
add("csStoryKickerProcess", "PROCESS", "प्रक्रिया", "প্ৰক্ৰিয়া")

# ------------------------------------------------------------------ clusters
CLUSTERS: list[dict] = [
    {
        "key": "Assam",
        "fabric": (
            "Mekhela sador — muga & eri silk",
            "मेखला सादोर — मूगा और एरी रेशम",
            "মেখেলা চাদৰ — মুগা আৰু এৰী পাট",
        ),
        "shortName": ("mekhela sador", "मेखला सादोर", "মেখেলা চাদৰ"),
        "place": (
            "Kamrup & Nalbari, Assam",
            "कामरूप और नलबाड़ी, असम",
            "কামৰূপ আৰু নলবাৰী, অসম",
        ),
        "bio": [
            ("Handloom weaver", "हथकरघा बुनकर", "হাতঁতশাল বয়নশিল্পী"),
            ("Kamrup, Assam", "कामरूप, असम", "কামৰূপ, অসম"),
            (
                "Mekhela sador & stoles",
                "मेखला सादोर और स्टोल",
                "মেখেলা চাদৰ আৰু ষ্ট'ল",
            ),
            ("DM to order", "ऑर्डर के लिए DM करें", "অৰ্ডাৰৰ বাবে DM কৰক"),
            (
                "3rd generation weaver",
                "तीसरी पीढ़ी का बुनकर",
                "তৃতীয় প্ৰজন্মৰ বয়নশিল্পী",
            ),
        ],
        "heritage": (
            "Muga — the golden silk only Assam grows.",
            "मूगा — सुनहरा रेशम, जो सिर्फ़ असम में होता है।",
            "মুগা — সোণালী পাট, কেৱল অসমতেই হয়।",
        ),
        "material": (
            "Handspun eri — soft as a shawl, warm as wool.",
            "हाथ से काता एरी — शॉल जैसा मुलायम, ऊन जैसा गरम।",
            "হাতেৰে কটা এৰী — চাদৰৰ দৰে কোমল, ঊলৰ দৰে উম।",
        ),
        "process": (
            "Woven at home, weeks on the loom, motif by motif.",
            "घर पर बुना, हफ़्तों करघे पर, एक-एक बूटी।",
            "ঘৰতে বোৱা, সপ্তাহজুৰি তাঁতত, এটা এটাকৈ ফুল।",
        ),
        "tags": [
            "#mekhelachador",
            "#mugasilk",
            "#erisilk",
            "#assamhandloom",
            "#handwoven",
            "#vocalforlocal",
            "#silksofindia",
            "#weaversofindia",
        ],
    },
    {
        "key": "Srikalahasti",
        "fabric": (
            "Kalamkari — hand-painted cotton",
            "कलमकारी — हाथ से चित्रित सूती कपड़ा",
            "কলমকাৰী — হাতেৰে অঁকা কপাহী কাপোৰ",
        ),
        "shortName": ("kalamkari", "कलमकारी", "কলমকাৰী"),
        "place": (
            "Srikalahasti, Andhra Pradesh",
            "श्रीकालहस्ती, आंध्र प्रदेश",
            "শ্ৰীকালাহস্তী, অন্ধ্ৰপ্ৰদেশ",
        ),
        "bio": [
            ("Kalamkari artist", "कलमकारी कलाकार", "কলমকাৰী শিল্পী"),
            (
                "Srikalahasti, Andhra Pradesh",
                "श्रीकालहस्ती, आंध्र प्रदेश",
                "শ্ৰীকালাহস্তী, অন্ধ্ৰপ্ৰদেশ",
            ),
            (
                "Hand-painted panels & saris",
                "हाथ से चित्रित पैनल और साड़ियाँ",
                "হাতেৰে অঁকা পেনেল আৰু শাড়ী",
            ),
            ("DM to order", "ऑर्डर के लिए DM करें", "অৰ্ডাৰৰ বাবে DM কৰক"),
            ("Temple-art family", "मंदिर कला वाला परिवार", "মন্দিৰ-শিল্পৰ পৰিয়াল"),
        ],
        "heritage": (
            "Temple stories, drawn with a bamboo kalam.",
            "मंदिर की कहानियाँ, बाँस की कलम से बनाई गईं।",
            "মন্দিৰৰ কাহিনী, বাঁহৰ কলমেৰে অঁকা।",
        ),
        "material": (
            "Cotton and natural dyes — myrobalan, iron, alum.",
            "सूती कपड़ा और प्राकृतिक रंग — हरड़, लोहा, फिटकरी।",
            "কপাহী কাপোৰ আৰু প্ৰাকৃতিক ৰং — শিলিখা, লো, ফটিকিৰি।",
        ),
        "process": (
            "Drawn line by line — no two pieces alike.",
            "एक-एक लकीर से बनी — कोई दो टुकड़े एक जैसे नहीं।",
            "এটা এটাকৈ ৰেখা টানি অঁকা — দুখন কাপোৰ একে নহয়।",
        ),
        "tags": [
            "#kalamkari",
            "#srikalahasti",
            "#naturaldyes",
            "#handpainted",
            "#craftindia",
            "#vocalforlocal",
            "#textileart",
            "#madeinindia",
        ],
    },
    {
        "key": "Venkatgiri",
        "fabric": (
            "Venkatgiri saree — fine cotton & zari",
            "वेंकटगिरी साड़ी — महीन सूती और ज़री",
            "ভেংকটগিৰি শাড়ী — মিহি কপাহ আৰু জৰি",
        ),
        "shortName": ("Venkatgiri saree", "वेंकटगिरी साड़ी", "ভেংকটগিৰি শাড়ী"),
        "place": (
            "Venkatgiri, Andhra Pradesh",
            "वेंकटगिरी, आंध्र प्रदेश",
            "ভেংকটগিৰি, অন্ধ্ৰপ্ৰদেশ",
        ),
        "bio": [
            ("Handloom weaver", "हथकरघा बुनकर", "হাতঁতশাল বয়নশিল্পী"),
            (
                "Venkatgiri, Andhra Pradesh",
                "वेंकटगिरी, आंध्र प्रदेश",
                "ভেংকটগিৰি, অন্ধ্ৰপ্ৰদেশ",
            ),
            (
                "Fine cotton & zari saris",
                "महीन सूती और ज़री की साड़ियाँ",
                "মিহি কপাহ আৰু জৰিৰ শাড়ী",
            ),
            ("DM to order", "ऑर्डर के लिए DM करें", "অৰ্ডাৰৰ বাবে DM কৰক"),
            (
                "Weaving family since 1970",
                "1970 से बुनकरों का परिवार",
                "১৯৭০ চনৰ পৰা বয়নশিল্পীৰ পৰিয়াল",
            ),
        ],
        "heritage": (
            "Once woven for the Venkatagiri court.",
            "कभी वेंकटगिरी दरबार के लिए बुनी जाती थी।",
            "এসময়ত ভেংকটগিৰি ৰাজদৰবাৰৰ বাবে বোৱা হৈছিল।",
        ),
        "material": (
            "Cotton so fine the saree floats.",
            "इतनी महीन सूती कि साड़ी हवा में तैरती है।",
            "ইমান মিহি কপাহ যে শাড়ীখন বতাহত ভাঁহে।",
        ),
        "process": (
            "Jamdani motifs — parrot, mango, swan — woven in by hand.",
            "जामदानी बूटियाँ — तोता, आम, हंस — हाथ से बुनी गईं।",
            "জামদানি ফুল — শুৱা, আম, ৰাজহাঁহ — হাতেৰে বোৱা।",
        ),
        "tags": [
            "#venkatagiri",
            "#jamdani",
            "#zari",
            "#handloomsaree",
            "#cottonsaree",
            "#vocalforlocal",
            "#sareesofinstagram",
            "#madeinindia",
        ],
    },
    {
        "key": "Maniabandha",
        "fabric": (
            "Khandua ikat — tie-dyed silk",
            "खंडुआ इकत — बाँधकर रंगा रेशम",
            "খণ্ডুৱা ইকাট — বান্ধি ৰং কৰা পাট",
        ),
        "shortName": ("Khandua ikat", "खंडुआ इकत", "খণ্ডুৱা ইকাট"),
        "place": ("Maniabandha, Odisha", "मणिआबंधा, ओडिशा", "মণিয়াবন্ধা, ওড়িশা"),
        "bio": [
            ("Ikat weaver", "इकत बुनकर", "ইকাট বয়নশিল্পী"),
            ("Maniabandha, Odisha", "मणिआबंधा, ओडिशा", "মণিয়াবন্ধা, ওড়িশা"),
            (
                "Khandua saris & stoles",
                "खंडुआ साड़ियाँ और स्टोल",
                "খণ্ডুৱা শাড়ী আৰু ষ্ট'ল",
            ),
            ("DM to order", "ऑर्डर के लिए DM करें", "অৰ্ডাৰৰ বাবে DM কৰক"),
            (
                "Weaver village on the Mahanadi",
                "महानदी किनारे बुनकरों का गाँव",
                "মহানদীৰ পাৰৰ বয়নশিল্পীৰ গাঁও",
            ),
        ],
        "heritage": (
            "Khandua — woven for Lord Jagannath.",
            "खंडुआ — भगवान जगन्नाथ के लिए बुनी जाती है।",
            "খণ্ডুৱা — ভগৱান জগন্নাথৰ বাবে বোৱা।",
        ),
        "material": (
            "Silk yarns tie-dyed before they ever meet the loom.",
            "रेशम के धागे करघे तक पहुँचने से पहले ही बाँधकर रंगे जाते हैं।",
            "পাটৰ সূতা তাঁতলৈ যোৱাৰ আগতেই বান্ধি ৰং কৰা হয়।",
        ),
        "process": (
            "The pattern is dyed into the thread, then woven true.",
            "नक़्शा धागे में ही रंगा जाता है, फिर हूबहू बुना जाता है।",
            "নক্সাটো সূতাতে ৰং কৰা হয়, তাৰ পিছত হুবহু বোৱা হয়।",
        ),
        "tags": [
            "#khandua",
            "#ikat",
            "#odishahandloom",
            "#maniabandha",
            "#handwoven",
            "#tiedye",
            "#vocalforlocal",
            "#sareelove",
        ],
    },
    {
        "key": "Gopalpur",
        "fabric": (
            "Gopalpur tussar — wild silk",
            "गोपालपुर तसर — जंगली रेशम",
            "গোপালপুৰ তচৰ — বনৰীয়া পাট",
        ),
        "shortName": ("tussar sari", "तसर साड़ी", "তচৰ শাড়ী"),
        "place": (
            "Gopalpur, Jajpur, Odisha",
            "गोपालपुर, जाजपुर, ओडिशा",
            "গোপালপুৰ, যাজপুৰ, ওড়িশা",
        ),
        "bio": [
            ("Tussar weaver", "तसर बुनकर", "তচৰ বয়নশিল্পী"),
            ("Gopalpur, Odisha", "गोपालपुर, ओडिशा", "গোপালপুৰ, ওড়িশা"),
            (
                "Saris, stoles & fabric",
                "साड़ियाँ, स्टोल और कपड़ा",
                "শাড়ী, ষ্ট'ল আৰু কাপোৰ",
            ),
            ("DM to order", "ऑर्डर के लिए DM करें", "অৰ্ডাৰৰ বাবে DM কৰক"),
            ("GI-tagged craft", "GI टैग वाला हुनर", "GI টেগ পোৱা শিল্প"),
        ],
        "heritage": (
            "Woven in Gopalpur since the 16th century — GI tagged.",
            "गोपालपुर में 16वीं सदी से बुनी जा रही है — GI टैग वाली।",
            "গোপালপুৰত ষোড়শ শতিকাৰ পৰা বোৱা হৈ আহিছে — GI টেগ পোৱা।",
        ),
        "material": (
            "Wild tussar — its gold is natural, not dye.",
            "जंगली तसर — इसका सुनहरापन प्राकृतिक है, रंग का नहीं।",
            "বনৰীয়া তচৰ — ইয়াৰ সোণালী ৰং প্ৰাকৃতিক, ৰং দি কৰা নহয়।",
        ),
        "process": (
            "Hand-reeled, hand-spun, extra-weft motifs.",
            "हाथ से लपेटा, हाथ से काता, अतिरिक्त बाने की बूटियाँ।",
            "হাতেৰে ঘূৰোৱা, হাতেৰে কটা, অতিৰিক্ত বানাৰ ফুল।",
        ),
        "tags": [
            "#tussarsilk",
            "#gopalpur",
            "#odishaweaves",
            "#wildsilk",
            "#handspun",
            "#vocalforlocal",
            "#silksofindia",
            "#handwoven",
        ],
    },
    {
        "key": "Nagaland",
        "fabric": (
            "Naga shawl — loin loom",
            "नगा शॉल — कमर करघा",
            "নগা চাদৰ — কঁকাল তাঁত",
        ),
        "shortName": ("Naga shawl", "नगा शॉल", "নগা চাদৰ"),
        "place": ("Nagaland clusters", "नगालैंड के क्लस्टर", "নাগালেণ্ডৰ ক্লাষ্টাৰ"),
        "bio": [
            ("Loin-loom weaver", "कमर करघा बुनकर", "কঁকাল তাঁতৰ বয়নশিল্পী"),
            ("Nagaland", "नगालैंड", "নাগালেণ্ড"),
            ("Shawls & mekhalas", "शॉल और मेखला", "চাদৰ আৰু মেখেলা"),
            ("DM to order", "ऑर्डर के लिए DM करें", "অৰ্ডাৰৰ বাবে DM কৰক"),
            ("Weaves of my tribe", "मेरे समुदाय की बुनाई", "মোৰ জনগোষ্ঠীৰ বোৱা কাপোৰ"),
        ],
        "heritage": (
            "Every stripe and motif tells who you are.",
            "हर धारी और हर बूटी बताती है कि आप कौन हैं।",
            "প্ৰতিটো ৰেখা আৰু ফুলে কয় আপুনি কোন।",
        ),
        "material": (
            "Thick cotton on the loin loom, dyed deep.",
            "कमर करघे पर मोटा सूती, गहरा रंगा।",
            "কঁকাল তাঁতত ডাঠ কপাহ, গাঢ় ৰঙেৰে ৰঙোৱা।",
        ),
        "process": (
            "Woven strip by strip, stitched into one shawl.",
            "पट्टी दर पट्टी बुनी, फिर सिलकर एक शॉल बनी।",
            "এডাল এডালকৈ পাত বোৱা, তাৰ পিছত জোৰা লগাই এখন চাদৰ।",
        ),
        "tags": [
            "#nagashawl",
            "#loinloom",
            "#nagaland",
            "#handwoven",
            "#tribaltextile",
            "#vocalforlocal",
            "#northeastindia",
            "#craftindia",
        ],
    },
]

for cluster in CLUSTERS:
    name = cluster["key"]
    add(f"csCluster{name}Fabric", *cluster["fabric"])
    add(f"csCluster{name}ShortName", *cluster["shortName"])
    add(f"csCluster{name}Place", *cluster["place"])
    for i, line in enumerate(cluster["bio"]):
        add(f"csCluster{name}Bio{i}", *line)
    add(f"csCluster{name}StoryHeritage", *cluster["heritage"])
    add(f"csCluster{name}StoryMaterial", *cluster["material"])
    add(f"csCluster{name}StoryProcess", *cluster["process"])
    for i, tag in enumerate(cluster["tags"]):
        add_same(f"csCluster{name}Tag{i}", tag)

# --------------------------------------------------- technique + product setup
add("csNewProductTitle", "New product", "नया उत्पाद", "নতুন সামগ্ৰী")
add("csHowIsItMade", "How is it made?", "यह कैसे बनता है?", "এইটো কেনেকৈ বনোৱা হয়?")
add(
    "csTechniqueSub",
    "The technique decides what the camera must show.",
    "तकनीक तय करती है कि कैमरे को क्या दिखाना है।",
    "কৌশলেই ঠিক কৰে কেমেৰাই কি দেখুৱাব লাগে।",
)
add("csTechniqueWoven", "WOVEN", "बुना हुआ", "বোৱা")
add("csTechniqueHandPainted", "HAND-PAINTED", "हाथ से चित्रित", "হাতেৰে অঁকা")
add(
    "csNextMaterialType",
    "NEXT — MATERIAL TYPE",
    "आगे — सामग्री का प्रकार",
    "পৰৱৰ্তী — উপাদানৰ ধৰণ",
)
add("csNextMaterial", "NEXT — MATERIAL", "आगे — सामग्री", "পৰৱৰ্তী — উপাদান")
add(
    "csWhatArePhotographing",
    "What are you photographing?",
    "आप किसकी फ़ोटो ले रहे हैं?",
    "আপুনি কিহৰ ফটো তুলিছে?",
)
add("csPickYourProduct", "Pick your product.", "अपना उत्पाद चुनें।", "আপোনাৰ সামগ্ৰী বাছক।")

# ------------------------------------------------------------------ pick frames
add("csPickYourFrames", "Pick your frames", "अपने फ़्रेम चुनें", "আপোনাৰ ফ্ৰেম বাছক")
add(
    "csPickFramesSub",
    "Which shots will you take? Choose at least two.",
    "आप कौन-सी तस्वीरें लेंगे? कम से कम दो चुनें।",
    "আপুনি কোনবোৰ ফটো তুলিব? কমেও দুটা বাছক।",
)
add(
    "csNoTemplatesYet",
    "No templates for this product yet.",
    "इस उत्पाद के लिए अभी कोई टेम्पलेट नहीं है।",
    "এই সামগ্ৰীৰ বাবে এতিয়ালৈকে কোনো টেমপ্লেট নাই।",
)
add("csNextFrameIt", "NEXT — FRAME IT", "आगे — फ़्रेम करें", "পৰৱৰ্তী — ফ্ৰেম কৰক")

# ----------------------------------------------------------------- framing quiz
add(
    "csFramingProgress",
    "FRAMING {index} OF {total}",
    "फ़्रेमिंग {index} / {total}",
    "ফ্ৰেমিং {index} / {total}",
    OrderedDict([("index", INT), ("total", INT)]),
)
add(
    "csFramingProgressNamed",
    "FRAMING {index} OF {total} — {names}",
    "फ़्रेमिंग {index} / {total} — {names}",
    "ফ্ৰেমিং {index} / {total} — {names}",
    OrderedDict([("index", INT), ("total", INT), ("names", STR)]),
)
add(
    "csFramingThirdsTitle",
    "Where should your product sit?",
    "आपका उत्पाद कहाँ रखा जाए?",
    "আপোনাৰ সামগ্ৰীটো ক'ত থাকিব লাগে?",
)
add(
    "csFramingThirdsSub",
    "Tap the best frame. The lines are the rule of thirds.",
    "सबसे अच्छा फ़्रेम छुएँ। ये लकीरें तिहाई का नियम हैं।",
    "সৰ্বোত্তম ফ্ৰেমটোত টিপক। ৰেখাবোৰেই হ'ল তিনিভাগৰ নিয়ম।",
)
add(
    "csFramingThirdsMsg0",
    "Dead centre feels flat. Try a crossing point.",
    "बिल्कुल बीच में रखने से तस्वीर सपाट लगती है। किसी कटान बिंदु पर रखकर देखें।",
    "একেবাৰে মাজত ৰাখিলে ফটোখন সমান লাগে। ৰেখা লগ লগা বিন্দুত ৰাখি চাওক।",
)
add(
    "csFramingThirdsMsg1",
    "Yes — set it where the lines cross. The photo breathes.",
    "हाँ — जहाँ लकीरें कटती हैं, वहाँ रखें। तस्वीर में साँस आ जाती है।",
    "হয় — য'ত ৰেখাবোৰ লগ লাগে তাতে ৰাখক। ফটোখনে উশাহ ল'ব।",
)
add(
    "csFramingThirdsMsg2",
    "Too close to the edge — the product gets cut off.",
    "किनारे के बहुत पास — उत्पाद कट जाता है।",
    "কাষৰ বৰ ওচৰত — সামগ্ৰীটো কাটি যায়।",
)
add(
    "csFramingCenterTitle",
    "How close should you go?",
    "कितना पास जाएँ?",
    "কিমান ওচৰলৈ যাব?",
)
add(
    "csFramingCenterSub",
    "Close-ups, flat lays and hung pieces sit centred — fill the middle box.",
    "पास से ली गई, समतल रखी और टँगी हुई चीज़ें बीच में रहती हैं — बीच का ख़ाना भरें।",
    "ওচৰৰ ফটো, সমানকৈ পাৰি থোৱা আৰু ওলোমাই থোৱা সামগ্ৰী মাজত থাকে — মাজৰ বাকচটো ভৰাওক।",
)
add(
    "csFramingCenterMsg0",
    "Too far away — the detail is lost. Step in.",
    "बहुत दूर — बारीकी खो जाती है। पास आएँ।",
    "বৰ দূৰত — সূক্ষ্মতা হেৰাই যায়। ওচৰলৈ আহক।",
)
add(
    "csFramingCenterMsg1",
    "Yes — fill the centre box, edges parallel to the frame.",
    "हाँ — बीच का ख़ाना भरें, किनारे फ़्रेम के समानांतर रखें।",
    "হয় — মাজৰ বাকচটো ভৰাওক, প্ৰান্তবোৰ ফ্ৰেমৰ সমান্তৰালকৈ ৰাখক।",
)
add(
    "csFramingCenterMsg2",
    "Half out of the frame — centre it before you shoot.",
    "आधा फ़्रेम से बाहर — फ़ोटो लेने से पहले इसे बीच में लाएँ।",
    "আধা ফ্ৰেমৰ বাহিৰত — ফটো তোলাৰ আগতে মাজলৈ আনক।",
)
add(
    "csFramingDiagTitle",
    "How should the fabric flow?",
    "कपड़ा किस तरह बहे?",
    "কাপোৰখন কেনেকৈ বৈ যাব লাগে?",
)
add(
    "csFramingDiagSub",
    "Drapes and macro shots move along the diagonal — let the cloth lead the eye.",
    "लटकते कपड़े और बारीक तस्वीरें तिरछी लकीर पर चलती हैं — कपड़े को नज़र की राह बनने दें।",
    "ওলোমা কাপোৰ আৰু সূক্ষ্ম ফটো কোণাকৈ যায় — কাপোৰখনকে চকুৰ বাট হ'বলৈ দিয়ক।",
)
add(
    "csFramingDiagMsg0",
    "A flat row has no movement. Let it fall along the line.",
    "सीधी कतार में कोई हलचल नहीं होती। इसे तिरछी लकीर पर गिरने दें।",
    "পোনে পোনে শাৰীত কোনো গতি নাই। কোণৰ ৰেখাত পৰিবলৈ দিয়ক।",
)
add(
    "csFramingDiagMsg1",
    "Yes — the folds step down the diagonal and the eye follows.",
    "हाँ — सिलवटें तिरछी लकीर पर उतरती हैं और नज़र साथ चलती है।",
    "হয় — ভাঁজবোৰ কোণৰ ৰেখাত নামি যায় আৰু চকুৱে সেই বাটেৰে যায়।",
)
add(
    "csFramingDiagMsg2",
    "Bunched in a corner — the flow is gone.",
    "एक कोने में सिमटा हुआ — बहाव ख़त्म।",
    "এটা চুকত গোট খাই আছে — বৈ যোৱা ভাবটো নাইকিয়া।",
)
add(
    "csFramingDetailTitle",
    "How much border in the frame?",
    "फ़्रेम में किनारा कितना हो?",
    "ফ্ৰেমত আঁচল কিমান থাকিব?",
)
add(
    "csFramingDetailSub",
    "Border, motif and folded shots: fill the detail frame with the work itself.",
    "किनारा, बूटी और तह वाली तस्वीरें: बारीकी वाले फ़्रेम को काम से ही भरें।",
    "আঁচল, ফুল আৰু ভাঁজ কৰা ফটো: সূক্ষ্ম ফ্ৰেমটো কামটোৰেই ভৰাওক।",
)
add(
    "csFramingDetailMsg0",
    "Too thin, too far — nobody can see the craft.",
    "बहुत पतला, बहुत दूर — हुनर किसी को दिखता ही नहीं।",
    "বৰ পাতল, বৰ দূৰ — শিল্পটো কোনেও দেখা নাপায়।",
)
add(
    "csFramingDetailMsg1",
    "Yes — the border fills the frame, close enough to count threads.",
    "हाँ — किनारा पूरा फ़्रेम भरता है, इतना पास कि धागे गिने जा सकें।",
    "হয় — আঁচলে গোটেই ফ্ৰেম ভৰাইছে, ইমান ওচৰ যে সূতা গণিব পাৰি।",
)
add(
    "csFramingDetailMsg2",
    "A floating square shows neither border nor motif. Follow the band.",
    "हवा में तैरता चौकोर न किनारा दिखाता है, न बूटी। पट्टी के साथ चलें।",
    "বতাহত ভাঁহি থকা চতুৰ্ভুজে আঁচলো নেদেখুৱায়, ফুলো নেদেখুৱায়। পাতটোৰ লগে লগে যাওক।",
)
add("csNextFraming", "NEXT FRAMING", "अगली फ़्रेमिंग", "পৰৱৰ্তী ফ্ৰেমিং")
add("csNextLightIt", "NEXT — LIGHT IT", "आगे — रोशनी दें", "পৰৱৰ্তী — পোহৰ দিয়ক")

# ------------------------------------------------------------------- light quiz
add("csLightSide", "Light from the side", "बग़ल से रोशनी", "কাষৰ পৰা পোহৰ")
add(
    "csLightFront",
    "Soft light from the front",
    "सामने से नरम रोशनी",
    "সন্মুখৰ পৰা কোমল পোহৰ",
)
add("csLightBack", "Light from behind", "पीछे से रोशनी", "পিছফালৰ পৰা পোহৰ")
add(
    "csLightHeadingPanel",
    "A painted panel hates glare.",
    "चित्रित पैनल को चमक पसंद नहीं।",
    "অঁকা পেনেলে চিকমিকনি নিবিচাৰে।",
)
add(
    "csLightHeadingPainted",
    "Painted by hand — keep it even.",
    "हाथ से चित्रित — रोशनी बराबर रखें।",
    "হাতেৰে অঁকা — পোহৰ সমানে ৰাখক।",
)
add(
    "csLightHeadingSilk",
    "Silk shines. Make it glow.",
    "रेशम चमकता है। उसे दमकने दें।",
    "পাট চিকমিকায়। ইয়াক জিলিকিবলৈ দিয়ক।",
)
add(
    "csLightHeadingCotton",
    "Cotton is soft. Keep the light soft.",
    "सूती नरम होती है। रोशनी भी नरम रखें।",
    "কপাহ কোমল। পোহৰো কোমল ৰাখক।",
)
add(
    "csLightPromptPanel",
    "A painting on cloth reflects. Light it flat and soft.",
    "कपड़े पर बनी पेंटिंग चमक लौटाती है। रोशनी सपाट और नरम रखें।",
    "কাপোৰত অঁকা ছবিয়ে পোহৰ ওভতাই দিয়ে। পোহৰ সমান আৰু কোমল ৰাখক।",
)
add(
    "csLightPromptPainted",
    "Pick the light that keeps painted colours true.",
    "वह रोशनी चुनें जो चित्रित रंगों को सही रखे।",
    "অঁকা ৰংবোৰ সঁচা কৰি ৰখা পোহৰটো বাছক।",
)
add(
    "csLightPromptSilk",
    "Pick the light that shows your silk best.",
    "वह रोशनी चुनें जो आपके रेशम को सबसे अच्छा दिखाए।",
    "আপোনাৰ পাট আটাইতকৈ ভালকৈ দেখুৱা পোহৰটো বাছক।",
)
add(
    "csLightPromptDefault",
    "Pick the light that shows your product best.",
    "वह रोशनी चुनें जो आपके उत्पाद को सबसे अच्छा दिखाए।",
    "আপোনাৰ সামগ্ৰী আটাইতকৈ ভালকৈ দেখুৱা পোহৰটো বাছক।",
)
add(
    "csLightWhyPanel",
    "Right — soft, even, diffused light from the front. Natural-dye colours "
    "stay true and nothing shines back at the camera. Never use flash.",
    "सही — सामने से नरम, बराबर, फैली हुई रोशनी। प्राकृतिक रंग सही दिखते हैं और "
    "कैमरे में कोई चमक नहीं आती। फ़्लैश कभी न चलाएँ।",
    "শুদ্ধ — সন্মুখৰ পৰা কোমল, সমান, বিয়পি পৰা পোহৰ। প্ৰাকৃতিক ৰংবোৰ সঁচা থাকে "
    "আৰু কেমেৰালৈ একো চিকমিকনি নাহে। কেতিয়াও ফ্লেচ নিদিব।",
)
add(
    "csLightWhyPainted",
    "Right — even front light keeps the colours true, no glare on the painted "
    "surface.",
    "सही — सामने से बराबर रोशनी रंगों को सही रखती है, चित्रित सतह पर कोई चमक नहीं।",
    "শুদ্ধ — সন্মুখৰ সমান পোহৰে ৰংবোৰ সঁচা কৰি ৰাখে, অঁকা পৃষ্ঠত চিকমিকনি নাথাকে।",
)
add(
    "csLightWhySilk",
    "Right — side light catches the lustre of the silk.",
    "सही — बग़ल की रोशनी रेशम की चमक पकड़ लेती है।",
    "শুদ্ধ — কাষৰ পোহৰে পাটৰ জিলিকনি ধৰি লয়।",
)
add(
    "csLightWhyCotton",
    "Right — soft front light keeps cotton gentle and its colours true.",
    "सही — सामने से नरम रोशनी सूती को कोमल और उसके रंगों को सही रखती है।",
    "শুদ্ধ — সন্মুখৰ কোমল পোহৰে কপাহক কোমল আৰু ইয়াৰ ৰং সঁচা কৰি ৰাখে।",
)
add(
    "csLightWrongPanel",
    "Raking side light throws shadows across the brushwork and catches glare "
    "on the surface. Keep it even and diffused.",
    "बग़ल से पड़ती तिरछी रोशनी ब्रश के काम पर परछाइयाँ डालती है और सतह पर चमक ले "
    "आती है। रोशनी बराबर और फैली हुई रखें।",
    "কাষৰ পৰা পৰা তীব্ৰ পোহৰে বুৰুচৰ কামত ছাঁ পেলায় আৰু পৃষ্ঠত চিকমিকনি আনে। "
    "পোহৰ সমান আৰু বিয়পি পৰা ৰাখক।",
)
add(
    "csLightWrongPainted",
    "Side light throws shadows across the painted work. Keep it soft and even.",
    "बग़ल की रोशनी चित्रित काम पर परछाइयाँ डालती है। रोशनी नरम और बराबर रखें।",
    "কাষৰ পোহৰে অঁকা কামত ছাঁ পেলায়। পোহৰ কোমল আৰু সমান ৰাখক।",
)
add(
    "csLightWrongSilk",
    "Flat front light kills the shine. Bring the light around to the side.",
    "सामने की सपाट रोशनी चमक मार देती है। रोशनी को बग़ल में ले आएँ।",
    "সন্মুখৰ সমান পোহৰে জিলিকনি মাৰি পেলায়। পোহৰটো কাষলৈ আনক।",
)
add(
    "csLightWrongCotton",
    "Hard side light makes cotton look rough. Keep it soft, from the front.",
    "बग़ल की तेज़ रोशनी सूती को खुरदरा दिखाती है। सामने से नरम रोशनी रखें।",
    "কাষৰ কঠিন পোহৰে কপাহক ৰুক্ষ দেখুৱায়। সন্মুখৰ পৰা কোমল পোহৰ ৰাখক।",
)
add(
    "csLightWrongBacklight",
    "Backlight turns your product into a shadow. Save it for the thickness shot.",
    "पीछे की रोशनी आपके उत्पाद को परछाईं बना देती है। इसे मोटाई वाली तस्वीर के लिए रखें।",
    "পিছফালৰ পোহৰে আপোনাৰ সামগ্ৰীক ছাঁলৈ পৰিণত কৰে। ইয়াক ডাঠৰ ফটোৰ বাবে ৰাখক।",
)
add("csLightTipDoThisBadge", "DO THIS", "ऐसा करें", "এইদৰে কৰক")
add(
    "csLightTipDoThisBody",
    "Big soft window, curtain drawn. Even light across the whole panel — every "
    "colour true, no shine.",
    "बड़ी खिड़की की नरम रोशनी, पर्दा खींचा हुआ। पूरे पैनल पर बराबर रोशनी — हर रंग "
    "सही, कोई चमक नहीं।",
    "ডাঙৰ খিৰিকীৰ কোমল পোহৰ, পৰ্দা টনা। গোটেই পেনেলত সমান পোহৰ — প্ৰতিটো ৰং "
    "সঁচা, চিকমিকনি নাই।",
)
add("csLightTipNeverFlashBadge", "NEVER FLASH", "फ़्लैश कभी नहीं", "কেতিয়াও ফ্লেচ নহয়")
add(
    "csLightTipNeverFlashBody",
    "Flash bounces straight back — a white glare spot burns out the painting.",
    "फ़्लैश सीधा लौटकर आता है — एक सफ़ेद चमकीला धब्बा पेंटिंग को जला देता है।",
    "ফ্লেচ পোনে পোনে ওভতি আহে — এটা বগা চিকমিকনিৰ দাগে ছবিখন পুৰি পেলায়।",
)
add(
    "csLightTipAvoidSideBadge",
    "AVOID HARD SIDE LIGHT",
    "तेज़ बग़ल की रोशनी से बचें",
    "কাষৰ কঠিন পোহৰ এৰাই চলক",
)
add(
    "csLightTipAvoidSideBody",
    "A lamp or sun from one side drags shadows across the brushwork and the "
    "cloth texture fights the painting.",
    "एक तरफ़ से आती लैंप या धूप ब्रश के काम पर परछाइयाँ खींच देती है और कपड़े की "
    "बुनावट पेंटिंग से टकराने लगती है।",
    "এফালৰ পৰা অহা বাতি বা ৰ'দে বুৰুচৰ কামত ছাঁ টানি আনে আৰু কাপোৰৰ বুননিয়ে "
    "ছবিখনৰ লগত যুঁজ লগায়।",
)
add("csLightNowPick", "Now pick the right light", "अब सही रोशनी चुनें", "এতিয়া সঠিক পোহৰটো বাছক")
add("csNextShootYours", "NEXT — SHOOT YOURS", "आगे — अपनी फ़ोटो लें", "পৰৱৰ্তী — নিজৰ ফটো তোলক")

# ------------------------------------------------------------- shared / badges
add(
    "csFinishEarnBadge",
    "FINISH — EARN BADGE",
    "पूरा करें — बैज पाएँ",
    "সম্পূৰ্ণ কৰক — বেজ পাওক",
)


LOCALE_INDEX = {"en": 1, "hi": 2, "as": 3}


def merge(locale: str) -> tuple[int, int]:
    path = L10N_DIR / f"app_{locale}.arb"
    data = json.loads(path.read_text(encoding="utf-8-sig"), object_pairs_hook=OrderedDict)

    idx = LOCALE_INDEX[locale]
    added = 0
    updated = 0

    for entry in ENTRIES:
        key = entry[0]
        value = entry[idx]
        placeholders = entry[4]

        if key in data:
            if data[key] != value:
                updated += 1
        else:
            added += 1
        data[key] = value

        meta_key = f"@{key}"
        if placeholders:
            data[meta_key] = OrderedDict([("placeholders", placeholders)])
        elif meta_key in data:
            del data[meta_key]

    path.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    return added, updated


def main() -> None:
    keys = [e[0] for e in ENTRIES]
    duplicates = {k for k in keys if keys.count(k) > 1}
    if duplicates:
        raise SystemExit(f"Duplicate keys defined: {sorted(duplicates)}")

    print(f"Defined {len(ENTRIES)} cs* keys.")
    for locale in ("en", "hi", "as"):
        added, updated = merge(locale)
        print(f"  app_{locale}.arb: {added} keys added, {updated} updated")


if __name__ == "__main__":
    main()
