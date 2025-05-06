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

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/models/usage_model.dart';
import 'package:mindful/models/app_info.dart';
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
    'com.mindful.android.methodchannel.fg',
  );

  /// Flag indicating if the app is restarted by itself (after importing database).
  bool get isSelfRestart => _isSelfRestart;
  bool _isSelfRestart = false;

  /// [DeviceInfoModel] containing information about this device on which app is running
  DeviceInfoModel get deviceInfo => _deviceInfo;
  late DeviceInfoModel _deviceInfo;

  /// Initializes the method channel by setting a handler for incoming method calls from the native side.
  Future<void> init() async {
    _methodChannel.setMethodCallHandler(
      (call) async {
        if (call.method == "updateSelfStartStatus") {
          _isSelfRestart = call.arguments as bool? ?? false;
        }
      },
    );

    /// Load information about the device
    _deviceInfo = await MethodChannelService.instance.getDeviceInfo();
  }

  // ===========================================================================================
  // ==================================== SETUP ================================================
  // ===========================================================================================

  /// Update locale on the native side
  Future<bool> updateLocale({required String languageCode}) async =>
      await _methodChannel.invokeMethod('updateLocale', languageCode);

  /// Update excluded apps for widget purpose
  Future<bool> updateExcludedApps(List<String> excludedApps) async =>
      await _methodChannel.invokeMethod(
        'updateExcludedApps',
        jsonEncode(excludedApps),
      );

  /// Gets the map of device info and create and returns [DeviceInfoModel] .
  Future<DeviceInfoModel> getDeviceInfo() async => DeviceInfoModel.fromMap(
      await _methodChannel.invokeMapMethod('getDeviceInfo') ?? {});

  /// Gets the launch counts of apps mapped to their package name.
  Future<Map<String, int>> getAppsLaunchCount() async =>
      await _methodChannel.invokeMapMethod<String, int>('getAppsLaunchCount') ??
      {};

  /// Gets the total short screen time for the device in milliseconds.
  ///
  /// This method retrieves the total screen time spent on short-form video apps
  /// and converts it to seconds before returning the value.
  Future<int> getShortsScreenTimeSec() async {
    int time = await _methodChannel.invokeMethod('getShortsScreenTimeMs');
    return time ~/ 1000;
  }

  /// Gets all the stored native crash logs and clears them afterward.
  Future<List<CrashLogsTableCompanion>> getNativeCrashLogs() async {
    List<CrashLogsTableCompanion> crashLogs = [];

    try {
      String jsonString =
          await _methodChannel.invokeMethod('getNativeCrashLogs');

      List<dynamic> logMapsList = jsonDecode(jsonString);

      for (var item in logMapsList) {
        if (item is Map) {
          final logMap = Map<String, dynamic>.from(item);
          final log = CrashLogsTableCompanion(
            appVersion: Value(logMap['appVersion'] as String),
            timeStamp: Value(
              DateTime.fromMillisecondsSinceEpoch(logMap['timeStamp'] as int),
            ),
            error: Value((logMap['error'] as String).trim()),
            stackTrace: Value((logMap['stackTrace'] as String).trim()),
          );

          crashLogs.add(log);
        }
      }
    } catch (e) {
      debugPrint("MethodChannelService.getNativeCrashLogs() Error: $e");
    }

    return crashLogs;
  }

  /// Clears all the crash logs on the native side.
  Future<bool> clearNativeCrashLogs() async =>
      await _methodChannel.invokeMethod('clearNativeCrashLogs');

  /// Retrieves a list of all launchable apps installed on the user's device.
  Future<List<AppInfo>> fetchDeviceAppsInfo() async {
    try {
      List<Map> result =
          await _methodChannel.invokeListMethod<Map>('getDeviceAppsInfo') ?? [];
      return result.map((e) => AppInfo.fromMap(e)).toList();
    } catch (e) {
      debugPrint("MethodChannelService.fetchDeviceAppsInfo() Error: $e");
    }
    return [];
  }

  /// Loads Map of [String] package name and the respective [UsageModel] for the given interval
  ///
  /// The result map contains one [UsageModel] per app
  Future<Map<String, UsageModel>> fetchAppsUsageForInterval({
    required DateTime start,
    required DateTime end,
  }) async {
    Map<String, UsageModel> usagesMap = {};
    try {
      List<Map> results = await _methodChannel
              .invokeListMethod<Map>('getAppsUsageForInterval', {
            "startDateTime": start.millisecondsSinceEpoch,
            "endDateTime": end.millisecondsSinceEpoch,
          }) ??
          [];

      for (var map in results) {
        usagesMap[map["packageName"] as String] = UsageModel.fromMap(map);
      }
    } catch (e) {
      debugPrint("MethodChannelService.fetchAppsUsageForInterval() Error: $e");
    }
    return usagesMap;
  }

  // ===========================================================================================
  // ==================================== SERVICES =============================================
  // ===========================================================================================

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

  /// Safe method to update settings in Notification Listener service if provided.
  /// Also Updates the notification batching schedule if provided.
  ///
  /// This method push the updated settings to the service if it is already running
  /// otherwise try to bind to service if needed
  Future<void> updateNotificationSettings(
    NotificationSettings settings,
  ) async =>
      _methodChannel.invokeMethod(
        'updateNotificationSettings',
        jsonEncode(settings),
      );

  /// Updates the well-being settings for the foreground service.
  ///
  /// This method takes a [Wellbeing] object and sends it to the native side
  Future<void> updateWellBeingSettings(Wellbeing wellBeingSettings) async =>
      _methodChannel.invokeMethod(
        'updateWellBeingSettings',
        jsonEncode(
          {
            "allowedShortsTimeSec": wellBeingSettings.allowedShortsTimeSec,
            "blockNsfwSites": wellBeingSettings.blockNsfwSites,
            "blockedFeatures":
                wellBeingSettings.blockedFeatures.map((e) => e.name).toList(),
            "blockedWebsites": wellBeingSettings.blockedWebsites,
            "nsfwWebsites": wellBeingSettings.nsfwWebsites,
          },
        ),
      );

  /// Updates the bedtime schedule.
  ///
  /// This method takes a [BedtimeSchedule] object and sends it to the native side
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

  // ===========================================================================================
  // ==================================== PERMISSIONS ==========================================
  // ===========================================================================================
  /// Checks if the admin permission is granted and optionally asks for it.
  ///
  /// Returns `true` if the permission is granted Otherwise, returns `false`.
  Future<bool> getAndAskAdminPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskAdminPermission',
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

  /// Checks if the VPN permission is granted and optionally asks for it.
  ///
  /// This method returns `true` if the permission is granted Otherwise, it returns `false`.
  Future<bool> getAndAskVpnPermission({bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskVpnPermission',
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

  /// Checks if the notification permission is granted and optionally asks for it.
  ///
  /// This method returns `true` if the permission is granted Otherwise, it returns `false`.
  Future<bool> getAndAskNotificationPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskNotificationPermission',
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

  /// Checks if the Notification Access permission is granted and optionally asks for it.
  ///
  /// Returns `true` if the permission is granted Otherwise, returns `false`.
  Future<bool> getAndAskNotificationAccessPermission(
          {bool askPermissionToo = false}) async =>
      await _methodChannel.invokeMethod(
        'getAndAskNotificationAccessPermission',
        askPermissionToo,
      );

  /// Disable device Admin if active.
  Future<bool> disableDeviceAdmin() async =>
      await _methodChannel.invokeMethod('disableDeviceAdmin');

  // ===========================================================================================
  // ============================== EXTERNAL ACTIVITIES ========================================
  // ===========================================================================================

  /// Opens the device's Do Not Disturb (DND) settings.
  Future<bool> openDeviceDndSettings() async =>
      await _methodChannel.invokeMethod('openDeviceDndSettings');

  /// Opens the device specific settings to whitelist mindful.
  Future<bool> openAutoStartSettings() async =>
      await _methodChannel.invokeMethod('openAutoStartSettings');

  /// Opens an app with the specified package name.
  Future<bool> openAppWithPackage(String appPackage) async =>
      await _methodChannel.invokeMethod('openAppWithPackage', appPackage);

  /// Opens an app with notification thread.
  Future<bool> openAppWithNotificationThread(Notification notification) async =>
      await _methodChannel.invokeMethod(
        'openAppWithNotificationThread',
        jsonEncode(notification),
      );

  /// Opens the app settings for the specified app package.
  Future<bool> openAppSettingsForPackage(String appPackage) async =>
      await _methodChannel.invokeMethod(
        'openAppSettingsForPackage',
        appPackage,
      );

  // ===========================================================================================
  // ==================================== UTILS ================================================
  // ===========================================================================================

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

  /// Prompts the user to add Quick Focus Tile to the status bar
  Future<bool> promptForQuickTile() async =>
      await _methodChannel.invokeMethod('promptForQuickTile');
}
