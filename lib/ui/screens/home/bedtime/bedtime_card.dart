import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/screens/home/bedtime/schedule_days_selector.dart';

class BedtimeCard extends StatelessWidget {
  const BedtimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 208,
      padding: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Schedule time Start and End
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final startTime =
                  ref.watch(bedtimeProvider.select((value) => value.startTime));
              final endTime =
                  ref.watch(bedtimeProvider.select((value) => value.endTime));

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Schedule start time
                  _SelectedTime(
                    label: "Start",
                    initialTime: startTime,
                    onChange: (t) =>
                        ref.read(bedtimeProvider.notifier).setBedtimeStart(t),
                  ),

                  /// Schedule end time
                  _SelectedTime(
                    label: "End",
                    initialTime: endTime,
                    onChange: (t) =>
                        ref.read(bedtimeProvider.notifier).setBedtimeEnd(t),
                  ),
                ],
              );
            },
          ),

          /// Total calculated bedtime duration
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Divider(color: Theme.of(context).focusColor)),
              12.hBox(),
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  final totalDuration = ref.watch(
                    bedtimeProvider.select((value) => value.totalDuration),
                  );

                  /// Duration text
                  return StatefulText(totalDuration.toTimeFull());
                },
              ),
              12.hBox(),
              Expanded(child: Divider(color: Theme.of(context).focusColor)),
            ],
          ),

          /// Schedule selected Days
          const ScheduleDaysSelector(),
        ],
      ),
    ).toSliverBox();
  }
}

class _SelectedTime extends ConsumerWidget {
  const _SelectedTime({
    required this.label,
    required this.onChange,
    required this.initialTime,
  });

  final String label;
  final TimeOfDay initialTime;
  final Function(TimeOfDay time) onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScheduleOn =
        ref.watch(bedtimeProvider.select((value) => value.isScheduleOn));

    return RoundedContainer(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: Colors.transparent,
      onPressed: isScheduleOn
          ? null
          : () {
              showTimePicker(
                context: context,
                initialTime: initialTime,
              ).then((value) {
                onChange(value ?? initialTime);
              });
            },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Labels "START" and "END"
          StatefulText(
            label,
            isActive: !isScheduleOn,
          ),
          4.vBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// Time in hour and minutes
              StatefulText(
                initialTime.format(context).split(' ').first,
                height: 1,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                isActive: !isScheduleOn,
              ),
              4.hBox(),

              /// Time period AM/PM
              StatefulText(
                initialTime.period.name,
                height: 2,
                isActive: !isScheduleOn,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
