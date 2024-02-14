import 'dart:convert';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/models/bedtime_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Responsible for managing application data in SharedPreferences.
class LocalStorage {
  static final LocalStorage instance = LocalStorage._();
  late SharedPreferences _prefs;

  LocalStorage._();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save app timers map as json string to shared prefs
  void saveAppTimers(Map<String, int> appTimers) async {
    String jsonString = jsonEncode(appTimers);
    await _prefs.setString(Constants.prefAppTimersMap, jsonString);
  }

  /// Fetch saved app timers from shared prefs
  Map<String, int> loadAppTimers() {
    String jsonString = _prefs.getString(Constants.prefAppTimersMap) ?? "";

    if (jsonString.isNotEmpty) {
      final map = Map<String, int>.from(jsonDecode(jsonString));
      return map;
    }

    return {};
  }

  /// Save bedtime info to shared prefs
  void saveBedtimeInfo(BedtimeInfo info) async {
    String jsonString = jsonEncode(info.toJson());
    await _prefs.setString(Constants.prefBedtimeInfo, jsonString);
  }

  /// Load bedtime info from shared prefs
  BedtimeInfo loadBedtimeInfo() {
    _prefs.remove(Constants.prefBedtimeInfo);
    String jsonString = _prefs.getString(Constants.prefBedtimeInfo) ?? "";

    return jsonString.isNotEmpty
        ? BedtimeInfo.fromJson(jsonDecode(jsonString))
        : const BedtimeInfo();
  }
}
