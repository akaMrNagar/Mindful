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
    _init();
  }

  /// Tracks the last requested permission type for handling lifecycle changes.
  PermissionType _askedPermission = PermissionType.none;

  /// Initializes the permission state by fetching initial permission status and setting up a lifecycle listener.
  void _init() async {
    WidgetsBinding.instance.addObserver(this);
    state = await fetchPermissionsStatus();
  }

  /// Create [PermissionsModel] and initializes with permission state by fetching initial permission status.
  Future<PermissionsModel> fetchPermissionsStatus() async {
    return PermissionsModel(
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
    );
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
        ),
    };

    _askedPermission = PermissionType.none;
  }

  /// Requests the notification permission and updates the internal state.
  void askNotificationPermission() async {
    await MethodChannelService.instance
        .getAndAskNotificationPermission(askPermissionToo: true);
    _askedPermission = PermissionType.notification;
  }

  /// Requests the usage access permission and updates the internal state.
  void askUsageAccessPermission() async {
    await MethodChannelService.instance
        .getAndAskUsageAccessPermission(askPermissionToo: true);
    _askedPermission = PermissionType.usageAccess;
  }

  /// Requests the display overlay permission and updates the internal state.
  void askDisplayOverlayPermission() async {
    await MethodChannelService.instance
        .getAndAskDisplayOverlayPermission(askPermissionToo: true);
    _askedPermission = PermissionType.displayOverlay;
  }

  /// Requests the accessibility permission and updates the internal state.
  void askAccessibilityPermission() async {
    await MethodChannelService.instance
        .getAndAskAccessibilityPermission(askPermissionToo: true);
    _askedPermission = PermissionType.accessibility;
  }

  /// Requests the VPN permission and updates the internal state.
  void askVpnPermission() async {
    await MethodChannelService.instance
        .getAndAskVpnPermission(askPermissionToo: true);
    _askedPermission = PermissionType.vpn;
  }

  /// Requests the Do Not Disturb permission and updates the internal state.
  void askDndPermission() async {
    await MethodChannelService.instance
        .getAndAskDndPermission(askPermissionToo: true);
    _askedPermission = PermissionType.doNotDisturb;
  }

  /// Requests the Set Exact Alarm permission and updates the internal state.
  void askExactAlarmPermission() async {
    await MethodChannelService.instance
        .getAndAskExactAlarmPermission(askPermissionToo: true);
    _askedPermission = PermissionType.exactAlarm;
  }

  /// Requests the Ignore Battery Optimization permission and updates the internal state.
  void askIgnoreBatteryOptimizationPermission() async {
    await MethodChannelService.instance
        .getAndAskIgnoreBatteryOptimizationPermission(askPermissionToo: true);
    _askedPermission = PermissionType.ignoreOptimization;
  }
}
