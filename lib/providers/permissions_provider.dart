import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/permission_type.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/permissions_model.dart';

/// A Riverpod state notifier provider that manages and requests various permissions required by the app.
final permissionProvider =
    StateNotifierProvider<PermissionNotifier, PermissionsModel>((ref) {
  return PermissionNotifier();
});

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

    final cache = state.copyWith(
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
      haveAdminPermission:
          await MethodChannelService.instance.getAndAskAdminPermission(),
      haveVpnPermission:
          await MethodChannelService.instance.getAndAskVpnPermission(),
    );

    state = cache;
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
      PermissionType.admin => state.copyWith(
          haveAdminPermission:
              await MethodChannelService.instance.getAndAskAdminPermission(),
        ),
      PermissionType.vpn => state.copyWith(
          haveVpnPermission:
              await MethodChannelService.instance.getAndAskVpnPermission(),
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

  /// Requests the admin permission and updates the internal state.
  void askAdminPermission() async {
    await MethodChannelService.instance
        .getAndAskAdminPermission(askPermissionToo: true);
    _askedPermission = PermissionType.admin;
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
}