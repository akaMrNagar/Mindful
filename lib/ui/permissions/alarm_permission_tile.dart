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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/providers/system/permissions_provider.dart';
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
      position: ItemPosition.mid,
      titleText: context.locale.permission_alarms_title,
      accent: havePermission ? null : Theme.of(context).colorScheme.error,
      subtitleText: havePermission
          ? context.locale.permission_status_allowed
          : context.locale.permission_status_not_allowed,
      isSelected: havePermission,
      onPressed: havePermission ? null : () => _showSheet(context, ref),
    );
  }

  void _showSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => PermissionSheet(
        icon: FluentIcons.clock_alarm_20_filled,
        title: context.locale.permission_alarms_title,
        description: context.locale.permission_alarms_info,
        deviceSwitchTileLabel:
            context.locale.permission_alarms_device_tile_label,
        onTapGrantPermission: () {
          Navigator.of(sheetContext).maybePop();
          ref.read(permissionProvider.notifier).askExactAlarmPermission();
        },
      ),
    );
  }
}
