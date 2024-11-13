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
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/tables/invincible_mode_table.dart';
import 'package:mindful/core/services/drift_db_service.dart';

/// A Riverpod state notifier provider that manages [InvincibleMode] settings.
final invincibleModeProvider =
    StateNotifierProvider<InvincibleModeNotifier, InvincibleMode>(
  (ref) => InvincibleModeNotifier(),
);

/// This class manages the state of invincible mode settings.
class InvincibleModeNotifier extends StateNotifier<InvincibleMode> {
  InvincibleModeNotifier()
      : super(InvincibleModeTable.defaultInvincibleModeModel) {
    _init();
  }

  /// Initializes the settings state by loading from the database and setting up a listener for saving changes.
  void _init() async {
    final dao = DriftDbService.instance.driftDb.uniqueRecordsDao;
    state = await dao.loadInvincibleModeSettings();

    /// Listen to provider and save changes to Isar database
    addListener(
      fireImmediately: false,
      (state) => dao.saveInvincibleModeSettings(state),
    );
  }

  void switchInvincibleMode() =>
      state = state.copyWith(isInvincibleModeOn: !state.isInvincibleModeOn);

  void toggleIncludeAppsTimer() =>
      state = state.copyWith(includeAppsTimer: !state.includeAppsTimer);

  void toggleIncludeAppsLaunchLimit() => state =
      state.copyWith(includeAppsLaunchLimit: !state.includeAppsLaunchLimit);

  void toggleIncludeGroupsTimer() =>
      state = state.copyWith(includeGroupsTimer: !state.includeGroupsTimer);

  void toggleIncludeShortsTimer() =>
      state = state.copyWith(includeShortsTimer: !state.includeShortsTimer);

  void toggleIncludeBedtimeSchedule() => state =
      state.copyWith(includeBedtimeSchedule: !state.includeBedtimeSchedule);
}
