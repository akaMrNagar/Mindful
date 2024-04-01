import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/isar/settings_model.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsModel>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<SettingsModel> {
  SettingsNotifier() : super(const SettingsModel());
}
