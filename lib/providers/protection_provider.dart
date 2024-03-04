import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/internet_protection_info.dart';

final protectionProvider =
    StateNotifierProvider<ProtectionNotifier, InternetProtectionInfo>((ref) {
  return ProtectionNotifier();
});

class ProtectionNotifier extends StateNotifier<InternetProtectionInfo> {
  ProtectionNotifier() : super(const InternetProtectionInfo()) {
    _init();
  }

  void _init() {}

  void toggleBlockApps() => state = state.copyWith(blockApps: !state.blockApps);
  void toggleBlockWebsites() =>
      state = state.copyWith(blockWebsites: !state.blockWebsites);
}
