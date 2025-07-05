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
import 'package:mindful/ui/screens/restriction_groups/restriction_group_card.dart';

final _socials = <String>[
  "com.whatsapp",
  "com.twitter.android",
  "com.instagram.android",
  "com.snapchat.android",
];

final _entertainment = <String>[
  "com.google.android.youtube",
  "com.netflix.mediaclient",
  "com.amazon.avod.thirdpartyclient",
  "com.disney.disneyplus",
  "com.spotify.music",
  "com.zhiliaoapp.musically",
];

class SampleRestrictionGroup extends ConsumerWidget {
  const SampleRestrictionGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.5,
        child: Column(
          children: [
            RestrictionGroupCard(
              position: ItemPosition.top,
              group: RestrictionGroup(
                id: -1,
                groupName: "Social media",
                timerSec: 5400,
                activePeriodStart: const TimeOfDayAdapter.fromMinutes(1200),
                activePeriodEnd: const TimeOfDayAdapter.fromMinutes(1320),
                periodDurationInMins: 120,
                distractingApps: _socials,
              ),
            ),
            RestrictionGroupCard(
              position: ItemPosition.bottom,
              group: RestrictionGroup(
                id: -2,
                timerSec: 7200,
                groupName: "Entertainment",
                activePeriodStart: const TimeOfDayAdapter.fromMinutes(540),
                activePeriodEnd: const TimeOfDayAdapter.fromMinutes(720),
                periodDurationInMins: 120,
                distractingApps: _entertainment,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
