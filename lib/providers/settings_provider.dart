import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/isar_db_service.dart';
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

  // void toggleThemeMode() => state = state.copyWith(
  //       isInvincibleModeOn: !state.isInvincibleModeOn,
  //     );

  void toggleThemeMode() => state = state.copyWith(
        themeMode: ThemeMode.values[(state.themeMode.index + 1) % 2],
      );
}
