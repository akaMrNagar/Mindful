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
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/converters/list_converters.dart';

@DataClassName("Wellbeing")
class WellbeingTable extends Table {
  /// Unique ID for wellbeing
  IntColumn get id => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  /// Allowed time for short content in SECONDS
  IntColumn get allowedShortsTimeSec =>
      integer().withDefault(const Constant(30 * 60))();

  /// Flag denoting if to block instagram reels or not
  BoolColumn get blockInstaReels =>
      boolean().withDefault(const Constant(false))();

  /// Flag denoting if to block youtube shorts or not
  BoolColumn get blockYtShorts =>
      boolean().withDefault(const Constant(false))();

  /// Flag denoting if to block snapchat spotlight or not
  BoolColumn get blockSnapSpotlight =>
      boolean().withDefault(const Constant(false))();

  /// Flag denoting if to block facebook reels or not
  BoolColumn get blockFbReels => boolean().withDefault(const Constant(false))();

  /// Flag denoting if to block reddit shorts or not
  BoolColumn get blockRedditShorts =>
      boolean().withDefault(const Constant(false))();

  /// Flag denoting if the nsfw or adult  websites are blocked or not
  /// i.e if accessibility service is filtering websites or not
  BoolColumn get blockNsfwSites =>
      boolean().withDefault(const Constant(false))();

  /// List of website hosts which are blocked.
  TextColumn get blockedWebsites => text()
      .map(const ListStringConverter())
      .withDefault(Constant(jsonEncode([])))();

  static const defaultWellbeingModel = Wellbeing(
    id: 0,
    allowedShortsTimeSec: 30 * 60,
    blockInstaReels: false,
    blockYtShorts: false,
    blockSnapSpotlight: false,
    blockFbReels: false,
    blockRedditShorts: false,
    blockNsfwSites: false,
    blockedWebsites: [],
  );
}
