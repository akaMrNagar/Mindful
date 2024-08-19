import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/models/isar/bedtime_settings.dart';
import 'package:mindful/models/isar/wellbeing_settings.dart';

/// This class handles the Flutter method channel and is responsible for invoking native Android Java code.
///
/// It provides methods for communication between the Flutter and native Android parts of the application.
class MethodChannelService {
  /// Singleton instance of the MethodChannelService.
  static final MethodChannelService instance = MethodChannelService._();

  /// Private constructor for enforcing the singleton pattern.
  MethodChannelService._();

  /// The method channel object used for communication.
  final MethodChannel _methodChannel = const MethodChannel(
    'com.mindful.android.methodchannel',
  );

  /// Package name of the app whose Time Limit Exceeded dialog's emergency button is clicked.
  /// This is forwarded by the overlay dialog service to show the emergency button on the dashboard.
  String get targetedAppPackage => _targetedAppPackage;
  String _targetedAppPackage = "";

  /// Initializes the method channel by setting a handler for incoming method calls from the native side.
  Future<void> init() async {
    _methodChannel.setMethodCallHandler(
      (call) async {
        if (call.method == 'updateTargetedApp') {
          _targetedAppPackage = call.arguments;
        }
      },
    );
  }

  // SECTION: Utility Methods ======================================================================

  /// Get status of onboarding
  ///
  /// Returns a bool indicating if onboarding is completed or not
  Future<bool> getOnboardingStatus() async =>
      await _methodChannel.invokeMethod('getOnboardingStatus');

  /// Sets the status of onboarding as completed
  Future<void> setOnboardingDone() async =>
      await _methodChannel.invokeMethod('setOnboardingDone');

  /// Gets the total short screen time for the device in milliseconds.
  ///
  /// This method retrieves the total screen time spent on short-form video apps
  /// and converts it to seconds before returning the value.
  Future<int> getShortsScreenTimeSec() async {
    int time = await _methodChannel.invokeMethod('getShortsScreenTimeMs');
    return time ~/ 1000;
  }

  /// Sets the time of day when app usage data should be reset for the next day.
  ///
  /// This method takes the time of day in minutes and sends it to the native side
  /// to be set as the data reset time.
  Future<bool> setDataResetTime(int timeOfDayInMins) async =>
      await _methodChannel.invokeMethod('setDataResetTime', timeOfDayInMins);

  /// Parses the host name from a given URL string.
  ///
  /// This method sends the URL to the native side and retrieves the parsed host name.
  Future<String> parseHostFromUrl(String url) async =>
      await _methodChannel.invokeMethod('parseHostFromUrl', url);

  /// Launches a specified URL in the user's preferred web browser.
  ///
  /// This method takes the URL string and sends it to the native side for launching in the browser.
  Future<bool> launchUrl(String siteUrl) async =>
      await _methodChannel.invokeMethod('launchUrl', siteUrl);

  /// Retrieves a list of all launchable apps installed on the user's device along with their usage statistics.
  ///
  /// This method calls the native side to get information about all installed apps and their usage data
  /// for the current week, including screen time, Wi-Fi usage, and mobile data usage per day. The returned
  /// list contains `AndroidApp` objects with the app details and usage statistics.
  Future<List<AndroidApp>> getDeviceApps() async {
    try {
      Object result = await _methodChannel.invokeMethod('getDeviceApps');

      if (result is Iterable) {
        List<AndroidApp> list = [];
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

  /// Updates the app timers for the foreground service.
  ///
  /// This method takes a map of app packages to their respective timers and sends it to the native side
  /// to update the foreground service's app timers.
  Future<void> updateAppTimers(Map<String, int> appTimers) async =>
      _methodChannel.invokeMethod(
        'updateAppTimers',
        jsonEncode(appTimers),
      );

  /// Updates the list of blocked apps for the foreground service.
  ///
  /// This method takes a list of app packages to be blocked and sends it to the native side
  /// to update the foreground service's blocked apps list.
  Future<void> updateBlockedApps(List<String> blockedApps) async =>
      _methodChannel.invokeMethod(
        'updateBlockedApps',
        jsonEncode(blockedApps),
      );

  /// Updates the well-being settings for the foreground service.
  ///
  /// This method takes a [WellBeingSettings] object and sends it to the native side
  /// to update the foreground service's well-being settings.
  Future<void> updateWellBeingSettings(
          WellBeingSettings wellBeingSettings) async =>
      _methodChannel.invokeMethod(
        'updateWellBeingSettings',
        jsonEncode(wellBeingSettings),
      );

  /// Updates the bedtime schedule for the foreground service.
  ///
  /// This method takes a [BedtimeSettings] object and sends it to the native side
  /// to update the foreground service's bedtime schedule.
  Future<bool> updateBedtimeSchedule(BedtimeSettings bedtimeSettings) async =>
      await _methodChannel.invokeMethod(
        'updateBedtimeSchedule',
        jsonEncode(bedtimeSettings),
      );

  /// Gets the number of remaining emergency passes.
  ///
  /// This method retrieves the number of available emergency passes from the native side.
  Future<int> getLeftEmergencyPasses() async {
    return await _methodChannel.invokeMethod('getLeftEmergencyPasses') as int;
  }

  /// Uses an emergency pass.
  ///
  /// This method sends a request to the native side to use an emergency pass.
  Future<bool> useEmergencyPass() async =>
      await _methodChannel.invokeMethod('useEmergencyPass');

  /// Start new focus session.
  ///
  /// This method sends a request to the native side to start focus session.
  Future<bool> startFocusSession({
    required int durationSeconds,
    required bool toggleDnd,
    required List<String> distractingApps,
  }) async =>
      await _methodChannel.invokeMethod(
        'startFocusSession',
        jsonEncode({
          'toggleDnd': toggleDnd,
          'durationSeconds': durationSeconds,
          'distractingApps': distractingApps,
        }),
      );

  /// Stop running focus session.
  ///
  /// This method sends a request to the native side to stop already running focus session.
  Future<bool> stopFocusSession() async =>
      await _methodChannel.invokeMethod('stopFocusSession');

  // !SECTION
  // SECTION: Permissions Handler Methods ======================================================================

  /// Checks if the notification permission is granted and optionally asks for it.
  ///
  /// This method returns `true` if the permission is granted Otherwise, it returns `false`.
  Future<bool> getAndAskNotificationPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskNotificationPermission',
        askPermissionToo,
      );

  /// Checks if the accessibility permission is granted and optionally asks for it.
  ///
  /// This method returns `true` if the permission is granted Otherwise, it returns `false`.
  Future<bool> getAndAskAccessibilityPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskAccessibilityPermission',
        askPermissionToo,
      );

  /// Checks if the VPN permission is granted and optionally asks for it.
  ///
  /// This method returns `true` if the permission is granted Otherwise, it returns `false`.
  Future<bool> getAndAskVpnPermission({bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskVpnPermission',
        askPermissionToo,
      );

  /// Checks if the Do Not Disturb (DND) permission is granted and optionally asks for it.
  ///
  /// Returns `true` if the permission is granted Otherwise, returns `false`.
  Future<bool> getAndAskDndPermission({bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskDndPermission',
        askPermissionToo,
      );

  /// Checks if the usage access permission is granted and optionally asks for it.
  ///
  /// Returns `true` if the permission is granted Otherwise, returns `false`.
  Future<bool> getAndAskUsageAccessPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskUsageAccessPermission',
        askPermissionToo,
      );

  /// Checks if the display overlay permission is granted and optionally asks for it.
  ///
  /// Returns `true` if the permission is granted Otherwise, returns `false`.
  Future<bool> getAndAskDisplayOverlayPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskDisplayOverlayPermission',
        askPermissionToo,
      );

  /// Checks if the set exact alarm permission is granted and optionally asks for it.
  ///
  /// Returns `true` if the permission is granted Otherwise, returns `false`.
  Future<bool> getAndAskExactAlarmPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskExactAlarmPermission',
        askPermissionToo,
      );

  /// Checks if the ignore battery optimization permission is granted and optionally asks for it.
  ///
  /// Returns `true` if the permission is granted Otherwise, returns `false`.
  Future<bool> getAndAskIgnoreBatteryOptimizationPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskIgnoreBatteryOptimizationPermission',
        askPermissionToo,
      );

  /// Checks if the admin permission is granted and optionally asks for it.
  ///
  /// Returns `true` if the permission is granted Otherwise, returns `false`.
  Future<bool> getAndAskAdminPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskAdminPermission',
        askPermissionToo,
      );

  // !SECTION
  // SECTION: New Activity Launch Methods ======================================================================

  /// Opens the device's Do Not Disturb (DND) settings.
  Future<bool> openDeviceDndSettings() async =>
      await _methodChannel.invokeMethod('openDeviceDndSettings');

  /// Opens an app with the specified package name.
  Future<bool> openAppWithPackage(String appPackage) async =>
      await _methodChannel.invokeMethod('openAppWithPackage', appPackage);

  /// Opens the app settings for the specified app package.
  Future<bool> openAppSettingsForPackage(String appPackage) async =>
      await _methodChannel.invokeMethod(
        'openAppSettingsForPackage',
        appPackage,
      );

  // !SECTION
}
