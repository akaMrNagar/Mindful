/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';

/// A Riverpod state notifier provider that manages list of [NotificationSchedule].
final notificationSchedulesProvider = StateNotifierProvider<
    NotificationSchedulesNotifier, Map<int, NotificationSchedule>>(
  (ref) => NotificationSchedulesNotifier(),
);

class NotificationSchedulesNotifier
    extends StateNotifier<Map<int, NotificationSchedule>> {
  late DynamicRecordsDao _dao;

  NotificationSchedulesNotifier() : super({}) {
    init();
  }

  void init() async {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    final schedules = await _dao.fetchNotificationSchedules();
    state = Map.fromEntries(schedules.map((e) => MapEntry(e.id, e)));

    if (MethodChannelService.instance.isSelfRestart) {
      // await MethodChannelService.instance
      //     .setDataResetTime(state.dataResetTime.toMinutes);
    }
  }

  void createNewSchedule(String scheduleName) async {
    final newSchedule = await _dao.insertNotificationSchedule(
      NotificationScheduleTableCompanion(
        label: Value(scheduleName),
        time: Value(TimeOfDayAdapter.now()),
        isActive: const Value(true),
      ),
    );

    _insertUpdateSortSetState(newSchedule);
  }

  void updateScheduleById(NotificationSchedule updatedSchedule) async {
    await _dao.updateNotificationSchedule(updatedSchedule);
    _insertUpdateSortSetState(updatedSchedule);
  }

  void removeScheduleById(NotificationSchedule schedule) async {
    await _dao.removeNotificationSchedule(schedule);
    state = {...state}..remove(schedule.id);
  }

  void _insertUpdateSortSetState(NotificationSchedule schedule) async {
    /// Insert or Update map
    final updatedMap = {...state}..update(
        schedule.id,
        (value) => schedule,
        ifAbsent: () => schedule,
      );

    /// Update state with sorted entries
    state = Map.fromEntries(
      updatedMap.entries.toList()
        ..sort(
          (a, b) => a.value.time.toMinutes.compareTo(b.value.time.toMinutes),
        ),
    );
  }
}
