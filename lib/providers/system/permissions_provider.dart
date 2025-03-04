/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/permission_type.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/permissions_model.dart';

/// A Riverpod state notifier provider that manages and requests various permissions required by the app.
final permissionProvider =
    StateNotifierProvider<PermissionNotifier, PermissionsModel>(
  (ref) => PermissionNotifier(),
);

/// This class manages the state of app permissions and handles permission requests.
class PermissionNotifier extends StateNotifier<PermissionsModel>
    with WidgetsBindingObserver {
  PermissionNotifier() : super(const PermissionsModel()) {
    WidgetsBinding.instance.addObserver(this);
    fetchPermissionsStatus();
  }

  /// Tracks the last requested permission type for handling lifecycle changes.
  PermissionType _askedPermission = PermissionType.none;

  /// Create [PermissionsModel] and initializes with permission state by fetching initial permission status then updated state.
  Future<PermissionsModel> fetchPermissionsStatus() async {
    final cache = PermissionsModel(
      haveNotificationPermission:
          await MethodChannelService.instance.getAndAskNotificationPermission(),
      haveUsageAccessPermission:
          await MethodChannelService.instance.getAndAskUsageAccessPermission(),
      haveDisplayOverlayPermission: await MethodChannelService.instance
          .getAndAskDisplayOverlayPermission(),
      haveDndPermission:
          await MethodChannelService.instance.getAndAskDndPermission(),
      haveAccessibilityPermission: await MethodChannelService.instance
          .getAndAskAccessibilityPermission(),
      haveVpnPermission:
          await MethodChannelService.instance.getAndAskVpnPermission(),
      haveAlarmsPermission:
          await MethodChannelService.instance.getAndAskExactAlarmPermission(),
      haveIgnoreOptimizationPermission: await MethodChannelService.instance
          .getAndAskIgnoreBatteryOptimizationPermission(),
      haveAdminPermission:
          await MethodChannelService.instance.getAndAskAdminPermission(),
      haveNotificationAccessPermission: await MethodChannelService.instance
          .getAndAskNotificationAccessPermission(),
    );

    state = cache;
    return cache;
  }

  /// Removes the lifecycle observer when the widget is disposed.
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  /// Handles permission updates when the app resumes from background.
  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) async {
    if (appState != AppLifecycleState.resumed) return;

    state = switch (_askedPermission) {
      PermissionType.none => state,
      PermissionType.notification => state.copyWith(
          haveNotificationPermission: await MethodChannelService.instance
              .getAndAskNotificationPermission(),
        ),
      PermissionType.usageAccess => state.copyWith(
          haveUsageAccessPermission: await MethodChannelService.instance
              .getAndAskUsageAccessPermission(),
        ),
      PermissionType.displayOverlay => state.copyWith(
          haveDisplayOverlayPermission: await MethodChannelService.instance
              .getAndAskDisplayOverlayPermission(),
        ),
      PermissionType.doNotDisturb => state.copyWith(
          haveDndPermission:
              await MethodChannelService.instance.getAndAskDndPermission(),
        ),
      PermissionType.accessibility => state.copyWith(
          haveAccessibilityPermission: await MethodChannelService.instance
              .getAndAskAccessibilityPermission(),
        ),
      PermissionType.vpn => state.copyWith(
          haveVpnPermission:
              await MethodChannelService.instance.getAndAskVpnPermission(),
        ),
      PermissionType.exactAlarm => state.copyWith(
          haveAlarmsPermission: await MethodChannelService.instance
              .getAndAskExactAlarmPermission(),
        ),
      PermissionType.ignoreOptimization => state.copyWith(
          haveIgnoreOptimizationPermission: await MethodChannelService.instance
              .getAndAskIgnoreBatteryOptimizationPermission(),
          haveAlarmsPermission: await MethodChannelService.instance
              .getAndAskExactAlarmPermission(),
        ),
      PermissionType.admin => state.copyWith(
          haveAdminPermission:
              await MethodChannelService.instance.getAndAskAdminPermission(),
        ),
      PermissionType.notificationAccess => state.copyWith(
          haveNotificationAccessPermission: await MethodChannelService.instance
              .getAndAskNotificationAccessPermission(),
        ),
    };

    _askedPermission = PermissionType.none;
  }

  /// Requests the notification permission and updates the internal state.
  void askNotificationPermission() async {
    _askedPermission = PermissionType.notification;
    await MethodChannelService.instance
        .getAndAskNotificationPermission(askPermissionToo: true);
  }

  /// Requests the usage access permission and updates the internal state.
  void askUsageAccessPermission() async {
    _askedPermission = PermissionType.usageAccess;
    await MethodChannelService.instance
        .getAndAskUsageAccessPermission(askPermissionToo: true);
  }

  /// Requests the display overlay permission and updates the internal state.
  void askDisplayOverlayPermission() async {
    _askedPermission = PermissionType.displayOverlay;
    await MethodChannelService.instance
        .getAndAskDisplayOverlayPermission(askPermissionToo: true);
  }

  /// Requests the accessibility permission and updates the internal state.
  void askAccessibilityPermission() async {
    _askedPermission = PermissionType.accessibility;
    await MethodChannelService.instance
        .getAndAskAccessibilityPermission(askPermissionToo: true);
  }

  /// Requests the VPN permission and updates the internal state.
  void askVpnPermission() async {
    _askedPermission = PermissionType.vpn;
    await MethodChannelService.instance
        .getAndAskVpnPermission(askPermissionToo: true);
  }

  /// Requests the Do Not Disturb permission and updates the internal state.
  void askDndPermission() async {
    _askedPermission = PermissionType.doNotDisturb;
    await MethodChannelService.instance
        .getAndAskDndPermission(askPermissionToo: true);
  }

  /// Requests the Set Exact Alarm permission and updates the internal state.
  void askExactAlarmPermission() async {
    _askedPermission = PermissionType.exactAlarm;
    await MethodChannelService.instance
        .getAndAskExactAlarmPermission(askPermissionToo: true);
  }

  /// Requests the Ignore Battery Optimization permission and updates the internal state.
  void askIgnoreBatteryOptimizationPermission() async {
    _askedPermission = PermissionType.ignoreOptimization;
    await MethodChannelService.instance
        .getAndAskIgnoreBatteryOptimizationPermission(askPermissionToo: true);
  }

  /// Requests the Admin permission and updates the internal state.
  void askAdminPermission() async {
    _askedPermission = PermissionType.admin;
    await MethodChannelService.instance
        .getAndAskAdminPermission(askPermissionToo: true);
  }

  /// Request the device to disable admin if already enabled
  void disableAdminPermission() async {
    await MethodChannelService.instance.disableDeviceAdmin();
    await Future.delayed(500.ms);
    state = state.copyWith(
      haveAdminPermission:
          await MethodChannelService.instance.getAndAskAdminPermission(),
    );
  }

  /// Requests the Admin permission and updates the internal state.
  void askNotificationAccessPermission() async {
    _askedPermission = PermissionType.notificationAccess;
    await MethodChannelService.instance
        .getAndAskNotificationAccessPermission(askPermissionToo: true);
  }
}
