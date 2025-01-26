/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/utils/date_time_utils.dart';
import 'package:mindful/providers/usage/weekly_device_usage_provider.dart';
import 'package:mindful/ui/common/progress_percentage_indicator.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';

class ScreenTimeGlance extends ConsumerWidget {
  const ScreenTimeGlance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (today, yesterday) = ref.watch(
      weeklyDeviceUsageProvider(dateToday.weekRange).select((v) => (
            v[dateToday]?.screenTime ?? 0,
            v[dateToday.subtract(1.days)]?.screenTime ?? 0
          )),
    );

    return UsageGlanceCard(
      isPrimary: true,
      position: ItemPosition.topLeft,
      icon: FluentIcons.phone_screen_time_20_regular,
      title: context.locale.screen_time_label,
      info: today.seconds.toTimeShort(context),
      badge: ProgressPercentageIndicator(
        progressPercentage: today.toDiffPercentage(yesterday),
      ),
    );
  }
}
