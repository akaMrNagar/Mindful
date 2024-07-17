import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_permission_warning.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';

class TabService extends ConsumerWidget {
  const TabService({super.key});

  void _turnOnInvincibleMode(
      BuildContext context, WidgetRef ref, bool isInvincibleModeOn) async {
    final isConfirm = await showConfirmationDialog(
      context: context,
      icon: FluentIcons.animal_cat_20_regular,
      heroTag: "invincibleMode",
      title: "Invincible mode",
      info:
          "Are you absolutely sure you want to enable Invincible Mode? This action is irreversible. Once Invincible Mode is turned on, you cannot turn it off as long as this app is installed on your device. ",
      positiveLabel: "Start",
    );

    if (isConfirm) {
      ref.read(settingsProvider.notifier).switchInvincibleMode();
    }
  }

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

          /// Admin permission warning
          SliverPermissionWarning(
            havePermission: haveAdminPermission,
            margin: const EdgeInsets.symmetric(vertical: 12),
            title: "Admin",
            information:
                "Our application does not collect, store, or transmit any user data. As Free and Open Source Software (FOSS), you can review and modify the source code. Administrative privileges are required solely for essential system operations, ensuring the app functions correctly without compromising your privacy.",
            onTapAllow:
                ref.read(permissionProvider.notifier).askAdminPermission,
          ),

          /// Invincible mode
          Hero(
            tag: "invincibleMode",
            child: Material(
              color: Colors.transparent,
              child: DefaultListTile(
                isPrimary: true,
                switchValue: isInvincibleModeOn,
                enabled: kDebugMode
                    ? true
                    : haveAdminPermission && !isInvincibleModeOn,
                leadingIcon: FluentIcons.animal_cat_20_regular,
                titleText: "Invincible mode",
                onPressed: () =>
                    _turnOnInvincibleMode(context, ref, isInvincibleModeOn),
              ),
            ),
          ).toSliverBox(),

          12.vSliverBox(),

          /// Information about invincible mode
          const StyledText(
            "When Invincible Mode is enabled, you cannot modify app's timer once it runs out, change bedtime routine settings during the bedtime schedule period, or modify shorts blocker settings after reaching the daily limit.\n\nEnjoy a distraction-free experience!",
          ).toSliverBox(),
        ],
      ),
    );
  }
}
