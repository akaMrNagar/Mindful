import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';

import 'package:mindful/core/enums/session_type.dart';
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

  const FocusModeSettings({
    this.sessionType = SessionType.study,
    this.shouldStartDnd = false,
    this.distractingApps = const [],
  });

  FocusModeSettings copyWith({
    SessionType? sessionType,
    bool? shouldStartDnd,
    List<String>? distractingApps,
    FocusSession? lastSession,
  }) {
    return FocusModeSettings(
      sessionType: sessionType ?? this.sessionType,
      shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
      distractingApps: distractingApps ?? this.distractingApps,
    );
  }
}
