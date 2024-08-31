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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';

class BatteryPermissionTile extends ConsumerWidget {
  /// Creates a animated [DefaultListTile] for asking permission from user
  /// with self handled state and automatically hides itself if the user have granted the permission
  const BatteryPermissionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref.watch(
        permissionProvider.select((v) => v.haveIgnoreOptimizationPermission));

    return DefaultListTile(
      titleText: "Ignore Battery Optimization",
      enabled: !havePermission,
      switchValue: havePermission,
      leadingIcon: FluentIcons.battery_saver_20_regular,
      subtitleText: havePermission
          ? "Already unrestricted"
          : "Disable background restriction",
      onPressed: ref
          .read(permissionProvider.notifier)
          .askIgnoreBatteryOptimizationPermission,
    ).sliver;
  }
}
