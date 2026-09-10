import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/common.dart';
import '../../home/shot_sets_controller.dart';

/// PRACTICE FEED — matches Click & Social HTML `isGram` screen.
class PracticeFeedPage extends ConsumerStatefulWidget {
  const PracticeFeedPage({super.key});

  @override
  ConsumerState<PracticeFeedPage> createState() => _PracticeFeedPageState();
}

class _PracticeFeedPageState extends ConsumerState<PracticeFeedPage> {
  static const _prefsPublishedCaption = 'click_social_published_caption';
  static const _prefsPublishedTags = 'click_social_published_tags';
  static const _prefsPublishedUser = 'click_social_published_user';

  bool _loading = true;
  String? _publishedUser;
  String? _publishedCaption;
  String? _publishedTags;

  int _mineLikes = 0;
  final Map<int, int> _sampleLikes = {0: 34, 1: 57};

  @override
  void initState() {
    super.initState();
    _restore();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh when returning from Create a Post.
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString(_prefsPublishedUser);
    final caption = prefs.getString(_prefsPublishedCaption);
    final tags = prefs.getString(_prefsPublishedTags);
    if (!mounted) return;
    if (user == _publishedUser &&
        caption == _publishedCaption &&
        tags == _publishedTags &&
        !_loading) {
      return;
    }
    setState(() {
      _publishedUser = user;
      _publishedCaption = caption;
      _publishedTags = tags;
      _loading = false;
    });
  }

  String? get _coverPath {
    final sets = ref.watch(shotSetsProvider).valueOrNull;
    if (sets == null || sets.isEmpty) return null;
    return sets.first.coverShot?.filePath;
  }

  List<_FeedPost> _posts(AppLocalizations l10n) {
    final posts = <_FeedPost>[];
    if (_publishedUser != null &&
        _publishedCaption != null &&
        _publishedCaption!.isNotEmpty) {
      posts.add(
        _FeedPost(
          user: _publishedUser!,
          time: l10n.csFeedTimeNow,
          caption: _publishedCaption!,
          tags: _publishedTags ?? '',
          likes: _mineLikes,
          baseLikes: 0,
          photoPath: _coverPath,
          placeholder: l10n.csFeedYourPhotoPlaceholder,
          avatarColor: AppColors.primary,
          comments: _mineLikes > 0
              ? [
                  _FeedComment(
                    user: l10n.csFeedCommentUser1,
                    text: l10n.csFeedCommentBuyer,
                  ),
                ]
              : const [],
          isMine: true,
          sampleIndex: -1,
        ),
      );
    }

    posts.addAll([
      _FeedPost(
        user: l10n.csFeedSampleUser1,
        time: l10n.csFeedSampleTime1,
        caption: l10n.csFeedSampleCaption1,
        tags: l10n.csFeedSampleTags1,
        likes: _sampleLikes[0] ?? 34,
        baseLikes: 34,
        photoPath: null,
        placeholder: l10n.csFeedSamplePlaceholder,
        avatarColor: AppColors.textSecondary,
        comments: [
          _FeedComment(
            user: l10n.csFeedCommentUser2,
            text: l10n.csFeedCommentCraftLover,
          ),
        ],
        isMine: false,
        sampleIndex: 0,
      ),
      _FeedPost(
        user: l10n.csFeedSampleUser2,
        time: l10n.csFeedSampleTime2,
        caption: l10n.csFeedSampleCaption2,
        tags: l10n.csFeedSampleTags2,
        likes: _sampleLikes[1] ?? 57,
        baseLikes: 57,
        photoPath: null,
        placeholder: l10n.csFeedSamplePlaceholder,
        avatarColor: AppColors.textSecondary,
        comments: const [],
        isMine: false,
        sampleIndex: 1,
      ),
    ]);
    return posts;
  }

  void _like(_FeedPost post) {
    setState(() {
      if (post.isMine) {
        _mineLikes += 1;
      } else if (post.sampleIndex >= 0) {
        _sampleLikes[post.sampleIndex] =
            (_sampleLikes[post.sampleIndex] ?? post.baseLikes) + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.divider, width: 2),
              ),
            ),
            child: Row(
              children: [
                Text.rich(
                  TextSpan(
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 15,
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
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border, width: 1.5),
                  ),
                  child: Text(
                    l10n.csStaysOnYourPhone,
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (final post in _posts(l10n))
                _FeedCard(post: post, onLike: () => _like(post)),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Text(
                  l10n.csFeedTapHeart,
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeedPost {
  const _FeedPost({
    required this.user,
    required this.time,
    required this.caption,
    required this.tags,
    required this.likes,
    required this.baseLikes,
    required this.photoPath,
    required this.placeholder,
    required this.avatarColor,
    required this.comments,
    required this.isMine,
    required this.sampleIndex,
  });

  final String user;
  final String time;
  final String caption;
  final String tags;
  final int likes;
  final int baseLikes;
  final String? photoPath;
  final String placeholder;
  final Color avatarColor;
  final List<_FeedComment> comments;
  final bool isMine;
  final int sampleIndex;

  bool get liked => likes > baseLikes;
  String get initial => user.isEmpty ? '?' : user[0].toUpperCase();
}

class _FeedComment {
  const _FeedComment({required this.user, required this.text});
  final String user;
  final String text;
}

class _FeedCard extends StatelessWidget {
  const _FeedCard({required this.post, required this.onLike});

  final _FeedPost post;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    final heartColor = post.liked ? AppColors.primary : AppColors.textPrimary;

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 2)),
      ),
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  color: post.avatarColor,
                  child: Text(
                    post.initial,
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    post.user,
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  post.time,
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 230,
            width: double.infinity,
            child: post.photoPath == null || post.photoPath!.isEmpty
                ? Container(
                    color: AppColors.surfaceMuted,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      post.placeholder,
                      textAlign: TextAlign.center,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  )
                : ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0, 0, 0, 1, 0,
                    ]),
                    child: PhotoThumb(
                      path: post.photoPath!,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: onLike,
                child: SizedBox(
                  height: 44,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        post.liked ? Icons.favorite : Icons.favorite_border,
                        color: heartColor,
                        size: 22,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${post.likes}',
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
            child: Text.rich(
              TextSpan(
                style: AppTypography.labelSmall.copyWith(
                  fontSize: 13,
                  height: 1.45,
                  color: AppColors.textPrimary,
                ),
                children: [
                  TextSpan(
                    text: post.user,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: '  ${post.caption}'),
                ],
              ),
            ),
          ),
          if (post.tags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
              child: Text(
                post.tags,
                style: AppTypography.labelLarge.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          for (final comment in post.comments)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: Text.rich(
                TextSpan(
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 12.5,
                    color: AppColors.textPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: comment.user,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: '  ${comment.text}'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
