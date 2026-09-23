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
import '../../../l10n/app_copy.dart';
import '../../../shared/widgets/common.dart';
import '../../../shared/widgets/local_video_preview.dart';
import '../../home/shot_sets_controller.dart';
import '../click_social_clusters.dart';
import '../click_social_lessons.dart';
import '../click_social_store.dart';
import '../../../data/services/click_social_sync_service.dart';

/// Lesson 03 — Create a Post (matches Click & Social HTML + mock).
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
  int _step = 0; // 0 = story, 1 = hashtags & preview

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

  bool get _canGoHashtags => _selectedKickers.isNotEmpty;

  String? _lesson01CoverPath() {
    final sets = ref.read(shotSetsProvider).valueOrNull;
    if (sets == null || sets.isEmpty) return null;
    return sets.first.coverShot?.filePath;
  }

  /// Display path: dropped media wins; else Lesson 01 cover (HTML behaviour).
  String? get _displayMediaPath => _mediaPath ?? _lesson01CoverPath();

  bool get _displayIsVideo => _mediaPath != null && _mediaIsVideo;

  bool get _usingLesson01Photo =>
      _mediaPath == null && (_lesson01CoverPath()?.isNotEmpty ?? false);

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
      await ClickSocialStore.touch(prefs);
      ClickSocialSync.schedulePush();
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
    final media = _displayMediaPath;
    if (media != null && media.isNotEmpty) {
      await prefs.setString(_prefsPostMedia, media);
      await prefs.setBool(_prefsPostMediaIsVideo, _displayIsVideo);
    }
    if (!mounted) return;
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
    final captionText = _captionText(l10n);
    final displayPath = _displayMediaPath;

    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: _LessonBottomNav(
        onLearn: () => context.goNamed(AppRoute.home),
        onPractice: () => context.goNamed(AppRoute.gallery),
        onProgress: () => context.goNamed(AppRoute.settings),
      ),
      body: DecoratedBox(
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
              _Header(
                step: _step,
                totalSteps: 2,
                onBack: () {
                  if (_step == 0) {
                    context.goNamed(AppRoute.home);
                  } else {
                    setState(() => _step = 0);
                  }
                },
              ),
              Expanded(
                child: _step == 0
                    ? _StoryStep(
                        format: _format,
                        onFormatPick: (v) => setState(() => _format = v),
                        displayPath: displayPath,
                        displayIsVideo: _displayIsVideo,
                        usingLesson01: _usingLesson01Photo,
                        exampleAsset: _exampleAsset,
                        storyBlocks: _storyBlocks(l10n),
                        selectedKickers: _selectedKickers,
                        onToggleKicker: (id) {
                          setState(() {
                            if (_selectedKickers.contains(id)) {
                              _selectedKickers.remove(id);
                            } else {
                              _selectedKickers.add(id);
                            }
                          });
                        },
                        onPickMedia: _pickMedia,
                        dropHint: l10n.csDropPhotoOrVideo,
                        exampleText: l10n.csExampleKotpad,
                      )
                    : _HashtagsStep(
                        format: _format,
                        displayPath: displayPath,
                        displayIsVideo: _displayIsVideo,
                        exampleAsset: _exampleAsset,
                        tags: _tagOptions(l10n),
                        selectedTags: _selectedTags,
                        captionText: captionText,
                        tagLine: _tagLine,
                        username: () {
                          final learner =
                              _learnerName ?? l10n.csLearnerFallback;
                          return _username ??
                              '${learner.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '')}_weaves';
                        }(),
                        learnerName: _learnerName ?? l10n.csLearnerFallback,
                        placeLabel: _cluster?.place.split(',').last.trim() ??
                            _cluster?.shortName ??
                            'India',
                        canPublish: _canPublish,
                        onEdit: () => setState(() => _step = 0),
                        onToggleTag: (tag) {
                          setState(() {
                            if (_selectedTags.contains(tag)) {
                              _selectedTags.remove(tag);
                            } else if (_selectedTags.length < 5) {
                              _selectedTags.add(tag);
                            }
                          });
                        },
                        onPublish: () => _publish(l10n),
                        publishLabel: l10n.csPostToPracticeFeed,
                        practiceOnly: l10n.csPracticeFeedOnly,
                      ),
              ),
              if (_step == 0)
                _StoryFooter(
                  canNext: _canGoHashtags,
                  onBack: () => context.goNamed(AppRoute.home),
                  onNext: () => setState(() => _step = 1),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

String _storyKickerLabel(AppLocalizations l10n, String kicker) =>
    switch (kicker) {
      'HERITAGE' => l10n.csStoryKickerHeritage,
      'MATERIAL' => l10n.csStoryKickerMaterial,
      'PROCESS' => l10n.csStoryKickerProcess,
      _ => kicker,
    };

class _Header extends StatelessWidget {
  const _Header({
    required this.step,
    required this.totalSteps,
    required this.onBack,
  });

  final int step;
  final int totalSteps;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Material(
                color: AppColors.white,
                elevation: 2,
                shadowColor: AppColors.primary.withValues(alpha: 0.12),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onBack,
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 26,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${l10n.csLesson03Overline}  •  SOCIAL MEDIA',
                      textAlign: TextAlign.center,
                      style: AppTypography.navLabel.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.csLesson03Title,
                      textAlign: TextAlign.center,
                      style: AppTypography.displayMedium.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSelected,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  '${step + 1} / $totalSteps',
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (var i = 0; i < totalSteps; i++) ...[
                Expanded(
                  child: AnimatedContainer(
                    duration: AppMotion.select,
                    height: 5,
                    decoration: BoxDecoration(
                      color: i <= step
                          ? AppColors.primary
                          : AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
                if (i < totalSteps - 1) const SizedBox(width: 6),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _StoryStep extends StatelessWidget {
  const _StoryStep({
    required this.format,
    required this.onFormatPick,
    required this.displayPath,
    required this.displayIsVideo,
    required this.usingLesson01,
    required this.exampleAsset,
    required this.storyBlocks,
    required this.selectedKickers,
    required this.onToggleKicker,
    required this.onPickMedia,
    required this.dropHint,
    required this.exampleText,
  });

  final String format;
  final ValueChanged<String> onFormatPick;
  final String? displayPath;
  final bool displayIsVideo;
  final bool usingLesson01;
  final String exampleAsset;
  final List<(String, String)> storyBlocks;
  final Set<String> selectedKickers;
  final ValueChanged<String> onToggleKicker;
  final VoidCallback onPickMedia;
  final String dropHint;
  final String exampleText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final selectedCount = selectedKickers.length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      children: [
        _FormatTabs(selected: format, onPick: onFormatPick),
        const SizedBox(height: 14),
        _MediaSlot(
          displayPath: displayPath,
          displayIsVideo: displayIsVideo,
          usingLesson01: usingLesson01,
          dropHint: dropHint,
          onPickMedia: onPickMedia,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceSelected,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: GuideImage(
                    asset: exampleAsset,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  exampleText,
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
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.csAddYourStory.toUpperCase(),
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Choose the story lines that tell your craft journey.',
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$selectedCount selected',
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (final block in storyBlocks) ...[
          _StoryBlockButton(
            kicker: _storyKickerLabel(l10n, block.$1),
            text: block.$2,
            selected: selectedKickers.contains(block.$1),
            onTap: () => onToggleKicker(block.$1),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _HashtagsStep extends StatelessWidget {
  const _HashtagsStep({
    required this.format,
    required this.displayPath,
    required this.displayIsVideo,
    required this.exampleAsset,
    required this.tags,
    required this.selectedTags,
    required this.captionText,
    required this.tagLine,
    required this.username,
    required this.learnerName,
    required this.placeLabel,
    required this.canPublish,
    required this.onEdit,
    required this.onToggleTag,
    required this.onPublish,
    required this.publishLabel,
    required this.practiceOnly,
  });

  final String format;
  final String? displayPath;
  final bool displayIsVideo;
  final String exampleAsset;
  final List<String> tags;
  final Set<String> selectedTags;
  final String captionText;
  final String tagLine;
  final String username;
  final String learnerName;
  final String placeLabel;
  final bool canPublish;
  final VoidCallback onEdit;
  final ValueChanged<String> onToggleTag;
  final VoidCallback onPublish;
  final String publishLabel;
  final String practiceOnly;

  String get _snippet {
    final t = captionText.trim();
    if (t.isEmpty) return 'Add story lines on the previous step.';
    if (t.length <= 42) return t;
    return '${t.substring(0, 40)}…';
  }

  String get _initials {
    final parts = learnerName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return username.isEmpty ? 'A' : username[0].toUpperCase();
    }
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = selectedTags.length;
    final hasMedia = displayPath != null && displayPath!.isNotEmpty;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (hasMedia && !displayIsVideo)
                        PhotoThumb(
                          path: displayPath!,
                          borderRadius: BorderRadius.zero,
                        )
                      else if (hasMedia && displayIsVideo)
                        LocalVideoPreview(path: displayPath!)
                      else
                        GuideImage(
                          asset: exampleAsset,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.zero,
                        ),
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            format[0] + format.substring(1).toLowerCase(),
                            style: AppTypography.navLabel.copyWith(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 16,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Story selected',
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _snippet,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 12.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: onEdit,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Edit',
                  style: AppTypography.labelLarge.copyWith(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: Text(
                'HASHTAGS — PICK 3 TO 5',
                style: AppTypography.navLabel.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceSelected,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                '$selectedCount / 5 selected',
                style: AppTypography.labelSmall.copyWith(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Choose relevant craft tags to help buyers and craft lovers discover your work.',
          style: AppTypography.labelSmall.copyWith(
            fontSize: 12.5,
            height: 1.4,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final tag in tags)
              _TagChip(
                label: tag,
                selected: selectedTags.contains(tag),
                dimmed: selectedCount >= 5 && !selectedTags.contains(tag),
                onTap: () => onToggleTag(tag),
              ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: Text(
                'CAPTION & FEED PREVIEW',
                style: AppTypography.navLabel.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              'Live Simulation',
              style: AppTypography.labelSmall.copyWith(
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
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
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        _initials,
                        style: AppTypography.labelLarge.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            'Antaran Artisan • $placeLabel',
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 11.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert_rounded),
                      color: AppColors.textMuted,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: ColoredBox(
                  color: AppColors.surfaceSelected,
                  child: hasMedia
                      ? (displayIsVideo
                          ? LocalVideoPreview(path: displayPath!)
                          : PhotoThumb(
                              path: displayPath!,
                              borderRadius: BorderRadius.zero,
                            ))
                      : GuideImage(
                          asset: exampleAsset,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.zero,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
                child: Row(
                  children: [
                    const Icon(Icons.favorite_border_rounded,
                        size: 24, color: AppColors.textPrimary),
                    const SizedBox(width: 14),
                    const Icon(Icons.chat_bubble_outline_rounded,
                        size: 22, color: AppColors.textPrimary),
                    const SizedBox(width: 14),
                    const Icon(Icons.send_outlined,
                        size: 22, color: AppColors.textPrimary),
                    const Spacer(),
                    const Icon(Icons.bookmark_border_rounded,
                        size: 24, color: AppColors.textPrimary),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 6),
                child: Text.rich(
                  TextSpan(
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 13.5,
                      height: 1.4,
                      color: AppColors.textPrimary,
                    ),
                    children: [
                      TextSpan(
                        text: '$username ',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(text: captionText),
                    ],
                  ),
                ),
              ),
              if (tagLine.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
                  child: Text(
                    tagLine,
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
                child: Text(
                  'JUST NOW  •  ANTARAN PRACTICE FEED',
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Pressable(
          enabled: canPublish,
          elevate: true,
          borderRadius: BorderRadius.circular(28),
          child: Opacity(
            opacity: canPublish ? 1 : 0.45,
            child: Material(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: canPublish ? onPublish : null,
                child: SizedBox(
                  height: 54,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.send_rounded,
                        color: AppColors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        publishLabel,
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          practiceOnly,
          textAlign: TextAlign.center,
          style: AppTypography.labelSmall.copyWith(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _StoryFooter extends StatelessWidget {
  const _StoryFooter({
    required this.canNext,
    required this.onBack,
    required this.onNext,
  });

  final bool canNext;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          Material(
            color: AppColors.white,
            shape: const CircleBorder(),
            elevation: 1,
            shadowColor: AppColors.primary.withValues(alpha: 0.1),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onBack,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Pressable(
              enabled: canNext,
              elevate: true,
              borderRadius: BorderRadius.circular(28),
              child: Opacity(
                opacity: canNext ? 1 : 0.5,
                child: Material(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(28),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: canNext ? onNext : null,
                    child: SizedBox(
                      height: 52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'NEXT — HASHTAGS & PREVIEW',
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
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

class _MediaSlot extends StatelessWidget {
  const _MediaSlot({
    required this.displayPath,
    required this.displayIsVideo,
    required this.usingLesson01,
    required this.dropHint,
    required this.onPickMedia,
  });

  final String? displayPath;
  final bool displayIsVideo;
  final bool usingLesson01;
  final String dropHint;
  final VoidCallback onPickMedia;

  @override
  Widget build(BuildContext context) {
    final hasMedia = displayPath != null && displayPath!.isNotEmpty;

    return CustomPaint(
      painter: _DashedRRectPainter(
        color: AppColors.primary.withValues(alpha: 0.45),
        radius: 16,
        strokeWidth: 1.6,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(
                      color: AppColors.surfaceSelected,
                      child: !hasMedia
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  dropHint,
                                  textAlign: TextAlign.center,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            )
                          : displayIsVideo
                              ? LocalVideoPreview(path: displayPath!)
                              : PhotoThumb(
                                  path: displayPath!,
                                  borderRadius: BorderRadius.zero,
                                ),
                    ),
                    if (usingLesson01 && hasMedia)
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
                          child: Text(
                            '✓ Photo from Lesson 01',
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
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
                          onTap: onPickMedia,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.upload_rounded,
                                  size: 16,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Change',
                                  style: AppTypography.labelLarge.copyWith(
                                    fontSize: 12.5,
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
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    dropHint,
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
  });

  final Color color;
  final double radius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      const dash = 6.0;
      const gap = 4.0;
      while (distance < metric.length) {
        final next = distance + dash;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.radius != radius ||
      oldDelegate.strokeWidth != strokeWidth;
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
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          for (var i = 0; i < _formats.length; i++)
            Expanded(
              child: Pressable(
                elevate: false,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => onPick(_formats[i]),
                  child: AnimatedContainer(
                    duration: AppMotion.select,
                    curve: AppMotion.curve,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected == _formats[i]
                          ? AppColors.textPrimary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      labels[i].toUpperCase(),
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: selected == _formats[i]
                            ? AppColors.white
                            : AppColors.textPrimary,
                      ),
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
    return Pressable(
      elevate: false,
      borderRadius: BorderRadius.circular(14),
      child: Material(
        color: selected ? AppColors.textPrimary : AppColors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppMotion.select,
            curve: AppMotion.curve,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? AppColors.textPrimary : AppColors.borderLight,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary
                              : AppColors.surfaceMuted,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          kicker.toUpperCase(),
                          style: AppTypography.navLabel.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            color: selected
                                ? AppColors.white
                                : AppColors.textMuted,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text,
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 13.5,
                          height: 1.35,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? AppColors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                AnimatedContainer(
                  duration: AppMotion.select,
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: selected ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: selected ? AppColors.primary : AppColors.border,
                      width: 2,
                    ),
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: AppColors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
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
      child: Pressable(
        elevate: false,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppMotion.select,
            curve: AppMotion.curve,
            constraints: const BoxConstraints(minHeight: 40),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : AppColors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  selected ? Icons.check_rounded : Icons.add_rounded,
                  size: 16,
                  color: selected ? AppColors.white : AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: AppTypography.labelLarge.copyWith(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: selected ? AppColors.white : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LessonBottomNav extends StatelessWidget {
  const _LessonBottomNav({
    required this.onLearn,
    required this.onPractice,
    required this.onProgress,
  });

  final VoidCallback onLearn;
  final VoidCallback onPractice;
  final VoidCallback onProgress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      color: AppColors.white,
      elevation: 8,
      shadowColor: AppColors.primary.withValues(alpha: 0.1),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.menu_book_rounded,
                label: l10n.csNavLearn,
                active: true,
                onTap: onLearn,
              ),
              _NavItem(
                icon: Icons.photo_camera_outlined,
                label: l10n.csNavPractice,
                active: false,
                onTap: onPractice,
              ),
              _NavItem(
                icon: Icons.check_circle_outline,
                label: l10n.csNavProgress,
                active: false,
                onTap: onProgress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : AppColors.textMuted;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTypography.navLabel.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            if (active) ...[
              const SizedBox(height: 2),
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
