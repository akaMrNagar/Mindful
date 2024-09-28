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
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/app_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A Riverpod state notifier provider that manages global application settings.
final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>(
  (ref) => SettingsNotifier(),
);

/// This class manages the state of global application settings.
class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(const AppSettings()) {
    _init();
  }

  /// Initializes the settings state by loading from the database and setting up a listener for saving changes.
  void _init() async {
    state = await IsarDbService.instance.loadAppSettings();

    /// Listen to provider and save changes to Isar database
    addListener((state) async {
      await IsarDbService.instance.saveAppSettings(state);
    });
  }

  /// Toggles the Invincible Mode setting.
  void switchInvincibleMode() =>
      state = state.copyWith(isInvincibleModeOn: !state.isInvincibleModeOn);

  /// Changes the application's theme mode.
  void changeThemeMode(ThemeMode mode) =>
      state = state.copyWith(themeMode: mode);

  /// Changes the application's color theme.
  void changeColor(String color) => state = state.copyWith(color: color);

  /// Changes the username for dashboard.
  void changeUsername(String username) =>
      state = state.copyWith(username: username);

  /// Changes the time of day when app usage data is reset.
  /// Also updates the native side with the new reset time.
  void changeDataResetTime(TimeOfDay time) async {
    state = state.copyWith(dataResetTimeMins: time.minutes);
    await MethodChannelService.instance
        .setDataResetTime(state.dataResetTimeMins);
  }

  /// Changes app locale if it is supported.
  void changeLocale(String localeCode) async {
    if (AppLocalizations.supportedLocales.any(
      (e) => e.languageCode == localeCode,
    )) {
      /// Update native side
      await MethodChannelService.instance
          .updateLocale(languageCode: localeCode);

      /// Update state
      state = state.copyWith(localeCode: localeCode);
    }
  }

  /// Changes navigation bar from side to bottom
  void switchBottomNavigation() =>
      state = state.copyWith(bottomNavigation: !state.bottomNavigation);
}
