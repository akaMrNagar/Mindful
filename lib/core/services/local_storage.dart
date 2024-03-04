import 'dart:convert';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/models/app_focus_info.dart';
import 'package:mindful/models/bedtime_schedule_info.dart';
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
  void saveAppFocusInfos(Map<String, AppFocusInfo> appsFocus) async {
    String jsonString = jsonEncode(appsFocus);
    await _prefs.setString(Constants.prefAppFocusInfos, jsonString);
  }

  /// Fetch saved app timers from shared prefs
  Map<String, AppFocusInfo> loadAppFocusInfos() {
    String jsonString = _prefs.getString(Constants.prefAppFocusInfos) ?? "";

    if (jsonString.isNotEmpty) {
      final dynamicMap = Map<String, dynamic>.from(jsonDecode(jsonString));
      return dynamicMap.map(
        (key, value) => MapEntry(key, AppFocusInfo.fromJson(value)),
      );
    }

    return {};
  }

  /// Save bedtime info to shared prefs
  void saveBedtimeInfo(BedtimeScheduleInfo info) async {
    String jsonString = jsonEncode(info.toJson());
    await _prefs.setString(Constants.prefBedtimeInfo, jsonString);
  }

  /// Load bedtime info from shared prefs
  BedtimeScheduleInfo loadBedtimeInfo() {
    _prefs.remove(Constants.prefBedtimeInfo);
    String jsonString = _prefs.getString(Constants.prefBedtimeInfo) ?? "";

    return jsonString.isNotEmpty
        ? BedtimeScheduleInfo.fromJson(jsonDecode(jsonString))
        : const BedtimeScheduleInfo();
  }
}
