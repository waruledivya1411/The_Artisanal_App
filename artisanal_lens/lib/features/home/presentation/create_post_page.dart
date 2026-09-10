import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/providers.dart';
import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../../../shared/widgets/common.dart';
import '../../../shared/widgets/local_video_preview.dart';
import '../../home/shot_sets_controller.dart';
import '../click_social_clusters.dart';
import '../click_social_lessons.dart';

/// Lesson 03 — Create a Post (matches Click & Social HTML).
class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  static const _prefsName = 'click_social_name';
  static const _prefsClusterId = 'click_social_cluster_id';
  static const _prefsUsername = 'click_social_ig_username';
  static const _prefsPublishedCaption = 'click_social_published_caption';
  static const _prefsPublishedTags = 'click_social_published_tags';
  static const _prefsPublishedUser = 'click_social_published_user';
  static const _prefsPostMedia = 'click_social_post_media_path';
  static const _prefsPostMediaIsVideo = 'click_social_post_media_is_video';
  static const _exampleAsset = 'assets/images/guides/ex-post-card.jpg';

  /// Format ids stay English; only the tab labels are localized.
  String _format = 'POST';
  final Set<String> _selectedKickers = {};
  final Set<String> _selectedTags = {};
  String? _learnerName;
  String? _username;
  ClickSocialCluster? _cluster;
  bool _loading = true;

  /// HTML `image-slot`: learner drops any photo/video, or falls back to Lesson 01.
  String? _mediaPath;
  bool _mediaIsVideo = false;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMedia = prefs.getString(_prefsPostMedia);
    setState(() {
      _learnerName = prefs.getString(_prefsName);
      _username = prefs.getString(_prefsUsername);
      _cluster = clusterById(prefs.getString(_prefsClusterId));
      _mediaPath = savedMedia;
      _mediaIsVideo = prefs.getBool(_prefsPostMediaIsVideo) ?? false;
      _loading = false;
    });
  }

  List<(String, String)> _storyBlocks(AppLocalizations l10n) {
    final id = _cluster?.id;
    if (id != null) {
      final blocks = AppCopy.clusterStoryBlocks(l10n, id);
      if (blocks.isNotEmpty) return blocks;
    }
    return [
      ('HERITAGE', l10n.csStoryFallbackHeritage),
      ('MATERIAL', l10n.csStoryFallbackMaterial),
      ('PROCESS', l10n.csStoryFallbackProcess),
    ];
  }

  List<String> _tagOptions(AppLocalizations l10n) {
    final id = _cluster?.id;
    if (id != null) {
      final tags = AppCopy.clusterTags(l10n, id);
      if (tags.isNotEmpty) return tags;
    }
    return [
      l10n.csTagFallback0,
      l10n.csTagFallback1,
      l10n.csTagFallback2,
      l10n.csTagFallback3,
      l10n.csTagFallback4,
    ];
  }

  String _captionText(AppLocalizations l10n) {
    final parts = <String>[];
    for (final block in _storyBlocks(l10n)) {
      if (_selectedKickers.contains(block.$1)) parts.add(block.$2);
    }
    if (parts.isEmpty) return l10n.csCaptionPlaceholder;
    return parts.join(' ');
  }

  String get _tagLine => _selectedTags.join(' ');

  bool get _canPublish =>
      _selectedKickers.isNotEmpty && _selectedTags.length >= 3;

  String? _lesson01CoverPath() {
    final sets = ref.read(shotSetsProvider).valueOrNull;
    if (sets == null || sets.isEmpty) return null;
    return sets.first.coverShot?.filePath;
  }

  /// Display path: dropped media wins; else Lesson 01 cover (HTML behaviour).
  String? get _displayMediaPath => _mediaPath ?? _lesson01CoverPath();

  bool get _displayIsVideo => _mediaPath != null && _mediaIsVideo;

  Future<void> _pickMedia() async {
    final l10n = AppLocalizations.of(context);
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_outlined),
              title: Text(l10n.csChoosePhoto),
              onTap: () => Navigator.pop(context, 'photo'),
            ),
            ListTile(
              leading: const Icon(Icons.videocam_outlined),
              title: Text(l10n.csChooseVideo),
              onTap: () => Navigator.pop(context, 'video'),
            ),
          ],
        ),
      ),
    );
    if (choice == null || !mounted) return;

    final picker = ImagePicker();
    final XFile? picked = choice == 'video'
        ? await picker.pickVideo(source: ImageSource.gallery)
        : await picker.pickImage(source: ImageSource.gallery, imageQuality: 92);
    if (picked == null || !mounted) return;

    try {
      final stored = await ref.read(photoStorageProvider).persist(
            picked.path,
            setId: 'lesson03_post',
          );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsPostMedia, stored);
      await prefs.setBool(_prefsPostMediaIsVideo, choice == 'video');
      if (!mounted) return;
      setState(() {
        _mediaPath = stored;
        _mediaIsVideo = choice == 'video';
      });
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  }

  Future<void> _publish(AppLocalizations l10n) async {
    if (!_canPublish) return;
    final caption = _captionText(l10n);
    final prefs = await SharedPreferences.getInstance();
    final learnerName = _learnerName ?? l10n.csLearnerFallback;
    final user = _username ??
        '${learnerName.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '')}_weaves';
    await prefs.setString(_prefsPublishedCaption, caption);
    await prefs.setString(_prefsPublishedTags, _tagLine);
    await prefs.setString(_prefsPublishedUser, user);
    // Keep the dropped media for the practice feed.
    final media = _displayMediaPath;
    if (media != null && media.isNotEmpty) {
      await prefs.setString(_prefsPostMedia, media);
      await prefs.setBool(_prefsPostMediaIsVideo, _displayIsVideo);
    }
    if (!mounted) return;
    // HTML: content lesson goes to practice feed (`gram`), not home.
    await ClickSocialLessons.complete(
      context,
      prefsKey: ClickSocialLessons.contentDoneKey,
      badgeLabel: l10n.csBadgeStoryteller,
      routeName: AppRoute.gallery,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final l10n = AppLocalizations.of(context);
    final tagsFull = _selectedTags.length >= 5;
    final captionText = _captionText(l10n);
    final displayPath = _displayMediaPath;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(onBack: () => context.goNamed(AppRoute.home)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  _FormatTabs(
                    selected: _format,
                    onPick: (v) => setState(() => _format = v),
                  ),
                  Material(
                    color: AppColors.surfaceMuted,
                    child: InkWell(
                      onTap: _pickMedia,
                      child: Container(
                        height: 190,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.textPrimary,
                            width: 2,
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: displayPath == null || displayPath.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    l10n.csDropPhotoOrVideo,
                                    textAlign: TextAlign.center,
                                    style: AppTypography.labelSmall.copyWith(
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ),
                              )
                            : _displayIsVideo
                                ? LocalVideoPreview(path: displayPath)
                                : PhotoThumb(
                                    path: displayPath,
                                    borderRadius: BorderRadius.zero,
                                  ),
                      ),
                    ),
                  ),
                  if (_displayIsVideo) ...[
                    const SizedBox(height: 8),
                    Text(
                      l10n.csVideoSelected,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceMuted,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: GuideImage(
                            asset: _exampleAsset,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l10n.csExampleKotpad,
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 11.5,
                              height: 1.45,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.csAddYourStory,
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (final block in _storyBlocks(l10n)) ...[
                    _StoryBlockButton(
                      kicker: _storyKickerLabel(l10n, block.$1),
                      text: block.$2,
                      selected: _selectedKickers.contains(block.$1),
                      onTap: () {
                        setState(() {
                          if (_selectedKickers.contains(block.$1)) {
                            _selectedKickers.remove(block.$1);
                          } else {
                            _selectedKickers.add(block.$1);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  const SizedBox(height: 12),
                  Text.rich(
                    TextSpan(
                      style: AppTypography.navLabel.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        TextSpan(text: l10n.csHashtagsPick),
                        TextSpan(
                          text: tagsFull
                              ? l10n.csHashtagCountFull(_selectedTags.length)
                              : l10n.csHashtagCount(_selectedTags.length),
                          style: const TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tag in _tagOptions(l10n))
                        _TagChip(
                          label: tag,
                          selected: _selectedTags.contains(tag),
                          dimmed: tagsFull && !_selectedTags.contains(tag),
                          onTap: () {
                            setState(() {
                              if (_selectedTags.contains(tag)) {
                                _selectedTags.remove(tag);
                              } else if (_selectedTags.length < 5) {
                                _selectedTags.add(tag);
                              }
                            });
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Divider(height: 2, thickness: 2),
                  const SizedBox(height: 12),
                  Text(
                    l10n.csCaptionPreview,
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    captionText,
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 13,
                      height: 1.5,
                      color: _selectedKickers.isEmpty
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                    ),
                  ),
                  if (_tagLine.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      _tagLine,
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Opacity(
                    opacity: _canPublish ? 1 : 0.45,
                    child: InkWell(
                      onTap: _canPublish ? () => _publish(l10n) : null,
                      child: Container(
                        height: 52,
                        alignment: Alignment.center,
                        color: AppColors.primary,
                        child: Text(
                          l10n.csPostToPracticeFeed,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.csPracticeFeedOnly,
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Story block ids stay English so selection state survives a locale switch.
String _storyKickerLabel(AppLocalizations l10n, String kicker) =>
    switch (kicker) {
      'HERITAGE' => l10n.csStoryKickerHeritage,
      'MATERIAL' => l10n.csStoryKickerMaterial,
      'PROCESS' => l10n.csStoryKickerProcess,
      _ => kicker,
    };

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 8, 12, 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 2)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.chevron_left, size: 28),
            color: AppColors.textPrimary,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.csLesson03Overline,
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  l10n.csLesson03Title,
                  style: AppTypography.labelLarge.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
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

class _FormatTabs extends StatelessWidget {
  const _FormatTabs({required this.selected, required this.onPick});

  final String selected;
  final ValueChanged<String> onPick;

  static const _formats = ['POST', 'STORY', 'REEL'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels = [l10n.csFormatPost, l10n.csFormatStory, l10n.csFormatReel];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textPrimary, width: 2),
      ),
      child: Row(
        children: [
          for (var i = 0; i < _formats.length; i++)
            Expanded(
              child: InkWell(
                onTap: () => onPick(_formats[i]),
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected == _formats[i]
                        ? AppColors.textPrimary
                        : AppColors.white,
                    border: i == 0
                        ? null
                        : const Border(
                            left: BorderSide(
                              color: AppColors.textPrimary,
                              width: 2,
                            ),
                          ),
                  ),
                  child: Text(
                    labels[i],
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      color: selected == _formats[i]
                          ? AppColors.white
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StoryBlockButton extends StatelessWidget {
  const _StoryBlockButton({
    required this.kicker,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String kicker;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : AppColors.white,
          border: Border.all(color: AppColors.textPrimary, width: 2),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              child: Text(
                kicker,
                style: AppTypography.navLabel.copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                  color: selected
                      ? AppColors.primaryLight
                      : AppColors.primary,
                ),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: AppTypography.labelSmall.copyWith(
                  fontSize: 13,
                  height: 1.35,
                  color: selected ? AppColors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.label,
    required this.selected,
    required this.dimmed,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool dimmed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: dimmed ? 0.45 : 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 40),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.textPrimary : AppColors.white,
            border: Border.all(color: AppColors.textPrimary, width: 2),
          ),
          child: Text(
            label,
            style: AppTypography.labelLarge.copyWith(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: selected ? AppColors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
