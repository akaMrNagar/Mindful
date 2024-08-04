import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';

class BatteryPermission extends ConsumerWidget {
  /// Creates a animated [SliverPrimaryActionContainer] for asking permission from user
  /// with self handled state and automatically hides itself if the user have granted the permission
  const BatteryPermission({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref.watch(
        permissionProvider.select((v) => v.haveIgnoreOptimizationPermission));

    return SliverPrimaryActionContainer(
      isVisible: !havePermission,
      margin: const EdgeInsets.only(bottom: 8),
      title: "Ignore Battery Optimization",
      actionBtnLabel: havePermission ? "Already granted" : null,
      information:
          "Please grant ignore battery optimization permission. This will allow Mindful to operate in background without interruptions.",
      onTapAction: !havePermission
          ? ref
              .read(permissionProvider.notifier)
              .askIgnoreBatteryOptimizationPermission
          : null,
    );
  }
}
