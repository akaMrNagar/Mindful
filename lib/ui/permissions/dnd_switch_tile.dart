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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/permissions/permission_sheet.dart';

class DndSwitchTile extends ConsumerWidget {
  const DndSwitchTile({
    required this.switchValue,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

  final bool enabled;
  final bool switchValue;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission =
        ref.watch(permissionProvider.select((v) => v.haveDndPermission));

    return DefaultListTile(
      enabled: !havePermission || enabled,
      switchValue: switchValue,
      titleText: context.locale.permission_dnd_tile_title,
      subtitleText: context.locale.permission_dnd_tile_subtitle,
      accent: havePermission ? null : Theme.of(context).colorScheme.error,
      isSelected: havePermission,
      margin: const EdgeInsets.only(bottom: 2),
      onPressed: havePermission ? onPressed : () => _showSheet(context, ref),
    );
  }

  void _showSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => PermissionSheet(
        icon: FluentIcons.alert_snooze_20_filled,
        title: context.locale.permission_dnd_title,
        description: context.locale.permission_dnd_info,
        onGrantPermission: () {
          ref.read(permissionProvider.notifier).askDndPermission();
          Navigator.of(sheetContext).maybePop();
        },
      ),
    );
  }
}
