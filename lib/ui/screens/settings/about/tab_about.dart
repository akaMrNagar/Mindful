import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_donation_card.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';

class TabAbout extends ConsumerWidget {
  const TabAbout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// Appbar
          const SliverFlexibleAppBar(title: "About"),

          /// Donation box
          const SliverDonationCard(),
          12.vSliverBox,

          /// Social
          const SliverContentTitle(title: "Social"),

          /// Source code
          DefaultListTile(
            leadingIcon: FluentIcons.code_20_regular,
            titleText: "GitHub",
            subtitleText: "View the source code.",
            onPressed: () =>
                MethodChannelService.instance.launchUrl(AppConstants.githubUrl),
          ).sliverBox,

          /// Issue
          DefaultListTile(
            leadingIcon: FluentIcons.bug_20_regular,
            titleText: "Report an issue",
            subtitleText: "You will be redirected to GitHub.",
            onPressed: () => MethodChannelService.instance
                .launchUrl(AppConstants.githubIssueUrl),
          ).sliverBox,

          /// Idea
          DefaultListTile(
            leadingIcon: FluentIcons.lightbulb_filament_20_regular,
            titleText: "Suggest an idea",
            subtitleText: "You will be redirected to GitHub.",
            onPressed: () => MethodChannelService.instance
                .launchUrl(AppConstants.githubSuggestionUrl),
          ).sliverBox,

          /// Privacy police
          const SliverContentTitle(title: "Privacy"),
          const StyledText(
            "Mindful is committed to protecting your privacy.We do not collect any type of data. The app operates entirely offline and does not require an internet connection.",
            fontSize: 14,
            // isSubtitle: true,
          ).sliverBox,
          12.vSliverBox,
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.tonalIcon(
              icon: const Icon(FluentIcons.info_20_regular),
              label: const Text("More details"),
              onPressed: () => MethodChannelService.instance
                  .launchUrl(AppConstants.privacyPolicyUrl),
            ),
          ).sliverBox,

          /// Permissions
          const SliverContentTitle(title: "Permissions"),
          const DefaultListTile(
            titleText: "Usage access",
            subtitleText: "Allows to fetch screen and data usage.",
          ).sliverBox,
          const DefaultListTile(
            titleText: "Display over other apps",
            subtitleText:
                "Allows to show an overlay when paused apps are opened.",
          ).sliverBox,
          const DefaultListTile(
            titleText: "Accessibility",
            subtitleText:
                "Allows to detect opened website and short content on different platforms.",
          ).sliverBox,
          const DefaultListTile(
            titleText: "Do not disturb",
            subtitleText:
                "Allows to start and stop dnd during bedtime schedule.",
          ).sliverBox,
          const DefaultListTile(
            titleText: "Admin",
            subtitleText:
                "Allows to restrict user from uninstalling during invincible mode.",
          ).sliverBox,
          const DefaultListTile(
            titleText: "VPN",
            subtitleText:
                "Allows to restrict internet access to specified apps.",
          ).sliverBox,
          const DefaultListTile(
            titleText: "Internet",
            subtitleText:
                "Allows to create and protect local vpn socket when blocking app's internet.",
          ).sliverBox,
          const DefaultListTile(
            titleText: "Notification",
            subtitleText:
                "Allows to remind and alert about important information and events.",
          ).sliverBox,

          const SliverTabsBottomPadding(),
        ],
      ),
    );
  }
}



// <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
//     <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
//     <uses-permission android:name="android.permission.FOREGROUND_SERVICE_SPECIAL_USE" />
//     <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
//     <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
//     <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY" />
//     <uses-permission android:name="android.permission.INTERNET" />
//     <uses-permission
//         android:name="android.permission.QUERY_ALL_PACKAGES"
//         tools:ignore="QueryAllPackagesPermission" />
//     <uses-permission
//         android:name="android.permission.PACKAGE_USAGE_STATS"
//         tools:ignore="ProtectedPermissions" />