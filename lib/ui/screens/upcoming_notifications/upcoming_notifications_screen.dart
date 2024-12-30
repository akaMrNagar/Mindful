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
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/upcoming_notifications_provider.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/sliver_shimmer_list.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/upcoming_notifications/notifications_group_tile.dart';

class UpcomingNotificationsScreen extends ConsumerWidget {
  const UpcomingNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationMap = ref.watch(upcomingNotificationsProvider);
    final notificationEntries = notificationMap.value?.entries.toList() ?? [];

    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.alert_badge_20_regular,
          filledIcon: FluentIcons.alert_badge_20_filled,
          title: context.locale.upcoming_notifications_tab_title,
          sliverBody: DefaultRefreshIndicator(
            onRefresh: ref
                .read(upcomingNotificationsProvider.notifier)
                .refreshNotifications,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                notificationMap.hasValue
                    ? notificationEntries.isEmpty

                        /// No notifications
                        ? SizedBox(
                            height: 256,
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
                        : SliverList.builder(
                            itemCount: notificationEntries.length,
                            itemBuilder: (context, index) =>
                                NotificationsGroupTile(
                              packageName: notificationEntries[index].key,
                              notifications: notificationEntries[index].value,
                              position: getItemPositionInList(
                                index,
                                notificationEntries.length,
                              ),
                            ),
                          )

                    /// Loading notifications
                    : const SliverShimmerList(
                        includeSubtitle: true,
                        includeTrailing: true,
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
