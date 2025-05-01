/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/time_picker_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({
    super.key,
    required this.label,
    required this.heroTag,
    required this.onChange,
    required this.initialTime,
    this.bgColor,
    this.icon,
    this.iconColor,
    this.isModifiable,
    this.iconSize = 32,
    this.enabled = true,
  });

  final String label;
  final Object heroTag;
  final bool enabled;
  final TimeOfDayAdapter initialTime;
  final Function(TimeOfDayAdapter time) onChange;
  final bool Function()? isModifiable;
  final Color? bgColor;
  final IconData? icon;
  final Color? iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return DefaultHero(
      tag: heroTag,
      child: RoundedContainer(
        color: bgColor,
        padding: const EdgeInsets.all(16),
        onPressed: enabled
            ? () async {
                if (!(isModifiable?.call() ?? true)) return;

                final pickedTime = await showCustomTimePickerDialog(
                  context: context,
                  initialTime: initialTime,
                  heroTag: heroTag,
                  info: label,
                );

                onChange(pickedTime ?? initialTime);
              }
            : null,
        child: Row(
          children: [
            /// Icon
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  icon,
                  size: iconSize,
                  color: enabled ? iconColor : Theme.of(context).disabledColor,
                ),
              ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Label
                StyledText(
                  label,
                  isSubtitle: !enabled,
                ),
                4.vBox,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /// Time in hour and minutes
                    StyledText(
                      initialTime.format(context).split(' ').first,
                      height: 1,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      isSubtitle: !enabled,
                    ),
                    4.hBox,

                    /// Time period AM/PM
                    StyledText(
                      initialTime.format(context).split(' ').last,
                      height: 2,
                      isSubtitle: !enabled,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
