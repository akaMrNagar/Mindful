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

class TabService extends ConsumerWidget {
  const TabService({super.key});

  void _turnOnInvincibleMode(
      BuildContext context, WidgetRef ref, bool isInvincibleModeOn) async {
    final isConfirm = await showConfirmationDialog(
      context: context,
      icon: FluentIcons.animal_cat_20_regular,
      heroTag: AppTags.invincibleModeTag,
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
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "Service"),

          /// Invincible
          const SliverContentTitle(title: "Invincible mode"),

          4.vSliverBox,

          /// Information about invincible mode
          const StyledText(
            "When Invincible Mode is enabled, you cannot modify app's timer once it runs out, change bedtime routine settings during the bedtime schedule period, or modify shorts blocker settings after reaching the daily limit.\n\nEnjoy a distraction-free experience!",
          ).sliverBox,
          12.vSliverBox,

          /// Admin permission warning
          const AdminPermission(),

          /// Invincible mode
          DefaultHero(
            tag: AppTags.invincibleModeTag,
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
          ).sliverBox,
        ],
      ),
    );
  }
}
