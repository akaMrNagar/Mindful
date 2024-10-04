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
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/daos/unique_records_dao.dart';
import 'package:mindful/core/database/tables/mindful_settings_table.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'mindful_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class MindfulSettingsNotifier extends _$MindfulSettingsNotifier {
  late UniqueRecordsDao _dao;

  @override
  MindfulSettings build() {
    _init();
    return MindfulSettingsTable.defaultMindfulSettingsModel;
  }

  /// Initializes the settings state by loading from the database and setting up a listener for saving changes.
  void _init() async {
    _dao = DriftDbService.instance.driftDb.uniqueRecordsDao;
    state = await _dao.loadSettings();

    /// Listen to provider and save changes to Isar database
    ref.listenSelf((prev, next) async {
      _dao.saveSettings(next);
    });
  }

  /// Toggles the Invincible Mode setting.
  void switchInvincibleMode() =>
      state = state.copyWith(isInvincibleModeOn: !state.isInvincibleModeOn);

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
    // await MethodChannelService.instance
    //     .setDataResetTime(state.dataResetTimeMins);
  }

  /// Changes app locale if it is supported.
  void changeLocale(String localeCode) async {
    if (AppLocalizations.supportedLocales.any(
      (e) => e.languageCode == localeCode,
    )) {
      /// Update native side
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
}
