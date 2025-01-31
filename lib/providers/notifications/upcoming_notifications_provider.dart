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

/// Holds list of sorted notifications
final upcomingNotificationsProvider = StateNotifierProvider<
    NotificationsNotifier, AsyncValue<List<NotificationModel>>>(
  (ref) => NotificationsNotifier(),
);

class NotificationsNotifier
    extends StateNotifier<AsyncValue<List<NotificationModel>>> {
  NotificationsNotifier() : super(const AsyncLoading()) {
    refreshNotifications();
  }

  /// Fetches and updates the state with the latest list of pending notifications.
  Future<bool> refreshNotifications() async {
    var notifications =
        await MethodChannelService.instance.getUpComingNotifications();
    notifications.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));

    /// update state
    state = AsyncData(notifications);
    return true;
  }
}
