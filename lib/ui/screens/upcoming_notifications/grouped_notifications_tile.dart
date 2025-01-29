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
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/notification_model.dart';
import 'package:mindful/providers/apps/apps_info_provider.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/upcoming_notifications/single_notification_tile.dart';

class AppsNotificationsTile extends ConsumerWidget {
  const AppsNotificationsTile({
    super.key,
    required this.packageName,
    required this.notifications,
    required this.position,
  });

  final String packageName;
  final List<NotificationModel> notifications;
  final ItemPosition position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInfo =
        ref.watch(appsInfoProvider.select((v) => v.value?[packageName]));
    return appInfo == null
        ? 0.vBox
        : DefaultExpandableListTile(
            titleText: appInfo.name,
            position: position,
            subtitle: StyledText(
              context.locale.nNotifications(notifications.length),
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
            leading: ApplicationIcon(appInfo: appInfo),
            content: ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(0),
              itemCount: notifications.length,
              itemBuilder: (context, index) => SingleNotificationTile(
                title: notifications[index].titleText,
                content: notifications[index].contentText,
                timeStamp: notifications[index].timeStamp,
                position: ItemPosition.mid,
                onPressed: () => MethodChannelService.instance
                    .openAppWithPackage(packageName),
              ),
            ),
          );
  }
}
