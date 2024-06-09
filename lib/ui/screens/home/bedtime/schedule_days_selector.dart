import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/stateful_text.dart';

class ScheduleDaysSelector extends ConsumerWidget {
  const ScheduleDaysSelector({super.key});

  void _toggleDays(WidgetRef ref, int index) =>
      ref.read(bedtimeProvider.notifier).toggleScheduleDay(index);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleDays =
        ref.watch(bedtimeProvider.select((value) => value.scheduleDays));

    final isScheduleOn =
        ref.watch(bedtimeProvider.select((value) => value.isScheduleOn));

    return SizedBox(
        height: 40,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              7,
              (index) => RoundedContainer(
                height: 40,
                width: 40,
                circularRadius: 20,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                color: scheduleDays[index]
                    ? Theme.of(context).colorScheme.surface
                    : Colors.transparent,
                onPressed:
                    isScheduleOn ? null : () => _toggleDays(ref, index),
                child: StatefulText(
                  AppStrings.daysShort[index],
                  fontSize: 14,
                  isActive: !isScheduleOn,
                ),
              ),
            ),
          ),
        ));
  }
}
