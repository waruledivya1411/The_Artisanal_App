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
import '../../../shared/motion/motion.dart';
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

  static const _prefsOnboardStep = 'click_social_onboard_step';

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
  int _onboardingStep = 0;

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
      _onboardingStep = (prefs.getInt(_prefsOnboardStep) ?? 0).clamp(0, 2);
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
    await prefs.remove(_prefsOnboardStep);
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
    await prefs.setInt(_prefsOnboardStep, _onboardingStep);
    if (_selectedClusterId != null) {
      await prefs.setString(_prefsClusterId, _selectedClusterId!);
    }
    await ref.read(localeProvider.notifier).select(language);
  }

  Future<void> _openOnboardingForEdit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsOnboarded, false);
    await prefs.setInt(_prefsOnboardStep, 0);
    if (!mounted) return;
    setState(() {
      _onboarded = false;
      _onboardingStep = 0;
    });
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
        step: _onboardingStep,
        onStepChanged: (step) async {
          setState(() => _onboardingStep = step);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt(_prefsOnboardStep, step);
          await prefs.setString(_prefsName, _nameController.text.trim());
          if (_selectedClusterId != null) {
            await prefs.setString(_prefsClusterId, _selectedClusterId!);
          }
        },
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
    required this.step,
    required this.onStepChanged,
    required this.nameController,
    required this.selectedLanguage,
    required this.onLanguagePick,
    required this.selectedClusterId,
    required this.onClusterPick,
    required this.onStartLearning,
  });

  final int step;
  final ValueChanged<int> onStepChanged;
  final TextEditingController nameController;
  final AppLanguage selectedLanguage;
  final Future<void> Function(AppLanguage) onLanguagePick;
  final String? selectedClusterId;
  final ValueChanged<String> onClusterPick;
  final VoidCallback onStartLearning;

  bool get _canAdvance => switch (step) {
        0 => nameController.text.trim().isNotEmpty,
        1 => true,
        _ => selectedClusterId != null,
      };

  void _next(AppLocalizations l10n) {
    if (!_canAdvance) return;
    if (step < 2) {
      onStepChanged(step + 1);
      return;
    }
    onStartLearning();
  }

  void _back() {
    if (step > 0) onStepChanged(step - 1);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final titles = [
      l10n.csStepYourName,
      l10n.csStepYourLanguage,
      l10n.csStepYourCluster,
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7FAFD),
              Color(0xFFEEF5FB),
              Color(0xFFE8F1F9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        l10n.csAntaranLearningTool.toUpperCase(),
                        style: AppTypography.overline.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primaryLight),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.wifi_off_rounded,
                            size: 12,
                            color: AppColors.primary.withValues(alpha: 0.85),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            l10n.csWorksOffline,
                            style: AppTypography.navLabel.copyWith(
                              fontSize: 9,
                              letterSpacing: 0.8,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 2, 20, 8),
                child: Row(
                  children: [
                    for (var i = 0; i < 3; i++) ...[
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
                      if (i < 2) const SizedBox(width: 6),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: AppMotion.card,
                  switchInCurve: AppMotion.curve,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    final slide = Tween<Offset>(
                      begin: const Offset(0.08, 0.04),
                      end: Offset.zero,
                    ).animate(animation);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(position: slide, child: child),
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey(step),
                    child: _buildStep(context, l10n, titles[step]),
                  ),
                ),
              ),
              ListenableBuilder(
                listenable: nameController,
                builder: (context, _) => _FloatingBar(
                  showBack: step > 0,
                  canAdvance: _canAdvance,
                  label: step < 2 ? 'NEXT' : l10n.csStartLearning,
                  onBack: _back,
                  onNext: () => _next(l10n),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(
    BuildContext context,
    AppLocalizations l10n,
    String title,
  ) {
    return switch (step) {
      0 => _NameStep(
          title: title,
          nameController: nameController,
          brand: l10n.csClickAndSocial,
          tagline: l10n.csOnboardingTagline,
          hint: l10n.csNameHint,
        ),
      1 => _LanguageStep(
          title: title,
          selectedLanguage: selectedLanguage,
          onLanguagePick: onLanguagePick,
          selectedLabel: l10n.csSelected,
          pickLabel: l10n.csPick,
        ),
      _ => _ClusterStep(
          title: title,
          hint: l10n.csClusterHint,
          selectedClusterId: selectedClusterId,
          onClusterPick: onClusterPick,
          selectedLabel: l10n.csSelected,
          pickLabel: l10n.csPick,
        ),
    };
  }
}

class _FloatingBar extends StatelessWidget {
  const _FloatingBar({
    required this.showBack,
    required this.canAdvance,
    required this.label,
    required this.onBack,
    required this.onNext,
  });

  final bool showBack;
  final bool canAdvance;
  final String label;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final nextButton = Pressable(
      enabled: canAdvance,
      elevate: true,
      borderRadius: BorderRadius.circular(28),
      child: AnimatedOpacity(
        duration: AppMotion.select,
        opacity: canAdvance ? 1 : 0.45,
        child: Material(
          color: AppColors.primary,
          elevation: 4,
          shadowColor: AppColors.primary.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: canAdvance ? onNext : null,
            child: SizedBox(
              height: 48,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: showBack ? 0 : 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: showBack ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    Text(
                      label,
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
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      child: Row(
        children: [
          if (showBack) ...[
            Pressable(
              elevate: true,
              borderRadius: BorderRadius.circular(24),
              child: Material(
                color: AppColors.white,
                elevation: 2,
                shadowColor: AppColors.primary.withValues(alpha: 0.15),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
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
            Expanded(child: nextButton),
          ] else ...[
            const Spacer(),
            nextButton,
          ],
        ],
      ),
    );
  }
}

class _NameStep extends StatelessWidget {
  const _NameStep({
    required this.title,
    required this.nameController,
    required this.brand,
    required this.tagline,
    required this.hint,
  });

  final String title;
  final TextEditingController nameController;
  final String brand;
  final String tagline;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      children: [
        FadeSlideIn(
          child: Text.rich(
            TextSpan(
              style: AppTypography.displayLarge.copyWith(
                fontSize: 36,
                height: 1.05,
                letterSpacing: -0.5,
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
              children: [
                TextSpan(text: brand),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        FadeSlideIn(
          delay: const Duration(milliseconds: 50),
          child: Text(
            tagline,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 28),
        FadeSlideIn(
          delay: const Duration(milliseconds: 90),
          child: Text(
            title,
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 10),
        FadeSlideIn(
          delay: const Duration(milliseconds: 120),
          child: TextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTypography.bodyMedium.copyWith(
                color: AppColors.textMuted,
              ),
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LanguageStep extends StatefulWidget {
  const _LanguageStep({
    required this.title,
    required this.selectedLanguage,
    required this.onLanguagePick,
    required this.selectedLabel,
    required this.pickLabel,
  });

  final String title;
  final AppLanguage selectedLanguage;
  final Future<void> Function(AppLanguage) onLanguagePick;
  final String selectedLabel;
  final String pickLabel;

  @override
  State<_LanguageStep> createState() => _LanguageStepState();
}

class _LanguageStepState extends State<_LanguageStep> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = AppLanguage.values.where((lang) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return lang.label.toLowerCase().contains(q) ||
          lang.englishName.toLowerCase().contains(q) ||
          lang.region.toLowerCase().contains(q);
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      children: [
        FadeSlideIn(
          child: Text(
            widget.title,
            style: AppTypography.displayMedium.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 6),
        FadeSlideIn(
          delay: const Duration(milliseconds: 40),
          child: Text(
            'Chosen once. Your lessons, instructions, and community stories will be tuned to it.',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textMuted,
              height: 1.4,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 14),
        FadeSlideIn(
          delay: const Duration(milliseconds: 70),
          child: _SearchField(
            hint: 'Search language or dialect...',
            onChanged: (value) => setState(() => _query = value.trim()),
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < filtered.length; i++)
          FadeSlideIn.staggered(
            index: i,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _SelectCard(
                selected: filtered[i] == widget.selectedLanguage,
                glyph: filtered[i].glyph,
                title: filtered[i].label,
                region: filtered[i].region,
                subtitle: filtered[i].englishName == filtered[i].label
                    ? filtered[i].region
                    : '${filtered[i].englishName} · ${filtered[i].region}',
                selectedLabel: widget.selectedLabel,
                pickLabel: widget.pickLabel,
                onTap: () => widget.onLanguagePick(filtered[i]),
              ),
            ),
          ),
      ],
    );
  }
}

class _ClusterStep extends StatefulWidget {
  const _ClusterStep({
    required this.title,
    required this.hint,
    required this.selectedClusterId,
    required this.onClusterPick,
    required this.selectedLabel,
    required this.pickLabel,
  });

  final String title;
  final String hint;
  final String? selectedClusterId;
  final ValueChanged<String> onClusterPick;
  final String selectedLabel;
  final String pickLabel;

  @override
  State<_ClusterStep> createState() => _ClusterStepState();
}

class _ClusterStepState extends State<_ClusterStep> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filtered = clickSocialClusters.where((cluster) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      final place = AppCopy.clusterPlace(l10n, cluster.id);
      final fabric = AppCopy.clusterFabric(l10n, cluster.id);
      return cluster.place.toLowerCase().contains(q) ||
          cluster.fabric.toLowerCase().contains(q) ||
          place.toLowerCase().contains(q) ||
          fabric.toLowerCase().contains(q);
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      children: [
        FadeSlideIn(
          child: Text(
            widget.title,
            style: AppTypography.displayMedium.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 6),
        FadeSlideIn(
          delay: const Duration(milliseconds: 40),
          child: Text(
            widget.hint,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textMuted,
              height: 1.4,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 14),
        FadeSlideIn(
          delay: const Duration(milliseconds: 70),
          child: _SearchField(
            hint: 'Filter clusters or states...',
            onChanged: (value) => setState(() => _query = value.trim()),
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < filtered.length; i++)
          FadeSlideIn.staggered(
            index: i,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Builder(
                builder: (context) {
                  final cluster = filtered[i];
                  final place = AppCopy.clusterPlace(l10n, cluster.id);
                  final fullPlace = place.isEmpty ? cluster.place : place;
                  final parts = _splitPlace(fullPlace);
                  return _SelectCard(
                    selected: widget.selectedClusterId == cluster.id,
                    icon: Icons.place_rounded,
                    title: parts.$1,
                    region: parts.$2,
                    selectedLabel: widget.selectedLabel,
                    pickLabel: widget.pickLabel,
                    onTap: () => widget.onClusterPick(cluster.id),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

(String, String) _splitPlace(String place) {
  final i = place.lastIndexOf(',');
  if (i <= 0) return (place, '');
  return (place.substring(0, i).trim(), place.substring(i + 1).trim());
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.hint, required this.onChanged});

  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: AppTypography.bodyMedium.copyWith(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.labelSmall.copyWith(
          color: AppColors.textMuted,
          fontSize: 13,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.textMuted,
          size: 20,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _SelectCard extends StatelessWidget {
  const _SelectCard({
    required this.selected,
    required this.title,
    required this.region,
    required this.selectedLabel,
    required this.pickLabel,
    required this.onTap,
    this.subtitle,
    this.glyph,
    this.icon,
  });

  final bool selected;
  final String title;
  final String region;
  final String? subtitle;
  final String selectedLabel;
  final String pickLabel;
  final VoidCallback onTap;
  final String? glyph;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      elevate: true,
      borderRadius: BorderRadius.circular(18),
      child: Material(
        color: AppColors.white,
        elevation: selected ? 3 : 1,
        shadowColor: AppColors.primary.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppMotion.select,
            padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.borderLight,
                width: selected ? 2 : 1.2,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: AppMotion.select,
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary
                        : AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: icon != null
                      ? Icon(
                          icon,
                          size: 20,
                          color: selected
                              ? AppColors.white
                              : AppColors.primary,
                        )
                      : Text(
                          glyph ?? 'Aa',
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: glyph == 'Aa' ? 14 : 16,
                            fontWeight: FontWeight.w800,
                            color: selected
                                ? AppColors.white
                                : AppColors.primary,
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
                          Flexible(
                            child: Text(
                              title,
                              style: AppTypography.labelLarge.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          if (region.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? AppColors.surfaceSelected
                                    : AppColors.backgroundAlt,
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Text(
                                region,
                                style: AppTypography.navLabel.copyWith(
                                  fontSize: 9,
                                  letterSpacing: 0.2,
                                  color: AppColors.primaryLight,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.labelSmall.copyWith(
                            fontSize: 11,
                            color: AppColors.textMuted,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedContainer(
                  duration: AppMotion.select,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (selected) ...[
                        const Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        selected ? selectedLabel : pickLabel,
                        style: AppTypography.navLabel.copyWith(
                          fontSize: 9,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.w800,
                          color: selected
                              ? AppColors.white
                              : AppColors.primary,
                        ),
                      ),
                    ],
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
    final percent = (progress * 100).round();

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
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7FAFD),
              Color(0xFFEEF5FB),
              Color(0xFFE8F1F9),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: [
              FadeSlideIn(
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        l10n.csClickAndSocialInline.toUpperCase(),
                        style: AppTypography.overline.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSelected,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            l10n.csOfflineReady,
                            style: AppTypography.navLabel.copyWith(
                              fontSize: 9,
                              letterSpacing: 0.7,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              FadeSlideIn(
                delay: const Duration(milliseconds: 40),
                child: Text(
                  l10n.csHelloName(learnerName),
                  style: AppTypography.displayMedium.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              FadeSlideIn(
                delay: const Duration(milliseconds: 70),
                child: Material(
                  color: AppColors.white,
                  elevation: 1,
                  shadowColor: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: onEditProfile,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceMuted,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.place_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              clusterPlace,
                              style: AppTypography.labelLarge.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Text(
                            l10n.csChange,
                            style: AppTypography.navLabel.copyWith(
                              fontSize: 10,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              FadeSlideIn(
                delay: const Duration(milliseconds: 90),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.csLessonsDone(doneCount),
                            style: AppTypography.navLabel.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.7,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ),
                        Text(
                          '$percent%',
                          style: AppTypography.labelLarge.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: SizedBox(
                        height: 7,
                        child: Stack(
                          children: [
                            Container(color: AppColors.surfaceMuted),
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: progress),
                              duration: AppMotion.progress,
                              curve: AppMotion.curveInOut,
                              builder: (context, value, _) =>
                                  FractionallySizedBox(
                                widthFactor: value,
                                child: Container(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              for (var i = 0; i < lessons.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _LessonTile(item: lessons[i], index: i),
                ),
            ],
          ),
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
  const _LessonTile({required this.item, this.index = 0});

  final _LessonItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return FadeSlideIn.staggered(
      index: index,
      child: Pressable(
        elevate: true,
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: AppColors.white,
          elevation: 1,
          shadowColor: AppColors.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: item.onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: AppMotion.select,
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: item.done
                          ? AppColors.primary
                          : AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.number,
                      style: AppTypography.labelLarge.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: item.done
                            ? AppColors.white
                            : AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      item.title,
                      style: AppTypography.bodyMedium.copyWith(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: AppMotion.select,
                    switchInCurve: AppMotion.curve,
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                    child: item.done
                        ? Container(
                            key: const ValueKey('done'),
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.check_rounded,
                              color: AppColors.white,
                              size: 16,
                            ),
                          )
                        : Icon(
                            Icons.chevron_right_rounded,
                            key: const ValueKey('next'),
                            color: AppColors.primary.withValues(alpha: 0.7),
                            size: 24,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
