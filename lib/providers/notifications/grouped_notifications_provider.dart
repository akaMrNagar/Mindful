/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/notification_model.dart';
import 'package:mindful/providers/notifications/upcoming_notifications_provider.dart';

/// Holds map of Package and its list of notifications
final groupedNotificationsProvider = StateNotifierProvider<
    GroupedNotificationsNotifier,
    AsyncValue<Map<String, List<NotificationModel>>>>(
  (ref) => GroupedNotificationsNotifier(
    ref.watch(upcomingNotificationsProvider).value ?? [],
  ),
);

class GroupedNotificationsNotifier
    extends StateNotifier<AsyncValue<Map<String, List<NotificationModel>>>> {
  final List<NotificationModel> notifications;

  GroupedNotificationsNotifier(this.notifications)
      : super(const AsyncLoading()) {
    _init();
  }

  /// Fetches and updates the state with the latest list of pending notifications.
  Future<bool> _init() async {
    final Map<String, List<NotificationModel>> mapByPackages = {};

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
  List<NotificationModel> _groupAndSortNotifications(
    List<NotificationModel> notifications,
  ) {
    /// Merge notifications if they belongs to same conversation
    final Map<String, NotificationModel> grouped = {};

    for (var notification in notifications) {
      grouped.update(
        notification.titleText,
        (existing) => existing.copyWith(
          timeStamp: existing.timeStamp,
          contentText: '${existing.contentText}\n${notification.contentText}',
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
