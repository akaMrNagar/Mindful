/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';

/// Type of session used for differentiating focus sessions
enum SessionType {
  study,
  work,
  exercise,
  meditation,
  creativeWriting,
  reading,
  programming,
  chores,
  projectPlanning,
  artAndDesign,
  languageLearning,
  musicPractice,
  selfCare,
  brainstorming,
  skillDevelopment,
  research,
  networking,
  cooking,
  sportsTraining,
  restAndRelaxation,
  other,
}

/// Map of [SessionType] and their respective localized string labels or titles
Map<SessionType, String> sessionTypeLabels(BuildContext context) => {
      SessionType.study: context.locale.focus_session_type_study,
      SessionType.work: context.locale.focus_session_type_work,
      SessionType.exercise: context.locale.focus_session_type_exercise,
      SessionType.meditation: context.locale.focus_session_type_meditation,
      SessionType.creativeWriting:
          context.locale.focus_session_type_creativeWriting,
      SessionType.reading: context.locale.focus_session_type_reading,
      SessionType.programming: context.locale.focus_session_type_programming,
      SessionType.chores: context.locale.focus_session_type_chores,
      SessionType.projectPlanning:
          context.locale.focus_session_type_projectPlanning,
      SessionType.artAndDesign: context.locale.focus_session_type_artAndDesign,
      SessionType.languageLearning:
          context.locale.focus_session_type_languageLearning,
      SessionType.musicPractice:
          context.locale.focus_session_type_musicPractice,
      SessionType.selfCare: context.locale.focus_session_type_selfCare,
      SessionType.brainstorming:
          context.locale.focus_session_type_brainstorming,
      SessionType.skillDevelopment:
          context.locale.focus_session_type_skillDevelopment,
      SessionType.research: context.locale.focus_session_type_research,
      SessionType.networking: context.locale.focus_session_type_networking,
      SessionType.cooking: context.locale.focus_session_type_cooking,
      SessionType.sportsTraining:
          context.locale.focus_session_type_sportsTraining,
      SessionType.restAndRelaxation:
          context.locale.focus_session_type_restAndRelaxation,
      SessionType.other: context.locale.focus_session_type_other,
    };

/// Map of [SessionType] and their respective icons [IconData]
const Map<SessionType, IconData> sessionTypeIcons = {
  SessionType.study: FluentIcons.class_20_regular,
  SessionType.work: FluentIcons.tasks_app_20_regular,
  SessionType.exercise: FluentIcons.dumbbell_20_regular,
  SessionType.meditation: FluentIcons.communication_20_regular,
  SessionType.creativeWriting: FluentIcons.calligraphy_pen_20_regular,
  SessionType.reading: FluentIcons.reading_list_20_regular,
  SessionType.programming: FluentIcons.code_20_regular,
  SessionType.chores: FluentIcons.bot_20_regular,
  SessionType.projectPlanning: FluentIcons.broad_activity_feed_20_regular,
  SessionType.artAndDesign: FluentIcons.color_20_regular,
  SessionType.languageLearning: FluentIcons.local_language_20_regular,
  SessionType.musicPractice: FluentIcons.music_note_1_20_regular,
  SessionType.selfCare: FluentIcons.bowl_salad_20_regular,
  SessionType.brainstorming: FluentIcons.brain_circuit_20_regular,
  SessionType.skillDevelopment: FluentIcons.device_eq_20_regular,
  SessionType.research: FluentIcons.slide_search_20_regular,
  SessionType.networking: FluentIcons.people_community_20_regular,
  SessionType.cooking: FluentIcons.food_20_regular,
  SessionType.sportsTraining: FluentIcons.sport_20_regular,
  SessionType.restAndRelaxation: FluentIcons.drink_coffee_20_regular,
  SessionType.other: FluentIcons.approvals_app_20_regular,
};
