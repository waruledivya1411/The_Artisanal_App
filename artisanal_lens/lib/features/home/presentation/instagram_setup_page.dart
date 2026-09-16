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
  int _settingsSub = 0; // 0 = Settings, 1 = Account type and tools
  int? _settingsWrong;
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
    return ['${base}_weaves', '$base.handloom', 'weaves_by_$base'];
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

  String _localizedShortName(AppLocalizations l10n) {
    final id = _cluster?.id;
    if (id != null) {
      final name = AppCopy.clusterShortName(l10n, id);
      if (name.isNotEmpty) return name;
    }
    return _cluster?.shortName ?? l10n.csCraftFallback;
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
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
      routeName: AppRoute.home,
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              stepLabel: l10n.csStepOfTotal(_step + 1, 5),
              onBack: () {
                if (_step == 0) {
                  context.goNamed(AppRoute.home);
                } else if (_step == 2 && _settingsSub == 1) {
                  setState(() {
                    _settingsSub = 0;
                    _settingsWrong = null;
                  });
                } else {
                  setState(() {
                    _step -= 1;
                    _settingsWrong = null;
                  });
                }
              },
            ),
            Expanded(
              child: switch (_step) {
                0 => _UsernameStep(
                    options: _usernameOptions(learnerName),
                    selected: _username,
                    onPick: (v) => setState(() => _username = v),
                    onNext: () => setState(() => _step = 1),
                  ),
                1 => _EditProfileStep(
                    displayName:
                        '$learnerName · ${_localizedShortName(l10n)}',
                    username: _username ?? l10n.csPickANameFallback,
                    bioPicked: _bio.toList(),
                    bioOptions: _bioOptions(l10n),
                    photoPath: _profilePhotoPath,
                    onPickPhoto: _pickProfilePhoto,
                    onToggleBio: (line) {
                      setState(() {
                        if (_bio.contains(line)) {
                          _bio.remove(line);
                        } else {
                          _bio.add(line);
                        }
                      });
                    },
                    onNext: () => setState(() => _step = 2),
                  ),
                2 => _SettingsWalkthroughStep(
                    settingsSub: _settingsSub,
                    settingsWrong: _settingsWrong,
                    onPick: (ok, index) {
                      if (!ok) {
                        setState(() => _settingsWrong = index);
                        return;
                      }
                      if (_settingsSub == 0) {
                        setState(() {
                          _settingsSub = 1;
                          _settingsWrong = null;
                        });
                      } else {
                        setState(() {
                          _step = 3;
                          _settingsWrong = null;
                        });
                      }
                    },
                  ),
                3 => _CategoryStep(
                    selected: _category,
                    onPick: (v) => setState(() => _category = v),
                    onNext: () => setState(() => _step = 4),
                  ),
                _ => _PreviewStep(
                    username: _username ?? l10n.csPickANameFallback,
                    categoryKey: _category ?? _categoryKeys.first,
                    bioPicked: _bio.toList(),
                    avatarLetter: ((_username ?? learnerName).isEmpty
                            ? 'A'
                            : (_username ?? learnerName)[0])
                        .toUpperCase(),
                    photoPath: _profilePhotoPath,
                    onFinish: _finish,
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Persisted category values stay English so saved preferences keep working.
const _categoryKeys = [
  'Artist',
  'Shopping & retail',
  'Local business',
  'Entrepreneur',
];

String _categoryLabel(AppLocalizations l10n, String key) => switch (key) {
      'Artist' => l10n.csCategoryArtist,
      'Shopping & retail' => l10n.csCategoryShoppingRetail,
      'Local business' => l10n.csCategoryLocalBusiness,
      'Entrepreneur' => l10n.csCategoryEntrepreneur,
      _ => key,
    };

class _Header extends StatelessWidget {
  const _Header({required this.stepLabel, required this.onBack});

  final String stepLabel;
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
                  l10n.csLesson02Overline,
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  l10n.csLesson02Title,
                  style: AppTypography.labelLarge.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            stepLabel,
            style: AppTypography.labelSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _UsernameStep extends StatelessWidget {
  const _UsernameStep({
    required this.options,
    required this.selected,
    required this.onPick,
    required this.onNext,
  });

  final List<String> options;
  final String? selected;
  final ValueChanged<String> onPick;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          l10n.csPickYourUsername,
          style: AppTypography.displayMedium.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.csUsernameHint,
          style: AppTypography.labelSmall.copyWith(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        for (final name in options) ...[
          _SelectRow(
            selected: selected == name,
            onTap: () => onPick(name),
            child: Row(
              children: [
                const Text(
                  '@',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                Text(
                  name,
                  style: AppTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: selected == name
                        ? AppColors.white
                        : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (selected != null) ...[
          const SizedBox(height: 8),
          _PrimaryButton(label: l10n.csNextEditProfile, onTap: onNext),
        ],
      ],
    );
  }
}

class _EditProfileStep extends StatelessWidget {
  const _EditProfileStep({
    required this.displayName,
    required this.username,
    required this.bioPicked,
    required this.bioOptions,
    required this.photoPath,
    required this.onPickPhoto,
    required this.onToggleBio,
    required this.onNext,
  });

  final String displayName;
  final String username;
  final List<String> bioPicked;
  final List<String> bioOptions;
  final String? photoPath;
  final VoidCallback onPickPhoto;
  final ValueChanged<String> onToggleBio;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bioReady = bioPicked.length >= 2;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Text.rich(
          TextSpan(
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
            children: [
              TextSpan(text: l10n.csEditProfileIntroBefore),
              TextSpan(
                text: l10n.csEditProfileIntroBold,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: l10n.csEditProfileIntroAfter),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.textPrimary, width: 2),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPickPhoto,
                  customBorder: const CircleBorder(),
                  child: Ink(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceMuted,
                      border:
                          Border.all(color: AppColors.textPrimary, width: 2),
                    ),
                    child: ClipOval(
                      child: photoPath == null || photoPath!.isEmpty
                          ? const Icon(Icons.person_outline, size: 32)
                          : PhotoThumb(
                              path: photoPath!,
                              borderRadius: BorderRadius.zero,
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: onPickPhoto,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    l10n.csChangePhotoTip,
                    textAlign: TextAlign.center,
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _ProfileRow(label: l10n.csFieldName, value: displayName),
              _ProfileRow(label: l10n.csFieldUsername, value: username),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.divider, width: 2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        l10n.csFieldBio,
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                    Expanded(
                      child: bioPicked.isEmpty
                          ? Text(
                              l10n.csBioPlaceholder,
                              style: AppTypography.labelSmall.copyWith(
                                fontSize: 12.5,
                                color: AppColors.textMuted,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (final line in bioPicked)
                                  Text(
                                    line,
                                    style: AppTypography.labelSmall.copyWith(
                                      fontSize: 12.5,
                                      height: 1.45,
                                      color: AppColors.textPrimary,
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
        const SizedBox(height: 16),
        Text(
          l10n.csBioLinesPrompt,
          style: AppTypography.navLabel.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final line in bioOptions)
              _ChipButton(
                label: line,
                selected: bioPicked.contains(line),
                onTap: () => onToggleBio(line),
              ),
          ],
        ),
        if (bioReady) ...[
          const SizedBox(height: 16),
          _PrimaryButton(label: l10n.csNextGoProfessional, onTap: onNext),
        ],
      ],
    );
  }
}

class _SettingsWalkthroughStep extends StatelessWidget {
  const _SettingsWalkthroughStep({
    required this.settingsSub,
    required this.settingsWrong,
    required this.onPick,
  });

  final int settingsSub;
  final int? settingsWrong;
  final void Function(bool ok, int index) onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final menu = settingsSub == 0
        ? [
            _SettingsRowData(
              l10n.csSettingsNotifications,
              l10n.csSettingsNotificationsSub,
              false,
            ),
            _SettingsRowData(
              l10n.csSettingsPrivacy,
              l10n.csSettingsPrivacySub,
              false,
            ),
            _SettingsRowData(
              l10n.csAccountTypeAndTools,
              l10n.csSettingsAccountTypeSub,
              true,
            ),
            _SettingsRowData(
              l10n.csSettingsHelp,
              l10n.csSettingsHelpSub,
              false,
            ),
          ]
        : [
            _SettingsRowData(
              l10n.csSettingsSwitchProfessional,
              l10n.csSettingsSwitchProfessionalSub,
              true,
            ),
            _SettingsRowData(
              l10n.csSettingsDeleteAccount,
              l10n.csSettingsDeleteAccountSub,
              false,
            ),
            _SettingsRowData(
              l10n.csSettingsPersonalInfo,
              l10n.csSettingsPersonalInfoSub,
              false,
            ),
          ];

    final prompt = settingsSub == 0
        ? l10n.csSettingsPrompt
        : l10n.csSettingsPromptAlmost;
    final title =
        settingsSub == 0 ? l10n.csSettingsTitle : l10n.csAccountTypeAndTools;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Text(
          prompt,
          style: AppTypography.labelSmall.copyWith(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.textPrimary, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Text(
                  title,
                  style: AppTypography.labelLarge.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              for (var i = 0; i < menu.length; i++)
                InkWell(
                  onTap: () => onPick(menu[i].ok, i),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 52),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: settingsWrong == i
                          ? AppColors.surfaceMuted
                          : Colors.transparent,
                      border: const Border(
                        top: BorderSide(color: AppColors.divider, width: 2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: menu[i].ok
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu[i].label,
                                style: AppTypography.labelLarge.copyWith(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                menu[i].sub,
                                style: AppTypography.labelSmall.copyWith(
                                  fontSize: 11,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (settingsWrong != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            color: const Color(0xFFFFE5E5),
            child: Text(
              l10n.csSettingsWrongPick,
              style: AppTypography.labelLarge.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9B2C2C),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SettingsRowData {
  const _SettingsRowData(this.label, this.sub, this.ok);
  final String label;
  final String sub;
  final bool ok;
}

class _CategoryStep extends StatelessWidget {
  const _CategoryStep({
    required this.selected,
    required this.onPick,
    required this.onNext,
  });

  final String? selected;
  final ValueChanged<String> onPick;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Text.rich(
          TextSpan(
            style: AppTypography.labelSmall.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
            children: [
              TextSpan(text: l10n.csCategoryIntroBefore),
              TextSpan(
                text: l10n.csCategoryIntroBold,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: l10n.csCategoryIntroAfter),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final key in _categoryKeys)
              _ChipButton(
                label: _categoryLabel(l10n, key),
                selected: selected == key,
                onTap: () => onPick(key),
              ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          color: AppColors.surfaceMuted,
          child: Text.rich(
            TextSpan(
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12.5,
                height: 1.5,
                color: AppColors.textPrimary,
              ),
              children: [
                TextSpan(text: l10n.csProAccountNote1),
                TextSpan(
                  text: l10n.csProAccountInsights,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: l10n.csProAccountNote2),
                TextSpan(
                  text: l10n.csProAccountContactButton,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: l10n.csProAccountNote3),
                TextSpan(
                  text: l10n.csProAccountAds,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: l10n.csProAccountNote4),
              ],
            ),
          ),
        ),
        if (selected != null) ...[
          const SizedBox(height: 16),
          _PrimaryButton(label: l10n.csSwitchToProfessional, onTap: onNext),
        ],
      ],
    );
  }
}

class _PreviewStep extends StatelessWidget {
  const _PreviewStep({
    required this.username,
    required this.categoryKey,
    required this.bioPicked,
    required this.avatarLetter,
    required this.photoPath,
    required this.onFinish,
  });

  final String username;
  final String categoryKey;
  final List<String> bioPicked;
  final String avatarLetter;
  final String? photoPath;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Text(
          l10n.csPreviewIntro,
          style: AppTypography.labelSmall.copyWith(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.textPrimary, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.textPrimary,
                      border:
                          Border.all(color: AppColors.textPrimary, width: 2),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: photoPath == null || photoPath!.isEmpty
                        ? Text(
                            avatarLetter,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          )
                        : PhotoThumb(
                            path: photoPath!,
                            borderRadius: BorderRadius.zero,
                          ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          _categoryLabel(l10n, categoryKey),
                          style: AppTypography.labelSmall.copyWith(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.csPostsFollowers,
                          style: AppTypography.labelSmall.copyWith(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              for (final line in bioPicked)
                Text(
                  line,
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.textPrimary, width: 2),
                      ),
                      child: Text(
                        l10n.csFollow,
                        style: AppTypography.navLabel.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.textPrimary, width: 2),
                      ),
                      child: Text(
                        l10n.csMessage,
                        style: AppTypography.navLabel.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: AppColors.primary.withValues(alpha: 0.12),
                child: Text(
                  l10n.csProfessionalAccount,
                  style: AppTypography.navLabel.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _PrimaryButton(label: l10n.csFinishEarnBadge, onTap: onFinish),
      ],
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.divider, width: 2)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.labelLarge.copyWith(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectRow extends StatelessWidget {
  const _SelectRow({
    required this.selected,
    required this.onTap,
    required this.child,
  });

  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : AppColors.white,
          border: Border.all(color: AppColors.textPrimary, width: 2),
        ),
        child: child,
      ),
    );
  }
}

class _ChipButton extends StatelessWidget {
  const _ChipButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : AppColors.white,
          border: Border.all(color: AppColors.textPrimary, width: 2),
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        color: AppColors.primary,
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
