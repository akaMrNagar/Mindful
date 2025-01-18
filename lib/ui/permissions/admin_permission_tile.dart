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
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/providers/system/mindful_settings_provider.dart';
import 'package:mindful/providers/system/permissions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/permissions/permission_sheet.dart';

class AdminPermissionTile extends ConsumerWidget {
  const AdminPermissionTile({super.key});

  void _toggleTamperProtection(
    BuildContext context,
    WidgetRef ref,
    bool isAdminEnabled,
    TimeOfDayAdapter uninstallWindowTime,
  ) async {
    if (isAdminEnabled) {
      /// User wants to Disable
      if (DateTime.now().isBetweenTod(uninstallWindowTime,
          TimeOfDayAdapter.fromMinutes(uninstallWindowTime.toMinutes + 5))) {
        ref.read(permissionProvider.notifier).disableAdminPermission();
      } else {
        context.showSnackAlert(
          context.locale.permission_admin_snack_alert,
        );
      }
    } else {
      /// User wants to Enable
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (sheetContext) => PermissionSheet(
          icon: FluentIcons.shield_keyhole_20_filled,
          title: context.locale.permission_admin_title,
          description: context.locale.permission_admin_info,
          onTapGrantPermission: () {
            Navigator.of(sheetContext).maybePop();
            ref.read(permissionProvider.notifier).askAdminPermission();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission =
        ref.watch(permissionProvider.select((v) => v.haveAdminPermission));

    final uninstallWindowTime =
        ref.watch(mindfulSettingsProvider.select((v) => v.uninstallWindowTime));

    return DefaultListTile(
      position: ItemPosition.mid,
      switchValue: havePermission,
      leadingIcon: FluentIcons.shield_keyhole_20_regular,
      titleText: context.locale.tamper_protection_tile_title,
      subtitleText: context.locale.tamper_protection_tile_subtitle,
      onPressed: () => _toggleTamperProtection(
        context,
        ref,
        havePermission,
        uninstallWindowTime,
      ),
    );
  }
}
