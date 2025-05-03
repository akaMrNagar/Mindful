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
import 'package:mindful/core/database/converters/list_converters.dart';

@DataClassName("NotificationSettings")
class NotificationSettingsTable extends Table {
  /// Unique ID for notification config
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// Boolean denoting if to store notifications of non-batched apps too.
  BoolColumn get storeNonBatchedToo =>
      boolean().withDefault(const Constant(false))();

  /// List of app's packages whose notifications are batched.
  TextColumn get batchedApps => text()
      .map(const ListStringConverter())
      .withDefault(Constant(jsonEncode([])))();
}
