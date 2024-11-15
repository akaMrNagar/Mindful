/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/time_picker_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class TimePeriodStartEndCards extends StatelessWidget {
  const TimePeriodStartEndCards({
    super.key,
    this.bgColor,
    this.enabled = true,
    required this.startTime,
    required this.endTime,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
  });

  final bool enabled;
  final Color? bgColor;
  final TimeOfDayAdapter startTime;
  final TimeOfDayAdapter endTime;
  final Function(TimeOfDayAdapter timeTod) onStartTimeChanged;
  final Function(TimeOfDayAdapter timeTod) onEndTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Schedule start time
        Expanded(
          child: _SelectedTime(
            enabled: enabled,
            label: context.locale.schedule_start_label,
            heroTag: HeroTags.scheduleStartTimePickerTag,
            initialTime: startTime,
            color: bgColor,
            onChange: onStartTimeChanged,
          ),
        ),

        12.hBox,

        /// Schedule end time
        Expanded(
          child: _SelectedTime(
            enabled: enabled,
            label: context.locale.schedule_end_label,
            heroTag: HeroTags.scheduleEndTimePickerTag,
            initialTime: endTime,
            color: bgColor,
            onChange: onEndTimeChanged,
          ),
        ),
      ],
    );
  }
}

class _SelectedTime extends StatelessWidget {
  const _SelectedTime({
    required this.label,
    required this.heroTag,
    required this.enabled,
    required this.onChange,
    required this.initialTime,
    this.color,
  });

  final String label;
  final Object heroTag;
  final bool enabled;
  final TimeOfDayAdapter initialTime;
  final Function(TimeOfDayAdapter time) onChange;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DefaultHero(
      tag: heroTag,
      child: RoundedContainer(
        color: color,
        padding: const EdgeInsets.all(16),
        onPressed: enabled
            ? () {
                showCustomTimePickerDialog(
                  context: context,
                  initialTime: initialTime,
                  heroTag: heroTag,
                  info: label,
                ).then(
                  (value) {
                    onChange(value ?? initialTime);
                  },
                );
              }
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Labels "START" and "END"
            StyledText(
              label,
              isSubtitle: !enabled,
            ),
            4.vBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// Time in hour and minutes
                StyledText(
                  initialTime.format(context).split(' ').first,
                  height: 1,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  isSubtitle: !enabled,
                ),
                4.hBox,

                /// Time period AM/PM
                StyledText(
                  initialTime.format(context).split(' ').last,
                  height: 2,
                  isSubtitle: !enabled,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
