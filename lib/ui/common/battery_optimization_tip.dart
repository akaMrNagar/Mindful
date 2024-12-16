import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';

class BatteryOptimizationTip extends ConsumerWidget {
  const BatteryOptimizationTip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref.watch(
      permissionProvider.select((v) => v.haveIgnoreOptimizationPermission),
    );

    final prob = Random().nextInt(10);

    return SliverPrimaryActionContainer(
      isVisible: !havePermission && prob == 1,
      icon: FluentIcons.lightbulb_filament_20_regular,
      margin: const EdgeInsets.only(bottom: 4),
      title: context.locale.tip_container_title,
      information: context.locale.battery_optimization_tip,
    );
  }
}
