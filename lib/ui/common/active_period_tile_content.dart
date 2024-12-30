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
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/time_period_start_end_cards.dart';

class ActivePeriodTileContent extends StatelessWidget {
  const ActivePeriodTileContent({
    super.key,
    this.isModifiable,
    required this.totalDuration,
    required this.startTime,
    required this.endTime,
    required this.onTimeChanged,
  });

  final Duration totalDuration;
  final TimeOfDayAdapter startTime;
  final TimeOfDayAdapter endTime;
  final bool Function()? isModifiable;

  final Function(TimeOfDayAdapter start, TimeOfDayAdapter end) onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.all(12),
      borderRadius: getBorderRadiusFromPosition(ItemPosition.mid),
      child: Column(
        children: [
          /// Info
          StyledText(
            context.locale.active_period_info,
            color: Theme.of(context).hintColor,
          ),

          24.vBox,

          /// Total duration
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Divider(color: Theme.of(context).focusColor)),
              12.hBox,
              StyledText(
                totalDuration.toTimeFull(context),
              ),
              12.hBox,
              Expanded(child: Divider(color: Theme.of(context).focusColor)),
            ],
          ),

          24.vBox,

          /// Period time
          TimePeriodStartEndCards(
            isModifiable: isModifiable,
            bgColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            startTime: startTime,
            endTime: endTime,
            onStartTimeChanged: (start) => onTimeChanged(start, endTime),
            onEndTimeChanged: (end) => onTimeChanged(startTime, end),
          ),

          12.vBox,

          /// Reset button
          FittedBox(
            child: TextButton.icon(
              icon: const Icon(FluentIcons.arrow_reset_20_filled),
              label: Text(context.locale.dialog_button_reset),
              onPressed: () {
                if (!(isModifiable?.call() ?? true)) return;

                onTimeChanged(
                  const TimeOfDayAdapter.zero(),
                  const TimeOfDayAdapter.zero(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
