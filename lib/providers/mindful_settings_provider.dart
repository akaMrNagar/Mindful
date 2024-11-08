/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/tables/mindful_settings_table.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A Riverpod state notifier provider that manages mindful app's settings.
final mindfulSettingsProvider =
    StateNotifierProvider<MindfulSettingsNotifier, MindfulSettings>(
  (ref) => MindfulSettingsNotifier(),
);

/// This class manages the state of mindful settings.
class MindfulSettingsNotifier extends StateNotifier<MindfulSettings> {
  MindfulSettingsNotifier()
      : super(MindfulSettingsTable.defaultMindfulSettingsModel) {
    _init();
  }

  /// Initializes the settings state by loading from the database and setting up a listener for saving changes.
  void _init() async {
    final dao = DriftDbService.instance.driftDb.uniqueRecordsDao;
    state = await dao.loadMindfulSettings();

    /// Listen to provider and save changes to Isar database
    addListener(
      fireImmediately: false,
      (state) => dao.saveMindfulSettings(state),
    );
  }

  /// Changes the application's theme mode.
  void changeThemeMode(AppThemeMode mode) =>
      state = state.copyWith(themeMode: mode);

  /// Changes the application's color theme.
  void changeColor(String color) => state = state.copyWith(accentColor: color);

  /// Changes the username for dashboard.
  void changeUsername(String username) =>
      state = state.copyWith(username: username);

  /// Changes the time of day when app usage data is reset.
  /// Also updates the native side with the new reset time.
  void changeDataResetTime(TimeOfDay time) async {
    state = state.copyWith(dataResetTimeMins: time.minutes);
    // TODO
    // await MethodChannelService.instance
    //     .setDataResetTime(state.dataResetTimeMins);
  }

  /// Changes app locale if it is supported.
  void changeLocale(String localeCode) async {
    if (AppLocalizations.supportedLocales.any(
      (e) => e.languageCode == localeCode,
    )) {
      /// Update native side
      // TODO
      // await MethodChannelService.instance
      //     .updateLocale(languageCode: localeCode);

      /// Update state
      state = state.copyWith(localeCode: localeCode);
    }
  }

  /// Changes navigation bar from side to bottom
  void switchBottomNavigation() =>
      state = state.copyWith(useBottomNavigation: !state.useBottomNavigation);

  /// Switch AMOLED dark mode
  void switchAmoledDark() =>
      state = state.copyWith(useAmoledDark: !state.useAmoledDark);
  
  /// Switch dynamic color
  void switchDynamicColor() =>
      state = state.copyWith(useDynamicColors: !state.useDynamicColors);

  /// Include or Exclude an app from total usage statistics
  void includeExcludeApp(String appPackage, bool shouldInclude) =>
      state = state.copyWith(
        excludedApps: shouldInclude
            ? [...state.excludedApps, appPackage]
            : [...state.excludedApps.where((e) => e != appPackage)],
      );
}
