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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/providers/restrictions/bedtime_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/time_period_start_end_cards.dart';

class BedtimeScheduleCard extends ConsumerWidget {
  const BedtimeScheduleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScheduleOn =
        ref.watch(bedtimeScheduleProvider.select((v) => v.isScheduleOn));

    final startTime =
        ref.watch(bedtimeScheduleProvider.select((v) => v.scheduleStartTime));

    final endTime =
        ref.watch(bedtimeScheduleProvider.select((v) => v.scheduleEndTime));

    final totalDuration = ref.watch(bedtimeScheduleProvider
        .select((v) => v.scheduleDurationInMins.minutes));

    final scheduleDays = ref
        .watch(bedtimeScheduleProvider.select((value) => value.scheduleDays));

    return RoundedContainer(
      height: 224,
      borderRadius: getBorderRadiusFromPosition(ItemPosition.top),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Schedule time Start and End
          TimePeriodStartEndCards(
            enabled: !isScheduleOn,
            startTime: startTime,
            endTime: endTime,
            onStartTimeChanged:
                ref.read(bedtimeScheduleProvider.notifier).setBedtimeStart,
            onEndTimeChanged:
                ref.read(bedtimeScheduleProvider.notifier).setBedtimeEnd,
          ),

          /// Total calculated bedtime duration
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Divider(color: Theme.of(context).focusColor)),
              12.hBox,
              StyledText(totalDuration.toTimeFull(context)),
              12.hBox,
              Expanded(child: Divider(color: Theme.of(context).focusColor)),
            ],
          ),

          /// Schedule selected Days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) => Expanded(
                child: RoundedContainer(
                  circularRadius: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  color: scheduleDays[index]
                      ? isScheduleOn
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  onPressed: isScheduleOn
                      ? null
                      : () => ref
                          .read(bedtimeScheduleProvider.notifier)
                          .toggleScheduleDay(index),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: StyledText(
                      AppConstants.daysShort(context)[index],
                      fontSize: 12,
                      isSubtitle: isScheduleOn,
                      textAlign: TextAlign.center,
                      color: scheduleDays[index]
                          ? Theme.of(context).colorScheme.surface
                          : null,
                    ).centered,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
