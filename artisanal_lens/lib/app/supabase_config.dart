/// Supabase project credentials.
///
/// Backend is off for UI-only runs (emulator / APK). Set [enabled] to `true`
/// when cloud auth and lesson sync should come back.
///
/// Override credentials at build time when re-enabling:
///
/// ```bash
/// flutter run --dart-define-from-file=supabase.local.json
/// ```
abstract final class SupabaseConfig {
  /// Flip to `true` to reconnect Supabase auth, sync, and remote tutorials.
  static const bool enabled = false;

  static const _defaultUrl = 'https://tghlozzogdkejgophiqs.supabase.co';
  static const _defaultAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRnaGxvenpvZ2RrZWpnb3BoaXFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODc5MDE3ODAsImV4cCI6MjEwMzQ3Nzc4MH0.mz3PdT3Br7zOjtb05JbveC6Fy4iLMcGwTfKp6eNjxgM';

  static const url = String.fromEnvironment('SUPABASE_URL', defaultValue: _defaultUrl);
  static const anonKey =
      String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: _defaultAnonKey);

  static const photosBucket = 'photos';
  static const tutorialVideosBucket = 'tutorial-videos';
  static const tutorialImagesBucket = 'tutorial-images';

  static bool get isConfigured =>
      enabled && url.isNotEmpty && anonKey.isNotEmpty;
}
