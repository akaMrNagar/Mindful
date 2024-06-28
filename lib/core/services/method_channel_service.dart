import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindful/core/enums/toast_duration.dart';
import 'package:mindful/models/android_app.dart';

/// This class handle flutter method channel and responsible for invoking native android java code
class MethodChannelService {
  static final MethodChannelService instance = MethodChannelService._();
  final MethodChannel _methodChannel =
      const MethodChannel('com.akamrnagar.mindful.methodchannel');

  /// Package of the app whose Time Limit Exceeded dialog is clicked.
  /// This is forwarded by the tracking service to open the app's dashboard screen directly.
  String targetedAppPackage = "";
  MethodChannelService._() {
    /// Handle calls from native side
    _methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'updateTargetedApp') {
        targetedAppPackage = call.arguments;
      }
    });
  }

  /// This method will start tracking service if it is already not running
  /// otherwise will trigger data refresh
  Future<bool> refreshAppTimers() async =>
      await _methodChannel.invokeMethod('refreshAppTimers');
  
  Future<bool> tryToStopTrackingService() async =>
      await _methodChannel.invokeMethod('tryToStopTrackingService');

  Future<bool> isAccessibilityServiceRunning() async =>
      await _methodChannel.invokeMethod('isAccessibilityServiceRunning');

  Future<bool> startAccessibilityService() async =>
      await _methodChannel.invokeMethod('startAccessibilityService');

  Future<bool> stopAccessibilityService() async =>
      await _methodChannel.invokeMethod('stopAccessibilityService');

  Future<bool> isVpnServiceRunning() async =>
      await _methodChannel.invokeMethod('isVpnServiceRunning');

  Future<bool> startVpnService() async =>
      await _methodChannel.invokeMethod('startVpnService');

  Future<bool> stopVpnService() async =>
      await _methodChannel.invokeMethod('stopVpnService');

  Future<bool> flagVpnRestart() async =>
      await _methodChannel.invokeMethod('flagVpnRestart');

  Future<bool> scheduleBedtimeRoutine() async =>
      await _methodChannel.invokeMethod('scheduleBedtimeRoutine');

  Future<bool> cancelBedtimeRoutine() async =>
      await _methodChannel.invokeMethod('cancelBedtimeRoutine');

  Future<bool> showToast(
    String msg, {
    ToastDuration duration = ToastDuration.short,
  }) async =>
      await _methodChannel.invokeMethod(
        'showToast',
        {
          'message': msg,
          'duration': duration.index,
        },
      );

  Future<String> parseUrl(String url) async =>
      await _methodChannel.invokeMethod('parseUrl', {'url': url});

  // Future<bool> scheduleBedtimeTask({
  //   required BedtimeScheduleInfo info,
  // }) async =>
  //     await _methodChannel.invokeMethod(
  //       'scheduleBedtimeTask',
  //       {
  //         'toggleDnd': info.enableDND,
  //         'pauseApps': info.pauseApps,
  //         'selectedDays': info.selectedDays,
  //         'durationMs': info.endTime.difference(info.startTime) * 60000,
  //         'startMsEpoch': DateTime(
  //           now.year,
  //           now.month,
  //           now.day,
  //           info.startTime.hour,
  //           info.startTime.minute,
  //           0,
  //           0,
  //         ).millisecondsSinceEpoch,
  //       },
  // );

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
                    'MethodChannelService.getDeviceApps() : Unable to add the following app: $entry');
              } else {
                debugPrint('MethodChannelService.getDeviceApps() : $e $trace');
              }
            }
          }
        }
        return list;
      } else {
        return List<AndroidApp>.empty();
      }
    } catch (e) {
      debugPrint("MethodChannelService.getDeviceApps() Error: $e");
      return List<AndroidApp>.empty();
    }
  }
}
