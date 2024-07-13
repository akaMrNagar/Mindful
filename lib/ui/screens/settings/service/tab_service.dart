import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';

class TabService extends ConsumerWidget {
  const TabService({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInvincibleModeOn =
        ref.watch(settingsProvider.select((v) => v.isInvincibleModeOn));

    final haveAdminPermission =
        ref.watch(permissionProvider.select((v) => v.haveAdminPermission));

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: CustomScrollView(
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "Service"),

          /// Invincible
          const SliverContentTitle(title: "Invincible mode"),

          /// Invincible mode
          DefaultListTile(
            switchValue: isInvincibleModeOn,
            titleText: "Invincible mode",
            subtitleText:
                "Restrict user from altering the app's timer and bedtime schedule once the app's timer ran out and during the bedtime scheduled period respectively",
            onPressed: ref.read(settingsProvider.notifier).switchInvincibleMode,
          ).toSliverBox(),

          /// Prevent uninstall
          DefaultListTile(
            titleText: "Prevent uninstall",
            switchValue: haveAdminPermission,
            subtitleText:
                "Restrict user from uninstalling this app by granting administrative privileges",
            onPressed: haveAdminPermission
                ? ref.read(permissionProvider.notifier).revokeAdminPermission
                : ref.read(permissionProvider.notifier).askAdminPermission,
          ).toSliverBox(),

          24.vSliverBox(),

          /// Note:
          RoundedContainer(
            color: Theme.of(context).colorScheme.secondaryContainer,
            padding: const EdgeInsets.all(12),
            child: StyledText(
              "Our application does not collect, store, or transmit any user data. As Free and Open Source Software (FOSS), you can review and modify the source code. Administrative privileges are required solely for essential system operations, ensuring the app functions correctly without compromising your privacy.",
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ).toSliverBox(),
        ],
      ),
    );
  }
}
