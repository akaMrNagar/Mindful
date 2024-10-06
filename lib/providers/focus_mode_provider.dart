/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:async';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/database/tables/focus_mode_table.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';

/// A Riverpod state notifier provider that manages Focus Mode Settings.
final focusModeProvider = StateNotifierProvider<FocusModeNotifier, FocusMode>(
  (ref) => FocusModeNotifier(),
);

/// This class manages the state of Focus Mode Settings.
class FocusModeNotifier extends StateNotifier<FocusMode> {
  late DynamicRecordsDao _dynamicDao;
  Timer? _activeSessionTimer;
  FocusSession? activeSession;

  FocusModeNotifier() : super(FocusModeTable.defaultFocusModeModel) {
    _init();
  }

  /// Initializes the state by loading from the database and setting up a listener for saving changes.
  void _init() async {
    _dynamicDao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    final uniqueDao = DriftDbService.instance.driftDb.uniqueRecordsDao;

    /// update state
    state = await uniqueDao.loadFocusModeSettings();

    /// restart session service if needed
    if (state.activeSessionId != null) {
      activeSession =
          await _dynamicDao.fetchFocusSessionById(state.activeSessionId!);

      if (activeSession != null) _startFocusSessionService(activeSession!);
    }

    /// Listen to provider and save changes to Isar database
    addListener(
      fireImmediately: false,
      (state) => uniqueDao.saveFocusModeSettings(state),
    );
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

    /// Update service if session is active
    if (activeSession != null) {
      await MethodChannelService.instance.updateFocusSession(
        distractingApps: state.distractingApps,
      );
    }
  }

  /// Set session type for current focus session.
  void setSessionType(SessionType sessionType) =>
      state = state.copyWith(sessionType: sessionType);

  /// Starts a new focus session with the specified duration.
  ///
  /// Returns a [FocusSession] object representing the newly started session.
  Future<FocusSession> startNewSession({
    required int durationSeconds,
  }) async {
    /// Insert session to database
    final session = await _dynamicDao.insertFocusSession(
      type: state.sessionType,
      durationSecs: durationSeconds,
    );

    /// Start service
    await _startFocusSessionService(session);

    /// Update state
    state = state.copyWith(activeSessionId: Value(session.id));

    /// Schedule the session timer
    _scheduleRefreshActiveSessionTimer(durationSeconds.seconds);
    return session;
  }

  /// Ends the current active focus session, marking it as failed.
  ///
  /// Updates the session in the database and stops the focus session service.
  Future<void> giveUpOnActiveSession() async {
    if (activeSession == null) return;

    final updatedSession = activeSession!.copyWith(
      state: SessionState.failed,
      durationSecs:
          DateTime.now().difference(activeSession!.startDateTime).inSeconds,
    );

    /// Update session in database
    await _dynamicDao.updateFocusSessionById(updatedSession);

    /// Start service
    await MethodChannelService.instance.stopFocusSession();

    /// Cancel active session timer
    _activeSessionTimer?.cancel();

    activeSession = null;
    state = state.copyWith(activeSessionId: const Value(null));
  }

  /// Starts the focus session service with the given session.
  Future<void> _startFocusSessionService(FocusSession session) async =>
      await MethodChannelService.instance.startFocusSession(
        durationSeconds: session.durationSecs,
        startTimeMsEpoch: session.startDateTime.millisecondsSinceEpoch,
        toggleDnd: state.shouldStartDnd,
        distractingApps: state.distractingApps,
      );

  /// This function schedules a future check call to [_checkAndUpdateActiveSession]
  /// with the specified [Duration] delay
  void _scheduleRefreshActiveSessionTimer(Duration delay) {
    _activeSessionTimer?.cancel();
    _activeSessionTimer = Timer(delay, _checkAndUpdateActiveSession);
  }

  /// Checks and updates the active session status.
  ///
  /// This function checks whether the last active focus session is still ongoing
  /// or if it needs to be marked as successful based on the session's duration.
  /// If the session is still active, it schedules a future check when the session is expected to complete.
  Future<void> _checkAndUpdateActiveSession() async {
    if (activeSession != null) {
      final timeDiffSecs =
          DateTime.now().difference(activeSession!.startDateTime).inSeconds;

      /// If session is completed then update it's state in Database
      if (timeDiffSecs >= activeSession!.durationSecs) {
        await _dynamicDao.updateFocusSessionById(
          activeSession!.copyWith(state: SessionState.successful),
        );

        activeSession = null;
        state = state.copyWith(activeSessionId: const Value(null));
        _updateSessionsStreak();
        return;
      } else {
        // Adding 1 second ensures that the check occurs slightly after the session is supposed to end.
        final expectedToCompleteInSecs =
            (activeSession!.durationSecs - timeDiffSecs + 1);
        _scheduleRefreshActiveSessionTimer(expectedToCompleteInSecs.seconds);
      }
    }
  }

  /// Update the streaks in database on the basis of current streak
  void _updateSessionsStreak() async {
    /// If streak is already updated then return
    final today = DateTime.now().dateOnly;
    if (state.lastTimeStreakUpdated.dateOnly == today) return;

    final newStreak = state.currentStreak + 1;

    state = state.copyWith(
      currentStreak: newStreak,
      longestStreak: max(newStreak, state.longestStreak),
      lastTimeStreakUpdated: today,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _activeSessionTimer?.cancel();
  }
}
