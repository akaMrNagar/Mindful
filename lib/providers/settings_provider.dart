import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_time_of_day.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/app_settings.dart';

/// A Riverpod state notifier provider that manages global application settings.
final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});

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

  /// Changes the time of day when app usage data is reset.
  /// Also updates the native side with the new reset time.
  void changeDataResetTime(TimeOfDay time) async {
    state = state.copyWith(dataResetTimeMins: time.minutes);
    await MethodChannelService.instance.setDataResetTime(state.dataResetTimeMins);
  }
}
