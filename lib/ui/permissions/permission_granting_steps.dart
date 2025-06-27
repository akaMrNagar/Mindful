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
import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class PermissionGrantingSteps extends StatelessWidget {
  const PermissionGrantingSteps({
    super.key,
    required this.deviceSwitchTileLabel,
    required this.labelOfBtnToClick,
    this.isAccessibilityPerm = false,
  });

  final String deviceSwitchTileLabel;
  final String labelOfBtnToClick;
  final bool isAccessibilityPerm;

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
            context.locale.permission_grant_step_one(labelOfBtnToClick),
            fontSize: 14,
          ),
          6.vBox,

          /// Second step
          StyledText(
            context.locale.permission_grant_step_two,
            fontSize: 14,
          ),
          6.vBox,
          DefaultListTile(
            leading: const RoundedContainer(
              circularRadius: 12,
              color: Colors.white,
              child: Icon(
                FluentIcons.target_arrow_20_regular,
                color: Colors.black,
                size: 40,
              ),
            ),
            titleText: "Mindful",
            subtitleText: isAccessibilityPerm
                ? context.locale.permission_status_off
                : context.locale.permission_status_not_allowed,
          ),

          12.vBox,

          /// Third step
          StyledText(
            context.locale.permission_grant_step_three,
            fontSize: 14,
          ),
          6.vBox,
          DefaultListTile(
            // margin: const EdgeInsets.only(left: 16, top: 4),
            color: Theme.of(context).colorScheme.surfaceContainer,
            switchValue: true,
            titleText: deviceSwitchTileLabel,
          ),

          6.vBox,
        ],
      ),
    );
  }
}
