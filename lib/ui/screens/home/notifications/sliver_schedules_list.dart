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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/config/hero_tags.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/providers/notifications/notification_schedules_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_slide_to_remove.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/common/time_card.dart';
import 'package:mindful/ui/transitions/default_effects.dart';

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
      itemBuilder: (context, i, item, position) => _ScheduleCard(
        schedule: item,
        position: position,
        enabled: haveNotificationAccessPermission,
        onUpdate: (newSchedule) => _updateSchedule(ref, newSchedule),
        onRemove: (schedule) => _removeSchedule(ref, schedule),
      ).animateOnce(
        ref: ref,
        uniqueKey: "home.notifications.schedules.${item.id}",
        delay: (800 + (100 * i)).ms,
        effects: DefaultEffects.transitionIn,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ClipRRect(
        borderRadius: getBorderRadiusFromPosition(position),
        child: DefaultSlideToRemove(
          enabled: enabled,
          key: Key("${schedule.label}:${schedule.id}"),
          onDismiss: () => onRemove(schedule),
          child: DefaultListTile(
            position: ItemPosition.fit,
            margin: const EdgeInsets.all(0),

            /// Time
            leading: TimeCard(
              label: schedule.label,
              heroTag: HeroTags.notificationScheduleTimerTileTag(
                schedule.id,
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
                  ? (isActive) =>
                      onUpdate(schedule.copyWith(isActive: isActive))
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
