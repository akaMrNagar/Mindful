/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mindful/core/database/converters/notification_schedule_list_converter.dart';
import 'package:mindful/core/database/converters/string_list_converter.dart';
import 'package:mindful/core/enums/recap_type.dart';
import 'package:mindful/core/utils/default_models_utils.dart';

@DataClassName("NotificationSettings")
class NotificationSettingsTable extends Table {
  /// Unique ID for notification config
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// Notifications recap type for schedule triggered [RecapType]
  IntColumn get recapType =>
      intEnum<RecapType>().withDefault(const Constant(0))();

  /// Maximum number of weeks till the app's notification history will be kept
  /// Default is 2 weeks.
  IntColumn get notificationHistoryWeeks =>
      integer().withDefault(const Constant(2))();

  /// Boolean denoting if to store notifications of non-batched apps too.
  BoolColumn get storeNonBatchedToo =>
      boolean().withDefault(const Constant(false))();

  /// List of app's packages whose notifications are batched.
  TextColumn get batchedApps => text()
      .map(const StringListConverter())
      .withDefault(Constant(jsonEncode([])))();

  /// List of batching schedules
  TextColumn get schedules => text()
      .map(const NotificationScheduleListConverter())
      .withDefault(Constant(jsonEncode(
        defaultNotificationSettingsModel.schedules,
      )))();
}
