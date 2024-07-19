import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/time_text_short.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/duration_picker.dart';

class ShortsTimerChart extends ConsumerWidget {
  const ShortsTimerChart({
    super.key,
    required this.isModifiable,
    required this.allowedTimeSec,
    required this.remainingTimeSec,
  });

  final bool isModifiable;
  final int allowedTimeSec;
  final int remainingTimeSec;

  void _editAllowedTime(BuildContext context, WidgetRef ref) async {
    final newTime = await showDurationPicker(
      context: context,
      initialTime: allowedTimeSec,
      appName: "Short content",
    );

    if (newTime != allowedTimeSec) {
      ref.read(wellBeingProvider.notifier).setAllowedShortContentTime(newTime);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double squareDimension = 208;

    final progressValue = max(
      0.001,
      (remainingTimeSec / allowedTimeSec),
    );

    final lerpedColor = Color.lerp(
      Theme.of(context).colorScheme.errorContainer,
      Theme.of(context).colorScheme.primaryContainer,
      progressValue,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: SizedBox.square(
        dimension: squareDimension,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
          children: [
            /// Background ring with color based on progress
            RotatedBox(
              quarterTurns: 2,
              child: FittedBox(
                child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 4,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: lerpedColor),
              ),
            ),

            /// Remaining time progress bar
            RotatedBox(
              quarterTurns: 2,
              child: FittedBox(
                child: CircularProgressIndicator(
                  value: progressValue,
                  strokeWidth: 2.5,
                  strokeCap: StrokeCap.round,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),

            /// Remaining time
            FittedBox(
              child: RoundedContainer(
                width: squareDimension,
                height: squareDimension,
                circularRadius: squareDimension,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(12),
                color: lerpedColor,
                onPressed:
                    isModifiable ? () => _editAllowedTime(context, ref) : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FluentIcons.beach_20_regular,
                      size: 56,
                    ),
                    12.vBox(),

                    /// Remaining Time text
                    TimeTextShort(
                      timeDuration: remainingTimeSec.seconds,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    2.vBox(),
                    StyledText(
                      "Left from ${allowedTimeSec.seconds.toTimeShort()}",
                      fontSize: 14,
                      isSubtitle: true,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    32.vBox(),
                    Icon(
                      FluentIcons.edit_20_regular,
                      color: isModifiable ? null : Theme.of(context).focusColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
