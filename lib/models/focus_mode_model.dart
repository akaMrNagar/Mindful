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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';

/// A model containing both [FocusMode] and [FocusProfile] along with nullable active [FocusSession].
@immutable
class FocusModeModel {
  final FocusMode focusMode;
  final FocusProfile focusProfile;
  final AsyncValue<FocusSession?> activeSession;
  final int elapsedTimeSec;

  const FocusModeModel({
    required this.focusMode,
    required this.focusProfile,
    this.activeSession = const AsyncLoading(),
    this.elapsedTimeSec = 0,
  });

  FocusModeModel removeActiveSession() {
    return FocusModeModel(
      focusMode: focusMode,
      focusProfile: focusProfile,
      elapsedTimeSec: elapsedTimeSec,
      activeSession: const AsyncData(null),
    );
  }

  FocusModeModel copyWith({
    FocusMode? focusMode,
    FocusProfile? focusProfile,
    FocusSession? activeSession,
    int? elapsedTimeSec,
  }) {
    return FocusModeModel(
      focusMode: focusMode ?? this.focusMode,
      focusProfile: focusProfile ?? this.focusProfile,
      elapsedTimeSec: elapsedTimeSec ?? this.elapsedTimeSec,
      activeSession: AsyncData(activeSession ?? this.activeSession.value),
    );
  }
}
