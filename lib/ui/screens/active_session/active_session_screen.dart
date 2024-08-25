import 'dart:async';
import 'dart:math';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/models/isar/focus_session.dart';
import 'package:mindful/providers/active_session_provider.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
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

    final remaining = widget.session.duration
        .subtract(DateTime.now().difference(widget.session.startTime));

    if (remaining.inSeconds > 0) _remainingTime = remaining.subtract(2.seconds);

    _timer = Timer.periodic(1.seconds, (timer) {
      /// Decrease remaining duration or cancel timer if remaining duration is 0
      if (_remainingTime.inSeconds > 0) {
        setState(() => _remainingTime = _remainingTime.subtract(1.seconds));
      } else {
        _timer!.cancel();
        _launchConfetti();
        Future.delayed(
          1.seconds,
          ref.read(activeSessionProvider.notifier).refreshActiveSessionState,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const timeStyle = TextStyle(fontSize: 48, fontWeight: FontWeight.w600);
    final quotes = [
      "Every step counts, stay strong and keep going!",
      "Stay focused! you're making amazing progress!",
      "You're crushing it! Keep the momentum going!",
      "Just a little more to go, you're doing fantastic!",
      "Congratulations! 🎉\n You've completed your focus session of ${widget.session.duration.toTimeFull(replaceCommaWithAnd: true)}.\n\nGreat job—keep up the amazing work!"
    ];
    final isSessionActive = _remainingTime.inSeconds > 0;
    final progress = !isSessionActive
        ? 100
        : 100 -
            ((_remainingTime.inSeconds / widget.session.duration.inSeconds) *
                100);

    final quoteIndex = (progress / 20).floor() - 1;

    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.brain_circuit_20_filled,
          title: "Session",
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// Appbar
              SliverFlexibleAppBar(
                title: sessionTypeLabels[widget.session.type] ?? "Focus",
              ),

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
                    label: const Text("Give Up"),
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
        title: "Give Up",
        info:
            "Hold on! You're almost there don't give up now! Are you sure you want to end this focus session early? Progress will be lost.",
        icon: FluentIcons.emoji_sad_20_filled,
        positiveLabel: "Give up",
        negativeLabel: "Keep pushing");

    if (!confirm) return;
    await ref.read(activeSessionProvider.notifier).giveUpOnCurrentSession();

    /// Show alert and go back
    if (!mounted) return;
    context.showSnackAlert(
      "You gave up! Don't worry, you can do better next time. Every effort counts - just keep going",
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
