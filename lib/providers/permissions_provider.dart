import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/permission_type.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/permissions_model.dart';

final permissionProvider =
    StateNotifierProvider<PermissionNotifier, PermissionsModel>((ref) {
  return PermissionNotifier();
});

class PermissionNotifier extends StateNotifier<PermissionsModel>
    with WidgetsBindingObserver {
  PermissionNotifier() : super(PermissionsModel()) {
    _init();
  }

  void _init() async {
    ///  Add widget bindings observe
    WidgetsBinding.instance.addObserver(this);

    final cache = state.copyWith(
      haveUsagePermission:
          await MethodChannelService.instance.getAndAskUsageStatesPermission(),
      haveDisplayOverayPermission: await MethodChannelService.instance
          .getAndAskDisplayOverlayPermission(),
      haveBatteryOptimizationPermission: await MethodChannelService.instance
          .getAndAskBatteryOptimizationPermission(),
      haveDndPermission:
          await MethodChannelService.instance.getAndAskDndPermission(),
      haveAccessibilityPermission: await MethodChannelService.instance
          .getAndAskAccessibilityPermission(),
      haveVpnPermission:
          await MethodChannelService.instance.getAndAskVpnPermission(),
    );

    state = cache;
  }

  @override
  void dispose() {
    super.dispose();

    ///  Remove widget bindings observe
    WidgetsBinding.instance.removeObserver(this);
  }

  PermissionType _askedPermission = PermissionType.none;

  @override
  // ignore: avoid_renaming_method_parameters
  void didChangeAppLifecycleState(AppLifecycleState appState) async {
    debugPrint("PermissionNotifier: Application state change to : $appState");

    /// Return if app state is not resumed state
    if (appState != AppLifecycleState.resumed) return;

    state = switch (_askedPermission) {
      PermissionType.none => state,
      PermissionType.usageAccess => state.copyWith(
          haveUsagePermission: await MethodChannelService.instance
              .getAndAskUsageStatesPermission(),
        ),
      PermissionType.displayOverlay => state.copyWith(
          haveDisplayOverayPermission: await MethodChannelService.instance
              .getAndAskDisplayOverlayPermission(),
        ),
      PermissionType.batteryOptimization => state.copyWith(
          haveBatteryOptimizationPermission: await MethodChannelService.instance
              .getAndAskBatteryOptimizationPermission(),
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
    };

    _askedPermission = PermissionType.none;
  }

  void askAccessibilityPermission() async {
    await MethodChannelService.instance
        .getAndAskAccessibilityPermission(askPermissionToo: true);
    _askedPermission = PermissionType.accessibility;
  }

  void askVpnPermission() async {
    await MethodChannelService.instance
        .getAndAskVpnPermission(askPermissionToo: true);
    _askedPermission = PermissionType.vpn;
  }

  void askDndPermission() async {
    await MethodChannelService.instance
        .getAndAskDndPermission(askPermissionToo: true);
    _askedPermission = PermissionType.doNotDisturb;
  }
}
