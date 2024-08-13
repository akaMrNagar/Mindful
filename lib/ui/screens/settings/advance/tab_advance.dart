import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/usage_algorithm.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/tags.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_dropdown_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/permissions/admin_permission.dart';
import 'package:mindful/ui/permissions/battery_Permission_tile.dart';
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
        heroTag: AppTags.invincibleModeTileTag,
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
    
        /// Usage
        const SliverContentTitle(title: "Usage"),
    
        /// Info about usage algorithm
        const StyledText(
          "If the screen time does not accurately reflect your usage, try changing the usage algorithm from the dropdown below.",
        ).sliver,
    
        4.vSliverBox,
    
        /// Usage algorithm
        DefaultDropdownTile<UsageAlgorithm>(
          value: ref.watch(settingsProvider.select((v) => v.algorithm)),
          dialogIcon: FluentIcons.data_sunburst_20_filled,
          label: "Usage algorithm",
          onSelected:
              ref.read(settingsProvider.notifier).changeUsageAlgorithm,
          items: [
            DefaultDropdownItem(
              label: "States Based",
              value: UsageAlgorithm.usageStates,
            ),
            DefaultDropdownItem(
              label: "Events Based",
              value: UsageAlgorithm.usageEvents,
            ),
          ],
        ).sliver,
    
        12.vSliverBox,
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
          tag: AppTags.invincibleModeTileTag,
          child: DefaultListTile(
            isPrimary: true,
            switchValue: isInvincibleModeOn,
            enabled: haveAdminPermission && !isInvincibleModeOn,
            leadingIcon: FluentIcons.animal_cat_20_regular,
            titleText: "Invincible mode",
            onPressed: () =>
                _turnOnInvincibleMode(context, ref, !isInvincibleModeOn),
          ),
        ).sliver,
        12.vSliverBox,
    
        /// Admin permission warning
        const AdminPermission(),
        if (isInvincibleModeOn && haveAdminPermission)
          const StyledText(
            "Note: If you wish to uninstall this app due to an emergency while Invincible Mode is on, please follow these steps:\n\n1. Go to Settings > Apps > All Apps or Downloaded Apps.\n2. Find Mindful in the list and open app settings page.\n3. Tap uninstall and you will be asked to Deactivate Admin then Tap on deactivate and uninstall",
            isSubtitle: true,
          ).sliver,
    
        const SliverTabsBottomPadding()
      ],
    );
  }
}
