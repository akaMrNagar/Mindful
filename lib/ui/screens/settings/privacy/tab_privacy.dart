import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';

class TabPrivacy extends ConsumerWidget {
  const TabPrivacy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "Privacy"),

          /// Privacy police
          const SliverContentTitle(title: "Privacy"),
          const StyledText(
            "Mindful is committed to protecting your privacy. We do not collect, store, or transfer any type of user data. The app operates entirely offline and does not require an internet connection, ensuring that your personal information remains private and secure on your device. As a Free and Open Source Software (FOSS) application, Mindful guarantees complete transparency and user control over their data.",
            fontSize: 14,
            // isSubtitle: true,
          ).sliver,
          12.vSliverBox,
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.tonalIcon(
              icon: const Icon(FluentIcons.info_20_regular),
              label: const Text("More details"),
              onPressed: () => MethodChannelService.instance
                  .launchUrl(AppConstants.privacyPolicyUrl),
            ),
          ).sliver,

          /// Permissions
          const SliverContentTitle(title: "Permissions"),
          const DefaultListTile(
            titleText: "Notification",
            subtitleText:
                "Allows to remind and alert about important information and events.",
          ).sliver,
          const DefaultListTile(
            titleText: "Usage access",
            subtitleText: "Allows to fetch screen and data usage.",
          ).sliver,
          const DefaultListTile(
            titleText: "Display over other apps",
            subtitleText:
                "Allows to show an overlay when paused apps are opened.",
          ).sliver,
          const DefaultListTile(
            titleText: "Accessibility",
            subtitleText:
                "Allows to detect opened website and short content on different platforms.",
          ).sliver,
          const DefaultListTile(
            titleText: "Do not disturb",
            subtitleText:
                "Allows to start and stop dnd during bedtime schedule.",
          ).sliver,
          const DefaultListTile(
            titleText: "VPN",
            subtitleText:
                "Allows to restrict internet access to specified apps.",
          ).sliver,
          const DefaultListTile(
            titleText: "Admin",
            subtitleText:
                "Allows to restrict user from uninstalling during invincible mode.",
          ).sliver,
          const DefaultListTile(
            titleText: "Internet",
            subtitleText:
                "Allows to create and protect local vpn socket when blocking app's internet.",
          ).sliver,

          const SliverTabsBottomPadding(),
        ],
      ),
    );
  }
}