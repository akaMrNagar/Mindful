import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/services/isar_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/isar/focus_session.dart';
import 'package:mindful/providers/focus_mode_provider.dart';

/// A Riverpod state notifier provider that manages active focus session.
final activeSessionProvider =
    StateNotifierProvider<ActiveSessionNotifier, AsyncValue<FocusSession?>>(
  (ref) => ActiveSessionNotifier(ref),
);

/// This class manages the state of global application settings.
class ActiveSessionNotifier extends StateNotifier<AsyncValue<FocusSession?>> {
  final StateNotifierProviderRef ref;

  ActiveSessionNotifier(this.ref) : super(const AsyncLoading()) {
    refreshActiveSessionState();
  }

  ///
  ///
  ///
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
        state = const AsyncData(null);
        ref.read(focusModeProvider.notifier).updateSessionsStreak();
        return;
      }
    }

    state = AsyncData(activeSession);
  }

  /// Start a new focus session.
  Future<FocusSession> startNewSession({
    required int durationSeconds,
    required SessionType type,
    required bool toggleDnd,
    required List<String> distractingApps,
  }) async {
    final session = FocusSession(
      durationSecs: durationSeconds,
      type: type,
      startTimeMsEpoch: DateTime.now().millisecondsSinceEpoch,
    );

    /// Start service
    await MethodChannelService.instance.startFocusSession(
      toggleDnd: toggleDnd,
      durationSeconds: durationSeconds,
      distractingApps: distractingApps,
    );

    /// Insert session to database
    await IsarDbService.instance.insertFocusSession(session);

    /// Update state
    state = AsyncData(session);
    return session;
  }

  Future<void> giveUpOnCurrentSession() async {
    if (state.value == null) return;

    final updatedSession = state.value!.copyWith(
      state: SessionState.failed,
      durationSecs: DateTime.now().difference(state.value!.startTime).inSeconds,
    );

    /// Update session in database
    await IsarDbService.instance.insertFocusSession(updatedSession);

    /// Start service
    await MethodChannelService.instance.stopFocusSession();
    state = const AsyncData(null);
  }
}
