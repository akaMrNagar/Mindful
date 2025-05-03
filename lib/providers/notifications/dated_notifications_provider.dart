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
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/services/drift_db_service.dart';

final datedNotificationsProvider = StateNotifierProvider.family<
    NotificationsNotifier, AsyncValue<List<Notification>>, m.DateTimeRange>(
  (ref, range) => NotificationsNotifier(range),
);

class NotificationsNotifier
    extends StateNotifier<AsyncValue<List<Notification>>> {
  late final DynamicRecordsDao _dao;
  final m.DateTimeRange range;

  NotificationsNotifier(this.range) : super(const AsyncLoading()) {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    refreshNotifications();
  }

  /// Fetches and updates the state with the latest list of notifications in the provided range.
  Future<bool> refreshNotifications() async {
    var notifications =
        await _dao.fetchAllNotificationsForInterval(range: range);

    /// update state
    state = AsyncData(notifications);
    return true;
  }

  Future<void> markNotificationsAsRead() async {
    if (state.value == null) return;

    /// Update
    final ids = state.value!.map((e) => e.id).toList();
    await _dao.markNotificationsAsRead(ids);
    state = AsyncData(
      state.value!.map((e) => e.copyWith(isRead: true)).toList(),
    );
  }

  Future<void> deleteNotification(Notification notification) async {
    final deleted = await _dao.deleteNotificationWithId(notification.id);
    if (deleted > 0) {
      state = AsyncData(
        [...(state.value ?? []).where((e) => e.id != notification.id)],
      );
    }
  }
}
