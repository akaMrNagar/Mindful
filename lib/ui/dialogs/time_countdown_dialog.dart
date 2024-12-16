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

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/flip_countdown_text.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/ui/transitions/hero_page_route.dart';
import 'package:mindful/ui/common/styled_text.dart';

/// Animates the hero widget to a alert dialog with count down timer
///
/// Invokes [onCountDownFinish] when the timer ran out
Future<void> showCountDownDialog({
  required BuildContext context,
  required Object heroTag,
  required Duration timerDuration,
  required String title,
  required String info,
  required IconData icon,
  required VoidCallback onCountDownFinish,
}) async {
  return await Navigator.of(context).push<void>(
    HeroPageRoute(
      isBarrierDismissible: false,
      builder: (context) => _LaunchLimitDialog(
        heroTag: heroTag,
        timerDuration: timerDuration,
        onCountDownFinish: onCountDownFinish,
        title: title,
        info: info,
        icon: icon,
      ),
    ),
  );
}

class _LaunchLimitDialog extends StatefulWidget {
  const _LaunchLimitDialog({
    required this.heroTag,
    required this.title,
    required this.info,
    required this.icon,
    required this.timerDuration,
    required this.onCountDownFinish,
  });

  final Object heroTag;
  final String title;
  final String info;
  final IconData icon;
  final Duration timerDuration;
  final VoidCallback onCountDownFinish;

  @override
  State<_LaunchLimitDialog> createState() => _LaunchLimitDialogState();
}

class _LaunchLimitDialogState extends State<_LaunchLimitDialog> {
  Duration _timeLeft = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.timerDuration;
    _timer = Timer.periodic(
      1.seconds,
      (timer) async {
        if (mounted) {
          setState(() => _timeLeft = _timeLeft.subtract(1.seconds));
        }

        /// Cancel timer after running out
        if (_timeLeft.inSeconds <= 0) {
          _timer?.cancel();
          if (mounted) Navigator.maybePop(context);
          widget.onCountDownFinish();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _timeLeft.inSeconds <= 0,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(48),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: DefaultHero(
              tag: widget.heroTag,
              child: AlertDialog(
                scrollable: true,
                icon: Icon(widget.icon),
                title: StyledText(widget.title, fontSize: 16),
                insetPadding: EdgeInsets.zero,
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StyledText(widget.info),
                        32.vBox,
                        FlipCountdownText(
                          duration: _timeLeft,
                          alwaysShowMinutes:
                              widget.timerDuration.inSeconds > 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
