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
import 'package:mindful/providers/apps/apps_info_provider.dart';

/// A Riverpod state notifier provider that manages a map of Package and [AppRestriction].
final appsRestrictionsProvider = StateNotifierProvider<AppsRestrictionsNotifier,
    Map<String, AppRestriction>>(
  (ref) => AppsRestrictionsNotifier(
    ref.watch(appsInfoProvider).value?.keys.toSet() ?? {},
  ),
);

class AppsRestrictionsNotifier
    extends StateNotifier<Map<String, AppRestriction>> {
  late DynamicRecordsDao _dao;
  final Set<String> _installedApps;

  AppsRestrictionsNotifier(this._installedApps) : super({}) {
    _init();
  }

  /// Initializes the infos state by loading data from the database.
  void _init() async {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    final items = await _dao.fetchAppsRestrictions();
    state = Map.fromEntries(items.map((e) => MapEntry(e.appPackage, e)));

    /// Update services
    _updateTrackerService();
    _updateVpnService();
  }

  /// Updates the timer for a specific app package.
  ///
  /// Anyway updated the platform-specific service.
  Future<void> updateAppTimer(String appPackage, int timerSec) async {
    final restriction = state[appPackage]?.copyWith(timerSec: timerSec) ??
        defaultAppRestrictionModel.copyWith(
          appPackage: appPackage,
          timerSec: timerSec,
        );

    /// Update database and state
    _updateStateDbAndServices(appPackage, restriction);
  }

  /// Set reminder type for a specific app package if package is not empty.
  ///
  /// Anyway call the platform channel service.
  void setReminderType(String appPackage, ReminderType reminderType) async {
    final restriction =
        state[appPackage]?.copyWith(reminderType: reminderType) ??
            defaultAppRestrictionModel.copyWith(
              appPackage: appPackage,
              reminderType: reminderType,
            );

    /// Update database and state
    _updateStateDbAndServices(appPackage, restriction);
  }

  /// Updates the launch limit for a specific app package.
  ///
  /// Anyway updated the platform-specific service.
  Future<void> updateAppLaunchLimit(String appPackage, int launchLimit) async {
    final restriction = state[appPackage]?.copyWith(launchLimit: launchLimit) ??
        defaultAppRestrictionModel.copyWith(
          appPackage: appPackage,
          launchLimit: launchLimit,
        );

    /// Update database and state
    _updateStateDbAndServices(appPackage, restriction);
  }

  /// Updates the active period time for a specific app package.
  ///
  /// Anyway updated the platform-specific service.
  Future<void> updateActivePeriod(
    String appPackage,
    TimeOfDayAdapter startTime,
    TimeOfDayAdapter endTime,
  ) async {
    final periodDuration = endTime.difference(startTime).inMinutes;

    final restriction = state[appPackage]?.copyWith(
          activePeriodStart: startTime,
          activePeriodEnd: endTime,
          periodDurationInMins: periodDuration,
        ) ??
        defaultAppRestrictionModel.copyWith(
          appPackage: appPackage,
          activePeriodStart: startTime,
          activePeriodEnd: endTime,
          periodDurationInMins: periodDuration,
        );

    /// Update database and state
    _updateStateDbAndServices(appPackage, restriction);
  }

  /// Toggles internet access permission for a specific app package if package is not empty.
  ///
  /// Anyway call the platform channel service to potentially start or stop a VPN.
  void switchInternetAccess(String appPackage, bool canAccessInternet) async {
    final restriction =
        state[appPackage]?.copyWith(canAccessInternet: canAccessInternet) ??
            defaultAppRestrictionModel.copyWith(
              appPackage: appPackage,
              canAccessInternet: canAccessInternet,
            );

    /// Update database and state
    _updateStateDbAndServices(appPackage, restriction, updateVpn: true);
  }

  /// Updates the id of associated [RestrictionGroup] for a specific app package.
  Future<void> updateAssociatedGroupId({
    required List<String> appPackages,
    bool removeIds = false,
    int? groupId,
  }) async {
    List<AppRestriction> updatedRestrictions = [];
    Map<String, AppRestriction> updatedState = {...state};

    final skippedApps = removeIds
        ? appPackages
        : state.values
            .where((e) => (e.associatedGroupId ?? -1) == groupId)
            .map((e) => e.appPackage);

    /// Remove associated group id for the removed old packages
    for (var appPackage in skippedApps) {
      final restriction =
          state[appPackage]?.copyWith(associatedGroupId: const Value(null)) ??
              defaultAppRestrictionModel.copyWith(
                appPackage: appPackage,
                associatedGroupId: const Value(null),
              );

      updatedRestrictions.add(restriction);
      updatedState.update(
        appPackage,
        (value) => restriction,
        ifAbsent: () => restriction,
      );
    }

    if (!removeIds) {
      /// Add/Update associated group id for the new packages
      for (var appPackage in appPackages) {
        final restriction =
            state[appPackage]?.copyWith(associatedGroupId: Value(groupId)) ??
                defaultAppRestrictionModel.copyWith(
                  appPackage: appPackage,
                  associatedGroupId: Value(groupId),
                );

        updatedRestrictions.add(restriction);
        updatedState.update(
          appPackage,
          (value) => restriction,
          ifAbsent: () => restriction,
        );
      }
    }

    /// Update database and state
    state = updatedState;
    await _dao.insertAppRestrictionsByPackage(updatedRestrictions);
    await _updateTrackerService();
  }

  /// Updates state and database with the provided data.
  ///
  /// Also update VPN service if flag is TRUE else update Tracker service
  void _updateStateDbAndServices(
    String appPackage,
    AppRestriction restriction, {
    bool updateVpn = false,
  }) async {
    state = {...state}..update(
        appPackage,
        (value) => restriction,
        ifAbsent: () => restriction,
      );
    await _dao.insertAppRestrictionByPackage(restriction);
    updateVpn ? _updateVpnService() : _updateTrackerService();
  }

  /// Filter restriction and remove uninstalled app packages
  ///
  /// At last update restrictions in Tracker service
  Future<void> _updateTrackerService() async {
    if (_installedApps.isEmpty) return;

    final filteredRestrictions = state.values
        .where(
          (e) =>
              _installedApps.contains(e.appPackage) &&
              (e.timerSec > 0 ||
                  e.launchLimit > 0 ||
                  e.periodDurationInMins > 0 ||
                  e.associatedGroupId != null),
        )
        .toList();

    await MethodChannelService.instance
        .updateAppRestrictions(filteredRestrictions);
  }

  /// Filter restriction and remove uninstalled app packages
  ///
  /// At last update restrictions in VPN service
  Future<void> _updateVpnService() async {
    if (_installedApps.isEmpty) return;

    final blockedApps = state.values
        .where(
          (e) => _installedApps.contains(e.appPackage) && !e.canAccessInternet,
        )
        .map((e) => e.appPackage)
        .toList();

    await MethodChannelService.instance.updateInternetBlockedApps(blockedApps);
  }
}
