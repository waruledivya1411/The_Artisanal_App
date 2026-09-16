import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/supabase_config.dart';

/// Boots Supabase when [SupabaseConfig.isConfigured] is true.
///
/// When the backend is disconnected (`SupabaseConfig.enabled == false`) the
/// app stays fully offline; auth, sync, and remote tutorials stay dormant.
Future<void> initializeSupabase() async {
  if (!SupabaseConfig.isConfigured) {
    debugPrint(
      'Supabase: disconnected. Set SupabaseConfig.enabled = true to reconnect.',
    );
    return;
  }

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );
  debugPrint('Supabase: initialized.');
  await ensureLearnerSession();
}

/// Gives the lesson flow a cloud identity without a settings password.
///
/// Anonymous sessions persist on the phone. Creating an account later upgrades
/// that same user so badges and photos stay attached.
Future<void> ensureLearnerSession() async {
  final client = supabaseClient;
  if (client == null || client.auth.currentSession != null) return;
  try {
    await client.auth.signInAnonymously();
    debugPrint('Supabase: anonymous learner session ready.');
  } catch (error) {
    debugPrint(
      'Supabase: anonymous session unavailable ($error). '
      'Enable Anonymous sign-ins in Authentication → Providers.',
    );
  }
}

SupabaseClient? get supabaseClient =>
    SupabaseConfig.isConfigured ? Supabase.instance.client : null;
