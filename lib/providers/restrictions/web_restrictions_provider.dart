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
import 'package:mindful/core/enums/reminder_type.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/default_models_utils.dart';

/// A Riverpod state notifier provider that manages a map of Package and [WebRestriction].
final webRestrictionsProvider = StateNotifierProvider<WebRestrictionsNotifier,
    Map<String, WebRestriction>>(
  (ref) => WebRestrictionsNotifier(),
);

class WebRestrictionsNotifier
    extends StateNotifier<Map<String, WebRestriction>> {
  late DynamicRecordsDao _dao;

  WebRestrictionsNotifier() : super({}) {
    _init();
  }

  /// Initializes the infos state by loading data from the database.
  void _init() async {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    final items = await _dao.fetchWebRestrictions();
    state = Map.fromEntries(items.map((e) => MapEntry(e.host, e)));
  }

  /// add a specific website
  ///
  /// Anyway updated the platform-specific service.
  Future<void> addWebsite(String host, bool isNsfw) async {
    final restriction = state[host]?.copyWith(isNsfw: isNsfw) ??
        defaultWebRestrictionModel.copyWith(
          host: host,
          isNsfw: isNsfw
        );

    /// Update database and state
    _updateStateDbAndServices(host, restriction);
  }

  /// Updates the timer for a specific website
  ///
  /// Anyway updated the platform-specific service.
  Future<void> updateWebTimer(String host, int timerSec) async {
    final restriction = state[host]?.copyWith(timerSec: timerSec) ??
        defaultWebRestrictionModel.copyWith(
          host: host,
          timerSec: timerSec,
        );

    /// Update database and state
    _updateStateDbAndServices(host, restriction);
  }

  /// removes a website host.
  void removeHost(String host) async => state.remove(host);

  /// Set reminder type for a specific host.
  ///
  /// Anyway call the platform channel service.
  void setReminderType(String host, ReminderType reminderType) async {
    final restriction =
        state[host]?.copyWith(reminderType: reminderType) ??
            defaultWebRestrictionModel.copyWith(
              host: host,
              reminderType: reminderType,
            );

    /// Update database and state
    _updateStateDbAndServices(host, restriction);
  }

  /// Updates the launch limit for a specific host.
  ///
  /// Anyway updated the platform-specific service.
  Future<void> updateWebLaunchLimit(String host, int launchLimit) async {
    final restriction = state[host]?.copyWith(launchLimit: launchLimit) ??
        defaultWebRestrictionModel.copyWith(
          host: host,
          launchLimit: launchLimit,
        );

    /// Update database and state
    _updateStateDbAndServices(host, restriction);
  }

  /// Updates the active period time for a specific host.
  ///
  /// Anyway updated the platform-specific service.
  Future<void> updateActivePeriod(
    String host,
    TimeOfDayAdapter startTime,
    TimeOfDayAdapter endTime,
  ) async {
    final periodDuration = endTime.difference(startTime).inMinutes;

    final restriction = state[host]?.copyWith(
          activePeriodStart: startTime,
          activePeriodEnd: endTime,
          periodDurationInMins: periodDuration,
        ) ??
        defaultWebRestrictionModel.copyWith(
          host: host,
          activePeriodStart: startTime,
          activePeriodEnd: endTime,
          periodDurationInMins: periodDuration,
        );

    /// Update database and state
    _updateStateDbAndServices(host, restriction);
  }

  /// Toggles isNsfw for a specific host.
  ///
  /// Anyway call the platform channel service.
  void switchIsNsfw(String host, bool isNsfw) async {
    final restriction =
        state[host]?.copyWith(isNsfw: isNsfw) ??
            defaultWebRestrictionModel.copyWith(
              host: host,
              isNsfw: isNsfw,
            );

    /// Update database and state
    _updateStateDbAndServices(host, restriction);
  }

  /// Updates the id of associated [RestrictionGroup] for a specific host.
  Future<void> updateAssociatedGroupId({
    required List<String> hosts,
    bool removeIds = false,
    int? groupId,
  }) async {
    List<WebRestriction> updatedRestrictions = [];
    Map<String, WebRestriction> updatedState = {...state};

    final skippedApps = removeIds
        ? hosts
        : state.values
            .where((e) => (e.associatedGroupId ?? -1) == groupId)
            .map((e) => e.host);

    /// Remove associated group id for the removed old packages
    for (var host in skippedApps) {
      final restriction =
          state[host]?.copyWith(associatedGroupId: const Value(null)) ??
              defaultWebRestrictionModel.copyWith(
                host: host,
                associatedGroupId: const Value(null),
              );

      updatedRestrictions.add(restriction);
      updatedState.update(
        host,
        (value) => restriction,
        ifAbsent: () => restriction,
      );
    }

    if (!removeIds) {
      /// Add/Update associated group id for the new packages
      for (var host in hosts) {
        final restriction =
            state[host]?.copyWith(associatedGroupId: Value(groupId)) ??
                defaultWebRestrictionModel.copyWith(
                  host: host,
                  associatedGroupId: Value(groupId),
                );

        updatedRestrictions.add(restriction);
        updatedState.update(
          host,
          (value) => restriction,
          ifAbsent: () => restriction,
        );
      }
    }

    /// Update database and state
    state = updatedState;
    await _dao.insertWebRestrictionsByHost(updatedRestrictions);
  }

  /// Updates state and database with the provided data.
  ///
  ///
  void _updateStateDbAndServices(
    String host,
    WebRestriction restriction
  ) async {
    state = {...state}..update(
        host,
        (value) => restriction,
        ifAbsent: () => restriction,
      );
    await _dao.insertWebRestrictionByHost(restriction);
    await MethodChannelService.instance.updateWebRestrictions(state.values.toList());
  }
}
