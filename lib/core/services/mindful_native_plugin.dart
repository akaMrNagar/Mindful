import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindful/models/android_app.dart';

/// This class handle flutter method channel and responsible for invoking native android java code
class MindfulNativePlugin {
  static final MindfulNativePlugin instance = MindfulNativePlugin._();

  /// Package of the app whose Time Limit Exceeded dialog is clicked.
  /// This is forwarded by the tracking service to open the app's dashboard screen directly.
  String targetedAppPackage = "";
  MindfulNativePlugin._() {
    /// Handle calls from native side
    _methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'openAppDashboard') targetedAppPackage = call.arguments;
    });
  }

  final MethodChannel _methodChannel =
      const MethodChannel('com.akamrnagar.mindful');

  /// Get the documents directory path of the app
  Future<String> getAppDirectoryPath() async =>
      await _methodChannel.invokeMethod('getAppDirectoryPath');

  /// Restart the apps tracking service.
  /// Should be called when the app timers changes
  Future<bool> restartTrackingService() async =>
      await _methodChannel.invokeMethod('restartService');

  /// Generates a list of [AndroidApp] all the launchable apps
  /// installed on the user device including their usage
  /// like screen time, wifi usage, mobile usage for current week per day.
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
                    'MindfulNativePlugin.getDeviceApps() : Unable to add the following app: $entry');
              } else {
                debugPrint('MindfulNativePlugin.getDeviceApps() : $e $trace');
              }
            }
          }
        }
        return list;
      } else {
        return List<AndroidApp>.empty();
      }
    } catch (e) {
      debugPrint("MindfulNativePlugin.getDeviceApps() Error: $e");
      return List<AndroidApp>.empty();
    }
  }
}
