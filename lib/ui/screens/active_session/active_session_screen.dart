/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:async';
import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/providers/focus/focus_mode_provider.dart';
import 'package:mindful/ui/common/default_fab_button.dart';
import 'package:mindful/ui/common/flip_countdown_text.dart';
import 'package:mindful/ui/common/scaffold_shell.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/screens/active_session/sine_wave.dart';
import 'package:mindful/ui/screens/active_session/timer_progress_clock.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  const ActiveSessionScreen({super.key});

  @override
  ConsumerState<ActiveSessionScreen> createState() =>
      _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  static const int _secondsInHour = 3600;
  bool _isCompleted = false;
  bool _isPoppingTriggered = false;

  @override
  void initState() {
    super.initState();

    /// Add a callback when the session will is completed successfully
    ref.read(focusModeProvider.notifier).setSessionSuccessCallback(
      () {
        if (!mounted) return;
        setState(() => _isCompleted = true);
        _launchConfetti();
      },
    );
  }

  /// This callback will be after a frame is rendered only when
  /// the active session provider is initialized and loaded successfully
  void _postFrameCallback(bool haveActiveSession) {
    if (haveActiveSession || _isCompleted || _isPoppingTriggered) return;
    _isPoppingTriggered = true;

    /// maybe first frame is rendering so call it after completion
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        context.showSnackAlert(
          context.locale.active_session_none_warning,
        );

        /// Let the snackbar appear then go back
        await Future.delayed(1.seconds);
        if (!mounted) return;

        /// Either go back if navigator can pop or go to home screen
        context.popOrPushReplace(AppRoutes.homePath);
      },
    );
  }

  List<String> _getQuotes(BuildContext context) => [
        context.locale.active_session_quote_one,
        context.locale.active_session_quote_two,
        context.locale.active_session_quote_three,
        context.locale.active_session_quote_four,
      ];

  double _getProgress(
    FocusSession? activeSession,
    bool isFinite,
    int elapsedSec,
  ) {
    /// Check if active session is null {may be loading}
    if (activeSession == null) return 0;

    if (isFinite) {
      return _isCompleted
          ? 100
          : 100 - ((elapsedSec / (activeSession.durationSecs)) * 100);
    } else {
      return ((elapsedSec % _secondsInHour) / _secondsInHour) * 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Active session and Elapsed time in seconds
    final activeSession =
        ref.watch(focusModeProvider.select((v) => v.activeSession));

    final elapsedSeconds =
        ref.watch(focusModeProvider.select((v) => v.elapsedTimeSec));

    final sessionDurationSec = activeSession.value?.durationSecs ?? 0;

    /// Is the session finite means it does have any finite duration
    final isFinite = sessionDurationSec > 0;
    final progress =
        _getProgress(activeSession.value, isFinite, elapsedSeconds);

    final totalDuration = (isFinite
            ? _isCompleted
                ? sessionDurationSec
                : sessionDurationSec - elapsedSeconds
            : elapsedSeconds)
        .seconds;

    final quoteIndex = (progress / 25).floor() - 1;
    final quotes = _getQuotes(context);

    /// Add post frame callback after loading
    if (activeSession.hasValue) {
      _postFrameCallback(activeSession.value != null);
    }

    final enforceSession = ref
        .watch(focusModeProvider.select((v) => v.focusProfile.enforceSession));

    return Skeletonizer.zone(
      enabled: !activeSession.hasValue,
      ignorePointers: false,
      enableSwitchAnimation: true,
      child: ScaffoldShell(
        items: [
          NavbarItem(
            icon: FluentIcons.brain_circuit_20_regular,
            filledIcon: FluentIcons.brain_circuit_20_filled,
            actions: [
              /// Goal or reflection
              _isCompleted || !activeSession.hasValue
                  ? 0.vBox
                  : DefaultHero(
                      tag: HeroTags.sessionReflectionTag,
                      child: IconButton.filledTonal(
                        icon: const Icon(FluentIcons.clipboard_task_20_filled),
                        onPressed: _askAboutFocusReflection,
                      ),
                    ),
            ],
            titleBuilder: (percentage) =>
                _buildTitle(activeSession.value, percentage),
            fab: _isCompleted ||
                    !activeSession.hasValue ||
                    (enforceSession && isFinite)
                ? const SizedBox.shrink()
                : DefaultFabButton(
                    heroTag: HeroTags.giveUpOrFinishFocusSessionTag,
                    label: isFinite
                        ? context.locale.active_session_giveup_dialog_title
                        : context.locale.active_session_finish_dialog_title,
                    icon: isFinite
                        ? FluentIcons.emoji_sad_20_filled
                        : FluentIcons.emoji_surprise_20_filled,
                    onPressed: () => _giveUpOrFinishActiveSession(isFinite),
                  ),
            sliverBody: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                24.vSliverBox,

                /// Clock painter
                TimerProgressClock(
                  progress: progress.toDouble(),
                ).sliver,
                20.vSliverBox,

                /// Countdown timer
                FlipCountdownText(duration: totalDuration).sliver,
                40.vSliverBox,

                /// Motivation quote
                SliverAnimatedPaintExtent(
                  duration: AppConstants.defaultAnimDuration,
                  child: Skeleton.leaf(
                    child: StyledText(
                      _isCompleted
                          ? context.locale.active_session_quote_five(
                              totalDuration.toTimeFull(
                                context,
                                replaceCommaWithAnd: true,
                              ),
                            )
                          : quotes[max(quoteIndex, 0)],
                      fontSize: 14,
                      textAlign: TextAlign.center,
                    ),
                  ).centered.sliver,
                ),

                64.vSliverBox,

                /// Waves
                SineWave(
                  sinColor: Theme.of(context).colorScheme.primaryContainer,
                  cosColor: Theme.of(context).colorScheme.primary,
                ).sliver,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(FocusSession? session, double percentage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: percentage,
          child: Icon(
            sessionTypeIcons[session?.type] ??
                FluentIcons.target_arrow_20_regular,
            size: 24 * percentage,
          ),
        ),
        2.vBox,
        AppBarTitle(
          titleText: sessionTypeLabels(context)[session?.type] ??
              context.locale.active_session_tab_title,
        )
      ],
    );
  }

  void _giveUpOrFinishActiveSession(bool isFinite) async {
    final confirm = await showConfirmationDialog(
      context: context,
      heroTag: HeroTags.giveUpOrFinishFocusSessionTag,
      title: isFinite
          ? context.locale.active_session_giveup_dialog_title
          : context.locale.active_session_finish_dialog_title,
      info: isFinite
          ? context.locale.active_session_giveup_dialog_info
          : context.locale.active_session_finish_dialog_info,
      icon: isFinite
          ? FluentIcons.emoji_sad_20_filled
          : FluentIcons.emoji_surprise_20_filled,
      positiveLabel: isFinite
          ? context.locale.active_session_giveup_dialog_title
          : context.locale.active_session_finish_dialog_title,
      negativeLabel: context.locale.active_session_dialog_button_keep_pushing,
    );

    if (!confirm) return;

    _isPoppingTriggered = true;
    await ref.read(focusModeProvider.notifier).giveUpOrFinishFocusSession(
          isTheSessionSuccessful: !isFinite,
          isFiniteSession: isFinite,
        );

    if (isFinite) {
      await Future.delayed(1.seconds);

      /// Show alert and go back
      if (!mounted) return;
      context.showSnackAlert(context.locale.active_session_giveup_snack_alert);
      Navigator.of(context).maybePop();
    } else {
      _launchConfetti();
    }
  }

  void _launchConfetti() {
    if (!mounted) return;

    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.onSecondaryContainer,
    ];

    Confetti.launch(
      context,
      options: ConfettiOptions(
        particleCount: 100,
        scalar: 1.5,
        angle: 60,
        spread: 55,
        startVelocity: 60,
        gravity: 0.5,
        x: 0,
        y: 1,
        colors: colors,
      ),
      onFinished: (overlay) => overlay.remove(),
    );

    Confetti.launch(
      context,
      options: ConfettiOptions(
        particleCount: 100,
        scalar: 1.5,
        angle: 120,
        spread: 55,
        startVelocity: 60,
        gravity: 0.5,
        x: 1,
        y: 1,
        colors: colors,
      ),
      onFinished: (overlay) => overlay.remove(),
    );
  }

  void _askAboutFocusReflection() async {
    final reflection = await showFocusReflectionDialog(
      context: context,
      heroTag: HeroTags.sessionReflectionTag,
      initialText: ref.read(focusModeProvider
              .select((v) => v.activeSession.value?.reflection)) ??
          "",
    );

    if (reflection == null) return;
    ref.read(focusModeProvider.notifier).updateFocusReflection(reflection);
  }
}
