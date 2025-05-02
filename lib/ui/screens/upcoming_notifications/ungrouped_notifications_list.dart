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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/apps/apps_info_provider.dart';
import 'package:mindful/providers/notifications/upcoming_notifications_provider.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/screens/upcoming_notifications/single_notification_tile.dart';

class UngroupedNotificationsList extends ConsumerWidget {
  const UngroupedNotificationsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(upcomingNotificationsProvider).value ?? [];

    return SliverImplicitlyAnimatedList(
      items: notifications,
      keyBuilder: (e) => "${e.packageName}: ${e.timeStamp}",
      itemBuilder: (context, i, notification, position) {
        final appInfo = ref.read(
            appsInfoProvider.select((v) => v.value?[notification.packageName]));

        return appInfo == null
            ? 0.vBox
            : SingleNotificationTile(
                position: position,
                leading: ApplicationIcon(appInfo: appInfo),
                title: notification.titleText,
                content: notification.contentText,
                timeStamp: notification.timeStamp,
                onPressed: () => MethodChannelService.instance
                    .openAppWithPackage(notification.packageName),
              );
      },
    );
  }
}
