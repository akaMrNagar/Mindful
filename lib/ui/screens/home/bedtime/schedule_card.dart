import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/strings.dart';
import 'package:mindful/ui/widgets/custom_text.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        // color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          /// Schedule time
          const Row(
            children: [
              _Time(),
              Spacer(),
              _Time(),
            ],
          ),

          /// Days
          16.vBox(),
          FittedBox(
            child: Row(
              children: AppStrings.daysShort
                  .map(
                    (e) => IconButton.outlined(
                      onPressed: () {},
                      icon: Text(e),
                    ),
                  )
                  .toList(),
            ),
          ),

          /// Total bedtime duration
          16.vBox(),
          Row(
            children: [
              const Icon(FluentIcons.clock_lock_20_regular),
              8.hBox(),
              Text(10552.minutes.toTimeFull()),
            ],
          )
        ],
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubtitleText("Start"),
          4.vBox(),
          Row(
            children: [
              const TitleText(
                "11:00",
                size: 28,
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
