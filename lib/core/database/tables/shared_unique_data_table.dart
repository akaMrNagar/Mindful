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
import 'package:mindful/core/database/converters/string_list_converter.dart';

@DataClassName("SharedUniqueData")
class SharedUniqueDataTable extends Table {
  /// Unique ID for Shared Data
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// List of app's packages which are excluded from the aggregated usage statistics.
  TextColumn get excludedApps => text()
      .map(const StringListConverter())
      .withDefault(Constant(jsonEncode([])))();
}
