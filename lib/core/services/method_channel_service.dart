import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mindful/core/enums/toast_duration.dart';
import 'package:mindful/models/android_app.dart';

/// This class handle flutter method channel and responsible for invoking native android java code
class MethodChannelService {
  /// static instance
  static final MethodChannelService instance = MethodChannelService._();

  /// private constructor
  MethodChannelService._();

  /// Method channel object
  final MethodChannel _methodChannel = const MethodChannel(
    'com.akamrnagar.mindful.methodchannel',
  );

  /// Package of the app whose Time Limit Exceeded dialog is clicked.
  /// This is forwarded by the tracking service to open the app's dashboard screen directly.
  String targetedAppPackage = "";

  Future<void> init() async {
    /// Handle calls from native side
    _methodChannel.setMethodCallHandler(
      (call) async {
        if (call.method == 'updateTargetedApp') {
          targetedAppPackage = call.arguments;
        }
      },
    );
  }

  //
  // Tracking Service Methods ======================================================================
  //

  /// This method will start tracking service if it is already not running
  /// otherwise will trigger data refresh
  Future<bool> refreshAppTimers() async =>
      await _methodChannel.invokeMethod('refreshAppTimers');

  Future<bool> tryToStopTrackingService() async =>
      await _methodChannel.invokeMethod('tryToStopTrackingService');

  //
  // VPN Service Methods ======================================================================
  //

  Future<bool> stopVpnService() async =>
      await _methodChannel.invokeMethod('stopVpnService');

  Future<bool> flagVpnRestart() async =>
      await _methodChannel.invokeMethod('flagVpnRestart');

  //
  // Bedtime Schedule Methods ======================================================================
  //

  Future<bool> scheduleBedtimeRoutine() async =>
      await _methodChannel.invokeMethod('scheduleBedtimeRoutine');

  Future<bool> cancelBedtimeRoutine() async =>
      await _methodChannel.invokeMethod('cancelBedtimeRoutine');

  //
  // Utility Methods ======================================================================
  //

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
      await _methodChannel.invokeMethod('parseUrl', url);

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

  //
  // Permissions Handler Methods ======================================================================
  //

  Future<bool> getAndAskAccessibilityPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskAccessibilityPermission',
        askPermissionToo,
      );

  Future<bool> getAndAskVpnPermission({bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskVpnPermission',
        askPermissionToo,
      );

  Future<bool> getAndAskDndPermission({bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskDndPermission',
        askPermissionToo,
      );

  Future<bool> getAndAskUsageStatesPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskUsageStatesPermission',
        askPermissionToo,
      );

  Future<bool> getAndAskDisplayOverlayPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskDisplayOverlayPermission',
        askPermissionToo,
      );

  Future<bool> getAndAskBatteryOptimizationPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskBatteryOptimizationPermission',
        askPermissionToo,
      );

  //
  // New Activity Launch Methods ======================================================================
  //

  Future<bool> openDeviceDndSettings() async =>
      await _methodChannel.invokeMethod('openDeviceDndSettings');

  Future<bool> openAppWithPackage(String appPackage) async =>
      await _methodChannel.invokeMethod('openAppWithPackage', appPackage);

  Future<bool> openAppSettingsForPackage(String appPackage) async =>
      await _methodChannel.invokeMethod(
        'openAppSettingsForPackage',
        appPackage,
      );
}
