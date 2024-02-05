import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/providers/schedule_provider.dart';

class DaysSelector extends ConsumerWidget {
  const DaysSelector({super.key});

  void _toggleDays(WidgetRef ref, int index) =>
      ref.read(bedtimeProvider.notifier).toggleSelectedDays(index);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDays =
        ref.watch(bedtimeProvider.select((value) => value.selectedDays));

    final modifiable =
        ref.watch(bedtimeProvider.select((value) => value.bedtimeStatus)) &&
            !ref.watch(bedtimeProvider.select((value) => value.invincible));

    return Row(
      children: List.generate(
        7,
        (index) => selectedDays[index]
            ? IconButton.outlined(
                onPressed: modifiable ? () => _toggleDays(ref, index) : null,
                icon: Text(AppStrings.daysShort[index]),
              )
            : IconButton(
                onPressed: modifiable ? () => _toggleDays(ref, index) : null,
                icon: Text(AppStrings.daysShort[index]),
              ),
      ).toList(),
    );
  }
}
