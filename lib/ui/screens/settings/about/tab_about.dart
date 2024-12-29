/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/device_info_provider.dart';
import 'package:mindful/ui/common/breathing_widget.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/sliver_primary_action_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';

class TabAbout extends ConsumerWidget {
  const TabAbout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appVersion =
        ref.watch(deviceInfoProvider).value?.mindfulVersion ?? "Loading..";

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// App version
        StyledText(
          appVersion,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          isSubtitle: true,
          height: 1,
        ).rightCentered.sliver,
        2.vSliverBox,
        StyledText(
          "db-v${DriftDbService.instance.driftDb.schemaVersion}",
          fontWeight: FontWeight.bold,
          fontSize: 14,
          isSubtitle: true,
          height: 1,
        ).rightCentered.sliver,

        /// Breathing logo
        BreathingWidget(
          dimension: min(360, MediaQuery.of(context).size.width * 0.7),
          child: RoundedContainer(
            circularRadius: 120,
            color: Theme.of(context).colorScheme.secondaryContainer,
            padding: const EdgeInsets.all(12),
            child:
                const Icon(FluentIcons.weather_sunny_low_20_filled, size: 48),
          ),
        ).sliver,

        /// Title
        const StyledText(
          "Mindful",
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ).centered.sliver,

        /// Tag line about focus
        StyledText(
          context.locale.mindful_tagline,
          fontSize: 16,
          isSubtitle: true,
        ).centered.sliver,

        24.vSliverBox,

        /// Donation box
        SliverPrimaryActionContainer(
          isVisible: true,
          radius: getBorderRadiusFromPosition(ItemPosition.top),
          icon: FluentIcons.handshake_20_regular,
          title: context.locale.donation_card_title,
          information: context.locale.donation_card_info,
          positiveBtn: FilledButton.icon(
            icon: const Icon(FluentIcons.heart_20_filled),
            label: Text(context.locale.donation_card_button_donate),
            onPressed: () => MethodChannelService.instance
                .launchUrl(AppConstants.githubFeedbackSectionUrl),
          ),
        ),

        /// Change log
        DefaultListTile(
          position: ItemPosition.bottom,
          leadingIcon: FluentIcons.slide_text_20_regular,
          titleText: context.locale.changelog_tile_title,
          subtitleText: context.locale.redirected_to_github_subtitle,
          trailing: const Icon(FluentIcons.chevron_right_20_regular),
          onPressed: () => MethodChannelService.instance
              .launchUrl(AppConstants.githubChangeLogUrl(appVersion)),
        ).sliver,

        /// Contribute
        ContentSectionHeader(title: context.locale.contribute_heading).sliver,

        /// Source code
        DefaultListTile(
          position: ItemPosition.top,
          leadingIcon: FluentIcons.code_20_regular,
          titleText: context.locale.github_tile_title,
          subtitleText: context.locale.github_tile_subtitle,
          onPressed: () =>
              MethodChannelService.instance.launchUrl(AppConstants.githubUrl),
        ).sliver,

        /// Issue
        DefaultListTile(
          position: ItemPosition.mid,
          leadingIcon: FluentIcons.bug_20_regular,
          titleText: context.locale.report_issue_tile_title,
          subtitleText: context.locale.redirected_to_github_subtitle,
          onPressed: () => MethodChannelService.instance
              .launchUrl(AppConstants.githubIssueDirectUrl),
        ).sliver,

        /// Idea
        DefaultListTile(
          position: ItemPosition.mid,
          leadingIcon: FluentIcons.lightbulb_filament_20_regular,
          titleText: context.locale.suggest_idea_tile_title,
          subtitleText: context.locale.redirected_to_github_subtitle,
          onPressed: () => MethodChannelService.instance
              .launchUrl(AppConstants.githubSuggestionDirectUrl),
        ).sliver,

        /// Email
        DefaultListTile(
          position: ItemPosition.bottom,
          leadingIcon: FluentIcons.mail_20_regular,
          titleText: context.locale.write_email_tile_title,
          subtitleText: context.locale.write_email_tile_subtitle,
          onPressed: () => MethodChannelService.instance
              .launchUrl(AppConstants.supportEmailUrl),
        ).sliver,

        /// Privacy policy
        ContentSectionHeader(title: context.locale.privacy_policy_heading)
            .sliver,
        StyledText(context.locale.privacy_policy_info).sliver,
        12.vSliverBox,
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton.tonalIcon(
            icon: const Icon(FluentIcons.info_20_regular),
            label: Text(context.locale.more_details_button),
            onPressed: () => MethodChannelService.instance
                .launchUrl(AppConstants.privacyPolicyUrl),
          ),
        ).sliver,

        const SliverTabsBottomPadding(),
      ],
    );
  }
}
