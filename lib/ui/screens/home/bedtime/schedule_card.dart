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
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                7,
                (index) => Expanded(
                  child: RoundedContainer(
                    circularRadius: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
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
                    child: StyledText(
                      AppStrings.daysShort[index],
                      fontSize: 14,
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
