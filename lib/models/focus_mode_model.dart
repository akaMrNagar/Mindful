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
import 'package:mindful/core/database/app_database.dart';


/// A model containing both [FocusMode] and [FocusProfile] along with nullable active [FocusSession].
@immutable
class FocusModeModel {
  final FocusMode focusMode;
  final FocusProfile focusProfile;
  final FocusSession? activeSession;

  const FocusModeModel({
    required this.focusMode,
    required this.focusProfile,
    this.activeSession,
  });

  FocusModeModel copyWith({
    FocusMode? focusMode,
    FocusProfile? focusProfile,
    FocusSession? activeSession,
  }) {
    return FocusModeModel(
      focusMode: focusMode ?? this.focusMode,
      focusProfile: focusProfile ?? this.focusProfile,
      activeSession: activeSession,
    );
  }
}
