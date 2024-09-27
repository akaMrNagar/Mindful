/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
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
            heroTag: heroTag,
            icon: ApplicationIcon(app: app),
            title: app.name,
            info: context.locale.timer_picker_dialog_info,
            positiveButtonLabel: context.locale.dialog_button_set_timer,
            initialTimeInSec: initialTime,
          ),
        ),
      ) ??
      initialTime;
}

/// Animates the hero widget to a alert dialog containing duration picker with the provided configurations
///
/// Returns time in seconds and take initial time in seconds
Future<int> showShortsTimerPicker({
  required BuildContext context,
  required Object heroTag,
  required int initialTime,
}) async {
  return await Navigator.of(context).push<int>(
        HeroPageRoute(
          builder: (context) => _DurationPickerDialog(
            title: context.locale.short_content_heading,
            info: context.locale.timer_picker_dialog_info,
            icon: const Icon(FluentIcons.video_clip_multiple_20_filled),
            heroTag: heroTag,
            initialTimeInSec: initialTime,
            positiveButtonLabel: context.locale.dialog_button_set_timer,
            showDeleteButton: false,
          ),
        ),
      ) ??
      initialTime;
}

/// Animates the hero widget to a alert dialog containing duration picker with the provided configurations
///
/// Returns time in seconds and take initial time in seconds
Future<int?> showFocusTimerPicker({
  required BuildContext context,
  required Object heroTag,
  int initialTime = 30 * 60,
}) async {
  return await Navigator.of(context).push<int?>(
    HeroPageRoute(
      builder: (context) => _DurationPickerDialog(
        title: context.locale.focus_session_tile_title,
        icon: const Icon(FluentIcons.timer_20_regular),
        heroTag: heroTag,
        initialTimeInSec: initialTime,
        info: context.locale.focus_session_dialog_info,
        positiveButtonLabel: context.locale.focus_session_dialog_button_start,
        showDeleteButton: false,
      ),
    ),
  );
}

class _DurationPickerDialog extends StatefulWidget {
  const _DurationPickerDialog({
    required this.icon,
    required this.title,
    required this.initialTimeInSec,
    required this.heroTag,
    required this.info,
    required this.positiveButtonLabel,
    this.showDeleteButton = true,
  });

  final Widget icon;
  final String title;
  final Object heroTag;
  final int initialTimeInSec;
  final String positiveButtonLabel;
  final bool showDeleteButton;
  final String info;

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
            title: StyledText(
              widget.title,
              fontSize: 16,
            ),
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  StyledText(widget.info),
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
                  if (widget.showDeleteButton)
                    FittedBox(
                      child: FilledButton.icon(
                        icon: const Icon(FluentIcons.delete_20_regular),
                        label: Text(context.locale.dialog_button_delete_timer),
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
                child: Text(context.locale.dialog_button_cancel),
                onPressed: () => Navigator.maybePop(context),
              ),
              TextButton(
                child: Text(widget.positiveButtonLabel),
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
