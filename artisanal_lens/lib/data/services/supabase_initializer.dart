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
}

SupabaseClient? get supabaseClient =>
    SupabaseConfig.isConfigured ? Supabase.instance.client : null;
