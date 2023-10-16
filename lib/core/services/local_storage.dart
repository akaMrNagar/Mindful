import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._();
  late SharedPreferences _prefs;

  LocalStorage._();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveAppTimers(Map<String, int> appTimers) async {
    String jsonString = jsonEncode(appTimers);
    await _prefs.setString("AppsTimer", jsonString);
  }

  Future<Map<String, int>> loadAppTimers() async {
    String jsonString = _prefs.getString("AppsTimer") ?? "";

    try {
      final map = Map<String, int>.from(jsonDecode(jsonString));
      return map;
      // ignore: empty_catches
    } catch (e) {}

    return {};
  }
}
