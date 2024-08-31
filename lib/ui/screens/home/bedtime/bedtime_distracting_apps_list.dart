/*
 *
 *  * Copyright (c) 2024 Pawan Nagar (https://github.com/akaMrNagar)
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

class BedtimeDistractingAppsList extends ConsumerWidget {
  const BedtimeDistractingAppsList({
    super.key,
  });

  void _insertRemoveDistractingApp(
    WidgetRef ref,
    BuildContext context,
    String packageName,
    bool shouldInsert,
  ) async {
    /// If bedtime schedule is active or ON
    if (ref.read(bedtimeProvider).isScheduleOn) {
      context.showSnackAlert(
        "Modifications to the list of distracting apps is not permitted while the bedtime schedule is active.",
      );
      return;
    }

    ref
        .read(bedtimeProvider.notifier)
        .insertRemoveDistractingApp(packageName, shouldInsert);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final distractingApps =
        ref.watch(bedtimeProvider.select((v) => v.distractingApps));

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
