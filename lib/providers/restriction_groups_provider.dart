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
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/database/daos/dynamic_records_dao.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/apps_provider.dart';

/// A Riverpod state notifier provider that manages a map of group IDs and [RestrictionGroup].
final restrictionGroupsProvider = StateNotifierProvider<
    RestrictionGroupsNotifier, Map<int, RestrictionGroup>>(
  (ref) => RestrictionGroupsNotifier(
    ref.watch(appsProvider).value?.keys.toSet() ?? {},
  ),
);

class RestrictionGroupsNotifier
    extends StateNotifier<Map<int, RestrictionGroup>> {
  late DynamicRecordsDao _dao;
  final Set<String> _installedApps;

  /// Constructor that takes the list of installed apps.
  RestrictionGroupsNotifier(this._installedApps) : super({}) {
    _init();
  }

  /// Initializes the state by loading data from the database.
  /// This method loads the restriction groups from the database and sets
  /// them in the state.
  void _init() async {
    _dao = DriftDbService.instance.driftDb.dynamicRecordsDao;
    final groupsList = await _dao.fetchRestrictionGroups();
    state = Map.fromEntries(groupsList.map((e) => MapEntry(e.id, e)));

    // Listen to changes and update the tracker service.
    addListener((_) => updateGroupsInTrackerService());
  }

  /// Creates a new restriction group and adds it to the state.
  Future<RestrictionGroup> createNewGroup({
    required String groupName,
    required int timerSec,
    required List<String> distractingApps,
  }) async {
    final newGroup = await _dao.insertRestrictionGroup(
      groupName: groupName,
      timerSec: timerSec,
      distractingApps: distractingApps,

      /// FIXME: Change the period
      periodDurationInMins: 0,
      activePeriodStart: const TimeOfDayAdapter.zero(),
      activePeriodEnd: const TimeOfDayAdapter.zero(),
    );

    state = {...state}..update(
        newGroup.id,
        (value) => newGroup,
        ifAbsent: () => newGroup,
      );

    return newGroup;
  }

  /// Updates an existing restriction group in the database and state.
  void updateGroup({required RestrictionGroup group}) async {
    await _dao.updateRestrictionGroupById(group);
    state = {...state}..update(
        group.id,
        (value) => group,
        ifAbsent: () => group,
      );
  }

  /// Removes a restriction group from the database and state.
  void removeGroup({required RestrictionGroup group}) async {
    await _dao.removeRestrictionGroupById(group);
    state = {...state}..remove(group.id);
  }

  /// Updates the tracker service with the filtered restriction groups.
  ///
  /// This method filters the restriction groups based on installed apps and
  /// their timer settings and updates the tracker service accordingly.
  Future<void> updateGroupsInTrackerService() async {
    if (_installedApps.isEmpty) return;

    final filteredGroups = state.values
        .where(
          (e) =>
              e.timerSec > 0 &&
              e.distractingApps
                  .where((e) => _installedApps.contains(e))
                  .isNotEmpty,
        )
        .toList();

    await MethodChannelService.instance
        .updateRestrictionsGroups(filteredGroups);
  }
}
