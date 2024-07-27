import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';

class DndPermission extends ConsumerWidget {
  /// Creates a animated [SliverPrimaryActionContainer] for asking permission from user
  /// with self handled state and automatically hides itself if the user have granted the permission
  const DndPermission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission =
        ref.watch(permissionProvider.select((v) => v.haveDndPermission));

    return SliverPrimaryActionContainer(
      isVisible: !havePermission,
      margin: const EdgeInsets.only(top: 4, bottom: 12),
      title: "Do not disturb",
      information:
          "Please grant Do Not Disturb access. This will allow Mindful to start and stop Do Not Disturb mode during the bedtime schedule.",
      onTapAction: ref.read(permissionProvider.notifier).askDndPermission,
    );
  }
}
