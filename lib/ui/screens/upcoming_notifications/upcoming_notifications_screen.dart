/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/upcoming_notifications_provider.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/default_segmented_button.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/common/sliver_shimmer_list.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/upcoming_notifications/app_notifications_tile.dart';

class UpcomingNotificationsScreen extends ConsumerStatefulWidget {
  const UpcomingNotificationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpcomingStateNotificationsScreen();
}

class _UpcomingStateNotificationsScreen
    extends ConsumerState<UpcomingNotificationsScreen> {
  bool _shouldGroup = true;

  @override
  Widget build(BuildContext context) {
    final notificationMap =
        ref.watch(upcomingNotificationsProvider(_shouldGroup));

    /// {App Package : List of notifications}
    final notificationsByApp = notificationMap.value?.entries.toList() ?? [];

    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.alert_badge_20_regular,
          filledIcon: FluentIcons.alert_badge_20_filled,
          title: context.locale.upcoming_notifications_tab_title,
          sliverBody: DefaultRefreshIndicator(
            onRefresh: ref
                .read(upcomingNotificationsProvider(_shouldGroup).notifier)
                .refreshNotifications,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                /// Group un-group conversation
                DefaultSegmentedButton<bool>(
                  selected: _shouldGroup,
                  onChanged: (value) => setState(() => _shouldGroup = value),
                  segments: [
                    SegmentItem(
                      label: context.locale.button_segment_grouped_label,
                      value: true,
                    ),
                    SegmentItem(
                      label: context.locale.button_segment_ungrouped_label,
                      value: false,
                    ),
                  ],
                ).leftCentered.sliver,

                ContentSectionHeader(
                  title: context.locale.last_24_hours_heading,
                ).sliver,

                /// Notifications
                notificationMap.isLoading

                    /// Loading notifications
                    ? const SliverShimmerList(
                        includeSubtitle: true,
                        includeTrailing: true,
                      )

                    /// No notifications
                    : notificationsByApp.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  FluentIcons.emoji_sad_20_filled,
                                  size: 32,
                                ),
                                StyledText(
                                  context.locale
                                      .upcoming_notifications_empty_list_hint,
                                  fontSize: 14,
                                  isSubtitle: true,
                                ),
                              ],
                            ),
                          ).sliver

                        /// Have notifications
                        : SliverImplicitlyAnimatedList(
                            items: notificationsByApp,
                            keyBuilder: (entry) => entry.key,
                            itemBuilder: (context, entry, position) =>
                                AppsNotificationsTile(
                              packageName: entry.key,
                              notifications: entry.value,
                              position: position,
                            ),
                          ),

                /// padding
                const SliverTabsBottomPadding(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
