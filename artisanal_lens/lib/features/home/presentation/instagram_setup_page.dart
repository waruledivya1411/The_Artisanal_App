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
import '../../../shared/motion/motion.dart';
import '../../../shared/widgets/common.dart';
import '../click_social_clusters.dart';
import '../click_social_lessons.dart';
import '../click_social_store.dart';
import '../../../data/services/click_social_sync_service.dart';

/// Lesson 02 — Set Up Your Page on Instagram (matches Click & Social HTML).
class InstagramSetupPage extends ConsumerStatefulWidget {
  const InstagramSetupPage({super.key});

  @override
  ConsumerState<InstagramSetupPage> createState() => _InstagramSetupPageState();
}

class _InstagramSetupPageState extends ConsumerState<InstagramSetupPage> {
  static const _prefsName = 'click_social_name';
  static const _prefsClusterId = 'click_social_cluster_id';
  static const _prefsUsername = 'click_social_ig_username';
  static const _prefsBio = 'click_social_ig_bio';
  static const _prefsCategory = 'click_social_ig_category';
  static const _prefsProfilePhoto = 'click_social_profile_photo_path';

  int _step = 0; // 0..4
  String? _username;
  final Set<String> _bio = {};
  String? _category;
  String? _learnerName;
  ClickSocialCluster? _cluster;
  String? _profilePhotoPath;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_prefsName);
    final cluster = clusterById(prefs.getString(_prefsClusterId));
    final savedBio = prefs.getStringList(_prefsBio) ?? const <String>[];
    setState(() {
      _learnerName = name;
      _cluster = cluster;
      _username = prefs.getString(_prefsUsername);
      _bio.addAll(savedBio);
      _category = prefs.getString(_prefsCategory);
      _profilePhotoPath = prefs.getString(_prefsProfilePhoto);
      _loading = false;
    });
  }

  Future<void> _pickProfilePhoto() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 92,
    );
    if (picked == null || !mounted) return;

    try {
      final stored = await ref.read(photoStorageProvider).persist(
            picked.path,
            setId: 'lesson02_profile',
          );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsProfilePhoto, stored);
      await ClickSocialStore.touch(prefs);
      ClickSocialSync.schedulePush();
      if (!mounted) return;
      setState(() => _profilePhotoPath = stored);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  }

  List<String> _usernameOptions(String learnerName) {
    final raw = learnerName.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');
    final base = raw.isEmpty ? 'artisan' : raw;
    // For each of the 3 original patterns, include 2 more variants.
    return [
      '${base}_weaves',
      '$base.weaves',
      'weaves_$base',
      '$base.handloom',
      '${base}_handloom',
      'handloom_by_$base',
      'weaves_by_$base',
      'crafted_by_$base',
      '${base}_studio',
    ];
  }

  List<String> _bioOptions(AppLocalizations l10n) {
    final id = _cluster?.id;
    if (id != null) {
      final lines = AppCopy.clusterBioLines(l10n, id);
      if (lines.isNotEmpty) return lines;
    }
    return [
      l10n.csBioFallbackHandloomWeaver,
      l10n.csBioFallbackDmToOrder,
      l10n.csBioFallbackMadeByHand,
    ];
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    if (_learnerName != null && _learnerName!.trim().isNotEmpty) {
      await prefs.setString(_prefsName, _learnerName!.trim());
    }
    if (_username != null) {
      await prefs.setString(_prefsUsername, _username!);
    }
    await prefs.setStringList(_prefsBio, _bio.toList());
    if (_category != null) {
      await prefs.setString(_prefsCategory, _category!);
    }
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    await ClickSocialLessons.complete(
      context,
      prefsKey: ClickSocialLessons.profileDoneKey,
      badgeLabel: l10n.csBadgePageBuilder,
      routeName: AppRoute.createPost,
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
    final learnerName = _learnerName ?? l10n.csLearnerFallback;

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
              if (_step != 2)
                _Header(
                  step: _step,
                  totalSteps: 5,
                  title: _step == 4
                      ? 'Your Professional Profile'
                      : l10n.csLesson02Title,
                  onBack: () {
                    if (_step == 0) {
                      context.goNamed(AppRoute.home);
                    } else {
                      setState(() => _step -= 1);
                    }
                  },
                ),
              Expanded(
                child: switch (_step) {
                  0 => _UsernameStep(
                      options: _usernameOptions(learnerName),
                      selected: _username,
                      onPick: (v) => setState(() => _username = v),
                      onBack: () => context.goNamed(AppRoute.home),
                      onNext: () => setState(() => _step = 1),
                    ),
                  1 => _EditProfileStep(
                      initialName: '',
                      initialUsername: _username ?? '',
                      initialBio: _bio.join('\n'),
                      bioOptions: _bioOptions(l10n),
                      photoPath: _profilePhotoPath,
                      onPickPhoto: _pickProfilePhoto,
                      onNameChanged: (v) => setState(() => _learnerName = v),
                      onUsernameChanged: (v) => setState(
                            () => _username = v.trim().isEmpty ? null : v.trim(),
                          ),
                      onBioChanged: (v) {
                        setState(() {
                          _bio
                            ..clear()
                            ..addAll(
                              v
                                  .split('\n')
                                  .map((l) => l.trim())
                                  .where((l) => l.isNotEmpty),
                            );
                        });
                      },
                      onNext: () => setState(() => _step = 2),
                    ),
                  2 => _ProfessionalSwitchStep(
                      photoPath: _profilePhotoPath,
                      username: _username ?? learnerName,
                      displayName: learnerName,
                      onBack: () => setState(() => _step = 1),
                      onClose: () => setState(() => _step = 1),
                      onNext: () => setState(() => _step = 3),
                    ),
                  3 => _CategoryStep(
                      selected: _category,
                      onPick: (v) => setState(() => _category = v),
                      onNext: () => setState(() => _step = 4),
                    ),
                  _ => _PreviewStep(
                      username: _username ?? l10n.csPickANameFallback,
                      displayName: learnerName,
                      categoryKey: _category ?? _categoryKeys.first,
                      bioPicked: _bio.toList(),
                      placeLabel: _cluster?.place,
                      craftLabel: _cluster?.shortName,
                      avatarLetter: ((_username ?? learnerName).isEmpty
                              ? 'A'
                              : (_username ?? learnerName)[0])
                          .toUpperCase(),
                      photoPath: _profilePhotoPath,
                      onFinish: _finish,
                      onSharePhoto: () async {
                        await _finish();
                      },
                    ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Persisted category values stay English so saved preferences keep working.
const _categoryKeys = [
  'Artist',
  'Musician/band',
  'Blogger',
  'Clothing (Brand)',
  'Community',
  'Digital creator',
  'Education',
  'Entrepreneur',
  'Visual arts',
];

const _recommendedCategoryKey = 'Clothing (Brand)';

String _categoryLabel(AppLocalizations l10n, String key) => switch (key) {
      'Artist' => l10n.csCategoryArtist,
      'Entrepreneur' => l10n.csCategoryEntrepreneur,
      'Shopping & retail' => l10n.csCategoryShoppingRetail,
      'Local business' => l10n.csCategoryLocalBusiness,
      _ => key,
    };

IconData _categoryIcon(String key) => switch (key) {
      'Artist' => Icons.palette_outlined,
      'Musician/band' => Icons.music_note_outlined,
      'Blogger' => Icons.article_outlined,
      'Clothing (Brand)' => Icons.checkroom_rounded,
      'Community' => Icons.groups_outlined,
      'Digital creator' => Icons.videocam_outlined,
      'Education' => Icons.school_outlined,
      'Entrepreneur' => Icons.work_outline_rounded,
      'Visual arts' => Icons.brush_outlined,
      _ => Icons.category_outlined,
    };

class _Header extends StatelessWidget {
  const _Header({
    required this.step,
    required this.totalSteps,
    required this.title,
    required this.onBack,
  });

  final int step;
  final int totalSteps;
  final String title;
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
                child: Text(
                  '${l10n.csLesson02Overline} • INSTAGRAM SETUP',
                  textAlign: TextAlign.center,
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: step >= totalSteps - 1
                      ? AppColors.primary
                      : AppColors.surfaceSelected,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  '${step + 1} / $totalSteps',
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: step >= totalSteps - 1
                        ? AppColors.white
                        : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: AppTypography.displayMedium.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.15,
              color: AppColors.textPrimary,
            ),
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
                if (i < totalSteps - 1) const SizedBox(width: 4),
              ],
            ],
          ),
        ],
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
              _LessonNavItem(
                icon: Icons.menu_book_rounded,
                label: l10n.csNavLearn,
                active: true,
                onTap: onLearn,
              ),
              _LessonNavItem(
                icon: Icons.photo_camera_outlined,
                label: l10n.csNavPractice,
                active: false,
                onTap: onPractice,
              ),
              _LessonNavItem(
                icon: Icons.emoji_events_outlined,
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

class _LessonNavItem extends StatelessWidget {
  const _LessonNavItem({
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
            const SizedBox(height: 3),
            Text(
              label,
              style: AppTypography.navLabel.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UsernameStep extends StatelessWidget {
  const _UsernameStep({
    required this.options,
    required this.selected,
    required this.onPick,
    required this.onBack,
    required this.onNext,
  });

  final List<String> options;
  final String? selected;
  final ValueChanged<String> onPick;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            children: [
              Text(
                l10n.csPickYourUsername,
                style: AppTypography.displayMedium.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.csUsernameHint,
                style: AppTypography.labelSmall.copyWith(
                  fontSize: 13,
                  color: AppColors.textMuted,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 16),
              for (final name in options) ...[
                Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.82,
                    child: _UsernameCard(
                      handle: name,
                      selected: selected == name,
                      onTap: () => onPick(name),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Row(
            children: [
              Pressable(
                elevate: true,
                borderRadius: BorderRadius.circular(14),
                child: Material(
                  color: AppColors.white,
                  elevation: 1,
                  shadowColor: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: onBack,
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.textPrimary,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Pressable(
                  enabled: selected != null,
                  elevate: true,
                  borderRadius: BorderRadius.circular(28),
                  child: AnimatedOpacity(
                    duration: AppMotion.select,
                    opacity: selected != null ? 1 : 0.45,
                    child: Material(
                      color: AppColors.primary,
                      elevation: 4,
                      shadowColor: AppColors.primary.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(28),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(28),
                        onTap: selected != null ? onNext : null,
                        child: SizedBox(
                          height: 48,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.continueAction.toUpperCase(),
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  letterSpacing: 0.6,
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
        ),
      ],
    );
  }
}

class _UsernameCard extends StatelessWidget {
  const _UsernameCard({
    required this.handle,
    required this.selected,
    required this.onTap,
  });

  final String handle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      elevate: true,
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: AppColors.white,
        elevation: selected ? 3 : 1,
        shadowColor: AppColors.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppMotion.select,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.borderLight,
                width: selected ? 2 : 1.2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '@ ',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.primaryLight,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: handle,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: AppMotion.select,
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.borderLight,
                      width: 1.5,
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

class _EditProfileStep extends StatefulWidget {
  const _EditProfileStep({
    required this.initialName,
    required this.initialUsername,
    required this.initialBio,
    required this.bioOptions,
    required this.photoPath,
    required this.onPickPhoto,
    required this.onNameChanged,
    required this.onUsernameChanged,
    required this.onBioChanged,
    required this.onNext,
  });

  final String initialName;
  final String initialUsername;
  final String initialBio;
  final List<String> bioOptions;
  final String? photoPath;
  final VoidCallback onPickPhoto;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onUsernameChanged;
  final ValueChanged<String> onBioChanged;
  final VoidCallback onNext;

  @override
  State<_EditProfileStep> createState() => _EditProfileStepState();
}

class _EditProfileStepState extends State<_EditProfileStep> {
  bool _aiGenerated = false;
  bool _showBioSuggestions = false;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _pronounsCtrl;
  late final TextEditingController _bioCtrl;
  late final FocusNode _bioFocus;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName);
    _usernameCtrl = TextEditingController(text: widget.initialUsername);
    _pronounsCtrl = TextEditingController();
    _bioCtrl = TextEditingController(text: widget.initialBio);
    _bioFocus = FocusNode()..addListener(_onBioFocusChanged);
  }

  void _onBioFocusChanged() {
    if (_bioFocus.hasFocus && !_showBioSuggestions) {
      setState(() => _showBioSuggestions = true);
    }
  }

  @override
  void dispose() {
    _bioFocus.removeListener(_onBioFocusChanged);
    _bioFocus.dispose();
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _pronounsCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  void _appendBioLine(String line) {
    final current = _bioCtrl.text.trim();
    if (current.contains(line)) return;
    final next = current.isEmpty ? line : '$current\n$line';
    _bioCtrl.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: next.length),
    );
    widget.onBioChanged(next);
    setState(() => _showBioSuggestions = true);
  }

  void _useSuggestedBio() {
    // Place + craft + how to buy — first 3 suggestion lines when available.
    final picks = widget.bioOptions.take(3).toList();
    if (picks.isEmpty) return;
    final next = picks.join('\n');
    _bioCtrl.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: next.length),
    );
    widget.onBioChanged(next);
    setState(() => _showBioSuggestions = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        const SizedBox(height: 8),
        Center(
          child: Column(
            children: [
              SizedBox(
                width: 108,
                height: 72,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: _AvatarCircle(
                        onTap: widget.onPickPhoto,
                        child: widget.photoPath == null ||
                                widget.photoPath!.isEmpty
                            ? const Icon(
                                Icons.person_rounded,
                                size: 30,
                                color: AppColors.textMuted,
                              )
                            : PhotoThumb(
                                path: widget.photoPath!,
                                borderRadius: BorderRadius.zero,
                              ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: _AvatarCircle(
                        onTap: widget.onPickPhoto,
                        fill: AppColors.primary,
                        child: const Icon(
                          Icons.person_rounded,
                          size: 30,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Pressable(
                elevate: false,
                child: InkWell(
                  onTap: widget.onPickPhoto,
                  child: Text(
                    'Edit picture or avatar',
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _ProfileFieldCard(
          label: l10n.csFieldName,
          controller: _nameCtrl,
          onChanged: (v) {
            widget.onNameChanged(v);
            setState(() {});
          },
        ),
        const SizedBox(height: 10),
        _ProfileFieldCard(
          label: l10n.csFieldUsername,
          controller: _usernameCtrl,
          onChanged: (v) {
            widget.onUsernameChanged(v);
            setState(() {});
          },
        ),
        const SizedBox(height: 10),
        _ProfileFieldCard(
          label: 'Pronouns',
          placeholder: 'Add pronouns',
          controller: _pronounsCtrl,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 10),
        _ProfileFieldCard(
          label: l10n.csFieldBio,
          placeholder: 'Write your own, or tap for suggestions',
          controller: _bioCtrl,
          focusNode: _bioFocus,
          maxLines: 4,
          minLines: 3,
          onTap: () => setState(() => _showBioSuggestions = true),
          onChanged: (v) {
            widget.onBioChanged(v);
            setState(() {});
          },
        ),
        if (_showBioSuggestions) ...[
          const SizedBox(height: 10),
          _BioSuggestionsPanel(
            prompt: l10n.csBioLinesPrompt,
            options: widget.bioOptions,
            selectedText: _bioCtrl.text,
            onPickLine: _appendBioLine,
            onUseFormat: widget.bioOptions.length >= 2 ? _useSuggestedBio : null,
          ),
        ],
        const SizedBox(height: 6),
        _ActionRow(
          label: 'Links',
          action: 'Add link',
          onTap: () {},
        ),
        _ActionRow(
          label: 'Banners',
          subtitle: 'Add music, profiles and more.',
          action: 'Add banners',
          onTap: () {},
        ),
        const _ChevronRow(label: 'Gender', trailing: Icons.expand_more_rounded),
        const _ChevronRow(label: 'Reorder grid'),
        const SizedBox(height: 8),
        Material(
          color: AppColors.white,
          elevation: 1,
          shadowColor: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'AI-generated profile',
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'NEW',
                              style: AppTypography.navLabel.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          style: AppTypography.labelSmall.copyWith(
                            fontSize: 12,
                            height: 1.35,
                            color: AppColors.textMuted,
                          ),
                          children: const [
                            TextSpan(
                              text:
                                  'Add this label if your profile features an AI-generated person. ',
                            ),
                            TextSpan(
                              text: 'Learn more',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: _aiGenerated,
                  activeThumbColor: AppColors.white,
                  activeTrackColor: AppColors.primary,
                  onChanged: (v) => setState(() => _aiGenerated = v),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        _GuideProfessionalCta(
          onTap: widget.onNext,
        ),
        const SizedBox(height: 12),
        const _BlueTextLink(label: 'Personal information settings'),
        const SizedBox(height: 12),
        const _BlueTextLink(label: 'Show your profile is verified'),
      ],
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({
    required this.child,
    required this.onTap,
    this.fill,
  });

  final Widget child;
  final VoidCallback onTap;
  final Color? fill;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: fill ?? AppColors.surfaceMuted,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: AppColors.primary.withValues(alpha: 0.16),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Ink(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: fill ?? AppColors.surfaceMuted,
            border: Border.all(color: AppColors.white, width: 3),
          ),
          child: ClipOval(child: child),
        ),
      ),
    );
  }
}

class _ProfileFieldCard extends StatelessWidget {
  const _ProfileFieldCard({
    required this.label,
    required this.controller,
    required this.onChanged,
    this.placeholder,
    this.focusNode,
    this.onTap,
    this.maxLines = 1,
    this.minLines = 1,
  });

  final String label;
  final String? placeholder;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final int maxLines;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 1,
      shadowColor: AppColors.primary.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            TextField(
              controller: controller,
              focusNode: focusNode,
              onTap: onTap,
              onChanged: onChanged,
              maxLines: maxLines,
              minLines: minLines,
              cursorColor: AppColors.primary,
              style: AppTypography.labelLarge.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: AppColors.white,
                hintText: placeholder,
                hintStyle: AppTypography.labelLarge.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 4, bottom: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BioSuggestionsPanel extends StatelessWidget {
  const _BioSuggestionsPanel({
    required this.prompt,
    required this.options,
    required this.selectedText,
    required this.onPickLine,
    this.onUseFormat,
  });

  final String prompt;
  final List<String> options;
  final String selectedText;
  final ValueChanged<String> onPickLine;
  final VoidCallback? onUseFormat;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 1,
      shadowColor: AppColors.primary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight, width: 1.2),
        ),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              prompt,
              style: AppTypography.labelLarge.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap lines to add them, or keep typing your own.',
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            if (onUseFormat != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Pressable(
                  elevate: false,
                  borderRadius: BorderRadius.circular(99),
                  child: InkWell(
                    onTap: onUseFormat,
                    borderRadius: BorderRadius.circular(99),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(99),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'Use suggested bio',
                        style: AppTypography.navLabel.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            for (var i = 0; i < options.length; i++) ...[
              if (i > 0) const SizedBox(height: 8),
              _BioSuggestionChip(
                label: options[i],
                selected: selectedText.contains(options[i]),
                onTap: () => onPickLine(options[i]),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BioSuggestionChip extends StatelessWidget {
  const _BioSuggestionChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      elevate: true,
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppMotion.select,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.borderLight,
                width: selected ? 1.6 : 1.2,
              ),
              color: selected ? AppColors.primary : AppColors.surfaceSelected,
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.22),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: selected ? AppColors.white : AppColors.primary,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: AppMotion.select,
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected
                        ? AppColors.white.withValues(alpha: 0.22)
                        : AppColors.white,
                    border: Border.all(
                      color: selected
                          ? AppColors.white.withValues(alpha: 0.75)
                          : AppColors.primary.withValues(alpha: 0.35),
                    ),
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check_rounded,
                          size: 14,
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

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.label,
    required this.action,
    required this.onTap,
    this.subtitle,
  });

  final String label;
  final String action;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.labelLarge.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    action,
                    style: AppTypography.labelLarge.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChevronRow extends StatelessWidget {
  const _ChevronRow({
    required this.label,
    this.trailing = Icons.chevron_right_rounded,
  });

  final String label;
  final IconData trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTypography.labelLarge.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Icon(trailing, size: 20, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _ProfessionalSwitchStep extends StatelessWidget {
  const _ProfessionalSwitchStep({
    required this.photoPath,
    required this.username,
    required this.displayName,
    required this.onBack,
    required this.onClose,
    required this.onNext,
  });

  final String? photoPath;
  final String username;
  final String displayName;
  final VoidCallback onBack;
  final VoidCallback onClose;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final initialSource =
        displayName.trim().isNotEmpty ? displayName : username;
    final initial = initialSource.trim().isEmpty
        ? 'A'
        : initialSource.trim()[0].toUpperCase();
    final brandLine = displayName.trim().isEmpty
        ? (username.trim().isEmpty ? 'YOUR STUDIO' : username.trim())
        : displayName.trim();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _RoundIconButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: onBack,
                  ),
                  Expanded(
                    child: Text(
                      'LESSON 02  •  INSTAGRAM SETUP',
                      textAlign: TextAlign.center,
                      style: AppTypography.navLabel.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSelected,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      '3 / 5',
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  _RoundIconButton(
                    icon: Icons.close_rounded,
                    onTap: onClose,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'Switch to Professional Account',
                style: AppTypography.displayMedium.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  for (var i = 0; i < 5; i++) ...[
                    Expanded(
                      child: Container(
                        height: 5,
                        decoration: BoxDecoration(
                          color: i < 3
                              ? AppColors.primary
                              : AppColors.surfaceMuted,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                    if (i < 4) const SizedBox(width: 6),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Step 3: Instagram In-App Action',
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Text(
                    'Interactive Guide',
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 11.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            children: [
              Center(
                child: SizedBox(
                  width: 108,
                  height: 108,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surfaceSelected,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.28),
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: photoPath == null || photoPath!.isEmpty
                              ? Center(
                                  child: Text(
                                    initial,
                                    style: AppTypography.displayMedium.copyWith(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                )
                              : PhotoThumb(
                                  path: photoPath!,
                                  borderRadius: BorderRadius.zero,
                                ),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        bottom: 2,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 2.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                brandLine.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTypography.navLabel.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Get more tools and switch for free',
                textAlign: TextAlign.center,
                style: AppTypography.displayMedium.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 18),
              const _ProBenefitCard(
                icon: Icons.bar_chart_rounded,
                title: 'Access insights',
                body:
                    'See what content is getting the most attention and the best times to post.',
              ),
              const SizedBox(height: 10),
              const _ProBenefitCard(
                icon: Icons.campaign_rounded,
                title: 'Run ads',
                body:
                    'Get your content in front of more people and bring them to your profile or website to drive brand awareness and sales.',
              ),
              const SizedBox(height: 10),
              const _ProBenefitCard(
                icon: Icons.account_balance_wallet_rounded,
                title: 'Get paid',
                body:
                    'Earn money when you become eligible for features like Bonuses and Subscriptions.',
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSelected,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline_rounded,
                        size: 16,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ANTARAN WEAVER TIP',
                            style: AppTypography.navLabel.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'A professional account is 100% free and lets direct buyers see your WhatsApp contact button to place bulk orders for your handloom weaves.',
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 13,
                              height: 1.4,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Column(
            children: [
              Pressable(
                elevate: true,
                borderRadius: BorderRadius.circular(28),
                child: Material(
                  color: AppColors.primary,
                  elevation: 3,
                  shadowColor: AppColors.primary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(28),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: onNext,
                    child: SizedBox(
                      height: 52,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next',
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Free forever  •  Switch back to personal anytime',
                textAlign: TextAlign.center,
                style: AppTypography.labelSmall.copyWith(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.primary.withValues(alpha: 0.12),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 22, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _ProBenefitCard extends StatelessWidget {
  const _ProBenefitCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceSelected,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelLarge.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.textSecondary,
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

class _GuideProfessionalCta extends StatefulWidget {
  const _GuideProfessionalCta({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<_GuideProfessionalCta> createState() => _GuideProfessionalCtaState();
}

class _GuideProfessionalCtaState extends State<_GuideProfessionalCta>
    with SingleTickerProviderStateMixin {
  late final AnimationController _blink;

  @override
  void initState() {
    super.initState();
    _blink = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blink,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(_blink.value);
        // Flash between solid blue and a brighter flash so it reads as a cue.
        final flash = Color.lerp(
          AppColors.primary,
          const Color(0xFF5B9BD5),
          t,
        )!;
        final glowAlpha = 0.18 + (t * 0.42);
        final borderWidth = 2.0 + (t * 1.5);

        return Pressable(
          elevate: true,
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: widget.onTap,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      flash,
                      Color.lerp(flash, AppColors.primaryLight, 0.35)!,
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35 + t * 0.55),
                    width: borderWidth,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: flash.withValues(alpha: glowAlpha),
                      blurRadius: 10 + (t * 18),
                      spreadRadius: t * 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.workspace_premium_rounded,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Switch to professional account',
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Tap to continue the lesson →',
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 11.5,
                              color: AppColors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.white.withValues(alpha: 0.95),
                      size: 26,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BlueTextLink extends StatelessWidget {
  const _BlueTextLink({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _CategoryStep extends StatefulWidget {
  const _CategoryStep({
    required this.selected,
    required this.onPick,
    required this.onNext,
  });

  final String? selected;
  final ValueChanged<String> onPick;
  final VoidCallback onNext;

  @override
  State<_CategoryStep> createState() => _CategoryStepState();
}

class _CategoryStepState extends State<_CategoryStep> {
  bool _displayOnProfile = true;
  String _query = '';

  List<String> get _filteredKeys {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _categoryKeys;
    return _categoryKeys
        .where((k) => k.toLowerCase().contains(q))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final keys = _filteredKeys;
    final selectedCount = widget.selected == null ? 0 : 1;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          decoration: BoxDecoration(
            color: AppColors.surfaceSelected,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'STEP 4 OF 5  •  Business Identity',
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'What best describes you?',
                style: AppTypography.displayMedium.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Categories help people find accounts like yours. You can change this at any time.',
                style: AppTypography.labelSmall.copyWith(
                  fontSize: 13,
                  height: 1.4,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.tips_and_updates_rounded,
                      size: 18,
                      color: AppColors.primary.withValues(alpha: 0.85),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: AppTypography.labelSmall.copyWith(
                            fontSize: 12.5,
                            height: 1.35,
                            color: AppColors.textSecondary,
                          ),
                          children: const [
                            TextSpan(
                              text: 'Recommendation for Handloom Artisans. ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text:
                                  'Pick Clothing (Brand) to unlock the Shop badge.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceMuted,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Tip',
                        style: AppTypography.labelLarge.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Display on profile',
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Show this category under your name on Instagram.',
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: _displayOnProfile,
                activeThumbColor: AppColors.white,
                activeTrackColor: AppColors.primary,
                onChanged: (v) => setState(() => _displayOnProfile = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          onChanged: (v) => setState(() => _query = v),
          style: AppTypography.labelLarge.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'Search categories',
            hintStyle: AppTypography.labelSmall.copyWith(
              fontSize: 14,
              color: AppColors.textMuted,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.textMuted,
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Text(
              'SUGGESTED',
              style: AppTypography.navLabel.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: AppColors.textMuted,
              ),
            ),
            const Spacer(),
            Text(
              '$selectedCount Selected',
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final key in keys) ...[
          _CategoryOptionTile(
            label: _categoryLabel(l10n, key),
            icon: _categoryIcon(key),
            selected: widget.selected == key,
            isBestChoice: key == _recommendedCategoryKey,
            subtitle: key == _recommendedCategoryKey
                ? 'Ideal for weavers selling stoles, sarees & fabrics'
                : null,
            onTap: () => widget.onPick(key),
          ),
          const SizedBox(height: 8),
        ],
        if (keys.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'No categories match “$_query”.',
              textAlign: TextAlign.center,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ),
        const SizedBox(height: 8),
        Pressable(
          elevate: true,
          borderRadius: BorderRadius.circular(28),
          child: Material(
            color: widget.selected == null
                ? AppColors.primary.withValues(alpha: 0.45)
                : AppColors.primary,
            borderRadius: BorderRadius.circular(28),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: widget.selected == null ? null : widget.onNext,
              child: SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Switch to professional account',
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            style: AppTypography.labelSmall.copyWith(
              fontSize: 12,
              height: 1.4,
              color: AppColors.textMuted,
            ),
            children: const [
              TextSpan(
                text:
                    'Switching makes your profile public and all of your content can appear in search engines. ',
              ),
              TextSpan(
                text: 'Learn how to manage',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _CategoryOptionTile extends StatelessWidget {
  const _CategoryOptionTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.isBestChoice,
    required this.onTap,
    this.subtitle,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final bool isBestChoice;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      elevate: false,
      borderRadius: BorderRadius.circular(14),
      child: Material(
        color: selected ? AppColors.surfaceSelected : AppColors.white,
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
                color: selected ? AppColors.primary : AppColors.borderLight,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary
                        : AppColors.surfaceMuted.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: selected ? AppColors.white : AppColors.textMuted,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Text(
                            label,
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (isBestChoice)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'BEST CHOICE',
                                style: AppTypography.navLabel.copyWith(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.4,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: AppTypography.labelSmall.copyWith(
                            fontSize: 12,
                            height: 1.35,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedContainer(
                  duration: AppMotion.select,
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.border,
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

class _PreviewStep extends StatelessWidget {
  const _PreviewStep({
    required this.username,
    required this.displayName,
    required this.categoryKey,
    required this.bioPicked,
    required this.placeLabel,
    required this.craftLabel,
    required this.avatarLetter,
    required this.photoPath,
    required this.onFinish,
    required this.onSharePhoto,
  });

  final String username;
  final String displayName;
  final String categoryKey;
  final List<String> bioPicked;
  final String? placeLabel;
  final String? craftLabel;
  final String avatarLetter;
  final String? photoPath;
  final VoidCallback onFinish;
  final VoidCallback onSharePhoto;

  String get _handle {
    final raw = username.trim();
    if (raw.isEmpty) return 'your_studio';
    return raw.startsWith('@') ? raw.substring(1) : raw;
  }

  String get _profileName {
    final name = displayName.trim();
    if (name.isNotEmpty) return name;
    return _handle;
  }

  String get _bioText {
    if (bioPicked.isEmpty) return 'Add your craft story on the edit profile step.';
    return bioPicked.join('\n');
  }

  String get _locationText {
    final place = placeLabel?.trim();
    if (place != null && place.isNotEmpty) return place;
    // Prefer a short location-looking bio line if present.
    for (final line in bioPicked) {
      if (line.length <= 40 && !line.toLowerCase().contains('dm')) {
        return line;
      }
    }
    return '';
  }

  String _emptyStateHint(AppLocalizations l10n) {
    final craft = (craftLabel ?? '').trim();
    if (craft.isNotEmpty) {
      return 'Share photos of your $craft with buyers.';
    }
    final category = _categoryLabel(l10n, categoryKey);
    return 'Share photos of your $category work with buyers.';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final location = _locationText;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          decoration: BoxDecoration(
            color: AppColors.surfaceSelected,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Ready for Buyers!',
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Your bio, contact action button, and artisan branding are officially configured in Instagram Professional mode. Clients can now locate and order straight from your catalog.',
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 12.5,
                        height: 1.4,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
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
                padding: const EdgeInsets.fromLTRB(12, 12, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              _handle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelLarge.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 20,
                            color: AppColors.textPrimary,
                          ),
                          Container(
                            width: 7,
                            height: 7,
                            margin: const EdgeInsets.only(left: 2),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53E3E),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_box_outlined),
                      color: AppColors.textPrimary,
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook_rounded),
                      color: AppColors.textPrimary,
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu_rounded),
                      color: AppColors.textPrimary,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 4, 14, 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 78,
                      height: 78,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 78,
                            height: 78,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.35),
                                width: 2.5,
                              ),
                            ),
                            child: ClipOval(
                              child: photoPath == null || photoPath!.isEmpty
                                  ? ColoredBox(
                                      color: AppColors.surfaceSelected,
                                      child: Center(
                                        child: Text(
                                          avatarLetter,
                                          style: AppTypography.displayMedium
                                              .copyWith(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    )
                                  : PhotoThumb(
                                      path: photoPath!,
                                      borderRadius: BorderRadius.zero,
                                    ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                size: 13,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          _StatColumn(value: '0', label: 'posts'),
                          _StatColumn(value: '3', label: 'followers'),
                          _StatColumn(value: '0', label: 'following'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _profileName,
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _categoryLabel(l10n, categoryKey),
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _bioText,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 13,
                        height: 1.4,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (location.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 15,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              location,
                              style: AppTypography.labelSmall.copyWith(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundAlt,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Text(
                          '+ Add banners',
                          style: AppTypography.labelSmall.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundAlt,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Professional dashboard',
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Tools and resources just for businesses.',
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 11.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: Row(
                  children: [
                    for (final label in [
                      'Edit profile',
                      'Share profile',
                      'Contact',
                    ]) ...[
                      Expanded(
                        child: Container(
                          height: 34,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundAlt,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            label,
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      if (label != 'Contact') const SizedBox(width: 6),
                    ],
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.divider),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.grid_on_rounded, size: 22),
                          const SizedBox(height: 6),
                          Container(
                            height: 2,
                            color: AppColors.textPrimary,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.person_pin_outlined,
                        size: 22,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 22),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSelected,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.photo_camera_outlined,
                        size: 28,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Create your first post',
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _emptyStateHint(l10n),
                      textAlign: TextAlign.center,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 12.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Material(
                      color: AppColors.surfaceSelected,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: onSharePhoto,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            'Share Photo',
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'COMPLETED CHECKLIST',
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _ChecklistRow(
                label: photoPath != null && photoPath!.isNotEmpty
                    ? 'Artisan Logo & Brand Handle (@$_handle)'
                    : 'Brand Handle (@$_handle)',
              ),
              const SizedBox(height: 10),
              _ChecklistRow(
                label: bioPicked.isNotEmpty
                    ? 'Value-Driven Bio${location.isNotEmpty ? ' & Location Pin' : ''}'
                    : 'Professional Category (${_categoryLabel(l10n, categoryKey)})',
              ),
              const SizedBox(height: 10),
              const _ChecklistRow(
                label: 'Contact Button for Direct Inquiries',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Pressable(
          elevate: true,
          borderRadius: BorderRadius.circular(28),
          child: Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(28),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: onFinish,
              child: SizedBox(
                height: 54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'NEXT LESSON: CREATE A POST',
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
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
      ],
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.labelLarge.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            fontSize: 11.5,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle_rounded,
          size: 18,
          color: AppColors.success,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: AppTypography.labelLarge.copyWith(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

