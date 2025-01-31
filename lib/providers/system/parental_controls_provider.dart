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
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/utils/default_models_utils.dart';

/// A Riverpod state notifier provider that manages [ParentalControls]
final parentalControlsProvider =
    StateNotifierProvider<ParentalControlsNotifier, ParentalControls>(
  (ref) => ParentalControlsNotifier(),
);

class ParentalControlsNotifier extends StateNotifier<ParentalControls> {
  ParentalControlsNotifier() : super(defaultParentalControlsModel) {
    init();
  }

  /// Initializes the settings state by loading from the database and setting up a listener for saving changes.
  Future<ParentalControls> init() async {
    final dao = DriftDbService.instance.driftDb.uniqueRecordsDao;
    state = await dao.loadParentalControls();

    /// Listen to provider and save changes to Isar database
    addListener(
      fireImmediately: false,
      (state) => dao.saveParentalControls(state),
    );

    return state;
  }

  /// Switch protected access
  void switchProtectedAccess() =>
      state = state.copyWith(protectedAccess: !state.protectedAccess);

  /// Changes the time of day when uninstall widow starts for 5 minutes.
  void changeUninstallWindowTime(TimeOfDayAdapter time) =>
      state = state.copyWith(uninstallWindowTime: time);

  void switchInvincibleMode() =>
      state = state.copyWith(isInvincibleModeOn: !state.isInvincibleModeOn);

  void toggleIncludeAppsTimer() =>
      state = state.copyWith(includeAppsTimer: !state.includeAppsTimer);

  void toggleIncludeAppsLaunchLimit() => state =
      state.copyWith(includeAppsLaunchLimit: !state.includeAppsLaunchLimit);

  void toggleIncludeAppsActivePeriod() => state =
      state.copyWith(includeAppsActivePeriod: !state.includeAppsActivePeriod);

  void toggleIncludeGroupsTimer() =>
      state = state.copyWith(includeGroupsTimer: !state.includeGroupsTimer);

  void toggleIncludeGroupsActivePeriod() => state = state.copyWith(
      includeGroupsActivePeriod: !state.includeGroupsActivePeriod);

  void toggleIncludeShortsTimer() =>
      state = state.copyWith(includeShortsTimer: !state.includeShortsTimer);

  void toggleIncludeBedtimeSchedule() => state =
      state.copyWith(includeBedtimeSchedule: !state.includeBedtimeSchedule);
}
