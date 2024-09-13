/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class PermissionGrantingSteps extends StatelessWidget {
  const PermissionGrantingSteps({
    super.key,
    required this.btnLabel,
    required this.lastStepTileTitle,
    required this.permissionStatusSubtitle,
  });

  final String btnLabel;
  final String permissionStatusSubtitle;

  final String lastStepTileTitle;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      circularRadius: 24,
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// First step
          StyledText(
            "1. Click on $btnLabel button.",
            fontSize: 14,
          ),
          6.vBox,

          /// Second step
          const StyledText(
            "2. Select Mindful in the next screen.",
            fontSize: 14,
          ),
          DefaultListTile(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            margin: const EdgeInsets.only(left: 16, top: 4),
            leading: const RoundedContainer(
              circularRadius: 12,
              color: Colors.white,
              child: Icon(
                FluentIcons.weather_sunny_low_20_filled,
                color: Colors.black,
                size: 40,
              ),
            ),
            titleText: "Mindful",
            subtitleText: permissionStatusSubtitle,
          ),

          8.vBox,

          /// Third step
          const StyledText(
            "3. Click and turn on the switch like below.",
            fontSize: 14,
          ),
          DefaultListTile(
            margin: const EdgeInsets.only(left: 16, top: 4),
            color: Theme.of(context).colorScheme.surfaceContainer,
            switchValue: true,
            titleText: lastStepTileTitle,
          ),

          6.vBox,
        ],
      ),
    );
  }
}
