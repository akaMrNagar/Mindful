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

import 'package:animated_flip_counter/animated_flip_counter.dart';
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
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/screens/active_session/sine_wave.dart';
import 'package:mindful/ui/screens/active_session/timer_progress_clock.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  const ActiveSessionScreen({required this.session, super.key});

  final FocusSession session;

  @override
  ConsumerState<ActiveSessionScreen> createState() =>
      _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen>
    with WidgetsBindingObserver {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startSessionTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) async {
    if (appState == AppLifecycleState.resumed) {
      _startSessionTimer();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  void _startSessionTimer() {
    // Cancel if timer is already running
    _timer?.cancel();
    _remainingTime = Duration.zero;

    final remaining = widget.session.durationSecs.seconds
        .subtract(DateTime.now().difference(widget.session.startDateTime));

    if (remaining.inSeconds > 0) _remainingTime = remaining.subtract(2.seconds);

    _timer = Timer.periodic(1.seconds, (timer) {
      /// Decrease remaining duration or cancel timer if remaining duration is 0
      if (_remainingTime.inSeconds > 0) {
        setState(() => _remainingTime = _remainingTime.subtract(1.seconds));
      } else {
        _timer!.cancel();
        _launchConfetti();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const timeStyle = TextStyle(fontSize: 48, fontWeight: FontWeight.w600);
    final quotes = [
      context.locale.active_session_quote_one,
      context.locale.active_session_quote_two,
      context.locale.active_session_quote_three,
      context.locale.active_session_quote_four,
      context.locale.active_session_quote_five(
        widget.session.durationSecs.seconds.toTimeFull(context, replaceCommaWithAnd: true),
      ),
    ];
    final isSessionActive = _remainingTime.inSeconds > 0;
    final progress = !isSessionActive
        ? 100
        : 100 -
            ((_remainingTime.inSeconds / widget.session.durationSecs) *
                100);

    final quoteIndex = (progress / 20).floor() - 1;

    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.brain_circuit_20_regular,
          filledIcon: FluentIcons.brain_circuit_20_filled,
          title: context.locale.active_session_tab_title,
          appBarTitle: sessionTypeLabels(context)[widget.session.type] ??
              context.locale.active_session_tab_title,
          sliverBody: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              TimerProgressClock(
                progress: progress.toDouble(),
              ).sliver,
              20.vSliverBox,

              /// Countdown timer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Hours
                  if (_remainingTime.inHours > 0)
                    AnimatedFlipCounter(
                      suffix: ":",
                      value: _remainingTime.inHours,
                      textStyle: timeStyle,
                    ),

                  /// Minutes
                  AnimatedFlipCounter(
                    suffix: ":",
                    value: _remainingTime.inMinutes % 60,
                    textStyle: timeStyle,
                  ),

                  /// Seconds
                  AnimatedFlipCounter(
                    value: _remainingTime.inSeconds % 60,
                    textStyle: timeStyle,
                  ),
                ],
              ).sliver,
              64.vSliverBox,

              SliverAnimatedPaintExtent(
                duration: 300.ms,
                child: StyledText(
                  quotes[max(quoteIndex, 0)],
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  color: isSessionActive ? Theme.of(context).hintColor : null,
                ).centered.sliver,
              ),

              64.vSliverBox,

              /// Waves
              SineWave(
                sinColor: Theme.of(context).colorScheme.primaryContainer,
                cosColor: Theme.of(context).colorScheme.primary,
              ).sliver,

              64.vSliverBox,

              if (_remainingTime.inSeconds > 20)
                DefaultHero(
                  tag: HeroTags.giveUpFocusSessionTag,
                  child: FilledButton.tonalIcon(
                    label:
                        Text(context.locale.active_session_giveup_dialog_title),
                    icon: const Icon(FluentIcons.thumb_dislike_20_filled),
                    onPressed: _giveUp,
                  ),
                ).centered.sliver,
            ],
          ),
        ),
      ],
    );
  }

  void _giveUp() async {
    final confirm = await showConfirmationDialog(
      context: context,
      heroTag: HeroTags.giveUpFocusSessionTag,
      title: context.locale.active_session_giveup_dialog_title,
      info: context.locale.active_session_giveup_dialog_info,
      icon: FluentIcons.emoji_sad_20_filled,
      positiveLabel: context.locale.active_session_giveup_dialog_title,
      negativeLabel:
          context.locale.active_session_giveup_dialog_button_keep_pushing,
    );

    if (!confirm) return;
    await ref.read(focusModeProvider.notifier).giveUpOnActiveSession();

    /// Show alert and go back
    if (!mounted) return;
    context.showSnackAlert(
      context.locale.active_session_giveup_snack_alert,
    );
    Navigator.of(context).maybePop();
  }

  void _launchConfetti() {
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
