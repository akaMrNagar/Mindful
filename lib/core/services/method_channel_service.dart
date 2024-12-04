/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/models/device_info_model.dart';

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

  /// Flag indicating if the app is restarted by itself (after importing database).
  bool get isSelfRestart => _isSelfRestart;
  bool _isSelfRestart = false;

  /// Initializes the method channel by setting a handler for incoming method calls from the native side.
  Future<void> init() async {
    _methodChannel.setMethodCallHandler(
      (call) async {
        if (call.method == "updateIsRestartBool") {
          _isSelfRestart = call.arguments;
          debugPrint("The app is restarted by itself");
        } else if (call.method == 'updateTargetedApp') {
          _targetedAppPackage = call.arguments;
          debugPrint("The app is started by $_targetedAppPackage");
        }
      },
    );
  }

  // SECTION: Setup Methods ======================================================================

  /// Update locale on the native side
  Future<bool> updateLocale({required String languageCode}) async =>
      await _methodChannel.invokeMethod('updateLocale', languageCode);

  /// Update excluded apps for widget purpose
  Future<bool> updateExcludedApps(List<String> excludedApps) async =>
      await _methodChannel.invokeMethod(
        'updateExcludedApps',
        jsonEncode(excludedApps),
      );

  /// Sets the time of day when app data usage should be reset for the next day.
  ///
  /// This method takes the time of day in minutes and sends it to the native side
  /// to be set as the data reset time.
  Future<bool> setDataResetTime(int timeOfDayInMins) async =>
      await _methodChannel.invokeMethod('setDataResetTime', timeOfDayInMins);

  /// Gets the map of device info and create and returns [DeviceInfoModel] .
  Future<DeviceInfoModel> getDeviceInfo() async => DeviceInfoModel.fromMap(
      await _methodChannel.invokeMapMethod('getDeviceInfoMap') ?? {});

  /// Gets the total short screen time for the device in milliseconds.
  ///
  /// This method retrieves the total screen time spent on short-form video apps
  /// and converts it to seconds before returning the value.
  Future<int> getShortsScreenTimeSec() async {
    int time = await _methodChannel.invokeMethod('getShortsScreenTimeMs');
    return time ~/ 1000;
  }

  /// Gets the map of app package and the number launches for today.
  Future<Map<String, int>> getAppLaunchCounts() async =>
      await _methodChannel.invokeMapMethod('getAppLaunchCounts') ?? {};

  /// Retrieves a list of all launchable apps installed on the user's device along with their usage statistics.
  ///
  /// This method calls the native side to get information about all installed apps and their usage data
  /// for the current week, including screen time, Wi-Fi usage, and mobile data usage per day. The returned
  /// list contains `AndroidApp` objects with the app details and usage statistics.
  Future<List<AndroidApp>> getDeviceApps() async {
    List<AndroidApp> appsList = [];
    try {
      List<Map> result =
          await _methodChannel.invokeListMethod<Map>('getDeviceApps') ?? [];

      for (Map entry in result) {
        try {
          appsList.add(AndroidApp.fromMap(entry));
        } catch (e, trace) {
          debugPrint('MethodChannelService.getDeviceApps() : $e $trace');
        }
      }
    } catch (e) {
      debugPrint("MethodChannelService.getDeviceApps() Error: $e");
    }
    return appsList;
  }

  // !SECTION
  // SECTION: Foreground Service and Background Worker Methods ======================================================================

  /// Safe method to update app restrictions list in the TRACKER service.
  ///
  /// This method push the updated list to the service if it is already running
  /// otherwise only start service if list is not empty
  Future<void> updateAppRestrictions(
    List<AppRestriction> appRestrictions,
  ) async =>
      _methodChannel.invokeMethod(
        'updateAppRestrictions',
        jsonEncode(appRestrictions),
      );

  /// Safe method to update restriction groups list in the TRACKER service.
  ///
  /// This method push the updated list to the service if it is already running
  /// otherwise only start service if list is not empty
  Future<void> updateRestrictionsGroups(
    List<RestrictionGroup> restrictionGroups,
  ) async =>
      _methodChannel.invokeMethod(
        'updateRestrictionsGroups',
        jsonEncode(restrictionGroups),
      );

  /// Safe method to update internet blocked apps in the VPN service.
  ///
  /// This method push the updated list to the service if it is already running
  /// otherwise only start service if list is not empty
  Future<void> updateInternetBlockedApps(List<String> blockedApps) async =>
      _methodChannel.invokeMethod(
        'updateInternetBlockedApps',
        jsonEncode(blockedApps),
      );

  /// Updates the well-being settings for the foreground service.
  ///
  /// This method takes a [Wellbeing] object and sends it to the native side
  /// to update the foreground service's well-being settings.
  Future<void> updateWellBeingSettings(Wellbeing wellBeingSettings) async =>
      _methodChannel.invokeMethod(
        'updateWellBeingSettings',
        jsonEncode(wellBeingSettings),
      );

  /// Updates the bedtime schedule for the foreground service.
  ///
  /// This method takes a [BedtimeSchedule] object and sends it to the native side
  /// to update the foreground service's bedtime schedule.
  Future<bool> updateBedtimeSchedule(BedtimeSchedule bedtimeSettings) async =>
      await _methodChannel.invokeMethod(
        'updateBedtimeSchedule',
        jsonEncode(bedtimeSettings),
      );

  /// Uses an emergency pass and pause the tracking service.
  ///
  /// This method sends a request to the native side to use an emergency pass.
  Future<bool> activeEmergencyPause() async =>
      await _methodChannel.invokeMethod('activeEmergencyPause');

  /// Start new focus session or only updates the list of distracting apps if already running.
  ///
  /// This method sends a request to the native side to start focus session.
  Future<void> updateFocusSession({
    required FocusSession session,
    required FocusProfile profile,
  }) async =>
      await _methodChannel.invokeMethod(
        'updateFocusSession',
        jsonEncode({
          'startTimeMsEpoch': session.startDateTime.millisecondsSinceEpoch,
          'durationSeconds': session.durationSecs,
          'toggleDnd': profile.shouldStartDnd,
          'distractingApps': profile.distractingApps,
        }),
      );

  /// Giveup or Finish running focus session with success or failure.
  ///
  /// This method sends a request to the native side to stop already running focus session.
  Future<bool> giveUpOrFinishFocusSession({
    required bool isTheSessionSuccessful,
  }) async =>
      await _methodChannel.invokeMethod(
        'giveUpOrFinishFocusSession',
        isTheSessionSuccessful,
      );

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

  /// Disable device Admin if active.
  Future<bool> disableDeviceAdmin() async =>
      await _methodChannel.invokeMethod('disableDeviceAdmin');

  // !SECTION
  // SECTION: New Activity Launch Methods ======================================================================

  /// Opens the device's Do Not Disturb (DND) settings.
  Future<bool> openDeviceDndSettings() async =>
      await _methodChannel.invokeMethod('openDeviceDndSettings');

  /// Opens the device specific settings to whitelist mindful.
  Future<bool> openAutoStartSettings() async =>
      await _methodChannel.invokeMethod('openAutoStartSettings');

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
  // SECTION: Utility methods ======================================================================

  /// Pop animates and close the app
  Future<bool> restartApp() async =>
      await _methodChannel.invokeMethod('restartApp');

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
}
