/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/focus_mode_settings.dart';
import 'package:mindful/models/isar/focus_session.dart';

/// A Riverpod state notifier provider that manages Focus Mode Settings.
final focusModeProvider =
    StateNotifierProvider<FocusModeNotifier, FocusModeSettings>(
  (ref) => FocusModeNotifier(),
);

/// This class manages the state of Focus Mode Settings.
class FocusModeNotifier extends StateNotifier<FocusModeSettings> {
  FocusModeNotifier() : super(const FocusModeSettings()) {
    _init();
  }

  /// Initializes the state by loading from the database and setting up a listener for saving changes.
  void _init() async {
    state = await IsarDbService.instance.loadFocusModeSettings();
    await refreshActiveSessionState();

    /// Start service if already not running
    if (state.activeSession != null) {
      startFocusSessionService(state.activeSession!);
    }

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

    if (state.activeSession != null) {
      await MethodChannelService.instance.updateFocusSession(
        distractingApps: state.distractingApps,
      );
    }
  }

  /// Set session type for current focus session.
  void setSessionType(SessionType sessionType) =>
      state = state.copyWith(sessionType: sessionType);

  /// Update the streaks in database on the basis of current streak
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

  /// Refresh the state for active session
  ///
  /// Checks if the last active session is still ongoing or if it needs to be marked as successful.
  Future<void> refreshActiveSessionState() async {
    final activeSession =
        await IsarDbService.instance.loadLastActiveFocusSession();

    if (activeSession != null) {
      final timeDiffSecs =
          DateTime.now().difference(activeSession.startTime).inSeconds;

      /// If session is completed then update it's state in Database
      if (timeDiffSecs >= activeSession.durationSecs) {
        await IsarDbService.instance.insertFocusSession(
          activeSession.copyWith(state: SessionState.successful),
        );
        state = state.copyWith(activeSession: null);
        updateSessionsStreak();
        return;
      }
    }

    state = state.copyWith(activeSession: activeSession);
  }

  /// Starts a new focus session with the specified duration.
  ///
  /// Returns a [FocusSession] object representing the newly started session.
  Future<FocusSession> startNewSession({
    required int durationSeconds,
  }) async {
    final session = FocusSession(
      durationSecs: durationSeconds,
      type: state.sessionType,
      startTimeMsEpoch: DateTime.now().millisecondsSinceEpoch,
    );

    /// Start service
    await startFocusSessionService(session);

    /// Insert session to database
    await IsarDbService.instance.insertFocusSession(session);

    /// Update state
    state = state.copyWith(activeSession: session);
    return session;
  }

  /// Ends the current active focus session, marking it as failed.
  ///
  /// Updates the session in the database and stops the focus session service.
  Future<void> giveUpOnActiveSession() async {
    if (state.activeSession == null) return;

    final updatedSession = state.activeSession!.copyWith(
      state: SessionState.failed,
      durationSecs:
          DateTime.now().difference(state.activeSession!.startTime).inSeconds,
    );

    /// Update session in database
    await IsarDbService.instance.insertFocusSession(updatedSession);

    /// Start service
    await MethodChannelService.instance.stopFocusSession();
    state = state.copyWith(activeSession: null);
  }

  /// Starts the focus session service with the given session.
  Future<void> startFocusSessionService(FocusSession session) async =>
      await MethodChannelService.instance.startFocusSession(
        durationSeconds: session.durationSecs,
        startTimeMsEpoch: session.startTimeMsEpoch,
        toggleDnd: state.shouldStartDnd,
        distractingApps: state.distractingApps,
      );
}
