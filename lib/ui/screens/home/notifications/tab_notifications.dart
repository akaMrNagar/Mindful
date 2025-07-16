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
import 'package:mindful/config/navigation/app_routes.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/enums/recap_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/notifications/dated_notifications_provider.dart';
import 'package:mindful/providers/notifications/notification_settings_provider.dart';
import 'package:mindful/providers/system/permissions_provider.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/default_dropdown_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_refresh_indicator.dart';
import 'package:mindful/ui/common/go_to_badge_icon.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/common/status_label.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:mindful/ui/dialogs/modal_bottom_sheet.dart';
import 'package:mindful/ui/permissions/notification_access_permission_card.dart';
import 'package:mindful/ui/screens/home/notifications/sliver_batched_apps_list.dart';
import 'package:mindful/ui/screens/home/notifications/sliver_schedules_list.dart';

class TabNotifications extends ConsumerStatefulWidget {
  const TabNotifications({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TabNotificationsState();
}

class _TabNotificationsState extends ConsumerState<TabNotifications> {
  DateTimeRange _last24Hours = DateTime.now().last24Hours;

  @override
  Widget build(
    BuildContext context,
  ) {
    final havePermission = ref.watch(
        permissionProvider.select((v) => v.haveNotificationAccessPermission));

    final settings = ref.watch(notificationSettingsProvider);

    final notificationsCount = ref.watch(
        datedNotificationsProvider(_last24Hours)
            .select((v) => v.value?.length ?? 0));

    return DefaultRefreshIndicator(
      onRefresh: () async {
        if (mounted) setState(() => _last24Hours = DateTime.now().last24Hours);
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          StatusLabel(
            label: "Work in progress",
            accent: Theme.of(context).colorScheme.error,
          ).sliver,

          8.vSliverBox,

          /// Information about notification groups
          StyledText(context.locale.notifications_tab_info).sliver,

          16.vSliverBox,

          /// Upcoming notifications and Batched apps
          IntrinsicHeight(
            child: Row(
              children: [
                /// Upcoming notifications
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    badge: const GoToBadgeIcon(),
                    position: ItemPosition.topLeft,
                    icon: FluentIcons.alert_badge_20_regular,
                    title: context.locale.notifications_tab_title,
                    info: notificationsCount.toString(),
                    onTap: () => Navigator.of(context)
                        .pushNamed(AppRoutes.notificationsPath),
                  ),
                ),
                4.hBox,

                /// Batched apps
                Expanded(
                  child: UsageGlanceCard(
                    isPrimary: true,
                    badge: const GoToBadgeIcon(),
                    position: ItemPosition.topRight,
                    icon: FluentIcons.app_recent_20_regular,
                    title: context.locale.batched_apps_tile_title,
                    info: settings.batchedApps.length.toString(),
                    onTap: () => showDefaultBottomSheet(
                      context: context,
                      sliverBody: const SliverBatchedAppsList(),
                    ),
                  ),
                ),
              ],
            ),
          ).sliver,

          /// Permission card
          const NotificationAccessPermissionCard(),

          /// Non-batched history
          DefaultListTile(
            enabled: havePermission,
            position: ItemPosition.mid,
            switchValue: settings.storeNonBatchedToo,
            titleText: context.locale.store_all_tile_title,
            subtitleText: context.locale.store_all_tile_subtitle,
            onPressed: ref
                .read(notificationSettingsProvider.notifier)
                .toggleStoreNonBatched,
          ).sliver,

          /// Usage history in weeks
          DefaultDropdownTile<int>(
            position: ItemPosition.mid,
            titleText: context.locale.notification_history_tile_title,
            dialogIcon: FluentIcons.history_20_filled,
            value: settings.notificationHistoryWeeks,
            onSelected: ref
                .read(notificationSettingsProvider.notifier)
                .changeNotificationHistoryWeeks,
            items: [
              // 15 days = 2 weeks
              DefaultDropdownItem(
                label: context.locale.usage_history_15_days,
                value: 2,
              ),

              // 1 month = 4 weeks
              DefaultDropdownItem(
                label: context.locale.usage_history_1_month,
                value: 4,
              ),

              // 3 months = 13 weeks
              DefaultDropdownItem(
                label: context.locale.usage_history_3_month,
                value: 13,
              ),

              // 6 months = 26 weeks
              DefaultDropdownItem(
                label: context.locale.usage_history_6_month,
                value: 26,
              ),

              // 1 year = 52 weeks
              DefaultDropdownItem(
                label: context.locale.usage_history_1_year,
                value: 52,
              ),
            ],
          ).sliver,

          /// Batch recap type
          DefaultDropdownTile<RecapType>(
            position: ItemPosition.bottom,
            value: settings.recapType,
            onSelected:
                ref.read(notificationSettingsProvider.notifier).setRecapType,
            titleText: context.locale.batch_recap_dropdown_title,
            infoText: context.locale.batch_recap_dropdown_info,
            dialogIcon: FluentIcons.alert_urgent_20_filled,
            items: [
              DefaultDropdownItem(
                label: context.locale.batch_recap_option_summery_only,
                value: RecapType.summeryOnly,
              ),
              DefaultDropdownItem(
                label: context.locale.batch_recap_option_all_notifications,
                value: RecapType.allNotifications,
              ),
            ],
          ).sliver,

          /// Daily Schedules
          ContentSectionHeader(title: context.locale.schedules_heading).sliver,
          SliverSchedulesList(
            haveNotificationAccessPermission: havePermission,
          ),

          const SliverTabsBottomPadding(),
        ],
      ),
    );
  }
}
