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
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/restriction_infos_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/permissions/permission_sheet.dart';

class AppInternetSwitcher extends ConsumerWidget {
  const AppInternetSwitcher({
    required this.app,
    this.isIconButton = false,
    super.key,
  });

  final AndroidApp app;
  final bool isIconButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission =
        ref.watch(permissionProvider.select((v) => v.haveVpnPermission));

    final haveInternetAccess = ref.watch(restrictionInfosProvider
            .select((value) => value[app.packageName]?.internetAccess)) ??
        true;

    onPressed() => havePermission
        ? _switchInternet(context, ref, !haveInternetAccess)
        : _showSheet(context, ref);

    return isIconButton
        ? IconButton(
            icon: Icon(
              haveInternetAccess
                  ? FluentIcons.globe_20_regular
                  : FluentIcons.globe_prohibited_20_regular,
              color: haveInternetAccess
                  ? null
                  : Theme.of(context).colorScheme.error,
            ),
            onPressed: onPressed,
          )
        : DefaultListTile(
            switchValue: haveInternetAccess,
            enabled: !app.isImpSysApp,
            titleText: context.locale.internet_access_tile_title,
            subtitleText: app.isImpSysApp
                ? context.locale.internet_access_tile_subtitle_unavailable
                : context.locale.internet_access_tile_subtitle,
            leadingIcon: haveInternetAccess
                ? FluentIcons.globe_20_regular
                : FluentIcons.globe_prohibited_16_filled,
            accent:
                haveInternetAccess ? null : Theme.of(context).colorScheme.error,
            isSelected: havePermission,
            margin: const EdgeInsets.only(bottom: 2),
            onPressed: onPressed,
          );
  }

  void _showSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => PermissionSheet(
        icon: FluentIcons.channel_share_20_filled,
        title: context.locale.permission_vpn_title,
        description: context.locale.permission_vpn_info,
        onTapGrantPermission: () {
          ref.read(permissionProvider.notifier).askVpnPermission();
          Navigator.of(sheetContext).maybePop();
        },
      ),
    );
  }

  void _switchInternet(
    BuildContext context,
    WidgetRef ref,
    bool haveInternetAccess,
  ) {
    ref.read(restrictionInfosProvider.notifier).switchInternetAccess(
          app.packageName,
          haveInternetAccess,
        );

    context.showSnackAlert(
      haveInternetAccess
          ? context.locale.internet_access_unblocked_snack_alert(app.name)
          : context.locale.internet_access_blocked_snack_alert(app.name),
      icon: haveInternetAccess
          ? FluentIcons.globe_20_filled
          : FluentIcons.globe_prohibited_20_filled,
    );
  }
}
