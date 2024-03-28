import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/bedtime_schedule_provider.dart';
import 'package:mindful/ui/common/components/rounded_container.dart';
import 'package:mindful/ui/screens/home/bedtime/days_selector.dart';
import 'package:mindful/ui/common/buttons.dart';
import 'package:mindful/ui/common/custom_text.dart';

class BedtimeCard extends StatelessWidget {
  const BedtimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 200,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Schedule time
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return Row(
                children: [
                  _SelectedTime(
                    label: "Start",
                    initialTime: ref.watch(bedtimeScheduleProvider
                        .select((value) => value.startTime)),
                    onChange: (t) => ref
                        .read(bedtimeScheduleProvider.notifier)
                        .setBedtimeStart(t),
                  ),
                  const Spacer(),
                  _SelectedTime(
                    label: "End",
                    initialTime: ref.watch(bedtimeScheduleProvider
                        .select((value) => value.endTime)),
                    onChange: (t) => ref
                        .read(bedtimeScheduleProvider.notifier)
                        .setBedtimeEnd(t),
                  ),
                ],
              );
            },
          ),

          /// Total bedtime duration
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  color: Theme.of(context).focusColor,
                ),
              ),
              12.hBox(),
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  final startT = ref.watch(bedtimeScheduleProvider
                      .select((value) => value.startTime));
                  final endT = ref.watch(
                      bedtimeScheduleProvider.select((value) => value.endTime));

                  return SubtitleText(
                    endT.difference(startT).minutes.toTimeFull(),
                  );
                },
              ),
              12.hBox(),
              Expanded(
                child: Divider(
                  color: Theme.of(context).focusColor,
                ),
              ),
            ],
          ),

          /// Days
          const DaysSelector(),
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
    final bedtimeEnabled = ref
        .watch(bedtimeScheduleProvider.select((value) => value.bedtimeStatus));

    return SecondaryButton(
      onPressed: bedtimeEnabled
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
          SubtitleText(label),
          4.vBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(
                initialTime.format(context).split(' ').first,
                size: 36,
              ),
              6.hBox(),
              SubtitleText(
                "${initialTime.period.name} ${initialTime.period.index}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
