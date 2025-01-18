/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/models/usage_filter_model.dart';
import 'package:mindful/providers/apps/filtered_packages_provider.dart';
import 'package:mindful/ui/screens/restriction_groups/restriction_group_card.dart';

class SampleRestrictionGroup extends ConsumerWidget {
  const SampleRestrictionGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packages = ref
            .watch(filteredPackagesProvider(UsageFilterModel.constant()))
            .value ??
        [];
    final top = packages.take(15).toList();
    final first = top.take(6);
    final second = top.reversed.take(9);

    return IgnorePointer(
      child: Opacity(
        opacity: 0.4,
        child: Column(
          children: [
            RestrictionGroupCard(
              position: ItemPosition.top,
              group: RestrictionGroup(
                id: -100,
                groupName: "Group one",
                timerSec: 48800,
                activePeriodStart: const TimeOfDayAdapter.fromMinutes(1200),
                activePeriodEnd: const TimeOfDayAdapter.fromMinutes(1320),
                periodDurationInMins: 120,
                distractingApps: first.toList(),
              ),
            ),
            RestrictionGroupCard(
              position: ItemPosition.bottom,
              group: RestrictionGroup(
                id: -200,
                timerSec: 1800,
                groupName: "Group two",
                activePeriodStart: const TimeOfDayAdapter.fromMinutes(540),
                activePeriodEnd: const TimeOfDayAdapter.fromMinutes(720),
                periodDurationInMins: 120,
                distractingApps: second.toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
