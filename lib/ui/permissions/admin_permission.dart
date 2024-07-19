import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_permission_warning.dart';

class AdminPermission extends ConsumerWidget {
  const AdminPermission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission =
        ref.watch(permissionProvider.select((v) => v.haveAdminPermission));

    return SliverPermissionWarning(
      havePermission: havePermission,
      margin: const EdgeInsets.symmetric(vertical: 12),
      title: "Admin",
      information:
          "Please grant administrative privileges. Our app, being Free and Open Source Software (FOSS), does not collect, store, or transmit any user data. Administrative privileges are needed only for essential system operations to ensure the app runs smoothly without compromising your privacy.",
      onTapAllow: ref.read(permissionProvider.notifier).askAdminPermission,
    );
  }
}
