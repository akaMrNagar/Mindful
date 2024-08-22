import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';

import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
part 'focus_mode_settings.g.dart';

@immutable
@collection
class FocusModeSettings {
  /// ID for isar database
  Id get id => 0;

  @enumerated
  final SessionType sessionType;

  final bool shouldStartDnd;

  final List<String> distractingApps;

  final int longestStreak;

  final int currentStreak;

  final int lastStreakUpdatedDayMsEpoch;

  @ignore
  DateTime get lastStreakUpdatedDay =>
      DateTime.fromMillisecondsSinceEpoch(lastStreakUpdatedDayMsEpoch).dateOnly;

  const FocusModeSettings({
    this.sessionType = SessionType.study,
    this.shouldStartDnd = false,
    this.distractingApps = const [],
    this.longestStreak = 0,
    this.currentStreak = 0,
    this.lastStreakUpdatedDayMsEpoch = 0,
  });

  FocusModeSettings copyWith({
    SessionType? sessionType,
    bool? shouldStartDnd,
    List<String>? distractingApps,
    int? longestStreak,
    int? currentStreak,
    int? lastStreakUpdatedDayMsEpoch,
  }) {
    return FocusModeSettings(
      sessionType: sessionType ?? this.sessionType,
      shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
      distractingApps: distractingApps ?? this.distractingApps,
      longestStreak: longestStreak ?? this.longestStreak,
      currentStreak: currentStreak ?? this.currentStreak,
      lastStreakUpdatedDayMsEpoch:
          lastStreakUpdatedDayMsEpoch ?? this.lastStreakUpdatedDayMsEpoch,
    );
  }
}