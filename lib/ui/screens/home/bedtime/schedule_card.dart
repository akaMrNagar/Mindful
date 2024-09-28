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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/app_constants.dart';
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
      color: Theme.of(context).colorScheme.surfaceContainer,
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
                label: context.locale.schedule_start_label,
                enabled: !isScheduleOn,
                initialTime: startTime,
                onChange: (t) {
                  ref.read(bedtimeProvider.notifier).setBedtimeStart(t);
                },
              ),

              /// Schedule end time
              _SelectedTime(
                label: context.locale.schedule_end_label,
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
                          .read(bedtimeProvider.notifier)
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
