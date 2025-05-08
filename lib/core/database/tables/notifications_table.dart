/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:drift/drift.dart';

@DataClassName("Notification")
class NotificationsTable extends Table {
  /// Unique ID for notification
  IntColumn get id => integer().autoIncrement()();

  /// Unique key of this notification created by system for live link
  TextColumn get key => text()();

  /// Package name of the related app
  TextColumn get packageName => text()();

  /// [DateTime] when the notification is pushed
  DateTimeColumn get timeStamp =>
      dateTime().withDefault(Constant(DateTime(0)))();

  /// The title of the notification
  TextColumn get title => text().withDefault(const Constant(""))();

  /// The content of the notification
  TextColumn get content => text().withDefault(const Constant(""))();

  /// The category of the notification
  TextColumn get category => text().withDefault(const Constant(""))();

  /// Boolean denoting the status of this notification (Read/Unread)
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
}
