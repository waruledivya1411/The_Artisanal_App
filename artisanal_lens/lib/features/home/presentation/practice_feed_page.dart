import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/providers.dart';
import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../shared/motion/motion.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/common.dart';
import '../../../shared/widgets/local_video_preview.dart';
import '../../home/shot_sets_controller.dart';
import '../click_social_clusters.dart';
import '../click_social_store.dart';
import '../../../data/services/click_social_sync_service.dart';

/// PRACTICE FEED — matches Click & Social mock (sandbox Instagram feed).
class PracticeFeedPage extends ConsumerStatefulWidget {
  const PracticeFeedPage({super.key});

  @override
  ConsumerState<PracticeFeedPage> createState() => _PracticeFeedPageState();
}

class _PracticeFeedPageState extends ConsumerState<PracticeFeedPage> {
  static const _prefsPublishedCaption = 'click_social_published_caption';
  static const _prefsPublishedTags = 'click_social_published_tags';
  static const _prefsPublishedUser = 'click_social_published_user';
  static const _prefsPostMedia = 'click_social_post_media_path';
  static const _prefsPostMediaIsVideo = 'click_social_post_media_is_video';
  static const _prefsUsername = 'click_social_ig_username';
  static const _prefsClusterId = 'click_social_cluster_id';
  static const _prefsName = 'click_social_name';

  bool _loading = true;
  String? _publishedUser;
  String? _publishedCaption;
  String? _publishedTags;
  String? _publishedMediaPath;
  bool _publishedMediaIsVideo = false;
  String? _username;
  String? _learnerName;
  ClickSocialCluster? _cluster;
  int _mineLikes = 0;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString(_prefsPublishedUser);
    final caption = prefs.getString(_prefsPublishedCaption);
    final tags = prefs.getString(_prefsPublishedTags);
    final media = prefs.getString(_prefsPostMedia);
    final isVideo = prefs.getBool(_prefsPostMediaIsVideo) ?? false;
    final username = prefs.getString(_prefsUsername);
    final name = prefs.getString(_prefsName);
    final cluster = clusterById(prefs.getString(_prefsClusterId));
    if (!mounted) return;
    if (user == _publishedUser &&
        caption == _publishedCaption &&
        tags == _publishedTags &&
        media == _publishedMediaPath &&
        isVideo == _publishedMediaIsVideo &&
        username == _username &&
        name == _learnerName &&
        cluster?.id == _cluster?.id &&
        !_loading) {
      return;
    }
    setState(() {
      _publishedUser = user;
      _publishedCaption = caption;
      _publishedTags = tags;
      _publishedMediaPath = media;
      _publishedMediaIsVideo = isVideo;
      _username = username;
      _learnerName = name;
      _cluster = cluster;
      _loading = false;
    });
  }

  String? get _coverPath {
    final sets = ref.watch(shotSetsProvider).valueOrNull;
    if (sets == null || sets.isEmpty) return null;
    return sets.first.coverShot?.filePath;
  }

  String? get _mineMediaPath {
    final dropped = _publishedMediaPath;
    if (dropped != null && dropped.isNotEmpty) return dropped;
    return _coverPath;
  }

  bool get _hasMinePost =>
      _publishedCaption != null && _publishedCaption!.trim().isNotEmpty;

  String get _displayUser {
    final published = _publishedUser?.trim();
    if (published != null && published.isNotEmpty) return published;
    final username = _username?.trim();
    if (username != null && username.isNotEmpty) {
      return username.startsWith('@') ? username.substring(1) : username;
    }
    final name = (_learnerName ?? 'artisan')
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z]'), '');
    return name.isEmpty ? 'artisan_weaves' : '${name}_weaves';
  }

  String get _clusterLabel {
    final c = _cluster;
    if (c == null) return 'Your craft cluster';
    final place = c.place.split(',').last.trim();
    final short = c.shortName.trim();
    if (short.isEmpty) return place;
    if (place.toLowerCase().contains('assam')) return 'Assam Silk Cluster';
    if (place.toLowerCase().contains('nagaland')) {
      return 'Nagaland Craft Cluster';
    }
    return '${short[0].toUpperCase()}${short.substring(1)} · $place';
  }

  String get _productTag {
    final fabric = _cluster?.fabric.trim() ?? '';
    if (fabric.isNotEmpty) {
      final head = fabric.split('—').first.trim();
      if (head.isNotEmpty) return head;
    }
    final short = _cluster?.shortName.trim() ?? '';
    if (short.isNotEmpty) {
      return '${short[0].toUpperCase()}${short.substring(1)}';
    }
    return 'Your craft';
  }

  Future<void> _replacePhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 92,
    );
    if (picked == null || !mounted) return;
    try {
      final stored = await ref.read(photoStorageProvider).persist(
            picked.path,
            setId: 'practice_feed_replace',
          );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsPostMedia, stored);
      await prefs.setBool(_prefsPostMediaIsVideo, false);
      await ClickSocialStore.touch(prefs);
      ClickSocialSync.schedulePush();
      if (!mounted) return;
      setState(() {
        _publishedMediaPath = stored;
        _publishedMediaIsVideo = false;
      });
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  }

  void _likeMine() => setState(() => _mineLikes += 1);

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final l10n = AppLocalizations.of(context);

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF7FAFD),
            Color(0xFFEEF5FB),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: AppTypography.displayMedium.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(text: l10n.csPracticeFeed),
                          const TextSpan(
                            text: '.',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSelected,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.lock_rounded,
                          size: 12,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          l10n.csStaysOnYourPhone,
                          style: AppTypography.navLabel.copyWith(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSelected,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Safe practice sandbox. Test your photos, stories & hashtags before posting to live Instagram.',
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 12.5,
                          height: 1.4,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                children: [
                  if (_hasMinePost)
                    FadeSlideIn.staggered(
                      index: 0,
                      child: _PracticePostCard(
                        user: _displayUser,
                        clusterLabel: _clusterLabel,
                        productTag: _productTag,
                        caption: _publishedCaption!,
                        tags: _publishedTags ?? '',
                        likes: _mineLikes,
                        photoPath: _mineMediaPath,
                        isVideo: _publishedMediaPath != null &&
                            _publishedMediaPath!.isNotEmpty &&
                            _publishedMediaIsVideo,
                        timeLabel: l10n.csFeedTimeNow,
                        onLike: _likeMine,
                        onReplacePhoto: _replacePhoto,
                      ),
                    )
                  else
                    _EmptyFeedCard(
                      onCreate: () => context.goNamed(AppRoute.createPost),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Pressable(
                elevate: true,
                borderRadius: BorderRadius.circular(28),
                child: Material(
                  color: AppColors.primary,
                  elevation: 4,
                  shadowColor: AppColors.primary.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(28),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: () => context.goNamed(AppRoute.createPost),
                    child: SizedBox(
                      height: 54,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_rounded,
                            color: AppColors.white,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'CREATE PRACTICE POST',
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFeedCard extends StatelessWidget {
  const _EmptyFeedCard({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.surfaceSelected,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.photo_camera_outlined,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No practice posts yet',
            style: AppTypography.labelLarge.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Create a practice post from Lesson 03 to preview it here.',
            textAlign: TextAlign.center,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: onCreate,
            child: Text(
              'Create your first post',
              style: AppTypography.labelLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticePostCard extends StatelessWidget {
  const _PracticePostCard({
    required this.user,
    required this.clusterLabel,
    required this.productTag,
    required this.caption,
    required this.tags,
    required this.likes,
    required this.photoPath,
    required this.isVideo,
    required this.timeLabel,
    required this.onLike,
    required this.onReplacePhoto,
  });

  final String user;
  final String clusterLabel;
  final String productTag;
  final String caption;
  final String tags;
  final int likes;
  final String? photoPath;
  final bool isVideo;
  final String timeLabel;
  final VoidCallback onLike;
  final VoidCallback onReplacePhoto;

  String get _initial => user.isEmpty ? '?' : user[0].toUpperCase();
  bool get _liked => likes > 0;

  @override
  Widget build(BuildContext context) {
    final hasMedia = photoPath != null && photoPath!.isNotEmpty;
    final heartColor = _liked ? AppColors.primary : AppColors.textPrimary;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 10),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _initial,
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              user,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelLarge.copyWith(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF1E0),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              'Draft',
                              style: AppTypography.navLabel.copyWith(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFC05621),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        clusterLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 11.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  timeLabel,
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 11.5,
                    color: AppColors.textMuted,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_rounded),
                  color: AppColors.textMuted,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(
                  color: AppColors.surfaceSelected,
                  child: !hasMedia
                      ? Center(
                          child: Text(
                            'Add a craft photo',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        )
                      : isVideo
                          ? LocalVideoPreview(path: photoPath!)
                          : PhotoThumb(
                              path: photoPath!,
                              borderRadius: BorderRadius.zero,
                            ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.62),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          size: 13,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            productTag,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Material(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    elevation: 2,
                    shadowColor: Colors.black26,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: onReplacePhoto,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.refresh_rounded,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Replace Photo',
                              style: AppTypography.labelLarge.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
            child: Row(
              children: [
                Pressable(
                  elevate: false,
                  child: InkWell(
                    onTap: onLike,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          AnimatedSwitcher(
                            duration: AppMotion.select,
                            switchInCurve: AppMotion.curve,
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(scale: animation, child: child),
                            child: Icon(
                              _liked
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded,
                              key: ValueKey(_liked),
                              color: heartColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$likes',
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: heartColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 22,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: 14),
                const Icon(
                  Icons.send_outlined,
                  size: 22,
                  color: AppColors.textPrimary,
                ),
                const Spacer(),
                const Icon(
                  Icons.bookmark_border_rounded,
                  size: 24,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 0),
            child: Text.rich(
              TextSpan(
                style: AppTypography.labelSmall.copyWith(
                  fontSize: 13.5,
                  height: 1.4,
                  color: AppColors.textPrimary,
                ),
                children: [
                  TextSpan(
                    text: '$user ',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  TextSpan(text: caption),
                ],
              ),
            ),
          ),
          if (tags.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 0),
              child: Text(
                tags,
                style: AppTypography.labelLarge.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
            child: Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Verified with Lesson 03 tags • Ready for Instagram',
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
