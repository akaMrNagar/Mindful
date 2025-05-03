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
import 'package:mindful/core/database/app_database.dart' as db;
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_slide_to_remove.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.leading,
    this.color,
    this.onDismissed,
    required this.notification,
    required this.position,
  });

  final Widget? leading;
  final db.Notification notification;
  final ItemPosition position;
  final Color? color;
  final void Function(db.Notification notification)? onDismissed;

  void _onPressed() async =>
      MethodChannelService.instance.openAppWithNotificationThread(notification);

  @override
  Widget build(BuildContext context) {
    final isFromLast24Hours =
        notification.timeStamp.isAfter(DateTime.now().last24Hours.start);

    return DefaultSlideToRemove(
      enabled: onDismissed != null,
      key: Key("${notification.key}:${notification.id}"),
      position: position,
      onDismiss: () => onDismissed?.call(notification),
      child: RoundedContainer(
        onPressed: _onPressed,
        circularRadius: 0,
        color: color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultListTile(
              position: ItemPosition.fit,
              margin: const EdgeInsets.all(0),
              leading: leading,
              color: Colors.transparent,
              title: StyledText(
                notification.title,
                fontSize: 16,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: StyledText(
                notification.timeStamp.timeString(context),
                fontWeight: FontWeight.w600,
              ),
              subtitle: Row(
                children: [
                  /// Today's notification indicator
                  if (!notification.isRead && isFromLast24Hours)
                    RoundedContainer(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.only(right: 6),
                      color: Theme.of(context).colorScheme.primary,
                    ),

                  StyledText(
                    notification.timeStamp.dateString(context),
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),

            /// Conversation
            Padding(
              padding: const EdgeInsets.all(12).copyWith(top: 0),
              child: StyledText(
                notification.content,
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
