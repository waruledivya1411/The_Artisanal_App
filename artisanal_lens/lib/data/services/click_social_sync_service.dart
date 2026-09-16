import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/supabase_config.dart';
import '../../features/home/click_social_store.dart';
import '../datasources/photo_storage.dart';
import 'supabase_initializer.dart';

/// Backs up the Click & Social journey (profile, badges, Instagram, post).
///
/// Local prefs stay the source of truth. A signed-in session — including a
/// silent anonymous one — pushes after each lesson step and pulls a newer
/// cloud copy when the artisan signs in on another phone.
class ClickSocialSync {
  ClickSocialSync._();

  static Future<void>? _inFlight;

  /// Bumps after a cloud copy is written onto this phone so open screens reload.
  static final pulled = ValueNotifier<int>(0);

  /// Fire-and-forget push. Failures stay local; the next step retries.
  static void schedulePush() {
    unawaited(push());
  }

  static bool _queued = false;

  static Future<void> push() {
    if (_inFlight != null) {
      _queued = true;
      return _inFlight!;
    }
    final run = _reconcile(preferLocal: true).whenComplete(() {
      _inFlight = null;
      if (_queued) {
        _queued = false;
        push();
      }
    });
    _inFlight = run;
    return run;
  }

  /// Used after sign-in: take the newer of local and cloud.
  static Future<void> reconcile() {
    if (_inFlight != null) return _inFlight!;
    final run = _reconcile(preferLocal: false).whenComplete(() {
      _inFlight = null;
    });
    _inFlight = run;
    return run;
  }

  static Future<void> _reconcile({required bool preferLocal}) async {
    try {
      await ensureLearnerSession();
      final client = supabaseClient;
      final user = client?.auth.currentUser;
      if (client == null || user == null) return;

      final local = await ClickSocialStore.load();
      final remoteRow = await client
          .from('learner_progress')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();

      if (remoteRow != null && !preferLocal) {
        final remoteAt = DateTime.tryParse('${remoteRow['updated_at']}')?.toLocal();
        if (remoteAt != null && remoteAt.isAfter(local.updatedAt)) {
          await _applyRemote(client, remoteRow);
          pulled.value++;
          return;
        }
      }

      await _push(client, user.id, local);
    } catch (error, stack) {
      debugPrint('Click & Social sync skipped: $error\n$stack');
    }
  }

  static Future<void> _push(
    SupabaseClient client,
    String userId,
    ClickSocialSnapshot local,
  ) async {
    final storage = createPhotoStorage();
    final profilePath = await _uploadIfLocal(
      client,
      storage,
      userId: userId,
      localPath: local.profilePhotoPath,
      folder: 'profile',
      name: 'avatar',
    );
    final postPath = await _uploadIfLocal(
      client,
      storage,
      userId: userId,
      localPath: local.postMediaPath,
      folder: 'posts',
      name: 'practice',
    );

    final now = DateTime.now().toUtc();
    await client.from('profiles').upsert({
      'id': userId,
      'display_name': local.name.isEmpty ? null : local.name,
      'preferred_locale': local.language,
      'updated_at': now.toIso8601String(),
    });

    await client.from('learner_progress').upsert({
      'user_id': userId,
      'display_name': local.name.isEmpty ? null : local.name,
      'cluster_id': local.clusterId,
      'language': local.language,
      'onboarded': local.onboarded,
      'lesson_photo_done': local.photoDone,
      'lesson_profile_done': local.profileDone,
      'lesson_content_done': local.contentDone,
      'lesson_strategy_done': local.strategyDone,
      'lesson_analytics_done': local.analyticsDone,
      'ig_username': local.igUsername,
      'ig_bio': local.igBio,
      'ig_category': local.igCategory,
      'profile_photo_path': profilePath,
      'post_caption': local.postCaption,
      'post_tags': local.postTags,
      'post_user': local.postUser,
      'post_media_path': postPath,
      'post_media_is_video': local.postMediaIsVideo,
      'shoot_meta': {
        'frames': local.framePicks,
        'techniques': local.techniques,
      },
      'updated_at': now.toIso8601String(),
    });
  }

  static Future<void> _applyRemote(
    SupabaseClient client,
    Map<String, dynamic> row,
  ) async {
    final storage = createPhotoStorage();
    final profileLocal = await _downloadIfRemote(
      client,
      storage,
      storagePath: row['profile_photo_path'] as String?,
      setId: 'lesson02_profile',
      shotId: 'avatar',
    );
    final postLocal = await _downloadIfRemote(
      client,
      storage,
      storagePath: row['post_media_path'] as String?,
      setId: 'lesson03_post',
      shotId: 'practice',
    );

    final meta = row['shoot_meta'];
    final frames = <String, String>{};
    final techniques = <String, String>{};
    if (meta is Map) {
      final rawFrames = meta['frames'];
      final rawTechniques = meta['techniques'];
      if (rawFrames is Map) {
        rawFrames.forEach((key, value) {
          if (value != null) frames['$key'] = '$value';
        });
      }
      if (rawTechniques is Map) {
        rawTechniques.forEach((key, value) {
          if (value != null) techniques['$key'] = '$value';
        });
      }
    }

    final bio = row['ig_bio'];
    await ClickSocialStore.apply(
      ClickSocialSnapshot(
        updatedAt: DateTime.tryParse('${row['updated_at']}')?.toLocal() ??
            DateTime.now(),
        onboarded: row['onboarded'] == true,
        name: '${row['display_name'] ?? ''}',
        clusterId: row['cluster_id'] as String?,
        language: '${row['language'] ?? 'en'}',
        photoDone: row['lesson_photo_done'] == true,
        profileDone: row['lesson_profile_done'] == true,
        contentDone: row['lesson_content_done'] == true,
        strategyDone: row['lesson_strategy_done'] == true,
        analyticsDone: row['lesson_analytics_done'] == true,
        igUsername: row['ig_username'] as String?,
        igBio: bio is List ? bio.map((item) => '$item').toList() : const [],
        igCategory: row['ig_category'] as String?,
        profilePhotoPath: profileLocal,
        postCaption: row['post_caption'] as String?,
        postTags: row['post_tags'] as String?,
        postUser: row['post_user'] as String?,
        postMediaPath: postLocal,
        postMediaIsVideo: row['post_media_is_video'] == true,
        framePicks: frames,
        techniques: techniques,
      ),
    );
  }

  static Future<String?> _uploadIfLocal(
    SupabaseClient client,
    PhotoStorage storage, {
    required String userId,
    required String? localPath,
    required String folder,
    required String name,
  }) async {
    if (localPath == null || localPath.isEmpty) return null;
    if (localPath.startsWith('$userId/')) return localPath;
    final bytes = await storage.readBytes(localPath);
    if (bytes == null) return null;

    final ext = p.extension(localPath).isEmpty ? '.jpg' : p.extension(localPath);
    final storagePath = '$userId/$folder/$name$ext';
    await client.storage.from(SupabaseConfig.photosBucket).uploadBinary(
          storagePath,
          bytes,
          fileOptions: FileOptions(
            contentType: _contentType(ext),
            upsert: true,
          ),
        );
    return storagePath;
  }

  static Future<String?> _downloadIfRemote(
    SupabaseClient client,
    PhotoStorage storage, {
    required String? storagePath,
    required String setId,
    required String shotId,
  }) async {
    if (storagePath == null || storagePath.isEmpty) return null;
    if (!storagePath.contains('/')) return storagePath;
    try {
      final bytes = await client.storage
          .from(SupabaseConfig.photosBucket)
          .download(storagePath);
      final ext = p.extension(storagePath);
      return storage.persistBytes(
        bytes,
        setId: setId,
        shotId: shotId,
        extension: ext.isEmpty ? '.jpg' : ext,
      );
    } catch (error) {
      debugPrint('Could not download $storagePath: $error');
      return null;
    }
  }

  static String _contentType(String extension) => switch (extension.toLowerCase()) {
        '.png' => 'image/png',
        '.webp' => 'image/webp',
        '.gif' => 'image/gif',
        '.mp4' => 'video/mp4',
        '.mov' => 'video/quicktime',
        '.m4v' => 'video/mp4',
        '.webm' => 'video/webm',
        _ => 'image/jpeg',
      };
}
