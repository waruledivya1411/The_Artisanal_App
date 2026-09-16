import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/auth_controller.dart';
import '../../../app/locale_controller.dart';
import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_typography.dart';
import '../../../l10n/app_copy.dart';
import '../click_social_clusters.dart';
import '../click_social_store.dart';
import '../../../data/services/click_social_sync_service.dart';

class ClickSocialHomePage extends ConsumerStatefulWidget {
  const ClickSocialHomePage({super.key});

  @override
  ConsumerState<ClickSocialHomePage> createState() =>
      _ClickSocialHomePageState();
}

class _ClickSocialHomePageState extends ConsumerState<ClickSocialHomePage> {
  static const _prefsOnboarded = 'click_social_onboarded';
  static const _prefsName = 'click_social_name';
  static const _prefsClusterId = 'click_social_cluster_id';
  static const _prefsLanguage = 'click_social_language';
  static const _prefsProfileDone = 'click_social_lesson_profile_done';
  static const _prefsContentDone = 'click_social_lesson_content_done';
  static const _prefsStrategyDone = 'click_social_lesson_strategy_done';
  static const _prefsAnalyticsDone = 'click_social_lesson_analytics_done';
  static const _prefsPhotoDone = 'click_social_lesson_photo_done';

  final TextEditingController _nameController = TextEditingController();
  bool _loading = true;
  bool _onboarded = false;
  bool _photoLessonDone = false;
  bool _profileLessonDone = false;
  bool _contentLessonDone = false;
  bool _strategyLessonDone = false;
  bool _analyticsLessonDone = false;
  String? _selectedClusterId;
  AppLanguage _selectedLanguage = AppLanguage.english;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    ClickSocialSync.pulled.addListener(_restore);
    _restore();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh lesson badges when returning from Lesson 02 / other flows.
    if (_onboarded) {
      _refreshLessonFlags();
    }
  }

  Future<void> _refreshLessonFlags() async {
    final prefs = await SharedPreferences.getInstance();
    final photoDone = prefs.getBool(_prefsPhotoDone) ?? false;
    final profileDone = prefs.getBool(_prefsProfileDone) ?? false;
    final contentDone = prefs.getBool(_prefsContentDone) ?? false;
    final strategyDone = prefs.getBool(_prefsStrategyDone) ?? false;
    final analyticsDone = prefs.getBool(_prefsAnalyticsDone) ?? false;
    if (!mounted) return;
    if (photoDone == _photoLessonDone &&
        profileDone == _profileLessonDone &&
        contentDone == _contentLessonDone &&
        strategyDone == _strategyLessonDone &&
        analyticsDone == _analyticsLessonDone) {
      return;
    }
    setState(() {
      _photoLessonDone = photoDone;
      _profileLessonDone = profileDone;
      _contentLessonDone = contentDone;
      _strategyLessonDone = strategyDone;
      _analyticsLessonDone = analyticsDone;
    });
  }

  @override
  void dispose() {
    ClickSocialSync.pulled.removeListener(_restore);
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = ref.read(localeProvider);
    final storedLanguage = prefs.getString(_prefsLanguage);
    setState(() {
      _onboarded = prefs.getBool(_prefsOnboarded) ?? false;
      _nameController.text = prefs.getString(_prefsName) ?? '';
      _selectedClusterId = prefs.getString(_prefsClusterId);
      _selectedLanguage = AppLanguage.fromCode(storedLanguage ?? locale.code);
      _photoLessonDone = prefs.getBool(_prefsPhotoDone) ?? false;
      _profileLessonDone = prefs.getBool(_prefsProfileDone) ?? false;
      _contentLessonDone = prefs.getBool(_prefsContentDone) ?? false;
      _strategyLessonDone = prefs.getBool(_prefsStrategyDone) ?? false;
      _analyticsLessonDone = prefs.getBool(_prefsAnalyticsDone) ?? false;
      _loading = false;
    });
  }

  Future<void> _startLearning() async {
    if (_selectedClusterId == null || _nameController.text.trim().isEmpty) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final name = _nameController.text.trim();
    await ref.read(localeProvider.notifier).select(_selectedLanguage);
    await prefs.setBool(_prefsOnboarded, true);
    await prefs.setString(_prefsName, name);
    await prefs.setString(_prefsClusterId, _selectedClusterId!);
    await prefs.setString(_prefsLanguage, _selectedLanguage.code);
    await ClickSocialStore.touch(prefs);
    ClickSocialSync.schedulePush();
    if (!mounted) return;
    setState(() => _onboarded = true);
  }

  /// Applies the picked language straight away so onboarding itself is read
  /// in that language, rather than only after START LEARNING.
  ///
  /// The root MaterialApp is keyed on the language code, so selecting rebuilds
  /// this page from scratch. The half-finished onboarding answers are written
  /// first so [_restore] can bring them back.
  Future<void> _pickLanguage(AppLanguage language) async {
    setState(() => _selectedLanguage = language);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsLanguage, language.code);
    await prefs.setString(_prefsName, _nameController.text.trim());
    if (_selectedClusterId != null) {
      await prefs.setString(_prefsClusterId, _selectedClusterId!);
    }
    await ref.read(localeProvider.notifier).select(language);
  }

  Future<void> _openOnboardingForEdit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsOnboarded, false);
    if (!mounted) return;
    setState(() => _onboarded = false);
  }

  ClickSocialCluster? get _cluster => clusterById(_selectedClusterId);

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final l10n = AppLocalizations.of(context);

    if (!_onboarded) {
      return _OnboardingView(
        nameController: _nameController,
        selectedLanguage: _selectedLanguage,
        onLanguagePick: _pickLanguage,
        selectedClusterId: _selectedClusterId,
        onClusterPick: (id) => setState(() => _selectedClusterId = id),
        onStartLearning: _startLearning,
      );
    }

    final auth = ref.watch(authControllerProvider);
    return _LearningHomeView(
      learnerName: _nameController.text.trim().isEmpty
          ? l10n.csLearnerFallback
          : _nameController.text.trim(),
      clusterPlace: _cluster == null
          ? l10n.csClusterNotSelected
          : (AppCopy.clusterPlace(l10n, _cluster!.id).isEmpty
              ? _cluster!.place
              : AppCopy.clusterPlace(l10n, _cluster!.id)),
      signedIn: auth.isSignedIn,
      photoLessonDone: _photoLessonDone,
      profileLessonDone: _profileLessonDone,
      contentLessonDone: _contentLessonDone,
      strategyLessonDone: _strategyLessonDone,
      analyticsLessonDone: _analyticsLessonDone,
      onEditProfile: _openOnboardingForEdit,
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView({
    required this.nameController,
    required this.selectedLanguage,
    required this.onLanguagePick,
    required this.selectedClusterId,
    required this.onClusterPick,
    required this.onStartLearning,
  });

  final TextEditingController nameController;
  final AppLanguage selectedLanguage;
  final Future<void> Function(AppLanguage) onLanguagePick;
  final String? selectedClusterId;
  final ValueChanged<String> onClusterPick;
  final VoidCallback onStartLearning;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final canStart =
        nameController.text.trim().isNotEmpty && selectedClusterId != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.csAntaranLearningTool,
                  style: AppTypography.overline.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border, width: 1.5),
                  ),
                  child: Text(
                    l10n.csWorksOffline,
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 10,
                      letterSpacing: 1.0,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text.rich(
              TextSpan(
                style: AppTypography.displayLarge.copyWith(
                  fontSize: 46,
                  height: 0.98,
                  letterSpacing: -0.6,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
                children: [
                  TextSpan(text: l10n.csClickAndSocial),
                  const TextSpan(
                    text: '.',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              l10n.csOnboardingTagline,
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            const Divider(height: 1, thickness: 2),
            const SizedBox(height: 18),
            _StepLabel(number: '1', text: l10n.csStepYourName),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: l10n.csNameHint),
            ),
            const SizedBox(height: 20),
            _StepLabel(number: '2', text: l10n.csStepYourLanguage),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final language in AppLanguage.values)
                  _ChoiceButton(
                    selected: language == selectedLanguage,
                    onTap: () => onLanguagePick(language),
                    // HTML shows the native script on the chip (English /
                    // অসমীয়া / ଓଡ଼ିଆ / తెలుగు), not a translated name.
                    label: language.label,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            _StepLabel(number: '3', text: l10n.csStepYourCluster),
            const SizedBox(height: 6),
            Text(
              l10n.csClusterHint,
              style: AppTypography.labelSmall
                  .copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 8),
            for (final cluster in clickSocialClusters)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _ClusterButton(
                  selected: selectedClusterId == cluster.id,
                  label: () {
                    final place = AppCopy.clusterPlace(l10n, cluster.id);
                    return place.isEmpty ? cluster.place : place;
                  }(),
                  markLabel: selectedClusterId == cluster.id
                      ? l10n.csSelected
                      : l10n.csPick,
                  onTap: () => onClusterPick(cluster.id),
                ),
              ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: canStart ? onStartLearning : null,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: const RoundedRectangleBorder(),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    l10n.csStartLearning,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LearningHomeView extends StatelessWidget {
  const _LearningHomeView({
    required this.learnerName,
    required this.clusterPlace,
    required this.signedIn,
    required this.photoLessonDone,
    required this.profileLessonDone,
    required this.contentLessonDone,
    required this.strategyLessonDone,
    required this.analyticsLessonDone,
    required this.onEditProfile,
  });

  final String learnerName;
  final String clusterPlace;
  final bool signedIn;
  final bool photoLessonDone;
  final bool profileLessonDone;
  final bool contentLessonDone;
  final bool strategyLessonDone;
  final bool analyticsLessonDone;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final done = _lessonCompletion(
      photoLessonDone: photoLessonDone,
      profileLessonDone: profileLessonDone,
      contentLessonDone: contentLessonDone,
      strategyLessonDone: strategyLessonDone,
      analyticsLessonDone: analyticsLessonDone,
    );
    final doneCount = done.where((v) => v).length;
    final progress = doneCount / 5.0;

    // Exact labels from Click and Social App.dc.html
    final lessons = <_LessonItem>[
      _LessonItem(
        number: '01',
        title: l10n.csLesson01Title,
        subtitle: l10n.csLesson01Subtitle,
        done: done[0],
        onTap: () => context.pushNamed(AppRoute.productSetup),
      ),
      _LessonItem(
        number: '02',
        title: l10n.csLesson02Title,
        subtitle: l10n.csLesson02Subtitle,
        done: done[1],
        onTap: () => context.pushNamed(AppRoute.instagramSetup),
      ),
      _LessonItem(
        number: '03',
        title: l10n.csLesson03Title,
        subtitle: l10n.csLesson03Subtitle,
        done: done[2],
        onTap: () => context.pushNamed(AppRoute.createPost),
      ),
      _LessonItem(
        number: '04',
        title: l10n.csLesson04Title,
        subtitle: l10n.csLesson04Subtitle,
        done: done[3],
        onTap: () => context.pushNamed(AppRoute.postingPlan),
      ),
      _LessonItem(
        number: '05',
        title: l10n.csLesson05Title,
        subtitle: l10n.csLesson05Subtitle,
        done: done[4],
        onTap: () => context.pushNamed(AppRoute.readTheNumbers),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
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
                        letterSpacing: -0.2,
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        TextSpan(text: l10n.csClickAndSocialInline),
                        const TextSpan(
                          text: '.',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 8,
                    height: 8,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.csOfflineReady,
                    style: AppTypography.navLabel.copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.csHelloName(learnerName),
                          style: AppTypography.displayMedium.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                clusterPlace,
                                style: AppTypography.labelSmall.copyWith(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: onEditProfile,
                              child: Container(
                                height: 32,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.textPrimary,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  l10n.csChange,
                                  style: AppTypography.navLabel.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.csLessonsDone(doneCount),
                          style: AppTypography.navLabel.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 8,
                          child: Stack(
                            children: [
                              Container(color: AppColors.surfaceMuted),
                              FractionallySizedBox(
                                widthFactor: progress,
                                child: Container(color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (final lesson in lessons) _LessonTile(item: lesson),
                  const Divider(height: 2, thickness: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<bool> _lessonCompletion({
    required bool photoLessonDone,
    required bool profileLessonDone,
    required bool contentLessonDone,
    required bool strategyLessonDone,
    required bool analyticsLessonDone,
  }) {
    return [
      photoLessonDone,
      profileLessonDone,
      contentLessonDone,
      strategyLessonDone,
      analyticsLessonDone,
    ];
  }
}

class _StepLabel extends StatelessWidget {
  const _StepLabel({required this.number, required this.text});

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$number · ',
            style: AppTypography.navLabel.copyWith(
              fontSize: 11,
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: text,
            style: AppTypography.navLabel.copyWith(
              fontSize: 11,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    required this.selected,
    required this.onTap,
    required this.label,
  });

  final bool selected;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : AppColors.white,
          border: Border.all(color: AppColors.textPrimary, width: 2),
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: selected ? AppColors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ClusterButton extends StatelessWidget {
  const _ClusterButton({
    required this.selected,
    required this.label,
    required this.markLabel,
    required this.onTap,
  });

  final bool selected;
  final String label;
  final String markLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.textPrimary,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              markLabel,
              style: AppTypography.navLabel.copyWith(
                fontSize: 9,
                letterSpacing: 1.0,
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonItem {
  const _LessonItem({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.done,
    required this.onTap,
  });

  final String number;
  final String title;
  final String subtitle;
  final bool done;
  final VoidCallback onTap;
}

class _LessonTile extends StatelessWidget {
  const _LessonTile({required this.item});

  final _LessonItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 76),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.divider, width: 2)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              child: Text(
                item.number,
                style: AppTypography.displayMedium.copyWith(
                  fontSize: 22,
                  color: item.done ? AppColors.primary : AppColors.textMuted,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            item.done
                ? Container(
                    width: 26,
                    height: 26,
                    color: AppColors.primary,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 16,
                    ),
                  )
                : Icon(
                    Icons.chevron_right,
                    color: AppColors.textMuted.withValues(alpha: 0.9),
                    size: 20,
                  ),
          ],
        ),
      ),
    );
  }
}
