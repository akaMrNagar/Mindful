import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/permissions/admin_permission.dart';
import 'package:mindful/ui/permissions/battery_permission_tile.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class TabAdvance extends ConsumerWidget {
  const TabAdvance({super.key});

  void _turnOnInvincibleMode(
    BuildContext context,
    WidgetRef ref,
    bool shouldTurnOn,
  ) async {
    if (shouldTurnOn) {
      final isConfirm = await showConfirmationDialog(
        context: context,
        icon: FluentIcons.animal_cat_20_filled,
        heroTag: HeroTags.invincibleModeTileTag,
        title: "Invincible mode",
        info:
            "Are you absolutely sure you want to enable Invincible Mode? This action is irreversible. Once Invincible Mode is turned on, you cannot turn it off as long as this app is installed on your device.",
        positiveLabel: "Start",
      );
      if (isConfirm) {
        ref.read(settingsProvider.notifier).switchInvincibleMode();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInvincibleModeOn =
        ref.watch(settingsProvider.select((v) => v.isInvincibleModeOn));

    final haveAdminPermission =
        ref.watch(permissionProvider.select((v) => v.haveAdminPermission));

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        const SliverFlexibleAppBar(title: "Advance"),

        const SliverContentTitle(title: "Service"),

        /// Battery
        const StyledText(
          "If you are experiencing issues with Mindful suddenly stopping, please consider granting the ignore battery optimization permission. This will allow Mindful to operate in background without interruptions.",
        ).sliver,
        6.vSliverBox,

        /// Battery permission
        const BatteryPermissionTile(),

        /// Invincible
        12.vSliverBox,
        const SliverContentTitle(title: "Invincible mode"),

        /// Information about invincible mode
        const StyledText(
          "When Invincible Mode is enabled, you cannot uninstall Mindful, modify app's timer once it runs out, change bedtime routine settings during the bedtime schedule period, or modify shorts blocker settings after reaching the daily limit.\n\nEnjoy a distraction-free experience!",
        ).sliver,
        8.vSliverBox,

        /// Invincible mode
        DefaultHero(
          tag: HeroTags.invincibleModeTileTag,
          child: DefaultListTile(
            isPrimary: true,
            switchValue: isInvincibleModeOn,
            enabled: haveAdminPermission && !isInvincibleModeOn,
            leadingIcon: FluentIcons.animal_cat_20_regular,
            titleText: "Switch invincible mode",
            onPressed: () =>
                _turnOnInvincibleMode(context, ref, !isInvincibleModeOn),
          ),
        ).sliver,
        12.vSliverBox,

        /// Admin permission warning
        const AdminPermission(),
        if (isInvincibleModeOn && haveAdminPermission)
          Semantics(
            excludeSemantics: true,
            child: const StyledText(
              "Note: If you wish to uninstall this app due to an emergency while Invincible Mode is on, please follow these steps:\n\n1. Go to Settings > Apps > All Apps or Downloaded Apps.\n2. Find Mindful in the list and open app settings page.\n3. Tap uninstall and you will be asked to Deactivate Admin then Tap on deactivate and uninstall",
              isSubtitle: true,
            ),
          ).sliver,

        const SliverTabsBottomPadding()
      ],
    );
  }
}
