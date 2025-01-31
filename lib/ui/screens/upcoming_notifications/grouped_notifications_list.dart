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
import 'package:mindful/providers/notifications/grouped_notifications_provider.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/screens/upcoming_notifications/grouped_notifications_tile.dart';

class GroupedNotificationsList extends ConsumerWidget {
  const GroupedNotificationsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationMap = ref.watch(groupedNotificationsProvider);

    /// {App Package : List of notifications}
    final notificationsByApp = notificationMap.value?.entries.toList() ?? [];

    return SliverImplicitlyAnimatedList(
      items: notificationsByApp,
      keyBuilder: (entry) => entry.key,
      itemBuilder: (context, entry, position) => AppsNotificationsTile(
        packageName: entry.key,
        notifications: entry.value,
        position: position,
      ),
    );
  }
}
