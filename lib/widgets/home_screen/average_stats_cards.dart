import 'package:flutter/material.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/interactive_card.dart';

class AverageStatsCards extends StatelessWidget {
  const AverageStatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _AverageInfo(
          label: "Weekly",
          info: "13 hours, 57 minutes",
        ),
        _AverageInfo(
          label: "Monthly",
          info: "4 hours, 28 minutes",
        ),
      ],
    );
  }
}

class _AverageInfo extends StatelessWidget {
  const _AverageInfo({
    required this.label,
    required this.info,
  });

  final String label;
  final String info;

  @override
  Widget build(BuildContext context) {
    return InteractiveCard(
      onPressed: () {},
      circularRadius: 16,
      // color: Colors.transparent,
      applyBorder: true,
      borderWidth: 1,
      // borderColor: Colors.black12,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: double.infinity),
          SubtitleText(label),
          const SizedBox(height: 2),
          TitleText(info, size: 14),
        ],
      ),
    );
  }
}
