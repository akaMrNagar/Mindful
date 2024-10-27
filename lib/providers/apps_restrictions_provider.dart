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
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/database/tables/app_restriction_table.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';

/// A Riverpod state notifier provider that manages focus settings for individual apps, including timers and internet access.
final appsRestrictionsProvider = StateNotifierProvider<AppsRestrictionsNotifier,
    Map<String, AppRestriction>>(
  (ref) => AppsRestrictionsNotifier(),
);

class AppsRestrictionsNotifier
    extends StateNotifier<Map<String, AppRestriction>> {
  late DynamicRecordsDao _dao;

  AppsRestrictionsNotifier() : super({}) {
    _init();
  }

  /// Initializes the infos state by loading data from the Isar database and setting up a listener to save changes back.
  void _init() async {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;

    final items = await _dao.fetchAppsRestrictions();
    state = Map.fromEntries(items.map((e) => MapEntry(e.appPackage, e)));

    addListener(
      (newState) async {
        /// Save changes to the database whenever the state updates.
        // await IsarDbService.instance.saveRestrictionInfos(state.values.toList());
      },
      fireImmediately: false,
    );
  }

  /// Updates the focus timer for a specific app package.
  ///
  /// Anyway updated the platform-specific service.
  Future<void> updateAppTimer(String appPackage, int timerSec) async {
    final restriction = state[appPackage]?.copyWith(timerSec: timerSec) ??
        AppRestrictionTable.defaultAppRestrictionModel.copyWith(
          appPackage: appPackage,
          timerSec: timerSec,
        );

    /// Update database and state
    _updateState(appPackage, restriction);
    await _dao.insertAppRestrictionByPackage(restriction);
    _updateTrackerService();
  }

  /// Updates the launch limit for a specific app package.
  ///
  /// Anyway updated the platform-specific service.
  Future<void> updateAppLaunchLimit(String appPackage, int launchLimit) async {
    final restriction = state[appPackage]?.copyWith(launchLimit: launchLimit) ??
        AppRestrictionTable.defaultAppRestrictionModel.copyWith(
          appPackage: appPackage,
          launchLimit: launchLimit,
        );

    /// Update database and state
    _updateState(appPackage, restriction);
    await _dao.insertAppRestrictionByPackage(restriction);
    _updateTrackerService();
  }

  /// Updates the launch limit for a specific app package.
  ///
  /// Anyway updated the platform-specific service.
  Future<void> updateAppSessionAndCooldownTime(
    String appPackage,
    int sessionTimeSec,
    int coolDownTimeSec,
  ) async {
    final restriction = state[appPackage]?.copyWith(
          sessionTimeSec: sessionTimeSec,
          sessionCoolDownTimeSec: coolDownTimeSec,
        ) ??
        AppRestrictionTable.defaultAppRestrictionModel.copyWith(
          appPackage: appPackage,
          sessionTimeSec: sessionTimeSec,
          sessionCoolDownTimeSec: coolDownTimeSec,
        );

    /// Update database and state
    _updateState(appPackage, restriction);
    await _dao.insertAppRestrictionByPackage(restriction);
    _updateTrackerService();
  }

  /// Toggles internet access permission for a specific app package if package is not empty.
  ///
  /// Anyway call the platform channel service to potentially start or stop a VPN.
  void switchInternetAccess(String appPackage, bool canAccessInternet) async {
    final restriction =
        state[appPackage]?.copyWith(canAccessInternet: canAccessInternet) ??
            AppRestrictionTable.defaultAppRestrictionModel.copyWith(
              appPackage: appPackage,
              canAccessInternet: canAccessInternet,
            );

    /// Update database and state
    _updateState(appPackage, restriction);
    await _dao.insertAppRestrictionByPackage(restriction);
    _updateVpnService();
  }

  /// Updates the id of associated [RestrictionGroup] for a specific app package.
  void updateAssociatedGroupId({
    required List<String> appPackages,
    required int groupId,
    List<String> oldAppPackages = const [],
  }) async {
    List<AppRestriction> updatedRestrictions = [];
    Map<String, AppRestriction> updatedState = {...state};

    for (var appPackage in appPackages) {
      final restriction =
          state[appPackage]?.copyWith(associatedGroupId: const Value(null)) ??
              AppRestrictionTable.defaultAppRestrictionModel.copyWith(
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

    for (var appPackage in appPackages) {
      final restriction =
          state[appPackage]?.copyWith(associatedGroupId: Value(groupId)) ??
              AppRestrictionTable.defaultAppRestrictionModel.copyWith(
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

    /// Update database and state
    state = updatedState;
    await _dao.insertAppRestrictionsByPackage(updatedRestrictions);
    _updateTrackerService();
  }

  /// Restart services if they ara inactive but needed
  void checkAndRestartServices({
    required bool haveVpnPermission,
  }) {
    _updateTrackerService();
    if (haveVpnPermission) _updateVpnService();
  }

  void _updateState(String appPackage, AppRestriction restriction) =>
      state = {...state}..update(
          appPackage,
          (value) => restriction,
          ifAbsent: () => restriction,
        );

  Future<void> _updateTrackerService() async {
    final appTimers = Map.fromEntries(
      state.entries
          .where((i) => i.value.timerSec > 0)
          .map((e) => MapEntry(e.key, e.value.timerSec)),
    );

    await MethodChannelService.instance.updateAppTimers(appTimers);
  }

  Future<void> _updateVpnService() async {
    final blockedApps = state.values
        .where((e) => !e.canAccessInternet)
        .map((e) => e.appPackage)
        .toList();

    await MethodChannelService.instance.updateBlockedApps(blockedApps);
  }
}
