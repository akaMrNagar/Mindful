/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/app_theme_mode.dart';
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/default_models_utils.dart';

/// A Riverpod state notifier provider that manages [MindfulSettings].
final mindfulSettingsProvider =
    StateNotifierProvider<MindfulSettingsNotifier, MindfulSettings>(
  (ref) => MindfulSettingsNotifier(),
);

/// This class manages the state of mindful settings.
class MindfulSettingsNotifier extends StateNotifier<MindfulSettings> {
  MindfulSettingsNotifier() : super(defaultMindfulSettingsModel) {
    init(addListenerToo: true);
  }

  /// Initializes the settings state by loading from the database and setting up a listener for saving changes.
  Future<MindfulSettings> init({bool addListenerToo = false}) async {
    final dao = DriftDbService.instance.driftDb.uniqueRecordsDao;
    state = await dao.loadMindfulSettings();
    await MethodChannelService.instance
        .updateLocale(languageCode: state.localeCode);

    if (addListenerToo) {
      /// Run after a delay to avoid database deadlock
      /// Listen to provider and save changes to Isar database
      Future.delayed(
        1.seconds,
        () => addListener(
          fireImmediately: false,
          (state) => dao.saveMindfulSettings(state),
        ),
      );
    }

    return state;
  }

  /// Changes the username for dashboard.
  void changeUsername(String username) =>
      state = state.copyWith(username: username);

  /// Changes the application's theme mode.
  void changeThemeMode(AppThemeMode mode) =>
      state = state.copyWith(themeMode: mode);

  /// Changes the application's color theme.
  void changeColor(String color) => state = state.copyWith(accentColor: color);

  /// Switch AMOLED dark mode
  void switchAmoledDark() =>
      state = state.copyWith(useAmoledDark: !state.useAmoledDark);

  /// Switch dynamic color
  void switchDynamicColor() =>
      state = state.copyWith(useDynamicColors: !state.useDynamicColors);

  /// Changes app locale if it is supported.
  void changeLocale(String localeCode) async {
    if (AppLocalizations.supportedLocales.any(
      (e) => e.languageCode == localeCode,
    )) {
      /// Update state
      state = state.copyWith(localeCode: localeCode);

      /// Update native side
      await MethodChannelService.instance
          .updateLocale(languageCode: localeCode);
    }
  }

  /// Changes the default initial home tab.
  void changeHomeTab(DefaultHomeTab tab) =>
      state = state.copyWith(defaultHomeTab: tab);

  /// Changes navigation bar from side to bottom
  void switchBottomNavigation() =>
      state = state.copyWith(useBottomNavigation: !state.useBottomNavigation);

  /// Update the emergency pass count if last used timestamp is before today midnight
  /// and returns it
  int getUpdatedEmergencyPassCount() {
    final todayMidnight = DateTime.now().dateOnly;

    /// Reset emergency passes if the last timestamp is from yesterday
    if (state.lastEmergencyUsed.isBefore(todayMidnight)) {
      state = state.copyWith(leftEmergencyPasses: 3);
    }

    return state.leftEmergencyPasses;
  }

  /// Use emergency pause pass and pause the tracking service
  void useEmergencyPausePass() => state = state.copyWith(
        lastEmergencyUsed: DateTime.now(),
        leftEmergencyPasses: state.leftEmergencyPasses - 1,
      );

  /// Mark onboarding as completed
  void markOnboardingDone() => state = state.copyWith(isOnboardingDone: true);

  /// Switch protected access
  void switchProtectedAccess() =>
      state = state.copyWith(protectedAccess: !state.protectedAccess);

  /// Changes the time of day when uninstall widow starts for 5 minutes.
  void changeUninstallWindowTime(TimeOfDayAdapter time) =>
      state = state.copyWith(uninstallWindowTime: time);
}
