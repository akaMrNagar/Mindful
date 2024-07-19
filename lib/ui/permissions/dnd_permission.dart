import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_permission_warning.dart';

class DndPermission extends ConsumerWidget {
  const DndPermission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission =
        ref.watch(permissionProvider.select((v) => v.haveDndPermission));

    return SliverPermissionWarning(
      havePermission: havePermission,
      margin: const EdgeInsets.only(top: 8),
      title: "Do not disturb",
      information:
          "Please grant Do Not Disturb access. This will allow Mindful to start and stop Do Not Disturb mode during the bedtime schedule.",
      onTapAllow: ref.read(permissionProvider.notifier).askDndPermission,
    );
  }
}
