import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/permission_type.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/permissions_model.dart';

final permissionProvider =
    StateNotifierProvider<PermissionNotifier, PermissionsModel>((ref) {
  return PermissionNotifier();
});

class PermissionNotifier extends StateNotifier<PermissionsModel> {
  PermissionNotifier() : super(PermissionsModel()) {
    _init();
  }

  void _init() async {
    // Listen to app resume events
    MethodChannelService.instance.addOnResumeListener(onAppResume);
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

  PermissionType _askedPermission = PermissionType.none;

  void onAppResume(bool _) async {
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
