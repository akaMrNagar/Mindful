import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/focus_mode_settings.dart';
import 'package:mindful/models/isar/focus_session.dart';

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
    final cache = await IsarDbService.instance.loadFocusModeSettings();

    /// TODO: Check from native if the last session is completed or not
    /// if completed then update database
    final lastSession =
        await IsarDbService.instance.loadLastActiveFocusSession();

    state = cache.copyWith(
      lastSession: lastSession,
    );

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

  /// Start a new focus session.
  Future<void> startNewSession(int durationSeconds) async {
    final session = FocusSession(
      durationSecs: durationSeconds,
      type: state.sessionType,
      startTimeMsEpoch: DateTime.now().millisecondsSinceEpoch,
    );

    /// Insert session to database
    await IsarDbService.instance.insertFocusSession(session);

    /// Update state
    state = state.copyWith(
      lastSession: session,
    );
  }

  ///
  ///
  ///
  Future<void> giveUpOnLastSession() async {
    final updatedSession = state.lastSession!.copyWith(
      endTimeMsEpoch: DateTime.now().millisecondsSinceEpoch,
      state: SessionState.failed,
    );

    /// Update session in database
    await IsarDbService.instance.insertFocusSession(updatedSession);
    state = state.copyWith(lastSession: null);
  }
}
