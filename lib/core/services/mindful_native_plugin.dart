import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindful/models/android_app.dart';

class MindfulNativePlugin {
  static final MindfulNativePlugin instance = MindfulNativePlugin._();

  String goToApp = "";
  MindfulNativePlugin._() {
    _methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'openAppStats') goToApp = call.arguments;
    });
  }

  final MethodChannel _methodChannel =
      const MethodChannel('com.akamrnagar.mindful');

  /// Get the documents directory path of the app
  Future<String> getAppDirectoryPath() async =>
      await _methodChannel.invokeMethod('getAppDirectoryPath');

  Future<bool> restartTrackingService() async =>
      await _methodChannel.invokeMethod('restartService');

  /// Generates list of [AndroidApp] with all the usage info
  Future<List<AndroidApp>> getDeviceApps() async {
    try {
      Object result = await _methodChannel.invokeMethod('getDeviceApps');

      /// Parse
      if (result is Iterable) {
        List<AndroidApp> list = <AndroidApp>[];
        for (Object entry in result) {
          if (entry is Map) {
            try {
              list.add(AndroidApp.fromMap(entry));
            } catch (e, trace) {
              if (e is AssertionError) {
                debugPrint(
                    '[NATIVE PLUGIN] getDeviceApps() : Unable to add the following app: $entry');
              } else {
                debugPrint('[NATIVE PLUGIN] getDeviceApps() : $e $trace');
              }
            }
          }
        }
        return list;
      } else {
        return List<AndroidApp>.empty();
      }
    } catch (e) {
      debugPrint("Error: $e");
      return List<AndroidApp>.empty();
    }
  }
}
