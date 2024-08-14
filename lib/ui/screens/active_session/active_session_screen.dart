import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/models/isar/focus_session.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/screens/active_session/sine_wave.dart';
import 'package:mindful/ui/screens/active_session/timer_progress_clock.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class ActiveSessionScreen extends StatefulWidget {
  const ActiveSessionScreen({
    super.key,
    this.currentSession,
  });

  final FocusSession? currentSession;

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  FocusSession? _runningSession;
  Timer? _timer;
  Duration _remainingDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _iniSession();
  }

  void _iniSession() async {
    _runningSession = widget.currentSession ??
        await IsarDbService.instance.loadLastActiveFocusSession();

    if (_runningSession != null) {
      _startTimer(_runningSession!);
      return;
    }

    if (mounted) Navigator.of(context).maybePop();
  }

  void _startTimer(FocusSession session) {
    final elapsedSeconds =
        (session.startTimeMsEpoch - DateTime.now().millisecondsSinceEpoch) ~/
            1000;

    final remainingSeconds =
        session.duration.inSeconds - elapsedSeconds - session.breakDurationSecs;

    _remainingDuration = remainingSeconds.seconds;
    _timer = Timer.periodic(1.seconds, (timer) {
      int remainingSeconds = _remainingDuration.inSeconds;
      remainingSeconds > 0 ? remainingSeconds-- : _timer!.cancel();
      setState(() {
        _remainingDuration = remainingSeconds.seconds;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const timeStyle = TextStyle(fontSize: 48, fontWeight: FontWeight.w600);
    return Scaffold(
      body: DefaultNavbar(
        navbarItems: [
          NavbarItem(
            icon: FluentIcons.brain_circuit_20_filled,
            title: "Session",
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                /// Appbar
                const SliverFlexibleAppBar(title: "Study"),

                const TimerProgressClock(progress: 50).sliver,
                32.vSliverBox,

                /// Countdown timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Hours
                    if (_remainingDuration.inHours > 0)
                      AnimatedFlipCounter(
                        suffix: ":",
                        value: _remainingDuration.inHours,
                        textStyle: timeStyle,
                      ),

                    /// Minutes
                    AnimatedFlipCounter(
                      suffix: ":",
                      value: _remainingDuration.inMinutes % 60,
                      textStyle: timeStyle,
                    ),

                    /// Seconds
                    AnimatedFlipCounter(
                      value: _remainingDuration.inSeconds % 60,
                      textStyle: timeStyle,
                    ),
                  ],
                ).sliver,
                2.vSliverBox,

                const StyledText(
                  "You are doing great! keep it up",
                  fontSize: 14,
                ).centered.sliver,

                96.vSliverBox,

                /// Waves
                SineWave(
                  sinColor: Theme.of(context).colorScheme.primaryContainer,
                  cosColor: Theme.of(context).colorScheme.primary,
                ).sliver,

                96.vSliverBox,

                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton.tonalIcon(
                          label: const Text("Take break"),
                          icon: const Icon(FluentIcons.bowl_salad_20_filled),
                          onPressed: () {},
                        ),
                        12.hBox,
                        DefaultHero(
                          tag: HeroTags.giveUpFocusSessionTag,
                          child: FilledButton.tonalIcon(
                            label: const Text("Give Up"),
                            icon:
                                const Icon(FluentIcons.thumb_dislike_20_filled),
                            onPressed: () => _giveUp(context, ref),
                          ),
                        ),
                      ],
                    );
                  },
                ).sliver,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _giveUp(BuildContext context, WidgetRef ref) async {
    final confirm = await showConfirmationDialog(
        context: context,
        heroTag: HeroTags.giveUpFocusSessionTag,
        title: "Give Up",
        info:
            "Hold on! You're almost there don't give up now! Are you sure you want to end this focus session early? Progress will be lost.",
        icon: FluentIcons.warning_20_filled,
        positiveLabel: "Give up",
        negativeLabel: "Keep pushing");

    if (!confirm) return;
    await ref.read(focusModeProvider.notifier).giveUpOnLastSession();

    if (!context.mounted) return;

    /// Show alert and go back
    context.showSnackAlert(
      "Don't worry, you can do better next time! Every effort counts-just keep going!",
    );
    Navigator.of(context).maybePop();
  }
}
