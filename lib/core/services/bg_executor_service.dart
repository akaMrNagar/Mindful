import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/date_time_utils.dart';
import 'package:mindful/initializer.dart';

/// This class handles the Flutter method channel and is responsible for invoking flutter code.
///
/// The service executes tasks requested by native side in background.
class BgExecutorService {
  /// Singleton instance.
  static final BgExecutorService instance = BgExecutorService._();

  /// Private constructor for enforcing the singleton pattern.
  BgExecutorService._();

  /// The method channel object used for communication.
  final MethodChannel _methodChannel = const MethodChannel(
    'com.mindful.android.methodchannel.bg',
  );

  /// Initializes the method channel by setting a handler for incoming method calls from the native side.
  Future<void> init() async {
    /// Every task must complete under 5 minutes
    _methodChannel.setMethodCallHandler(
      (call) async {
        try {
          /// Handle tasks
          switch (call.method) {
            case "onBootOrAppUpdate":
              await _onBootOrAppUpdate();
              break;
            case "onMidnightReset":
              await _onMidnightReset();
              break;
            default:
          }

          // Task is completed with success
          _signalTaskCompletion();
        } catch (e) {
          final error = "${call.method}(): $e";
          debugPrint("BgExecutorService.MethodCall: $error");

          // Task failed with exception
          _signalTaskCompletion(error: error);
        }
      },
    );

    debugPrint('BgExecutorService.init(): Service initialized');
  }

  /// Every call from the native side must call finish to let native side know
  /// that the task is completed and it can release resources
  void _signalTaskCompletion({String? error}) async {
    try {
      debugPrint(
        'BgExecutorService._signalTaskCompletion(): Background task completed',
      );
      _methodChannel.invokeMethod("signalTaskCompleted", error);
      // ignore: empty_catches
    } catch (e) {}
  }

  /// This method will be invoked when the device boots or
  /// if the Mindful app is updated or changed
  ///
  /// Initialize and start all necessary services here
  Future<void> _onBootOrAppUpdate() async {
    await MethodChannelService.instance.init();
    await DriftDbService.instance.init();
    await Initializer.initializeServicesAndSchedules();
  }

  /// This method will be invoked everyday at Midnight 12
  ///
  /// Backup app's usage for yesterday to database
  Future<void> _onMidnightReset() async {
    await MethodChannelService.instance.init();
    await DriftDbService.instance.init();

    final dynamicDao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    final uniqueDao = DriftDbService.instance.driftDb.uniqueRecordsDao;

    /// Date yesterday
    final dateYesterday = dateToday.subtract(1.days);

    /// Number of day from today till then to keep history
    final historyDays =
        (await uniqueDao.loadMindfulSettings()).usageHistoryWeeks * 7;

    /// Remove usages before the specified history time
    await dynamicDao
        .removeBatchAppUsagesBefore(dateYesterday.subtract(historyDays.days));

    /// Fetch usage for yesterday
    final usages =
        await MethodChannelService.instance.fetchAppsUsageForInterval(
      start: dateYesterday,
      end: dateToday,
    );

    final usageCompanions = usages.entries
        .map(
          (entry) => AppUsageTableCompanion(
            date: Value(dateYesterday),
            packageName: Value(entry.key),
            screenTime: Value(entry.value.screenTime),
            mobileData: Value(entry.value.mobileData),
            wifiData: Value(entry.value.wifiData),
          ),
        )
        .toList();

    await dynamicDao.insertBatchAppUsages(usageCompanions);
  }
}
