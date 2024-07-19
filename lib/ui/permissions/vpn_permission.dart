import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_permission_warning.dart';

class VpnPermission extends ConsumerWidget {
  const VpnPermission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission =
        ref.watch(permissionProvider.select((v) => v.haveVpnPermission));

    return SliverPermissionWarning(
      havePermission: havePermission,
      margin: const EdgeInsets.only(bottom: 12),
      title: "Create VPN",
      information:
          "Please grant permission to create virtual private network (VPN) connection. This will enable Mindful to restrict internet access for designated applications by creating local on device VPN.",
      onTapAllow: ref.read(permissionProvider.notifier).askVpnPermission,
    );
  }
}
