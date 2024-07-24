import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/tags.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/permissions/admin_permission.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class TabGeneral extends ConsumerWidget {
  const TabGeneral({super.key});

  void _turnOnInvincibleMode(
      BuildContext context, WidgetRef ref, bool isInvincibleModeOn) async {
    final isConfirm = await showConfirmationDialog(
      context: context,
      icon: FluentIcons.animal_cat_20_regular,
      heroTag: AppTags.invincibleModeTileTag,
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

    final dataUsageResetTime =
        ref.watch(settingsProvider.select((v) => v.dataResetToD));

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "General"),

          /// Default settings
          const SliverContentTitle(title: "Defaults"),

          /// Data reset time
          DefaultListTile(
            titleText: "Daily data usage reset time",
            subtitleText:
                "Specify the time when your daily data cycle renews based on your recharge plan.",
            trailing: StyledText(
              " ${dataUsageResetTime.format(context)}",
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () async {
              final pickedTime = await showTimePicker(
                context: context,
                initialTime: dataUsageResetTime,
                helpText: "Select daily data usage reset time",
              );

              if (pickedTime != null && context.mounted) {
                ref
                    .read(settingsProvider.notifier)
                    .changeDataResetTime(pickedTime);
              }
            },
          ).sliver,

          /// Invincible
          const SliverContentTitle(title: "Invincible mode"),

          /// Information about invincible mode
          const StyledText(
            "When Invincible Mode is enabled, you cannot modify app's timer once it runs out, change bedtime routine settings during the bedtime schedule period, or modify shorts blocker settings after reaching the daily limit.\n\nEnjoy a distraction-free experience!",
          ).sliver,
          12.vSliverBox,

          /// Admin permission warning
          const AdminPermission(),

          /// Invincible mode
          DefaultHero(
            tag: AppTags.invincibleModeTileTag,
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
          ).sliver,

          12.vSliverBox,
          if (isInvincibleModeOn && haveAdminPermission)
            const StyledText(
              "Note: If you wish to uninstall this app due to an emergency while Invincible Mode is on, please follow these steps:\n\n1. Go to Settings > Security & Privacy > More Security & Privacy > Device Admin Apps.\n2. Find Mindful in the list and disable it.\n\nYou can now uninstall the app in the usual way.",
              // "Note: If you wish to uninstall this app app due to some emergency when invincible mode is On then go to Setting > Security & privacy > More security and privacy > Device admin apps and find mindful in the list and disable it. Now you can uninstall this app in usual way.",
              isSubtitle: true,
            ).sliver,
        ],
      ),
    );
  }
}
