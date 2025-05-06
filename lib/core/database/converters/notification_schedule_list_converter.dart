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
import 'dart:convert';

import 'package:mindful/models/notification_schedule.dart';

class NotificationScheduleListConverter
    extends TypeConverter<List<NotificationSchedule>, String> {
  const NotificationScheduleListConverter();

  @override
  List<NotificationSchedule> fromSql(String fromDb) {
    List<dynamic> jsonList = json.decode(fromDb);
    return jsonList.map((e) => NotificationSchedule.fromMap(e)).toList();
  }

  @override
  String toSql(List<NotificationSchedule> value) =>
      jsonEncode(value.map((e) => e.toMap()).toList());
}
