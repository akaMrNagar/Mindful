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
import 'package:mindful/models/app_info.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/ui/transitions/hero_page_route.dart';

/// Animates the hero widget to a alert dialog containing duration picker with the provided configurations
///
/// Returns time in seconds and take initial time in seconds
Future<int?> showAppTimerPicker({
  required AppInfo appInfo,
  required BuildContext context,
  required Object heroTag,
  required int initialTime,
}) async =>
    await Navigator.of(context).push<int>(
      HeroPageRoute(
        builder: (context) => _DurationPickerDialog(
          heroTag: heroTag,
          icon: ApplicationIcon(appInfo: appInfo),
          title: appInfo.name,
          info: context.locale.app_timer_picker_dialog_info,
          positiveButtonLabel: context.locale.dialog_button_set,
          initialTimeInSec: initialTime,
        ),
      ),
    );

/// Animates the hero widget to a alert dialog containing duration picker with the provided configurations
///
/// Returns time in seconds and take initial time in seconds
Future<int?> showShortsTimerPicker({
  required BuildContext context,
  required Object heroTag,
  required int initialTime,
}) async =>
    await Navigator.of(context).push<int>(
      HeroPageRoute(
        builder: (context) => _DurationPickerDialog(
          title: context.locale.short_content_heading,
          info: context.locale.short_content_timer_picker_dialog_info,
          icon: const Icon(FluentIcons.video_clip_multiple_20_filled),
          heroTag: heroTag,
          initialTimeInSec: initialTime,
          positiveButtonLabel: context.locale.dialog_button_set,
        ),
      ),
    );

/// Animates the hero widget to a alert dialog containing duration picker with the provided configurations
///
/// Returns time in seconds and take initial time in seconds
Future<int?> showWebTimerPicker({
  required BuildContext context,
  required Object heroTag,
  int initialTime = 5 * 60,
}) async {
  return await Navigator.of(context).push<int?>(
    HeroPageRoute(
      builder: (context) => _DurationPickerDialog(
        title: context.locale.focus_session_duration_tile_title,
        icon: const Icon(FluentIcons.timer_20_regular),
        heroTag: heroTag,
        initialTimeInSec: initialTime,
        info: context.locale.focus_session_duration_dialog_info,
        positiveButtonLabel: context.locale.dialog_button_set,
        // actionButtonLabel: context.locale.dialog_button_infinite,
      ),
    ),
  );
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
        title: context.locale.focus_session_duration_tile_title,
        icon: const Icon(FluentIcons.timer_20_regular),
        heroTag: heroTag,
        initialTimeInSec: initialTime,
        info: context.locale.focus_session_duration_dialog_info,
        positiveButtonLabel: context.locale.dialog_button_set,
        actionButtonLabel: context.locale.dialog_button_infinite,
      ),
    ),
  );
}

/// Animates the hero widget to a alert dialog containing duration picker with the provided configurations
///
/// Returns time in seconds and take initial time in seconds
Future<int?> showRestrictionGroupTimerPicker({
  required BuildContext context,
  required Object heroTag,
  required String groupName,
  int initialTime = 0,
}) async {
  return await Navigator.of(context).push<int?>(
    HeroPageRoute(
      builder: (context) => _DurationPickerDialog(
        title: groupName,
        icon: const Icon(FluentIcons.timer_20_regular),
        heroTag: heroTag,
        initialTimeInSec: initialTime,
        info: context.locale.restriction_group_timer_picker_dialog_info,
        positiveButtonLabel: context.locale.dialog_button_set,
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
    this.actionButtonLabel,
    // ignore: unused_element_parameter
    this.showActionButton = true,

    // ignore: unused_element_parameter
    this.minuteInterval = 1,
  });

  final Widget icon;
  final String title;
  final Object heroTag;
  final int initialTimeInSec;
  final String positiveButtonLabel;
  final bool showActionButton;
  final String? actionButtonLabel;
  final int minuteInterval;
  final String info;

  @override
  State<_DurationPickerDialog> createState() => _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<_DurationPickerDialog> {
  Duration? _selectedDuration;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(48),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: DefaultHero(
            tag: widget.heroTag,
            child: AlertDialog(
              scrollable: true,
              icon: widget.icon,
              title: StyledText(widget.title, fontSize: 16),
              insetPadding: EdgeInsets.zero,
              content: Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StyledText(widget.info),
                      Container(
                        height: 124,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: CupertinoTimerPicker(
                          itemExtent: 32,
                          minuteInterval: widget.minuteInterval,
                          mode: CupertinoTimerPickerMode.hm,
                          initialTimerDuration: widget.initialTimeInSec.seconds,
                          onTimerDurationChanged: (val) =>
                              _selectedDuration = val,
                        ),
                      ),
                      18.vBox,
                      if (widget.showActionButton)
                        FittedBox(
                          child: FilledButton.icon(
                            icon: const Icon(FluentIcons.arrow_reset_20_filled),
                            label: Text(
                              widget.actionButtonLabel ??
                                  context.locale.dialog_button_reset,
                            ),
                            onPressed: () => Navigator.maybePop(
                              context,
                              0,
                            ),
                          ),
                        )
                    ],
                  ),
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
      ),
    );
  }
}
