import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/focus_mode_settings.dart';

/// A Riverpod state notifier provider that manages focus mode settings.
final focusModeProvider =
    StateNotifierProvider<FocusModeNotifier, FocusModeSettings>(
  (ref) => FocusModeNotifier(),
);

/// This class manages the state of global application settings.
class FocusModeNotifier extends StateNotifier<FocusModeSettings> {
  FocusModeNotifier() : super(const FocusModeSettings()) {
    _init();
  }

  /// Initializes the state by loading from the database and setting up a listener for saving changes.
  void _init() async {
    state = await IsarDbService.instance.loadFocusModeSettings();

    /// Listen to provider and save changes to Isar database
    addListener((state) async {
      await IsarDbService.instance.saveFocusModeSettings(state);
    });
  }

  /// Enables or disables Do Not Disturb during the Focus Session.
  ///
  /// Checks for Do Not Disturb permission before enabling it.
  void setShouldStartDnd(bool shouldStartDnd) async {
    if (shouldStartDnd &&
        !await MethodChannelService.instance.getAndAskDndPermission()) {
      return;
    }
    state = state.copyWith(shouldStartDnd: shouldStartDnd);
  }

  /// Adds or removes an app package from the list of distracting apps.
  void insertRemoveDistractingApp(String appPackage, bool shouldInsert) async {
    state = state.copyWith(
      distractingApps: shouldInsert
          ? [...state.distractingApps, appPackage]
          : [...state.distractingApps.where((e) => e != appPackage)],
    );
  }

  /// Set session type for current focus session.
  void setSessionType(SessionType sessionType) =>
      state = state.copyWith(sessionType: sessionType);

  void updateSessionsStreak() async {
    /// If streak is already updated then return
    final today = DateTime.now().dateOnly;
    if (state.lastStreakUpdatedDay == today) return;

    final currentStreak = await IsarDbService.instance.loadCurrentStreak();

    /// Return if no change in streaks
    if (currentStreak == state.currentStreak) return;

    state = state.copyWith(
      currentStreak: currentStreak,
      longestStreak: max(currentStreak, state.longestStreak),
      lastStreakUpdatedDayMsEpoch: today.millisecondsSinceEpoch,
    );
  }
}
