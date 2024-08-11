import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/ui/common/breathing_widget.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';
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
          const StyledText(
            AppConstants.mindfulAppVersion,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            isSubtitle: true,
            height: 1,
          ).rightCentered.sliver,

          /// Breathing logo
          const BreathingWidget(
            dimension: 256,
            child: RoundedContainer(
              circularRadius: 120,
              padding: EdgeInsets.all(12),
              child: Icon(FluentIcons.weather_sunny_low_20_filled, size: 48),
            ),
          ).sliver,

          /// Title
          const StyledText(
            "Mindful",
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ).centered.sliver,

          /// Tag line about focus
          const StyledText(
            "Focus on what truly Matters",
            fontSize: 16,
            isSubtitle: true,
          ).centered.sliver,

          24.vSliverBox,

          /// Contribute
          const SliverContentTitle(title: "Contribute"),

          /// Source code
          DefaultListTile(
            leadingIcon: FluentIcons.code_20_regular,
            titleText: "GitHub",
            subtitleText: "View the source code.",
            onPressed: () =>
                MethodChannelService.instance.launchUrl(AppConstants.githubUrl),
          ).sliver,

          /// Issue
          DefaultListTile(
            leadingIcon: FluentIcons.bug_20_regular,
            titleText: "Report an issue",
            subtitleText: "You will be redirected to GitHub.",
            onPressed: () => MethodChannelService.instance
                .launchUrl(AppConstants.githubIssueUrl),
          ).sliver,

          /// Idea
          DefaultListTile(
            leadingIcon: FluentIcons.lightbulb_filament_20_regular,
            titleText: "Suggest an idea",
            subtitleText: "You will be redirected to GitHub.",
            onPressed: () => MethodChannelService.instance
                .launchUrl(AppConstants.githubSuggestionUrl),
          ).sliver,

          12.vSliverBox,
          const SliverContentTitle(title: "Support us"),
          12.vSliverBox,

          /// Donation box
          SliverPrimaryActionContainer(
            isVisible: true,
            title: "Thank you",
            information:
                "Mindful is a Free and Open Source Software (FOSS) that took months of dedicated, restless work to develop. If you find this app helpful, please consider making a donation to support our efforts and ensure continued development. Your generosity will help us keep improving and maintaining Mindful for everyone.",
            actionBtnLabel: "Donate",
            actionBtnIcon: const Icon(FluentIcons.heart_20_filled),
            onTapAction: () => MethodChannelService.instance
                .launchUrl(AppConstants.donationUrl),
          ),

          const SliverTabsBottomPadding(),
        ],
      ),
    );
  }
}
