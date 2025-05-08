/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/models/notification_schedule.dart';
import 'package:mindful/providers/notifications/notification_settings_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_slide_to_remove.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/common/time_card.dart';

class SliverSchedulesList extends ConsumerWidget {
  const SliverSchedulesList({
    super.key,
    required this.haveNotificationAccessPermission,
  });

  final bool haveNotificationAccessPermission;

  void _updateSchedule(
    WidgetRef ref,
    NotificationSchedule updatedSchedule,
    int index,
  ) =>
      ref
          .read(notificationSettingsProvider.notifier)
          .updateSchedule(updatedSchedule, index);

  void _removeSchedule(WidgetRef ref, int index) =>
      ref.read(notificationSettingsProvider.notifier).removeSchedule(index);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedules =
        ref.watch(notificationSettingsProvider.select((v) => v.schedules));

    return SliverImplicitlyAnimatedList<NotificationSchedule>(
      items: schedules,
      animationDelay: AppConstants.defaultAnimDuration * 0.75,
      keyBuilder: (e) => "${e.label}:${e.time.toMinutes}",
      itemBuilder: (context, i, item, position) => _ScheduleCard(
        schedule: item,
        position: position,
        enabled: haveNotificationAccessPermission,
        onUpdate: (newSchedule) => _updateSchedule(ref, newSchedule, i),
        onRemove: (schedule) => _removeSchedule(ref, i),
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

  @override
  Widget build(BuildContext context) {
    return DefaultSlideToRemove(
      enabled: enabled,
      position: position,
      key: Key("${schedule.label}:${schedule.time.toMinutes}"),
      onDismiss: () => onRemove(schedule),
      child: DefaultListTile(
        position: ItemPosition.fit,
        margin: const EdgeInsets.all(0),

        /// Time
        leading: TimeCard(
          label: schedule.label,
          heroTag: HeroTags.notificationScheduleTimerTileTag(
            schedule.time.toMinutes,
          ),
          enabled: enabled,
          icon: getIconFromHourOfDay(schedule.time.hour),
          iconColor: getColorFromHourOfDay(context, schedule.time.hour),
          initialTime: schedule.time,
          onChange: (newTime) {
            if (newTime == schedule.time) return;
            onUpdate(schedule.copyWith(time: newTime));
          },
        ),

        /// Switch
        trailing: Switch(
          value: schedule.isActive,
          onChanged: enabled
              ? (isActive) => onUpdate(schedule.copyWith(isActive: isActive))
              : null,
        ),
      ),
    );
  }
}
