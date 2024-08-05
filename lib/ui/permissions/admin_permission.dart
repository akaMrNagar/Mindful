import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';

class AdminPermission extends ConsumerWidget {
  /// Creates a animated [SliverPrimaryActionContainer] for asking permission from user
  /// with self handled state and automatically hides itself if the user have granted the permission
  const AdminPermission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission =
        ref.watch(permissionProvider.select((v) => v.haveAdminPermission));

    return SliverPrimaryActionContainer(
      isVisible: !havePermission,
      margin: const EdgeInsets.only(bottom: 12),
      title: "Admin",
      information:
          "Please grant administrative privileges. Our app, being Free and Open Source Software (FOSS), does not collect, store, or transmit any user data. Administrative privileges are needed only for essential system operations to ensure the app runs smoothly without compromising your privacy.",
      onTapAction: !havePermission
          ? ref.read(permissionProvider.notifier).askAdminPermission
          : null,
    );
  }
}
