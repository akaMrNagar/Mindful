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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/permissions/permission_granting_steps.dart';

class PermissionSheet extends StatelessWidget {
  const PermissionSheet({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTapGrantPermission,
    this.isAccessibilityPerm = false,
    this.deviceSwitchTileLabel,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTapGrantPermission;
  final bool isAccessibilityPerm;
  final String? deviceSwitchTileLabel;

  @override
  Widget build(BuildContext context) {
    final positiveButtonLabel = isAccessibilityPerm
        ? context.locale.permission_button_agree_and_continue
        : context.locale.permission_button_grant_permission;

    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              6.vBox,
              // Handle
              RoundedContainer(
                height: 6,
                width: 48,
                color: Theme.of(context).disabledColor,
              ).centered,
              24.vBox,

              Icon(
                icon,
                size: 32,
              ),
              8.vBox,

              /// Title
              StyledText(
                title,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              6.vBox,

              /// Info
              StyledText(
                description,
                fontSize: 13,
              ),

              if (deviceSwitchTileLabel != null) ...[
                12.vBox,
                PermissionGrantingSteps(
                  labelOfBtnToClick: positiveButtonLabel,
                  deviceSwitchTileLabel: deviceSwitchTileLabel!,
                  isAccessibilityPerm: isAccessibilityPerm,
                ),
              ],
              20.vBox,
              StyledText(
                context.locale.permission_sheet_privacy_info,
                fontSize: 13,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.green[900]
                    : Colors.green[300],
              ),
              40.vBox,

              /// Actions
              Row(
                children: [
                  if (isAccessibilityPerm)
                    TextButton(
                      onPressed: Navigator.of(context).maybePop,
                      child: Text(context.locale.permission_button_not_now),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: onTapGrantPermission,
                    child: Text(positiveButtonLabel),
                  ),
                ],
              ),
              32.vBox,
            ],
          ),
        ),
      ),
    );
  }
}
