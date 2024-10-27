/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/services/drift_db_service.dart';

final restrictionGroupsProvider = StateNotifierProvider<
    RestrictionGroupsNotifier, Map<int, RestrictionGroup>>(
  (ref) => RestrictionGroupsNotifier(),
);

class RestrictionGroupsNotifier
    extends StateNotifier<Map<int, RestrictionGroup>> {
  late DynamicRecordsDao _dao;

  RestrictionGroupsNotifier() : super({}) {
    _init();
  }

  /// Initializes the state by loading data from the database.
  void _init() async {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    final groupsList = await _dao.fetchRestrictionGroups();
    state = Map.fromEntries(groupsList.map((e) => MapEntry(e.id, e)));
  }

  void createNewGroup({
    required String groupName,
    required int timerSec,
    required List<String> distractingApps,
  }) async {
    final newGroup = await _dao.insertRestrictionGroup(
      groupName: groupName,
      timerSec: timerSec,
      distractingApps: distractingApps,
    );

    state = {...state}..update(
        newGroup.id,
        (value) => newGroup,
        ifAbsent: () => newGroup,
      );
  }

  void updateGroup({required RestrictionGroup group}) async {
    await _dao.updateRestrictionGroupById(group);
    state = {...state}..update(
        group.id,
        (value) => group,
        ifAbsent: () => group,
      );
  }

  void removeGroup({required RestrictionGroup group}) async {
    await _dao.removeRestrictionGroupById(group);
    state = {...state}..remove(group.id);
  }
}
