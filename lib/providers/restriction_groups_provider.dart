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

final restrictionGroupsProvider =
    StateNotifierProvider<RestrictionGroupsNotifier, List<RestrictionGroup>>(
  (ref) => RestrictionGroupsNotifier(),
);

class RestrictionGroupsNotifier extends StateNotifier<List<RestrictionGroup>> {
  late DynamicRecordsDao _dao;

  RestrictionGroupsNotifier() : super([]) {
    _init();
  }

  /// Initializes the state by loading data from the database.
  void _init() async {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    state = await _dao.fetchRestrictionGroups();
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

    state = state.toList()..add(newGroup);
  }

  void updateGroup({required RestrictionGroup group}) async {
    await _dao.updateRestrictionGroupById(group);

    state = state.toList()
      ..removeWhere((e) => e.id == group.id)
      ..add(group);
  }

  void removeGroup({required RestrictionGroup group}) async {
    await _dao.removeRestrictionGroupById(group);
    state = state.toList()..remove(group);
  }
}
