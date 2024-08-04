import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';

class DisplayOverlayPermission extends ConsumerWidget {
  /// Creates a animated [SliverPrimaryActionContainer] for asking permission from user
  /// with self handled state and automatically hides itself if the user have granted the permission
  const DisplayOverlayPermission({
    super.key,
    this.showEvenIfGranted = false,
  });

  final bool showEvenIfGranted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final havePermission = ref.watch(
        permissionProvider.select((v) => v.haveDisplayOverlayPermission));

    return SliverPrimaryActionContainer(
      isVisible: !havePermission || showEvenIfGranted,
      margin: const EdgeInsets.only(bottom: 8),
      title: "Display over other apps",
      information:
          "Please grant display overlay permission. This will allow Mindful to show an overlay when a paused app is opened, helping you stay focused and maintain your schedule.",
      onTapAction: !havePermission
          ? ref.read(permissionProvider.notifier).askDisplayOverlayPermission
          : null,
    );
  }
}
