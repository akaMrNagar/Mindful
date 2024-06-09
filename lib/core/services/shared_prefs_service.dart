import 'dart:convert';

import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/models/isar/bedtime_settings.dart';
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

  Future<void> updateBlockedApps(List<String> apps) =>
      _prefs.setString(AppConstants.prefKeyBlockedApps, jsonEncode(apps));

  Future<void> updateBlockedSites(List<String> websites) =>
      _prefs.setString(AppConstants.prefKeyBlockedSites, jsonEncode(websites));

  Future<void> updateBedtimeSettings(BedtimeSettings settings) => _prefs
      .setString(AppConstants.prefKeyBedtimeSettings, jsonEncode(settings));

  Future<void> updateNsfwBlockingStatus(bool isBlockingNsfw) =>
      _prefs.setBool(AppConstants.prefKeyNsfwBlockingStatus, isBlockingNsfw);
}
