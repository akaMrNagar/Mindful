/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/models/isar/focus_session.dart';
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
  final FocusSession? activeSession;

  @ignore
  DateTime get lastStreakUpdatedDay =>
      DateTime.fromMillisecondsSinceEpoch(lastStreakUpdatedDayMsEpoch).dateOnly;

  const FocusModeSettings({
    this.activeSession,
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
    FocusSession? activeSession,
  }) {
    return FocusModeSettings(
      sessionType: sessionType ?? this.sessionType,
      shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
      distractingApps: distractingApps ?? this.distractingApps,
      longestStreak: longestStreak ?? this.longestStreak,
      currentStreak: currentStreak ?? this.currentStreak,
      lastStreakUpdatedDayMsEpoch:
          lastStreakUpdatedDayMsEpoch ?? this.lastStreakUpdatedDayMsEpoch,
      activeSession: activeSession,
    );
  }
}
