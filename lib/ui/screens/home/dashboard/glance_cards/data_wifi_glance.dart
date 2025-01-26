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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/utils/date_time_utils.dart';
import 'package:mindful/providers/usage/weekly_device_usage_provider.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';

class DataWifiGlance extends ConsumerWidget {
  const DataWifiGlance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(
      weeklyDeviceUsageProvider(dateToday.weekRange).select(
        (v) => v[dateToday]?.wifiData ?? 0,
      ),
    );

    return UsageGlanceCard(
      title: context.locale.wifi_data_label,
      info: today.toData(),
    );
  }
}
