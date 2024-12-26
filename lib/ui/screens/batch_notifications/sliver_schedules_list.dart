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
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/notification_schedules_provider.dart';
import 'package:mindful/ui/common/default_slide_to_remove.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/common/time_card.dart';

class SliverSchedulesList extends ConsumerWidget {
  const SliverSchedulesList({super.key});

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
    this.position = ItemPosition.none,
  });

  final NotificationSchedule schedule;
  final ValueChanged<NotificationSchedule> onUpdate;
  final ValueChanged<NotificationSchedule> onRemove;
  final ItemPosition position;

  @override
  Widget build(BuildContext context) {
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
                      enabled: schedule.isActive,
                      icon: FluentIcons.sleep_20_filled,
                      iconColor: Theme.of(context).colorScheme.primary,
                      initialTime: schedule.time,
                      onChange: (newTime) =>
                          onUpdate(schedule.copyWith(time: newTime)),
                    ),

                    /// Switch
                    Switch(
                      value: schedule.isActive,
                      onChanged: (isActive) =>
                          onUpdate(schedule.copyWith(isActive: isActive)),
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
