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
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/notification_model.dart';

/// Holds map of Package and its list of notifications
final upcomingNotificationsProvider = StateNotifierProvider<DeviceAppsList,
    AsyncValue<Map<String, List<NotificationModel>>>>(
  (ref) => DeviceAppsList(),
);

class DeviceAppsList
    extends StateNotifier<AsyncValue<Map<String, List<NotificationModel>>>> {
  DeviceAppsList() : super(const AsyncLoading()) {
    refreshNotifications();
  }

  /// Fetches and updates the state with the latest list of pending notifications.
  ///
  Future<bool> refreshNotifications() async {
    Map<String, List<NotificationModel>> mapByPackages = {};

    final notifications =
        await MethodChannelService.instance.getUpComingNotifications();

    for (var notification in notifications) {
      /// Get the list of notifications for the package if null then create one
      List<NotificationModel> packageNotifications =
          mapByPackages[notification.packageName] ?? [];

      /// Add current notification to the package notifications
      packageNotifications.add(notification);

      /// update the map
      mapByPackages.update(
        notification.packageName,
        (value) => packageNotifications,
        ifAbsent: () => packageNotifications,
      );
    }

    /// update state
    state = AsyncData(mapByPackages);
    return true;
  }
}
