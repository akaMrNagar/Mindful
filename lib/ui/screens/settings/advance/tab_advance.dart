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
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/auth_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/mindful_settings_provider.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/time_picker_dialog.dart';
import 'package:mindful/ui/permissions/admin_permission_tile.dart';
import 'package:mindful/ui/permissions/battery_permission_tile.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class TabAdvance extends ConsumerStatefulWidget {
  const TabAdvance({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabAdvanceState();
}

class _TabAdvanceState extends ConsumerState<TabAdvance> {
  void _openAutoStartSettings(BuildContext context) async {
    final success = await MethodChannelService.instance.openAutoStartSettings();

    if (!success && context.mounted) {
      context.showSnackAlert(
        context.locale.whitelist_app_unsupported_snack_alert,
      );
    }
  }

  void _toggleProtectedAccess(bool isAccessProtected) async {
    try {
      if (!isAccessProtected) {
        final canEnable = await AuthService.instance.authenticate();
        if (!canEnable) {
          /// Show alert for no lock
          if (mounted) {
            context.showSnackAlert(
                context.locale.protected_access_no_lock_snack_alert);
          }

          return;
        }
      }

      ref.read(mindfulSettingsProvider.notifier).switchProtectedAccess();
    } catch (e) {
      debugPrint("Failed to authenticate: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final mindfulSettings = ref.watch(mindfulSettingsProvider);
    final isAdminEnabled =
        ref.watch(permissionProvider.select((v) => v.haveAdminPermission));

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Parental controls
        ContentSectionHeader(title: context.locale.parental_controls_heading)
            .sliver,

        /// Protected access
        DefaultListTile(
          position: ItemPosition.start,
          switchValue: mindfulSettings.protectedAccess,
          leadingIcon: FluentIcons.fingerprint_20_regular,
          titleText: context.locale.protected_access_tile_title,
          subtitleText: context.locale.protected_access_tile_subtitle,
          onPressed: () =>
              _toggleProtectedAccess(mindfulSettings.protectedAccess),
        ).sliver,

        /// Tamper protection
        const AdminPermissionTile().sliver,

        /// Uninstall window
        DefaultHero(
          tag: HeroTags.uninstallWindowTileTag,
          child: DefaultListTile(
            position: ItemPosition.end,
            enabled: !isAdminEnabled,
            titleText: context.locale.uninstall_window_tile_title,
            subtitleText: context.locale.uninstall_window_tile_subtitle,
            trailing: StyledText(
              mindfulSettings.uninstallWindowTime.format(context),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              isSubtitle: isAdminEnabled,
            ),
            onPressed: () async {
              final pickedTime = await showCustomTimePickerDialog(
                context: context,
                heroTag: HeroTags.uninstallWindowTileTag,
                initialTime: mindfulSettings.uninstallWindowTime,
                info: context.locale.uninstall_window_tile_title,
              );

              if (pickedTime != null && context.mounted) {
                ref
                    .read(mindfulSettingsProvider.notifier)
                    .changeUninstallWindowTime(pickedTime);
              }
            },
          ),
        ).sliver,

        /// Service
        ContentSectionHeader(title: context.locale.service_heading).sliver,

        /// Battery permission
        StyledText(context.locale.service_stopping_warning).sliver,
        6.vSliverBox,
        const BatteryPermissionTile(),
        DefaultListTile(
          position: ItemPosition.end,
          leadingIcon: FluentIcons.leaf_three_20_regular,
          titleText: context.locale.whitelist_app_tile_title,
          subtitleText: context.locale.whitelist_app_tile_subtitle,
          trailing: const Icon(FluentIcons.chevron_right_20_regular),
          onPressed: () => _openAutoStartSettings(context),
        ).sliver,

        const SliverTabsBottomPadding()
      ],
    );
  }
}
