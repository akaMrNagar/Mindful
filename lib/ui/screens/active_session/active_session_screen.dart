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
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/flip_countdown_text.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/screens/active_session/sine_wave.dart';
import 'package:mindful/ui/screens/active_session/timer_progress_clock.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  const ActiveSessionScreen({required this.session, super.key});

  final FocusSession session;

  @override
  ConsumerState<ActiveSessionScreen> createState() =>
      _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  bool _isCompleted = false;
  late bool _isFinite;

  @override
  void initState() {
    super.initState();
    _isFinite = widget.session.durationSecs > 0;
    ref.read(focusModeProvider.notifier).setSessionSuccessCallback(
      () {
        if (!mounted) return;
        setState(() => _isCompleted = true);
        _launchConfetti();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> _getQuotes(BuildContext context) => [
        context.locale.active_session_quote_one,
        context.locale.active_session_quote_two,
        context.locale.active_session_quote_three,
        context.locale.active_session_quote_four,
      ];

  double _getProgress(int elapsedSec) {
    if (_isFinite) {
      return _isCompleted
          ? 100
          : 100 - ((elapsedSec / widget.session.durationSecs) * 100);
    } else {
      return (elapsedSec / 12.hours.inSeconds) * 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final elapsedSeconds =
        ref.watch(focusModeProvider.select((v) => v.elapsedTimeSec));
    final progress = _getProgress(elapsedSeconds);

    final totalDuration = (_isFinite
            ? _isCompleted
                ? widget.session.durationSecs
                : widget.session.durationSecs - elapsedSeconds
            : elapsedSeconds)
        .seconds;

    final quoteIndex = (progress / 25).floor() - 1;
    final quotes = _getQuotes(context);

    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.brain_circuit_20_regular,
          filledIcon: FluentIcons.brain_circuit_20_filled,
          title: context.locale.active_session_tab_title,
          appBarTitle: sessionTypeLabels(context)[widget.session.type] ??
              context.locale.active_session_tab_title,
          fab: _isCompleted
              ? const SizedBox.shrink()
              : FloatingActionButton.extended(
                  heroTag: HeroTags.giveUpOrFinishFocusSessionTag,
                  label: Text(
                    _isFinite
                        ? context.locale.active_session_giveup_dialog_title
                        : context.locale.active_session_finish_dialog_title,
                  ),
                  icon: Icon(
                    _isFinite
                        ? FluentIcons.emoji_sad_20_filled
                        : FluentIcons.emoji_surprise_20_filled,
                  ),
                  onPressed: _giveUpOrFinishActiveSession,
                ),
          sliverBody: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              TimerProgressClock(
                progress: progress.toDouble(),
              ).sliver,
              20.vSliverBox,

              /// Countdown timer
              FlipCountdownText(duration: totalDuration).sliver,
              40.vSliverBox,

              SliverAnimatedPaintExtent(
                duration: AppConstants.defaultAnimDuration,
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
    );
  }

  void _giveUpOrFinishActiveSession() async {
    final confirm = await showConfirmationDialog(
      context: context,
      heroTag: HeroTags.giveUpOrFinishFocusSessionTag,
      title: _isFinite
          ? context.locale.active_session_giveup_dialog_title
          : context.locale.active_session_finish_dialog_title,
      info: _isFinite
          ? context.locale.active_session_giveup_dialog_info
          : context.locale.active_session_finish_dialog_info,
      icon: _isFinite
          ? FluentIcons.emoji_sad_20_filled
          : FluentIcons.emoji_surprise_20_filled,
      positiveLabel: _isFinite
          ? context.locale.active_session_giveup_dialog_title
          : context.locale.active_session_finish_dialog_title,
      negativeLabel: context.locale.active_session_dialog_button_keep_pushing,
    );

    if (!confirm) return;

    await ref.read(focusModeProvider.notifier).giveUpOrFinishFocusSession(
          isTheSessionSuccessful: !_isFinite,
        );

    if (_isFinite) {
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

    int frameTime = 1000 ~/ 24;
    int total = 5 * 1000 ~/ frameTime;
    int progress = 0;

    ConfettiController? controller1;
    ConfettiController? controller2;
    bool isDone = false;

    Timer.periodic(Duration(milliseconds: frameTime), (timer) {
      progress++;

      if (progress >= total) {
        timer.cancel();
        isDone = true;
        return;
      }
      if (controller1 == null) {
        controller1 = Confetti.launch(
          context,
          options: ConfettiOptions(
            particleCount: 2,
            scalar: 1.5,
            angle: 60,
            spread: 55,
            x: 0,
            y: .75,
            colors: colors,
          ),
          onFinished: (overlayEntry) {
            if (isDone) {
              overlayEntry.remove();
            }
          },
        );
      } else {
        controller1!.launch();
      }

      if (controller2 == null) {
        controller2 = Confetti.launch(
          context,
          options: ConfettiOptions(
            particleCount: 2,
            scalar: 1.5,
            angle: 120,
            spread: 55,
            x: 1,
            y: .75,
            colors: colors,
          ),
          onFinished: (overlayEntry) {
            if (isDone) {
              overlayEntry.remove();
            }
          },
        );
      } else {
        controller2!.launch();
      }
    });
  }
}
