import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/services/auth_service.dart';
import '../data/services/click_social_sync_service.dart';
import '../data/services/cloud_sync_service.dart';
import '../data/services/supabase_initializer.dart';
import '../features/home/shot_sets_controller.dart';
import 'providers.dart';

/// Signed-in artisan state for the account screen and sync triggers.
class AuthSession {
  const AuthSession({this.user, this.username});

  const AuthSession.signedOut() : user = null, username = null;

  final User? user;
  final String? username;

  bool get isSignedIn => user != null && user!.isAnonymous != true;
}

class AuthController extends Notifier<AuthSession> {
  AuthService get _auth => ref.read(authServiceProvider);
  StreamSubscription<AuthState>? _subscription;

  @override
  AuthSession build() {
    _subscription?.cancel();
    _subscription = _auth.authStateChanges.listen(_onAuthStateChanged);
    ref.onDispose(() => _subscription?.cancel());

    final user = _auth.currentUser;
    if (user == null || user.isAnonymous) return const AuthSession.signedOut();
    return AuthSession(
      user: user,
      username: _auth.usernameFromUser(user),
    );
  }

  Future<void> _onAuthStateChanged(AuthState event) async {
    final user = event.session?.user;
    if (user == null || user.isAnonymous) {
      state = const AuthSession.signedOut();
      if (user != null) {
        await _syncAfterSignIn();
      }
      return;
    }

    state = AuthSession(
      user: user,
      username: _auth.usernameFromUser(user),
    );

    if (event.event == AuthChangeEvent.signedIn ||
        event.event == AuthChangeEvent.tokenRefreshed) {
      await _syncAfterSignIn();
    }
  }

  Future<void> signUp({
    required String username,
    required String password,
  }) async {
    await _auth.signUp(username: username, password: password);
    await _syncAfterSignIn();
  }

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    await _auth.signIn(username: username, password: password);
    await _syncAfterSignIn();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    state = const AuthSession.signedOut();
    await ensureLearnerSession();
  }

  Future<CloudSyncResult> syncNow() async {
    await ClickSocialSync.reconcile();
    final sync = ref.read(cloudSyncServiceProvider);
    final result = await sync.syncAll();
    if (result.didWork) {
      await ref.read(shotSetsProvider.notifier).refreshFromDatabase();
    }
    return result;
  }

  Future<void> _syncAfterSignIn() async {
    await ClickSocialSync.reconcile();
    final sync = ref.read(cloudSyncServiceProvider);
    if (!sync.canSync) return;
    final result = await sync.syncAll();
    if (result.didWork) {
      await ref.read(shotSetsProvider.notifier).refreshFromDatabase();
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authControllerProvider =
    NotifierProvider<AuthController, AuthSession>(AuthController.new);
