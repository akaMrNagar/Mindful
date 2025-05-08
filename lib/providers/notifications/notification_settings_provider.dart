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
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/daos/unique_records_dao.dart';
import 'package:mindful/core/enums/recap_type.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/default_models_utils.dart';
import 'package:mindful/models/notification_schedule.dart';

/// A Riverpod state notifier provider that manages [NotificationSettings] related settings.
final notificationSettingsProvider =
    StateNotifierProvider<NotificationSettingsNotifier, NotificationSettings>(
  (ref) => NotificationSettingsNotifier(),
);

/// This class manages the state of [NotificationConfig]settings.
class NotificationSettingsNotifier extends StateNotifier<NotificationSettings> {
  late UniqueRecordsDao _dao;

  NotificationSettingsNotifier() : super(defaultNotificationSettingsModel) {
    _init();
  }

  /// Initializes the well-being settings by loading them from the database and setting up a listener to save changes.
  void _init() async {
    _dao = DriftDbService.instance.driftDb.uniqueRecordsDao;
    state = await _dao.loadNotificationSettings();
    await MethodChannelService.instance.updateNotificationSettings(state);

    /// Listen to provider and save changes to Isar database and platform service
    addListener(
      fireImmediately: false,
      (state) {
        _dao.saveNotificationSettings(state);
        MethodChannelService.instance.updateNotificationSettings(state);
      },
    );
  }

  /// Set recap type
  void setRecapType(RecapType recap) =>
      state = state.copyWith(recapType: recap);

  /// Toggle store all notifications
  void toggleStoreNonBatched() =>
      state = state.copyWith(storeNonBatchedToo: !state.storeNonBatchedToo);

  /// Changes the default notification history weeks.
  void changeNotificationHistoryWeeks(int weeks) =>
      state = state.copyWith(notificationHistoryWeeks: weeks);

  /// Batch or UnBatch app from notification schedule
  void batchUnBatchApp(String appPackage, bool shouldBatch) async =>
      state = state.copyWith(
        batchedApps: shouldBatch
            ? [...state.batchedApps, appPackage]
            : [...state.batchedApps.where((e) => e != appPackage)],
      );

  Future<void> createNewSchedule(
    String scheduleName, [
    TimeOfDayAdapter? time,
    bool? isActive,
  ]) async {
    final newSchedule = NotificationSchedule(
      label: scheduleName,
      time: time ?? TimeOfDayAdapter.now(),
      isActive: isActive ?? false,
    );

    /// Update state
    state = state.copyWith(
      schedules: state.schedules.toList()
        ..add(newSchedule)
        ..sort((a, b) => a.time.compareTo(b.time)),
    );
  }

  Future<void> updateSchedule(
    NotificationSchedule updatedSchedule,
    int index,
  ) async =>
      state = state.copyWith(
        schedules: state.schedules.toList()
          ..removeAt(index)
          ..add(updatedSchedule)
          ..sort((a, b) => a.time.compareTo(b.time)),
      );

  Future<void> removeSchedule(int index) async => state = state.copyWith(
        schedules: state.schedules
          ..removeAt(index)
          ..sort((a, b) => a.time.compareTo(b.time)),
      );
}
