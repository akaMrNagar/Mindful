import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressHeatmap extends ConsumerStatefulWidget {
  const ProgressHeatmap({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProgressHeatmapState();
}

class _ProgressHeatmapState extends ConsumerState<ProgressHeatmap> {
  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      datasets: {
        DateTime(2024, 8, 6): 3,
        DateTime(2024, 8, 7): 7,
        DateTime(2024, 8, 8): 10,
        DateTime(2024, 8, 9): 13,
        DateTime(2024, 9, 13): 50,
      },
      colorMode: ColorMode.opacity,
      flexible: true,
      // initDate: DateTime.now(),
      textColor: Theme.of(context).colorScheme.onPrimaryContainer,
      // showText: true,

      borderRadius: 14,

      // scrollable: true,
      defaultColor: Theme.of(context).colorScheme.surface,

      // showColorTip: false,

      colorsets: {
        0: Colors.green,
        // 0: Theme.of(context).colorScheme.primary,
      },

      onClick: (value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value.toString())));
      },
    );
  }
}
