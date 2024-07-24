import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/ui/transitions/hero_page_route.dart';

/// Animates the hero widget to a alert dialog containing duration picker with the provided configurations
/// 
/// Returns time in seconds and take initial time in seconds
Future<int> showAppTimerPicker({
  required AndroidApp app,
  required BuildContext context,
  required Object heroTag,
  required int initialTime,
}) async {
  return await Navigator.of(context).push<int>(
        HeroPageRoute(
          builder: (context) => _DurationPickerDialog(
            icon: ApplicationIcon(app: app),
            title: app.name,
            heroTag: heroTag,
            initialTimeInSec: initialTime,
          ),
        ),
      ) ??
      initialTime;
}

Future<int> showShortsTimerPicker({
  required BuildContext context,
  required Object heroTag,
  required int initialTime,
}) async {
  return await Navigator.of(context).push<int>(
        HeroPageRoute(
          builder: (context) => _DurationPickerDialog(
            title: "Short content",
            icon: const Icon(FluentIcons.video_clip_multiple_20_regular),
            heroTag: heroTag,
            initialTimeInSec: initialTime,
          ),
        ),
      ) ??
      initialTime;
}

class _DurationPickerDialog extends StatefulWidget {
  const _DurationPickerDialog({
    required this.icon,
    required this.title,
    required this.initialTimeInSec,
    required this.heroTag,
  });

  final Widget icon;
  final String title;
  final Object heroTag;
  final int initialTimeInSec;

  @override
  State<_DurationPickerDialog> createState() => _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<_DurationPickerDialog> {
  Duration? _selectedDuration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(48),
      alignment: Alignment.center,
      child: DefaultHero(
        tag: widget.heroTag,
        child: SingleChildScrollView(
          child: AlertDialog(
            icon: widget.icon,
            title: StyledText(widget.title, fontSize: 16),
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const StyledText(
                      "This timer will reset at midnight every day, ensuring that your daily usage is tracked accurately."),
                  Container(
                    height: 124,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: CupertinoTimerPicker(
                      itemExtent: 32,
                      mode: CupertinoTimerPickerMode.hm,
                      initialTimerDuration: widget.initialTimeInSec.seconds,
                      onTimerDurationChanged: (val) => _selectedDuration = val,
                    ),
                  ),
                  18.vBox,
                  FittedBox(
                    child: FilledButton.icon(
                      icon: const Icon(FluentIcons.delete_20_regular),
                      label: const Text("Delete timer"),
                      onPressed: () => Navigator.maybePop(
                        context,
                        0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("cancel"),
                onPressed: () =>
                    Navigator.maybePop(context, widget.initialTimeInSec),
              ),
              TextButton(
                child: const Text("Set timer"),
                onPressed: () => Navigator.maybePop(
                  context,
                  _selectedDuration?.inSeconds ?? widget.initialTimeInSec,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
