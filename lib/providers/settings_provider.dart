import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/shared_prefs_service.dart';
import 'package:mindful/models/isar/app_settings.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(const AppSettings()) {
    _init();
  }

  void _init() async {
    state = await IsarDbService.instance.loadAppSettings();

    /// Listen to provider and save changes to isar database
    addListener((state) async {
      await IsarDbService.instance.saveAppSettings(state);
    });
  }

  void switchInvincibleMode() =>
      state = state.copyWith(isInvincibleModeOn: !state.isInvincibleModeOn);

  void changeThemeMode(ThemeMode mode) =>
      state = state.copyWith(themeMode: mode);

  void changeColor(String color) => state = state.copyWith(color: color);

  Future<void> backupDatabase(String filePath) async =>
      IsarDbService.instance.backupToFile(filePath);

  Future<void> restoreDatabase(PlatformFile file) async =>
      IsarDbService.instance.restoreFromFile(file);

  Future<void> resetDatabase() async {
    /// Clear isar db
    await IsarDbService.instance.resetDb();

    /// Clear sharef pref
    await SharePrefsService.instance.resetPrefs();
  }
}
