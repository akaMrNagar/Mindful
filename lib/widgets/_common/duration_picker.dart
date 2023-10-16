import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindful/widgets/_common/interactive_card.dart';

/// Returns duration in seconds and take initial time as duration in seconds
Future<int> showDurationPicker({
  required BuildContext context,
  required int initialTime,
  required String appName,
}) async {
  final selectedTime = await showDialog<int>(
    barrierColor: Colors.black.withOpacity(0.7),
    context: context,
    builder: (context) {
      return _DurationPicker(
        initialDuration: Duration(minutes: initialTime),
        appName: appName,
      );
    },
  );

  return Future.value(selectedTime ?? initialTime);
}

class _DurationPicker extends StatelessWidget {
  const _DurationPicker({required this.initialDuration, required this.appName});

  final Duration initialDuration;
  final String appName;

  @override
  Widget build(BuildContext context) {
    Duration selectedDuration = initialDuration;

    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.375,
      child: Material(
        color: Colors.transparent,
        surfaceTintColor: Colors.white,
        child: InteractiveCard(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          circularRadius: 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              /// Title
              const Text(
                "Set timer",
                style: TextStyle(fontSize: 18),
              ),

              /// Subtitle
              const SizedBox(height: 4),
              Text(
                "The timer for $appName will restart from midnight everyday",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.color
                      ?.withOpacity(0.7),
                ),
              ),

              /// Time picker
              const Spacer(),
              SizedBox(
                height: 120,
                child: CupertinoTimerPicker(
                  itemExtent: 32,
                  // minuteInterval: 1,
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: initialDuration,
                  onTimerDurationChanged: (val) => selectedDuration = val,
                ),
              ),

              /// Cancel done buttons
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context, initialDuration.inMinutes),
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context, selectedDuration.inMinutes),
                    child: const Text("Done"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
