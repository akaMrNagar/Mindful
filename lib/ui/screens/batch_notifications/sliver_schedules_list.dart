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
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/providers/notifications/notification_schedules_provider.dart';
import 'package:mindful/ui/common/default_slide_to_remove.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/common/time_card.dart';

class SliverSchedulesList extends ConsumerWidget {
  const SliverSchedulesList({
    super.key,
    required this.haveNotificationAccessPermission,
  });

  final bool haveNotificationAccessPermission;

  void _updateSchedule(WidgetRef ref, NotificationSchedule updatedSchedule) =>
      ref
          .read(notificationSchedulesProvider.notifier)
          .updateScheduleById(updatedSchedule);

  void _removeSchedule(WidgetRef ref, NotificationSchedule schedule) => ref
      .read(notificationSchedulesProvider.notifier)
      .removeScheduleById(schedule);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedules = ref
        .watch(notificationSchedulesProvider.select((v) => v.values.toList()));

    return SliverImplicitlyAnimatedList<NotificationSchedule>(
      items: schedules,
      animationDelay: AppConstants.defaultAnimDuration * 0.75,
      keyBuilder: (e) => "${e.label}:${e.id}",
      itemBuilder: (context, item, position) => _ScheduleCard(
        schedule: item,
        position: position,
        enabled: haveNotificationAccessPermission,
        onUpdate: (newSchedule) => _updateSchedule(ref, newSchedule),
        onRemove: (schedule) => _removeSchedule(ref, schedule),
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.schedule,
    required this.onUpdate,
    required this.onRemove,
    required this.enabled,
    this.position = ItemPosition.none,
  });

  final NotificationSchedule schedule;
  final ValueChanged<NotificationSchedule> onUpdate;
  final ValueChanged<NotificationSchedule> onRemove;
  final ItemPosition position;
  final bool enabled;

  IconData _resolveIconFromTime(int hourOfDay) => hourOfDay.isBetween(5, 12)
      ? FluentIcons.weather_sunny_high_20_filled // morning (5-12) am
      : hourOfDay.isBetween(12, 16)
          ? FluentIcons.weather_sunny_20_filled // noon (12-4) pm
          : hourOfDay.isBetween(16, 21)
              ? FluentIcons.weather_moon_20_filled // evening (4-9) pm
              : FluentIcons.sleep_20_filled; // night

  @override
  Widget build(BuildContext context) {
    /// Generate accent on the basis of time
    final accent = Color.lerp(
      Theme.of(context).colorScheme.error,
      Theme.of(context).colorScheme.primary,
      schedule.time.hour / 24,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ClipRRect(
        borderRadius: getBorderRadiusFromPosition(position),
        child: DefaultSlideToRemove(
          key: Key("${schedule.label}:${schedule.id}"),
          onDismiss: () => onRemove(schedule),
          child: Container(
            padding: const EdgeInsets.only(right: 12),
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Time
                    TimeCard(
                      label: schedule.label,
                      heroTag: HeroTags.notificationScheduleTimerTileTag(
                        schedule.id,
                      ),
                      enabled: enabled,
                      icon: _resolveIconFromTime(schedule.time.hour),
                      iconColor: accent,
                      initialTime: schedule.time,
                      onChange: (newTime) {
                        if (newTime == schedule.time) return;
                        onUpdate(schedule.copyWith(time: newTime));
                      },
                    ),

                    /// Switch
                    Switch(
                      value: schedule.isActive,
                      onChanged: enabled
                          ? (isActive) =>
                              onUpdate(schedule.copyWith(isActive: isActive))
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
