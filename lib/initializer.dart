import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/apps/apps_info_provider.dart';
import 'package:mindful/providers/focus/focus_mode_provider.dart';
import 'package:mindful/providers/restrictions/apps_restrictions_provider.dart';
import 'package:mindful/providers/restrictions/bedtime_provider.dart';
import 'package:mindful/providers/restrictions/restriction_groups_provider.dart';
import 'package:mindful/providers/restrictions/wellbeing_provider.dart';

/// Initializer to initialize necessary things post onboarding or pre home screen
class Initializer {
  /// Initializes all the necessary primary providers.
  /// These providers don't care about onboarding and permission.
  ///
  /// This method should be invoked from [SplashScreen]
  static void initializePrimaryProviders(WidgetRef ref) {
    ref.read(appsInfoProvider);
    ref.read(appsRestrictionsProvider);
    debugPrint("Primary providers initialized.");
  }

  /// Initializes all the necessary secondary providers
  /// These providers need onboarding to be done.
  ///
  /// This method should be invoked from [HomeScreen]
  static void initializeSecondaryProviders(WidgetRef ref) {
    ref.read(focusModeProvider);
    ref.read(restrictionGroupsProvider);
    ref.read(bedtimeScheduleProvider);
    ref.read(wellBeingProvider);
    debugPrint("Secondary providers initialized.");
  }
}
