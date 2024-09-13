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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class ScheduleCard extends ConsumerWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScheduleOn =
        ref.watch(bedtimeProvider.select((v) => v.isScheduleOn));

    final startTime = ref.watch(bedtimeProvider.select((v) => v.startTime));

    final endTime = ref.watch(bedtimeProvider.select((v) => v.endTime));

    final totalDuration =
        ref.watch(bedtimeProvider.select((v) => v.totalDuration));

    final scheduleDays =
        ref.watch(bedtimeProvider.select((value) => value.scheduleDays));

    return RoundedContainer(
      height: 224,
      circularRadius: 24,
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Schedule time Start and End
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Schedule start time
              _SelectedTime(
                label: "Start",
                enabled: !isScheduleOn,
                initialTime: startTime,
                onChange: (t) {
                  ref.read(bedtimeProvider.notifier).setBedtimeStart(t);
                },
              ),

              /// Schedule end time
              _SelectedTime(
                label: "End",
                enabled: !isScheduleOn,
                initialTime: endTime,
                onChange: (t) =>
                    ref.read(bedtimeProvider.notifier).setBedtimeEnd(t),
              ),
            ],
          ),

          /// Total calculated bedtime duration
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Divider(color: Theme.of(context).focusColor)),
              12.hBox,
              StyledText(totalDuration.toTimeFull()),
              12.hBox,
              Expanded(child: Divider(color: Theme.of(context).focusColor)),
            ],
          ),

          /// Schedule selected Days
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                7,
                (index) => RoundedContainer(
                  circularRadius: 48,
                  height: 48,
                  width: 48,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  color: scheduleDays[index]
                      ? isScheduleOn
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  onPressed: isScheduleOn
                      ? null
                      : () => ref
                          .read(bedtimeProvider.notifier)
                          .toggleScheduleDay(index),
                  child: Semantics(
                    hint: AppStrings.daysFull[index],
                    child: StyledText(
                      AppStrings.daysShort[index],
                      fontSize: 16,
                      isSubtitle: isScheduleOn,
                      color: scheduleDays[index]
                          ? Theme.of(context).colorScheme.surface
                          : null,
                    ),
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

class _SelectedTime extends StatelessWidget {
  const _SelectedTime({
    required this.label,
    required this.enabled,
    required this.onChange,
    required this.initialTime,
  });

  final String label;
  final bool enabled;
  final TimeOfDay initialTime;
  final Function(TimeOfDay time) onChange;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 96,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: Colors.transparent,
      onPressed: enabled
          ? () {
              showTimePicker(
                context: context,
                initialTime: initialTime,
              ).then((value) {
                onChange(value ?? initialTime);
              });
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
                initialTime.period.name,
                height: 2,
                isSubtitle: !enabled,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
