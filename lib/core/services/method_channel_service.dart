import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mindful/core/enums/toast_duration.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/models/isar/bedtime_settings.dart';
import 'package:mindful/models/isar/wellbeing_settings.dart';

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

  /// Package of the app whose Time Limit Exceeded dialog's emergency button is clicked.
  /// This is forwarded by the overlay dialog service to show emergency button on dashboard.
  String get targetedAppPackage => _targetedAppPackage;
  String _targetedAppPackage = "";

  Future<void> init() async {
    /// Handle calls from native side
    _methodChannel.setMethodCallHandler(
      (call) async {
        if (call.method == 'updateTargetedApp') {
          _targetedAppPackage = call.arguments;
        }
      },
    );
  }

  // SECTION: Utility Methods ======================================================================

  Future<int> getShortsScreenTimeSec() async {
    int time = await _methodChannel.invokeMethod('getShortsScreenTimeMs');
    return time ~/ 1000;
  }

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

  Future<String> parseHostFromUrl(String url) async =>
      await _methodChannel.invokeMethod('parseHostFromUrl', url);

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

  // !SECTION
  // SECTION: Foreground Service and Background Worker Methods ======================================================================
  Future<void> updateAppTimers(Map<String, int> appTimers) async =>
      _methodChannel.invokeMethod(
        'updateAppTimers',
        jsonEncode(appTimers),
      );

  Future<void> updateBlockedApps(List<String> blockedApps) async =>
      _methodChannel.invokeMethod(
        'updateBlockedApps',
        jsonEncode(blockedApps),
      );

  Future<void> updateWellBeingSettings(
          WellBeingSettings wellBeingSettings) async =>
      _methodChannel.invokeMethod(
        'updateWellBeingSettings',
        jsonEncode(wellBeingSettings),
      );

  Future<bool> updateBedtimeSchedule(BedtimeSettings bedtimeSettings) async =>
      await _methodChannel.invokeMethod(
        'updateBedtimeSchedule',
        jsonEncode(bedtimeSettings),
      );

  Future<int> getLeftEmergencyPasses() async {
    return await _methodChannel.invokeMethod('getLeftEmergencyPasses') as int;
  }

  Future<void> useEmergencyPass() async =>
      await _methodChannel.invokeMethod('useEmergencyPass');

  // !SECTION
  // SECTION: Permissions Handler Methods ======================================================================

  Future<bool> getAndAskNotificationPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskNotificationPermission',
        askPermissionToo,
      );

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

  Future<bool> getAndAskUsageAccessPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskUsageAccessPermission',
        askPermissionToo,
      );

  Future<bool> getAndAskDisplayOverlayPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskDisplayOverlayPermission',
        askPermissionToo,
      );

  Future<bool> getAndAskAdminPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskAdminPermission',
        askPermissionToo,
      );

  // !SECTION
  // SECTION: New Activity Launch Methods ======================================================================

  Future<bool> openDeviceDndSettings() async =>
      await _methodChannel.invokeMethod('openDeviceDndSettings');

  Future<bool> openAppWithPackage(String appPackage) async =>
      await _methodChannel.invokeMethod('openAppWithPackage', appPackage);

  Future<bool> openAppSettingsForPackage(String appPackage) async =>
      await _methodChannel.invokeMethod(
        'openAppSettingsForPackage',
        appPackage,
      );

  // !SECTION
}
