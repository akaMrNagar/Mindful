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

/// Map of [SessionType] and their respective string labels or titles
const Map<SessionType, String> sessionTypeLabels = {
  SessionType.study: 'Study',
  SessionType.work: 'Work',
  SessionType.exercise: 'Exercise',
  SessionType.meditation: 'Meditation',
  SessionType.creativeWriting: 'Creative Writing',
  SessionType.reading: 'Reading',
  SessionType.programming: 'Programming',
  SessionType.chores: 'Chores',
  SessionType.projectPlanning: 'Project Planning',
  SessionType.artAndDesign: 'Art and Design',
  SessionType.languageLearning: 'Language Learning',
  SessionType.musicPractice: 'Music Practice',
  SessionType.selfCare: 'Self-Care',
  SessionType.brainstorming: 'Brainstorming',
  SessionType.skillDevelopment: 'Skill Development',
  SessionType.research: 'Research',
  SessionType.networking: 'Networking',
  SessionType.cooking: 'Cooking',
  SessionType.sportsTraining: 'Sports Training',
  SessionType.restAndRelaxation: 'Rest and Relaxation',
  SessionType.other: 'Other',
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
