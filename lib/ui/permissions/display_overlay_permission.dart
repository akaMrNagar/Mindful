import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_permission_warning.dart';

class DisplayOverlayPermission extends ConsumerWidget {
  const DisplayOverlayPermission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref.watch(
        permissionProvider.select((v) => v.haveDisplayOverlayPermission));

    return SliverPermissionWarning(
      havePermission: havePermission,
      margin: const EdgeInsets.only(bottom: 8),
      title: "Display over other apps",
      information:
          "Please grant display overlay permission. This will allow Mindful to show an overlay when a paused app is opened, helping you stay focused and maintain your schedule.",
      onTapAllow:
          ref.read(permissionProvider.notifier).askDisplayOverlayPermission,
    );
  }
}
