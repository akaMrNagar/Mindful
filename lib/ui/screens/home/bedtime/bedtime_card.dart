import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/schedule_provider.dart';
import 'package:mindful/ui/screens/home/bedtime/days_selector.dart';
import 'package:mindful/ui/widgets/buttons.dart';
import 'package:mindful/ui/widgets/custom_text.dart';

class BedtimeCard extends StatelessWidget {
  const BedtimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 4, right: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        // color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Schedule time
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _SelectedTime(
                  label: "Start",
                  onPressed: () {},
                ),
                const Spacer(),
                _SelectedTime(
                  label: "End",
                  onPressed: () {},
                ),
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
              SubtitleText(10552.minutes.toTimeFull()),
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

class _SelectedTime extends ConsumerWidget {
  const _SelectedTime({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SecondaryButton(
      onPressed: ref.watch(bedtimeProvider.select((value) => value.bedtimeStatus))
          ? onPressed
          : null,
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
