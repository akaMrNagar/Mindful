
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
  DateTime get endTime => DateTime.fromMillisecondsSinceEpoch(endTimeMsEpoch);

  @ignore
  DateTime get startTime =>
      DateTime.fromMillisecondsSinceEpoch(startTimeMsEpoch);

  @ignore
  Duration get duration => durationSecs.seconds;

  @enumerated
  final SessionType type;

  @enumerated
  final SessionState state;

  final int startTimeMsEpoch;

  final int endTimeMsEpoch;

  final int durationSecs;

  final int breakDurationSecs;
  

  const FocusSession({
    this.id = Isar.autoIncrement,
    this.state = SessionState.active,
    this.endTimeMsEpoch = 0,
    this.breakDurationSecs = 0,
    required this.type,
    required this.startTimeMsEpoch,
    required this.durationSecs,
  });

  FocusSession copyWith({
    SessionType? type,
    SessionState? state,
    int? startTimeMsEpoch,
    int? endTimeMsEpoch,
    int? durationSecs,
    int? breakDurationSecs,
  }) {
    return FocusSession(
      id: id,
      type: type ?? this.type,
      state: state ?? this.state,
      startTimeMsEpoch: startTimeMsEpoch ?? this.startTimeMsEpoch,
      endTimeMsEpoch: endTimeMsEpoch ?? this.endTimeMsEpoch,
      durationSecs: durationSecs ?? this.durationSecs,
      breakDurationSecs: breakDurationSecs ?? this.breakDurationSecs,
    );
  }
}
