import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
      icon: FluentIcons.fingerprint_20_regular,
      title: "Admin",
      information:
          "Please grant administrative privileges. This is required to prevent the uninstallation of Mindful when Invincible Mode is active. Rest assured, as a Free and Open Source Software (FOSS) app, Mindful does not collect, store, or transmit any user data—your privacy remains fully protected.",
      onTapAction: !havePermission
          ? ref.read(permissionProvider.notifier).askAdminPermission
          : null,
    );
  }
}
