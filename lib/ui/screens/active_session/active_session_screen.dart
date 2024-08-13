import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/active_session/sine_wave.dart';
import 'package:mindful/ui/screens/active_session/timer_progress_clock.dart';

class ActiveSessionScreen extends StatefulWidget {
  const ActiveSessionScreen({super.key});

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  Timer? _timer;
  Duration _remainingDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    startTimer(5);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer(int durMinutes) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _remainingDuration = durMinutes.minutes;
    _timer = Timer.periodic(1.seconds, (timer) {
      int remainingSeconds = _remainingDuration.inSeconds;
      setState(() {
        remainingSeconds > 0 ? remainingSeconds-- : _timer!.cancel();
        _remainingDuration = remainingSeconds.seconds;
      });
    });
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.tonalIcon(
                      label: const Text("Take break"),
                      icon: const Icon(FluentIcons.bowl_salad_20_filled),
                      onPressed: () {},
                    ),
                    12.hBox,
                    FilledButton.tonalIcon(
                      label: const Text("Give Up"),
                      icon: const Icon(FluentIcons.thumb_dislike_20_filled),
                      onPressed: () {},
                    ),
                  ],
                ).sliver,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
