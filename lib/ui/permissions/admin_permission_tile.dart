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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/providers/system/parental_controls_provider.dart';
import 'package:mindful/providers/system/permissions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/permissions/accessibility_permission_card.dart';
import 'package:mindful/ui/permissions/permission_sheet.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class AdminPermissionTile extends ConsumerWidget {
  const AdminPermissionTile({super.key});

  void _toggleTamperProtection(
    BuildContext context,
    WidgetRef ref,
    bool isAdminEnabled,
    TimeOfDayAdapter uninstallWindowTime,
  ) async {
    /// Ask accessibility permission if not allowed
    if (!ref.read(permissionProvider).haveAccessibilityPermission) {
      const AccessibilityPermissionCard()
          .showAccessibilityPermissionSheet(context, ref);
      return;
    }

    if (isAdminEnabled) {
      /// User wants to Disable
      if (ref
          .read(parentalControlsProvider.notifier)
          .isBetweenUninstallWindow) {
        ref.read(permissionProvider.notifier).disableAdminPermission();
      } else {
        context.showSnackAlert(
          context.locale.permission_admin_snack_alert,
        );
      }
    } else {
      /// Confirm
      final isConfirm = await showConfirmationDialog(
        context: context,
        heroTag: HeroTags.tamperProtectionTileTag,
        icon: FluentIcons.shield_keyhole_20_filled,
        title: context.locale.tamper_protection_tile_title,
        info: context.locale.tamper_protection_confirmation_dialog_info,
        positiveLabel: context.locale.permission_button_grant_permission,
      );

      await Future.delayed(400.ms);
      if (!isConfirm || !context.mounted) return;

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
    final haveAdminPermission =
        ref.watch(permissionProvider.select((v) => v.haveAdminPermission));
    final haveAccessibilityPermission = ref
        .watch(permissionProvider.select((v) => v.haveAccessibilityPermission));

    final uninstallWindowTime = ref
        .watch(parentalControlsProvider.select((v) => v.uninstallWindowTime));

    return DefaultHero(
      tag: HeroTags.tamperProtectionTileTag,
      child: DefaultListTile(
        position: ItemPosition.mid,
        switchValue: haveAdminPermission && haveAccessibilityPermission,
        leadingIcon: FluentIcons.shield_keyhole_20_regular,
        titleText: context.locale.tamper_protection_tile_title,
        subtitleText: context.locale.tamper_protection_tile_subtitle,
        onPressed: () => _toggleTamperProtection(
          context,
          ref,
          haveAdminPermission,
          uninstallWindowTime,
        ),
      ),
    );
  }
}
