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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/models/usage_model.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/providers/focus_mode_provider.dart';
import 'package:mindful/providers/restriction_groups_provider.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// DateTime.now()
DateTime get now => DateTime.now();

/// Get the date for today (Midnight 12).
/// The returned date will not have any time set.
///
/// Ex- 2025-01-01 00:00:00:000
DateTime get dateToday => DateTime.now().dateOnly;

/// Get the SQLITE database file path: /data/user/0/com.mindful.android/app_flutter/Mindful.sqlite
Future<String> getSqliteDbPath() async => path.join(
      (await getApplicationDocumentsDirectory()).path,
      'Mindful.sqlite',
    );

/// Calculates the day index for today (0-based) within the current week,
/// adjusted to start on Sunday (like Java) instead of Monday (default in Dart).
int get todayOfWeek => _formatWeekDayToSunday(now.weekday) - 1;

/// Internal helper function to adjust the day of week index to start on Sunday
/// (like Java) instead of Monday (default in Dart).
///
/// This function takes the original `weekday` value (0-6) and maps it to
/// a new value considering Sunday as the first day (0).
int _formatWeekDayToSunday(int weekDay) {
  return switch (weekDay) {
    DateTime.monday => DateTime.tuesday,
    DateTime.tuesday => DateTime.wednesday,
    DateTime.wednesday => DateTime.thursday,
    DateTime.thursday => DateTime.friday,
    DateTime.friday => DateTime.saturday,
    DateTime.saturday => DateTime.sunday,
    DateTime.sunday => DateTime.monday,
    int() => 1,
  };
}

/// Resolves [ItemPosition] from the given [index] and [length] of the item in the list
ItemPosition getItemPositionInList(int index, int length) => length <= 1
    ? ItemPosition.none
    : index == 0
        ? ItemPosition.top
        : index == (length - 1)
            ? ItemPosition.bottom
            : ItemPosition.mid;

/// Creates [BorderRadius] from the given [ItemPosition] for the group item
BorderRadius getBorderRadiusFromPosition(ItemPosition position) =>
    switch (position) {
      ItemPosition.none => BorderRadius.circular(24),

      /// Top
      ItemPosition.topLeft =>
        const BorderRadius.all(Radius.circular(6)).copyWith(
          topLeft: const Radius.circular(24),
        ),
      ItemPosition.top => const BorderRadius.vertical(
          top: Radius.circular(24),
          bottom: Radius.circular(6),
        ),
      ItemPosition.topRight =>
        const BorderRadius.all(Radius.circular(6)).copyWith(
          topRight: const Radius.circular(24),
        ),

      // Mid
      ItemPosition.left => const BorderRadius.horizontal(
          right: Radius.circular(6),
          left: Radius.circular(24),
        ),
      ItemPosition.mid => BorderRadius.circular(6),
      ItemPosition.right => const BorderRadius.horizontal(
          left: Radius.circular(6),
          right: Radius.circular(24),
        ),

      // Bottom
      ItemPosition.bottomLeft =>
        const BorderRadius.all(Radius.circular(6)).copyWith(
          bottomLeft: const Radius.circular(24),
        ),
      ItemPosition.bottom => const BorderRadius.vertical(
          top: Radius.circular(6),
          bottom: Radius.circular(24),
        ),
      ItemPosition.bottomRight =>
        const BorderRadius.all(Radius.circular(6)).copyWith(
          bottomRight: const Radius.circular(24),
        ),
    };

/// Invoke the method in the [try/catch] block and print the error if it occurred
Future<void> runSafe(String tag, Future<void> Function() method) async {
  try {
    await method();
  } catch (e) {
    debugPrint("Error Occurred [$tag] : ${e.toString()}");
  }
}

/// Initializes all the necessary providers and restarts services if needed
void initializeNecessaryProviders(WidgetRef ref) {
  ref.read(appsProvider);
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
    List.generate(7, (i) => MapEntry(startOfWeek.add(i.days), const UsageModel())),
  );
}
