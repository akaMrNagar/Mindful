import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:isar/isar.dart';

import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/core/enums/session_type.dart';

part 'focus_session.g.dart';

@immutable
@collection
class FocusSession {
  /// ID for isar database
  final Id id;

  @ignore
  DateTime get startTime =>
      DateTime.fromMillisecondsSinceEpoch(startTimeMsEpoch);

  @ignore
  Duration get duration => durationSecs.seconds;

  @enumerated
  final SessionType type;

  @enumerated
  final SessionState state;

  @Index(unique: true, replace: true)
  final int startTimeMsEpoch;

  final int durationSecs;

  const FocusSession({
    this.id = Isar.autoIncrement,
    this.state = SessionState.active,
    required this.type,
    required this.startTimeMsEpoch,
    required this.durationSecs,
  });

  FocusSession copyWith({
    SessionType? type,
    SessionState? state,
    int? startTimeMsEpoch,
    int? durationSecs,
  }) {
    return FocusSession(
      id: id,
      type: type ?? this.type,
      state: state ?? this.state,
      startTimeMsEpoch: startTimeMsEpoch ?? this.startTimeMsEpoch,
      durationSecs: durationSecs ?? this.durationSecs,
    );
  }

  @override
  String toString() {
    return 'FocusSession(id: $id, type: $type, state: $state, startTimeMsEpoch: $startTimeMsEpoch, durationSecs: $durationSecs)';
  }
}
