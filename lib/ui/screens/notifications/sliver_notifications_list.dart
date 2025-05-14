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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/apps/apps_info_provider.dart';
import 'package:mindful/providers/notifications/dated_conversation_provider.dart';
import 'package:mindful/providers/notifications/dated_notifications_provider.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_segmented_button.dart';
import 'package:mindful/ui/common/empty_list_indicator.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/common/sliver_shimmer_list.dart';
import 'package:mindful/ui/screens/notifications/conversation_tile.dart';
import 'package:mindful/ui/screens/notifications/notification_tile.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:mindful/core/database/app_database.dart' as db;

class SliverNotificationsList extends ConsumerStatefulWidget {
  const SliverNotificationsList({
    super.key,
    required this.timeRange,
    required this.header,
  });

  final DateTimeRange timeRange;
  final String header;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SliverNotificationsListState();
}

class _SliverNotificationsListState
    extends ConsumerState<SliverNotificationsList> {
  bool _shouldGroup = false;

  void _onDismissed(db.Notification notification) => ref
      .read(datedNotificationsProvider(widget.timeRange).notifier)
      .deleteNotification(notification);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        /// Header
        ContentSectionHeader(title: widget.header).sliver,

        /// Group un-group conversation
        DefaultSegmentedButton<bool>(
          selected: _shouldGroup,
          onChanged: (value) => setState(() => _shouldGroup = value),
          segments: [
            SegmentItem(
              value: false,
              label: context.locale.notifications_tab_title,
              icon: FluentIcons.chat_multiple_20_filled,
            ),
            SegmentItem(
              value: true,
              label: context.locale.conversations_label,
              icon: FluentIcons.chat_20_filled,
            ),
          ],
        ).leftCentered.sliver,

        12.vSliverBox,

        /// List
        SliverAnimatedSwitcher(
          duration: 200.ms,
          child: _shouldGroup
              ? _SliverConversationList(
                  timeRange: widget.timeRange,
                )
              : _SliverNotificationsList(
                  timeRange: widget.timeRange,
                  onDismissed: _onDismissed,
                ),
        )
      ],
    );
  }
}

class _SliverNotificationsList extends ConsumerWidget {
  const _SliverNotificationsList({
    required this.timeRange,
    this.onDismissed,
  });

  final DateTimeRange timeRange;
  final void Function(db.Notification notification)? onDismissed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(datedNotificationsProvider(timeRange));
    final appInfo = ref.watch(appsInfoProvider);

    return notifications.hasValue && appInfo.hasValue
        ? notifications.value!.isEmpty
            ? EmptyListIndicator(
                info: context.locale.notifications_empty_list_hint,
              ).sliver
            : SliverImplicitlyAnimatedList(
                items: notifications.value!,
                keyBuilder: (e) => e.id.toString(),
                itemBuilder: (context, i, notification, position) {
                  return NotificationTile(
                    position: position,
                    leading: appInfo.value!
                            .containsKey(notification.packageName)
                        ? ApplicationIcon(
                            appInfo: appInfo.value![notification.packageName]!,
                          )
                        : const Icon(
                            FluentIcons.error_circle_20_filled,
                            size: 36,
                          ),
                    notification: notification,
                    onDismissed: onDismissed,
                  );
                },
              )
        : const SliverShimmerList(
            includeLeading: true,
            includeSubtitle: true,
            includeTrailing: true,
          );
  }
}

class _SliverConversationList extends ConsumerWidget {
  const _SliverConversationList({
    required this.timeRange,
  });

  final DateTimeRange timeRange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsByApp = ref.watch(datedConversationProvider(timeRange));
    final appInfo = ref.watch(appsInfoProvider);

    return notificationsByApp.hasValue && appInfo.hasValue
        ? notificationsByApp.value!.isEmpty
            ? EmptyListIndicator(
                info: context.locale.notifications_empty_list_hint,
              ).sliver
            : SliverImplicitlyAnimatedList(
                items: notificationsByApp.value!.entries.toList(),
                keyBuilder: (entry) => entry.key,
                itemBuilder: (context, i, entry, position) {
                  return ConversationTile(
                    appName: appInfo.value![entry.key]?.name ?? entry.key,
                    leading: appInfo.value!.containsKey(entry.key)
                        ? ApplicationIcon(
                            appInfo: appInfo.value![entry.key]!,
                          )
                        : const Icon(
                            FluentIcons.error_circle_20_filled,
                            size: 36,
                          ),
                    packageName: entry.key,
                    conversations: entry.value,
                    position: position,
                  );
                })
        : const SliverShimmerList(
            includeLeading: true,
            includeSubtitle: true,
            includeTrailing: true,
          );
  }
}
