import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    state = state.copyWith();
  }

  void askAccessibilityPermission() async {
    await MethodChannelService.instance.startAccessibilityService();
  }
}
