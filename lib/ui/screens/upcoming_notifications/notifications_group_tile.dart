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
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/notification_model.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';

class NotificationsGroupTile extends ConsumerWidget {
  const NotificationsGroupTile({
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
    final app = ref.watch(appsProvider.select((v) => v.value?[packageName]));

    return app == null
        ? 0.vBox
        : DefaultExpandableListTile(
            titleText: app.name,
            subtitle: StyledText(
              context.locale.nNotifications(notifications.length),
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
            leading: ApplicationIcon(app: app),
            position: position,
            content: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: notifications.length,
              padding: const EdgeInsets.symmetric(),
              itemBuilder: (context, index) => _Notification(
                title: notifications[index].titleText,
                content: notifications[index].contentText,
                timeStamp: notifications[index].timeStamp,
                onPressed: () => MethodChannelService.instance
                    .openAppWithPackage(packageName),
              ),
            ),
          );
  }
}

class _Notification extends StatelessWidget {
  const _Notification({
    required this.title,
    required this.content,
    required this.timeStamp,
    required this.onPressed,
  });

  final String title;
  final String content;
  final DateTime timeStamp;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DefaultListTile(
      position: ItemPosition.mid,
      onPressed: onPressed,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StyledText(
              title,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          4.hBox,
          StyledText(timeStamp.timeString(context).toLowerCase()),
        ],
      ),
      subtitle: StyledText(
        content,
        fontSize: 14,
        color: Theme.of(context).hintColor,
      ),
    );
  }
}
