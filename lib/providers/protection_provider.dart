import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/isar/protection_model.dart';

final protectionProvider =
    StateNotifierProvider<ProtectionNotifier, ProtectionModel>((ref) {
  return ProtectionNotifier();
});

class ProtectionNotifier extends StateNotifier<ProtectionModel> {
  ProtectionNotifier() : super(const ProtectionModel()) {
    _init();
  }

  void _init() {}

  // void toggleBlockApps() => state = state.copyWith(blockApps: !state.blockApps);
  // void toggleBlockWebsites() =>
  //     state = state.copyWith(blockWebsites: !state.blockWebsites);
}
