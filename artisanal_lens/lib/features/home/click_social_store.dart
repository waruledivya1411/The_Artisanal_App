import 'package:shared_preferences/shared_preferences.dart';

import '../checklist/click_social_frames.dart';

/// Local Click & Social progress. The phone is the source of truth; the cloud
/// copy is a backup of this snapshot.
class ClickSocialSnapshot {
  const ClickSocialSnapshot({
    required this.updatedAt,
    required this.onboarded,
    required this.name,
    required this.clusterId,
    required this.language,
    required this.photoDone,
    required this.profileDone,
    required this.contentDone,
    required this.strategyDone,
    required this.analyticsDone,
    required this.igUsername,
    required this.igBio,
    required this.igCategory,
    required this.profilePhotoPath,
    required this.postCaption,
    required this.postTags,
    required this.postUser,
    required this.postMediaPath,
    required this.postMediaIsVideo,
    required this.framePicks,
    required this.techniques,
  });

  final DateTime updatedAt;
  final bool onboarded;
  final String name;
  final String? clusterId;
  final String language;
  final bool photoDone;
  final bool profileDone;
  final bool contentDone;
  final bool strategyDone;
  final bool analyticsDone;
  final String? igUsername;
  final List<String> igBio;
  final String? igCategory;
  final String? profilePhotoPath;
  final String? postCaption;
  final String? postTags;
  final String? postUser;
  final String? postMediaPath;
  final bool postMediaIsVideo;
  final Map<String, String> framePicks;
  final Map<String, String> techniques;

  bool get hasContent =>
      onboarded ||
      name.isNotEmpty ||
      photoDone ||
      profileDone ||
      contentDone ||
      strategyDone ||
      analyticsDone ||
      (igUsername != null && igUsername!.isNotEmpty) ||
      (postCaption != null && postCaption!.isNotEmpty);
}

/// SharedPreferences keys for the Click & Social flow.
abstract final class ClickSocialStore {
  static const onboarded = 'click_social_onboarded';
  static const name = 'click_social_name';
  static const clusterId = clickSocialClusterKey;
  static const language = 'click_social_language';
  static const updatedAt = 'click_social_updated_at';
  static const photoDone = 'click_social_lesson_photo_done';
  static const profileDone = 'click_social_lesson_profile_done';
  static const contentDone = 'click_social_lesson_content_done';
  static const strategyDone = 'click_social_lesson_strategy_done';
  static const analyticsDone = 'click_social_lesson_analytics_done';
  static const igUsername = 'click_social_ig_username';
  static const igBio = 'click_social_ig_bio';
  static const igCategory = 'click_social_ig_category';
  static const profilePhoto = 'click_social_profile_photo_path';
  static const postCaption = 'click_social_published_caption';
  static const postTags = 'click_social_published_tags';
  static const postUser = 'click_social_published_user';
  static const postMedia = 'click_social_post_media_path';
  static const postMediaIsVideo = 'click_social_post_media_is_video';

  static const _framePrefix = 'click_social_frame_picks_';
  static const _techniquePrefix = 'click_social_technique_';

  static Future<void> touch([SharedPreferences? prefs]) async {
    final store = prefs ?? await SharedPreferences.getInstance();
    await store.setInt(updatedAt, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<ClickSocialSnapshot> load() async {
    final prefs = await SharedPreferences.getInstance();
    final frames = <String, String>{};
    final techniques = <String, String>{};
    for (final key in prefs.getKeys()) {
      if (key.startsWith(_framePrefix)) {
        final value = prefs.getString(key);
        if (value != null && value.isNotEmpty) {
          frames[key.substring(_framePrefix.length)] = value;
        }
      } else if (key.startsWith(_techniquePrefix)) {
        final value = prefs.getString(key);
        if (value != null && value.isNotEmpty) {
          techniques[key.substring(_techniquePrefix.length)] = value;
        }
      }
    }

    final millis = prefs.getInt(updatedAt) ?? 0;
    return ClickSocialSnapshot(
      updatedAt: DateTime.fromMillisecondsSinceEpoch(millis),
      onboarded: prefs.getBool(onboarded) ?? false,
      name: prefs.getString(name)?.trim() ?? '',
      clusterId: prefs.getString(clusterId),
      language: prefs.getString(language) ?? 'en',
      photoDone: prefs.getBool(photoDone) ?? false,
      profileDone: prefs.getBool(profileDone) ?? false,
      contentDone: prefs.getBool(contentDone) ?? false,
      strategyDone: prefs.getBool(strategyDone) ?? false,
      analyticsDone: prefs.getBool(analyticsDone) ?? false,
      igUsername: prefs.getString(igUsername),
      igBio: prefs.getStringList(igBio) ?? const [],
      igCategory: prefs.getString(igCategory),
      profilePhotoPath: prefs.getString(profilePhoto),
      postCaption: prefs.getString(postCaption),
      postTags: prefs.getString(postTags),
      postUser: prefs.getString(postUser),
      postMediaPath: prefs.getString(postMedia),
      postMediaIsVideo: prefs.getBool(postMediaIsVideo) ?? false,
      framePicks: frames,
      techniques: techniques,
    );
  }

  static Future<void> apply(ClickSocialSnapshot remote) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboarded, remote.onboarded);
    await prefs.setString(name, remote.name);
    if (remote.clusterId == null || remote.clusterId!.isEmpty) {
      await prefs.remove(clusterId);
    } else {
      await prefs.setString(clusterId, remote.clusterId!);
    }
    await prefs.setString(language, remote.language);
    await prefs.setBool(photoDone, remote.photoDone);
    await prefs.setBool(profileDone, remote.profileDone);
    await prefs.setBool(contentDone, remote.contentDone);
    await prefs.setBool(strategyDone, remote.strategyDone);
    await prefs.setBool(analyticsDone, remote.analyticsDone);

    await _setOptional(prefs, igUsername, remote.igUsername);
    if (remote.igBio.isEmpty) {
      await prefs.remove(igBio);
    } else {
      await prefs.setStringList(igBio, remote.igBio);
    }
    await _setOptional(prefs, igCategory, remote.igCategory);
    await _setOptional(prefs, profilePhoto, remote.profilePhotoPath);
    await _setOptional(prefs, postCaption, remote.postCaption);
    await _setOptional(prefs, postTags, remote.postTags);
    await _setOptional(prefs, postUser, remote.postUser);
    await _setOptional(prefs, postMedia, remote.postMediaPath);
    await prefs.setBool(postMediaIsVideo, remote.postMediaIsVideo);

    for (final key in prefs.getKeys().toList()) {
      if (key.startsWith(_framePrefix) || key.startsWith(_techniquePrefix)) {
        await prefs.remove(key);
      }
    }
    for (final entry in remote.framePicks.entries) {
      await prefs.setString('$_framePrefix${entry.key}', entry.value);
    }
    for (final entry in remote.techniques.entries) {
      await prefs.setString('$_techniquePrefix${entry.key}', entry.value);
    }

    await prefs.setInt(updatedAt, remote.updatedAt.millisecondsSinceEpoch);
  }

  static Future<void> _setOptional(
    SharedPreferences prefs,
    String key,
    String? value,
  ) async {
    if (value == null || value.isEmpty) {
      await prefs.remove(key);
    } else {
      await prefs.setString(key, value);
    }
  }
}
