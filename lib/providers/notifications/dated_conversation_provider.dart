/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart' as m;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/providers/notifications/dated_notifications_provider.dart';

final datedConversationProvider = StateNotifierProvider.family<
    GroupedNotificationsNotifier,
    AsyncValue<Map<String, List<Notification>>>,
    m.DateTimeRange>(
  (ref, range) => GroupedNotificationsNotifier(
    ref.watch(datedNotificationsProvider(range)).value ?? [],
  ),
);

class GroupedNotificationsNotifier
    extends StateNotifier<AsyncValue<Map<String, List<Notification>>>> {
  final List<Notification> notifications;

  GroupedNotificationsNotifier(this.notifications)
      : super(const AsyncLoading()) {
    _init();
  }

  /// Fetches and updates the state with the latest list of pending notifications.
  Future<bool> _init() async {
    final Map<String, List<Notification>> mapByPackages = {};

    /// Group by package
    for (var notification in notifications) {
      mapByPackages
          .putIfAbsent(notification.packageName, () => [])
          .add(notification);
    }

    /// sort notifications for each package.
    mapByPackages.forEach((packageName, packageNotifications) {
      mapByPackages[packageName] =
          _groupAndSortNotifications(packageNotifications);
    });

    /// Sort packages by the most recent notification timestamp.
    final sortedEntries = mapByPackages.entries.toList()
      ..sort(
          (a, b) => b.value.first.timeStamp.compareTo(a.value.first.timeStamp));

    /// update state
    state = AsyncData(Map.fromEntries(sortedEntries));
    return true;
  }

  /// Groups and sorts notifications within a package.
  List<Notification> _groupAndSortNotifications(
    List<Notification> notifications,
  ) {
    /// Merge notifications if they belongs to same conversation
    final Map<String, Notification> grouped = {};

    for (var notification in notifications) {
      grouped.update(
        notification.title,
        (existing) => existing.copyWith(
          content: '${notification.content}\n${existing.content}',
        ),
        ifAbsent: () => notification,
      );
    }

    notifications = grouped.values.toList();

    /// Sort by timestamp (newest first).
    notifications.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
    return notifications;
  }
}
