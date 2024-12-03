/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

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
}
