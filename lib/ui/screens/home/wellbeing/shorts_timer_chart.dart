/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/time_text_short.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

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
    final newTimer = await showShortsTimerPicker(
      context: context,
      heroTag: HeroTags.shortContentTimerPickerTag,
      initialTime: allowedTimeSec,
    );

    if (newTimer == null || newTimer == allowedTimeSec) return;
    ref.read(wellBeingProvider.notifier).setAllowedShortContentTime(newTimer);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double squareDimension = 208;

    final double progressValue =
        allowedTimeSec > 0 ? (remainingTimeSec / allowedTimeSec) : 0;

    final lerpedColor = Color.lerp(
      Theme.of(context).colorScheme.errorContainer,
      Theme.of(context).colorScheme.primaryContainer,
      progressValue,
    );

    return Opacity(
      opacity: isModifiable ? 1 : 0.4,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        child: SizedBox.square(
          dimension: squareDimension,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// Background ring with color based on progress
                SizedBox.square(
                  dimension: squareDimension,
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 18,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: lerpedColor,
                  ),
                ),

                /// Remaining time progress bar
                SizedBox.square(
                  dimension: squareDimension,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: CircularProgressIndicator(
                      value: progressValue,
                      strokeWidth: 12,
                      strokeCap: StrokeCap.round,
                      strokeAlign: BorderSide.strokeAlignCenter,
                    ),
                  ),
                ),

                /// Remaining time
                DefaultHero(
                  tag: HeroTags.shortContentTimerPickerTag,
                  child: RoundedContainer(
                    width: squareDimension * 0.85,
                    height: squareDimension * 0.85,
                    circularRadius: squareDimension,
                    padding: const EdgeInsets.all(12),
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    onPressed: isModifiable
                        ? () => _editAllowedTime(context, ref)
                        : null,
                    child: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FluentIcons.beach_20_regular,
                            size: 42,
                          ),
                          12.vBox,

                          /// Remaining Time text
                          TimeTextShort(
                            timeDuration: remainingTimeSec.seconds,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                          4.vBox,
                          StyledText(
                            context.locale.shorts_time_left_from(
                              allowedTimeSec.seconds.toTimeShort(context),
                            ),
                            fontSize: 14,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          20.vBox,
                          const Icon(FluentIcons.edit_20_regular),
                        ],
                      ),
                    ),
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
