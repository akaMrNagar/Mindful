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

@DataClassName("AppUsage")
class AppUsageTable extends Table {
  /// Composite primary key from package name and timestamp
  @override
  Set<Column> get primaryKey => {packageName, date};

  /// Package name of the related app
  TextColumn get packageName => text()();

  /// The day [DateTime] but date only of the record
  DateTimeColumn get date => dateTime().withDefault(Constant(DateTime(0)))();

  /// Package screen time of the related app
  IntColumn get screenTime => integer().withDefault(const Constant(0))();

  /// Package mobile data usage of the related app
  IntColumn get mobileData => integer().withDefault(const Constant(0))();

  /// Package wifi data usage of the related app
  IntColumn get wifiData => integer().withDefault(const Constant(0))();
}
