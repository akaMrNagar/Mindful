import 'dart:convert';

import 'package:mindful/core/utils/constants.dart';
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
  /// This update will trigger timer refresh in [AppsTrackerService]
  void updateAppTimers(Map<String, int> appTimers) =>
      _prefs.setString(AppConstants.prefKeyAppTimers, jsonEncode(appTimers));

  // void toggleAppTrackingStatus(bool isAppTrackingOn) =>
  //     _prefs.setBool(AppConstants.prefKeyAppTrackingStatus, isAppTrackingOn);

  void toggleNsfwBlockingStatus(bool isBlockingNsfw) =>
      _prefs.setBool(AppConstants.prefKeyNsfwBlockingStatus, isBlockingNsfw);
}
