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
import 'package:mindful/core/enums/shorts_platform_features.dart';

@DataClassName("Wellbeing")
class WellbeingTable extends Table {
  /// Unique ID for wellbeing
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// Allowed time for short content in SECONDS
  IntColumn get allowedShortsTimeSec =>
      integer().withDefault(const Constant(30 * 60))();

  /// List of feature which are blocked
  TextColumn get blockedFeatures => text()
      .map(const ListEnumNamesConverter<ShortsPlatformFeatures>(
        ShortsPlatformFeatures.values,
      ))
      .withDefault(Constant(jsonEncode([])))();

  /// Flag denoting if the nsfw or adult  websites are blocked or not
  /// i.e if accessibility service is filtering websites or not
  BoolColumn get blockNsfwSites =>
      boolean().withDefault(const Constant(false))();

  /// List of website hosts which are blocked.
  TextColumn get blockedWebsites => text()
      .map(const ListStringConverter())
      .withDefault(Constant(jsonEncode([])))();

  /// List of website hosts which are nsfw.
  TextColumn get nsfwWebsites => text()
      .map(const ListStringConverter())
      .withDefault(Constant(jsonEncode([])))();
}
