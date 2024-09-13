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
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/permissions/permission_granting_steps.dart';

class PermissionSheet extends StatelessWidget {
  const PermissionSheet({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    required this.onTapPositiveBtn,
    this.permissionSwitchTitle,
    this.positiveBtnLabel = "Grant Permission",
    this.permissionStatusSubtitle = "Not Allowed",
    this.negativeBtnLabel,
  });

  final String title;
  final IconData icon;
  final String description;
  final String? permissionSwitchTitle;
  final String permissionStatusSubtitle;
  final String positiveBtnLabel;
  final VoidCallback onTapPositiveBtn;
  final String? negativeBtnLabel;

  @override
  Widget build(BuildContext context) {
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

              if (permissionSwitchTitle != null) ...[
                12.vBox,
                PermissionGrantingSteps(
                  btnLabel: positiveBtnLabel,
                  lastStepTileTitle: permissionSwitchTitle!,
                  permissionStatusSubtitle: permissionStatusSubtitle,
                ),
              ],
              20.vBox,
              StyledText(
                "Mindful is 100% secure and works offline. We do not collect or store any personal data.",
                fontSize: 13,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.green[900]
                    : Colors.green[300],
              ),
              40.vBox,

              /// Actions
              Row(
                children: [
                  if (negativeBtnLabel != null)
                    TextButton(
                      onPressed: Navigator.of(context).maybePop,
                      child: Text(negativeBtnLabel!),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: onTapPositiveBtn,
                    child: Text(positiveBtnLabel),
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
