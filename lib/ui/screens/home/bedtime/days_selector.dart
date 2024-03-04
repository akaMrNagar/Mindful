import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/providers/bedtime_schedule_provider.dart';

class DaysSelector extends ConsumerWidget {
  const DaysSelector({super.key});

  void _toggleDays(WidgetRef ref, int index) =>
      ref.read(bedtimeScheduleProvider.notifier).toggleSelectedDays(index);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDays = ref
        .watch(bedtimeScheduleProvider.select((value) => value.selectedDays));

    final status = ref
        .watch(bedtimeScheduleProvider.select((value) => value.bedtimeStatus));

    return Row(
      children: List.generate(
        7,
        (index) => selectedDays[index]
            ? IconButton.outlined(
                onPressed: status ? null : () => _toggleDays(ref, index),
                icon: Text(AppStrings.daysShort[index]),
              )
            : IconButton(
                onPressed: status ? null : () => _toggleDays(ref, index),
                icon: Text(AppStrings.daysShort[index]),
              ),
      ).toList(),
    );
  }
}
