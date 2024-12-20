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
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/device_info_provider.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';

class SliverBatteryPermissionSwitchTile extends ConsumerWidget {
  /// Creates a animated [DefaultListTile] for asking permission from user
  /// with self handled state and automatically hides itself if the user have granted the permission
  const SliverBatteryPermissionSwitchTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref.watch(
        permissionProvider.select((v) => v.haveIgnoreOptimizationPermission));

    return DefaultListTile(
      position: ItemPosition.start,
      titleText: context.locale.permission_battery_optimization_tile_title,
      enabled: !havePermission,
      switchValue: havePermission,
      leadingIcon: FluentIcons.battery_saver_20_regular,
      subtitleText: havePermission
          ? context.locale.permission_battery_optimization_status_enabled
          : context.locale.permission_battery_optimization_status_disabled,
      onPressed: ref
          .read(permissionProvider.notifier)
          .askIgnoreBatteryOptimizationPermission,
    ).sliver;
  }
}

class BatteryPermissionTile extends ConsumerWidget {
  const BatteryPermissionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref.watch(
        permissionProvider.select((v) => v.haveIgnoreOptimizationPermission));

    return DefaultListTile(
      position: ItemPosition.mid,
      titleText: context.locale.permission_battery_optimization_tile_title,
      accent: havePermission ? null : Theme.of(context).colorScheme.error,
      subtitleText: havePermission
          ? context.locale.permission_status_allowed
          : context.locale.permission_status_not_allowed,
      isSelected: havePermission,
      onPressed: havePermission
          ? null
          : () {
              // Show info about alarms and reminders permission.
              final sdkVersion = ref.watch(
                      deviceInfoProvider.select((v) => v.value?.sdkVersion)) ??
                  24;

              if (sdkVersion >= 31) {
                context.showSnackAlert(
                  context.locale.permission_battery_optimization_allow_info,
                  icon: FluentIcons.info_20_filled,
                );
              }

              // ask permission
              ref
                  .read(permissionProvider.notifier)
                  .askIgnoreBatteryOptimizationPermission();
            },
    );
  }
}
