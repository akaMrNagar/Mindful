import 'dart:convert';

import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/models/isar/bedtime_settings.dart';
import 'package:mindful/models/isar/wellbeing_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePrefsService {
  static final SharePrefsService instance = SharePrefsService._();
  SharePrefsService._();

  /// Prefs instance
  late SharedPreferences _prefs;

  /// Method to initialize shared prefrences service.
  /// It should be called in main method
  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  /// Updates timers map stored in shared prefrences.
  Future<void> updateAppTimers(Map<String, int> appTimers) =>
      _prefs.setString(AppConstants.prefKeyAppTimers, jsonEncode(appTimers));

  Future<void> updateBlockedApps(List<String> blockedApps) => _prefs.setString(
      AppConstants.prefKeyBlockedApps, jsonEncode(blockedApps));

  Future<void> updateBedtimeSettings(BedtimeSettings settings) => _prefs
      .setString(AppConstants.prefKeyBedtimeSettings, jsonEncode(settings));

  Future<void> updateWellBeingSettings(WellBeingSettings settings) => _prefs
      .setString(AppConstants.prefKeyWellbeingSettings, jsonEncode(settings));
}
