import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';

class ExactAlarmPermission extends ConsumerWidget {
  /// Creates a animated [SliverPrimaryActionContainer] for asking permission from user
  /// with self handled state and automatically hides itself if the user have granted the permission
  const ExactAlarmPermission({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission =
        ref.watch(permissionProvider.select((v) => v.haveAlarmsPermission));

    return SliverPrimaryActionContainer(
      isVisible: !havePermission,
      margin: const EdgeInsets.only(bottom: 8),
      icon: FluentIcons.clock_alarm_20_regular,
      title: "Alarms & Reminders",
      information:
          "Please grant permission for setting alarms and reminders. This will allow Mindful to start your bedtime schedule on time and reset app timers daily at midnight and help you stay on track.",
      onTapAction:
          ref.read(permissionProvider.notifier).askExactAlarmPermission,
    );
  }
}
