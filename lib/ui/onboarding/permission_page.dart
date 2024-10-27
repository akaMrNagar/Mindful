/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/ui/onboarding/onboarding_page.dart';
import 'package:mindful/ui/permissions/alarm_permission_tile.dart';
import 'package:mindful/ui/permissions/display_overlay_permission_tile.dart';
import 'package:mindful/ui/permissions/notification_permission_tile.dart';
import 'package:mindful/ui/permissions/usage_access_permission_tile.dart';

class PermissionsPage extends ConsumerWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perms = ref.watch(permissionProvider);
    final haveAllEssentialPermissions = perms.haveUsageAccessPermission &&
        perms.haveDisplayOverlayPermission &&
        perms.haveAlarmsPermission &&
        perms.haveNotificationPermission;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (haveAllEssentialPermissions && context.mounted) {
          MethodChannelService.instance.setOnboardingDone();
          Future.delayed(
            250.ms,
            () {
              Navigator.of(context).maybePop();
              ref
                  .read(appsRestrictionsProvider.notifier)
                  .checkAndRestartServices(
                    haveVpnPermission: perms.haveVpnPermission,
                  );
            },
          );
        }
      },
    );

    return Column(
      children: [
        Expanded(
          child: OnboardingPage(
            bottomPadding: 0,
            title: context.locale.onboarding_page_permissions_title,
            imgArtPath: "assets/illustrations/onboarding_4.png",
            description: context.locale.onboarding_page_permissions_info,
          ),
        ),

        12.vBox,

        /// Permission tiles
        const NotificationPermissionTile(),
        const AlarmPermissionTile(),
        const UsageAccessPermissionTile(),
        const DisplayOverlayPermissionTile(),

        108.vBox,
      ],
    );
  }
}
