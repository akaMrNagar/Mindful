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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/permissions/permission_sheet.dart';

class AlarmPermissionTile extends ConsumerWidget {
  const AlarmPermissionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission =
        ref.watch(permissionProvider.select((v) => v.haveAlarmsPermission));

    return DefaultListTile(
      titleText: "Alarms & Reminders",
      accent: havePermission ? null : Theme.of(context).colorScheme.error,
      subtitleText: havePermission ? "Allowed" : "Not allowed",
      isSelected: havePermission,
      margin: const EdgeInsets.only(bottom: 2),
      onPressed: havePermission ? null : () => _showSheet(context, ref),
    );
  }

  void _showSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => PermissionSheet(
        icon: FluentIcons.clock_alarm_20_filled,
        title: "Alarms & Reminders",
        description:
            "Please grant permission for setting alarms and reminders. This will allow Mindful to start your bedtime schedule on time and reset app timers daily at midnight and help you stay on track.",
        permissionSwitchTitle: "Allow setting alarms and reminders",
        onTapPositiveBtn: () {
          ref.read(permissionProvider.notifier).askExactAlarmPermission();
          Navigator.of(sheetContext).maybePop();
        },
      ),
    );
  }
}
