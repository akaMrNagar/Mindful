import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/screens/home/bedtime/days_selector.dart';
import 'package:mindful/ui/widgets/custom_text.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        // color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Schedule time
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _SelectedTime(label: "Start"),
                Spacer(),
                _SelectedTime(label: "End"),
              ],
            ),
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
              Text(10552.minutes.toTimeFull()),
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
    );
  }
}

class _SelectedTime extends StatelessWidget {
  const _SelectedTime({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubtitleText(label),
          4.vBox(),
          Row(
            children: [
              const TitleText(
                "11:00",
                size: 36,
              ),
              6.hBox(),
              const SubtitleText("pm"),
            ],
          ),
        ],
      ),
    );
  }
}
