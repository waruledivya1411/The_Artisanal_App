import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Languages offered in the Click & Social lesson (HTML onboarding chips).
enum AppLanguage {
  english('en', 'English'),
  assamese('as', 'অসমীয়া'),
  odia('or', 'ଓଡ଼ିଆ'),
  telugu('te', 'తెలుగు');

  const AppLanguage(this.code, this.label);

  final String code;

  /// Native script label shown on language chips.
  final String label;

  Locale get locale => Locale(code);

  static AppLanguage fromCode(String? code) {
    // Migrated away from Hindi — fall back to English if an old install
    // still has `hi` stored.
    if (code == 'hi') return AppLanguage.english;
    for (final language in AppLanguage.values) {
      if (language.code == code) return language;
    }
    return AppLanguage.english;
  }
}

/// Remembers the chosen language across launches.
///
/// A setting that forgets itself on restart is not a setting, so this writes
/// through to disk on every change and is read back before the first frame.
class LocaleController extends Notifier<AppLanguage> {
  static const String _prefsKey = 'app_language';

  SharedPreferences? _prefs;

  @override
  AppLanguage build() {
    _restore();
    return AppLanguage.english;
  }

  Future<void> _restore() async {
    _prefs = await SharedPreferences.getInstance();
    final stored = _prefs?.getString(_prefsKey);
    if (stored != null) {
      state = AppLanguage.fromCode(stored);
    }
  }

  Future<void> select(AppLanguage language) async {
    if (language == state) return;
    state = language;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(_prefsKey, language.code);
  }
}

final localeProvider =
    NotifierProvider<LocaleController, AppLanguage>(LocaleController.new);
