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

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/database/daos/unique_records_dao.dart';
import 'package:mindful/core/database/tables/focus_mode_table.dart';
import 'package:mindful/core/database/tables/focus_profile_table.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/focus_mode_model.dart';

/// A Riverpod state notifier provider that manages [FocusModeModel].
final focusModeProvider =
    StateNotifierProvider<FocusModeNotifier, FocusModeModel>(
  (ref) => FocusModeNotifier(),
);

/// This class manages the state of Focus Mode Settings.
class FocusModeNotifier extends StateNotifier<FocusModeModel> {
  late DynamicRecordsDao _dynamicDao;
  late UniqueRecordsDao _uniqueDao;
  Timer? _activeSessionTimer;

  FocusModeNotifier()
      : super(FocusModeModel(
          focusMode: FocusModeTable.defaultFocusModeModel,
          focusProfile: FocusProfileTable.defaultFocusProfileModel,
        )) {
    _init();
  }

  /// Initializes the state by loading from the database and setting up a listener for saving changes.
  void _init() async {
    _dynamicDao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    _uniqueDao = DriftDbService.instance.driftDb.uniqueRecordsDao;

    /// load from database
    final focusMode = await _uniqueDao.loadFocusModeSettings();
    final focusProfile =
        await _dynamicDao.fetchFocusProfileBySessionType(focusMode.sessionType);
    final activeSession = await _dynamicDao.fetchLastActiveFocusSession();

    /// update state
    state = state.copyWith(
      focusMode: focusMode,
      focusProfile: focusProfile,
      activeSession: activeSession,
    );

    /// restart session service if needed
    if (state.activeSession != null) {
      _startFocusSessionService(activeSession!);
    }
  }

  /// Enables or disables Do Not Disturb during the Focus Session.
  ///
  /// Checks for Do Not Disturb permission before enabling it.
  void setShouldStartDnd(bool shouldStartDnd) async {
    if (shouldStartDnd &&
        !await MethodChannelService.instance.getAndAskDndPermission()) {
      return;
    }
    state = state.copyWith(
      focusProfile: state.focusProfile.copyWith(shouldStartDnd: shouldStartDnd),
    );

    _updateFocusProfileInDb();
  }

  /// set the duration for the session
  void setSessionDuration(int durationSec) {
    state = state.copyWith(
      focusProfile: state.focusProfile.copyWith(sessionDuration: durationSec),
    );

    _updateFocusProfileInDb();
  }

  /// Adds or removes an app package from the list of distracting apps.
  void insertRemoveDistractingApp(String appPackage, bool shouldInsert) async {
    state = state.copyWith(
      focusProfile: state.focusProfile.copyWith(
        distractingApps: shouldInsert
            ? [...state.focusProfile.distractingApps, appPackage]
            : [
                ...state.focusProfile.distractingApps
                    .where((e) => e != appPackage)
              ],
      ),
    );

    _updateFocusProfileInDb();

    /// Update service if session is active
    if (state.activeSession != null) {
      await MethodChannelService.instance.updateFocusSession(
        distractingApps: state.focusProfile.distractingApps,
      );
    }
  }

  /// Set session type for current focus session.
  void setSessionType(SessionType sessionType) async {
    state = state.copyWith(
      focusMode: state.focusMode.copyWith(sessionType: sessionType),
      focusProfile:
          await _dynamicDao.fetchFocusProfileBySessionType(sessionType),
    );

    /// Update db
    _updateFocusModeInDb();
  }

  /// Starts a new focus session with the specified duration.
  ///
  /// Returns a [FocusSession] object representing the newly started session.
  Future<FocusSession> startNewSession() async {
    /// Insert session to database
    final session = await _dynamicDao.insertFocusSession(
      type: state.focusMode.sessionType,
      durationSecs: state.focusProfile.sessionDuration,
    );

    /// Start service
    await _startFocusSessionService(session);

    /// Update state
    state = state.copyWith(activeSession: session);

    /// Schedule the session timer
    _scheduleRefreshActiveSessionTimer(session.durationSecs.seconds);
    return session;
  }

  /// Ends the current active focus session, marking it as failed.
  ///
  /// Updates the session in the database and stops the focus session service.
  Future<void> giveUpOnActiveSession() async {
    if (state.activeSession == null) return;

    final updatedSession = state.activeSession!.copyWith(
      state: SessionState.failed,
      durationSecs: DateTime.now()
          .difference(state.activeSession!.startDateTime)
          .inSeconds,
    );

    /// Update session in database
    await _dynamicDao.updateFocusSessionById(updatedSession);

    /// Start service
    await MethodChannelService.instance.stopFocusSession();

    /// Cancel active session timer
    _activeSessionTimer?.cancel();

    state = state.copyWith(activeSession: null);
  }

  /// Starts the focus session service with the given session.
  Future<void> _startFocusSessionService(FocusSession session) async =>
      await MethodChannelService.instance.startFocusSession(
        durationSeconds: session.durationSecs,
        startTimeMsEpoch: session.startDateTime.millisecondsSinceEpoch,
        toggleDnd: state.focusProfile.shouldStartDnd,
        distractingApps: state.focusProfile.distractingApps,
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
    if (state.activeSession != null) {
      final timeDiffSecs = DateTime.now()
          .difference(state.activeSession!.startDateTime)
          .inSeconds;

      /// If session is completed then update it's state in Database
      if (timeDiffSecs >= state.activeSession!.durationSecs) {
        await _dynamicDao.updateFocusSessionById(
          state.activeSession!.copyWith(state: SessionState.successful),
        );

        state = state.copyWith(activeSession: null);
        _updateSessionsStreak();
        return;
      } else {
        // Adding 1 second ensures that the check occurs slightly after the session is supposed to end.
        final expectedToCompleteInSecs =
            (state.activeSession!.durationSecs - timeDiffSecs + 1);
        _scheduleRefreshActiveSessionTimer(expectedToCompleteInSecs.seconds);
      }
    }
  }

  /// Update the streaks in database on the basis of current streak
  void _updateSessionsStreak() async {
    /// If streak is already updated then return
    final today = DateTime.now().dateOnly;
    if (state.focusMode.lastTimeStreakUpdated.dateOnly == today) return;

    final newStreak = state.focusMode.currentStreak + 1;

    state = state.copyWith(
      focusMode: state.focusMode.copyWith(
        currentStreak: newStreak,
        longestStreak: max(newStreak, state.focusMode.longestStreak),
        lastTimeStreakUpdated: today,
      ),
    );

    _updateFocusModeInDb();
  }

  void _updateFocusModeInDb() async =>
      await _uniqueDao.saveFocusModeSettings(state.focusMode);

  void _updateFocusProfileInDb() async =>
      await _dynamicDao.insertFocusProfileBySessionType(state.focusProfile);

  @override
  void dispose() {
    super.dispose();
    _activeSessionTimer?.cancel();
  }
}
