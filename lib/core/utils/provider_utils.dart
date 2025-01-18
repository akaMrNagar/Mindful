import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/models/usage_model.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/providers/new/apps_info_provider.dart';
import 'package:mindful/providers/restriction_groups_provider.dart';
import 'package:mindful/providers/wellbeing_provider.dart';

/// Initializes all the necessary providers and restarts services if needed
void initializeNecessaryProviders(WidgetRef ref) {
  ref.read(appsInfoProvider);
  ref.read(appsRestrictionsProvider);
  ref.read(restrictionGroupsProvider);
  ref.read(bedtimeScheduleProvider);
  ref.read(wellBeingProvider);
  ref.read(focusModeProvider);
  debugPrint("Necessary providers initialized.");
}


/// Generates a Map<DateTime, int> for the 7 days of the week starting
/// from the given date's start of the week, initializing all values to 0.
Map<DateTime, UsageModel> generateEmptyWeekUsage(DateTime dt) {
  final startOfWeek = dt.startOfWeek;

  return Map.fromEntries(
    List.generate(
        7, (i) => MapEntry(startOfWeek.add(i.days), const UsageModel())),
  );
}
