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
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/permissions/permission_sheet.dart';

class DisplayOverlayPermissionTile extends ConsumerWidget {
  const DisplayOverlayPermissionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref.watch(
        permissionProvider.select((v) => v.haveDisplayOverlayPermission));

    return DefaultListTile(
      titleText: "Display Overlay",
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
        icon: FluentIcons.app_recent_20_filled,
        title: "Display Overlay",
        description:
            "Please grant display overlay permission. This will allow Mindful to show an overlay when a paused app is opened, helping you stay focused and maintain your schedule.",
        permissionSwitchTitle: "Allow display over other apps",
        onTapPositiveBtn: () {
          ref.read(permissionProvider.notifier).askDisplayOverlayPermission();
          Navigator.of(sheetContext).maybePop();
        },
      ),
    );
  }
}
