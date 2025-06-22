import 'package:flutter/material.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';

/// Initializer to initialize necessary things.
class Initializer {
  /// Initializes all the required services and schedules.
  ///
  /// This method must be called after initializing `DATABASE` and `METHOD CHANNEL`.
  static Future<void> initializeServicesAndSchedules() async {
    final startTimeStamp = DateTime.now();

    final dynamicDao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    final uniqueDao = DriftDbService.instance.driftDb.uniqueRecordsDao;

    /// fetch app restrictions
    var appRestrictions = await dynamicDao.fetchAppsRestrictions();
    var webRestrictions = await dynamicDao.fetchWebRestrictions();

    final internetBlockedApps = appRestrictions
        .where((e) => !e.canAccessInternet)
        .map((e) => e.appPackage)
        .toList();

    /// filter out restrictions
    appRestrictions.removeWhere(
      (e) =>
          e.timerSec <= 0 &&
          e.periodDurationInMins <= 0 &&
          e.launchLimit <= 0 &&
          e.associatedGroupId == null,
    );

    /// update tracker service
    await MethodChannelService.instance.updateAppRestrictions(appRestrictions);

    /// update tracker service
    await MethodChannelService.instance.updateWebRestrictions(webRestrictions);

    /// update vpn service
    await MethodChannelService.instance
        .updateInternetBlockedApps(internetBlockedApps);

    /// Update restriction groups
    final restrictionGroups = await dynamicDao.fetchRestrictionGroups();
    await MethodChannelService.instance
        .updateRestrictionsGroups(restrictionGroups);

    /// Fetch and update bedtime routine
    final bedtime = await uniqueDao.loadBedtimeSchedule();
    await MethodChannelService.instance.updateBedtimeSchedule(bedtime);

    /// Fetch and update wellbeing
    final wellbeing = await uniqueDao.loadWellBeingSettings();
    await MethodChannelService.instance.updateWellBeingSettings(wellbeing);

    /// Fetch and update notification settings
    final notificationSettings = await uniqueDao.loadNotificationSettings();
    await MethodChannelService.instance
        .updateNotificationSettings(notificationSettings);

    debugPrint(
      "All necessary services and schedules are initialized and it took ${DateTime.now().difference(startTimeStamp).inMilliseconds}ms.",
    );
  }
}
