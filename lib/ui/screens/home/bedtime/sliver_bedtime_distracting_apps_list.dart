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
import 'package:mindful/providers/bedtime_provider.dart';
import 'package:mindful/ui/common/sliver_distracting_apps_list.dart';

class SliverBedtimeDistractingAppsList extends ConsumerWidget {
  const SliverBedtimeDistractingAppsList({
    super.key,
  });

  void _insertRemoveDistractingApp(
    WidgetRef ref,
    BuildContext context,
    String packageName,
    bool shouldInsert,
  ) async {
    /// If bedtime schedule is active or ON
    if (ref.read(bedtimeScheduleProvider).isScheduleOn) {
      context.showSnackAlert(
          context.locale.bedtime_distracting_apps_modify_snack_alert);
      return;
    }

    ref
        .read(bedtimeScheduleProvider.notifier)
        .insertRemoveDistractingApp(packageName, shouldInsert);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distractingApps =
        ref.watch(bedtimeScheduleProvider.select((v) => v.distractingApps));

    return SliverDistractingAppsList(
      distractingApps: distractingApps,
      onSelectionChanged: (package, isSelected) => _insertRemoveDistractingApp(
        ref,
        context,
        package,
        isSelected,
      ),
    );
  }
}
