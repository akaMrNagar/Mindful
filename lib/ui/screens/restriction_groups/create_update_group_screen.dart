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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/apps_provider.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/providers/restriction_groups_provider.dart';
import 'package:mindful/ui/common/active_period_tile_content.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/default_fab_button.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/common/sliver_distracting_apps_list.dart';
import 'package:mindful/ui/common/usage_glance_card.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class CreateUpdateRestrictionGroupScreen extends ConsumerStatefulWidget {
  const CreateUpdateRestrictionGroupScreen({
    super.key,
    this.group,
    this.canUpdateTimer = true,
    this.canUpdateActivePeriod = true,
  });

  final RestrictionGroup? group;
  final bool canUpdateTimer;
  final bool canUpdateActivePeriod;

  @override
  ConsumerState<CreateUpdateRestrictionGroupScreen> createState() =>
      _CreateUpdateRestrictionGroupState();
}

class _CreateUpdateRestrictionGroupState
    extends ConsumerState<CreateUpdateRestrictionGroupScreen> {
  RestrictionGroup _group = const RestrictionGroup(
    id: 0,
    groupName: "Social Media",
    timerSec: 0,
    activePeriodStart: TimeOfDayAdapter.zero(),
    activePeriodEnd: TimeOfDayAdapter.zero(),
    periodDurationInMins: 0,
    distractingApps: [],
  );

  @override
  void initState() {
    super.initState();
    _group = widget.group ?? _group;
  }

  int? _calculateTimeSpent() => ref
      .read(appsProvider.select(
        (v) => v.value?.values
            .where((app) => _group.distractingApps.contains(app.packageName)),
      ))
      ?.fold(0, (n, app) => (n ?? 0) + app.screenTimeThisWeek[todayOfWeek]);

  @override
  Widget build(BuildContext context) {
    final isUpdating = widget.group != null;
    final timeSpent = _calculateTimeSpent() ?? 0;
    final timeLeft = max(0, (_group.timerSec - timeSpent));

    final alreadyGroupedApps = ref
        .watch(appsRestrictionsProvider.select((v) => v.values
            .where((e) =>
                e.associatedGroupId != null && e.associatedGroupId != _group.id)
            .map((e) => e.appPackage)))
        .toList();

    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          icon: FluentIcons.tab_desktop_bottom_20_regular,
          filledIcon: FluentIcons.tab_desktop_bottom_20_filled,
          title: _group.groupName,
          fab: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// Create OR Update FAB
              DefaultFabButton(
                icon: widget.group == null
                    ? FluentIcons.add_20_filled
                    : FluentIcons.arrow_upload_20_filled,
                label: widget.group == null
                    ? context.locale.create_button
                    : context.locale.update_button,
                onPressed: widget.group == null
                    ? _createNewGroup
                    : _updateCurrentGroup,
              ),
              8.vBox,

              /// Delete FAB
              if (isUpdating)
                DefaultFabButton(
                  heroTag: HeroTags.removeRestrictionGroupTag(_group.id),
                  icon: FluentIcons.delete_20_filled,
                  label: context.locale.dialog_button_remove,
                  onPressed: _deleteCurrentGroup,
                ),
            ],
          ),
          sliverBody: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              Row(
                children: [
                  /// Time spent
                  Expanded(
                    child: UsageGlanceCard(
                      position: ItemPosition.topLeft,
                      isPrimary: true,
                      icon: FluentIcons.phone_20_regular,
                      title: context.locale.restriction_group_time_spent_label,
                      info: timeSpent.seconds.toTimeShort(context),
                    ),
                  ),
                  4.hBox,

                  /// Time left
                  Expanded(
                    child: UsageGlanceCard(
                      position: ItemPosition.topRight,
                      isPrimary: true,
                      icon: FluentIcons.phone_screen_time_20_regular,
                      title: context.locale.restriction_group_time_left_label,
                      info: _group.timerSec > 0
                          ? timeLeft.seconds.toTimeShort(context)
                          : context.locale.app_limit_status_not_set,
                    ),
                  ),
                ],
              ).sliver,
              2.vSliverBox,

              /// Group name
              DefaultHero(
                tag: HeroTags.restrictionGroupNameTileTag(_group.id),
                child: DefaultListTile(
                  position: ItemPosition.mid,
                  leadingIcon: FluentIcons.app_title_20_regular,
                  titleText: context.locale.restriction_group_name_tile_title,
                  subtitleText: _group.groupName,
                  onPressed: () => showGroupNameInputDialog(
                    context: context,
                    heroTag: HeroTags.restrictionGroupNameTileTag(_group.id),
                    initialText: _group.groupName,
                  ).then(
                    (name) {
                      _group = _group.copyWith(groupName: name);
                      setState(() {});
                    },
                  ),
                ),
              ).sliver,

              /// Group active period
              DefaultExpandableListTile(
                position: ItemPosition.mid,
                leadingIcon: FluentIcons.drink_coffee_20_regular,
                titleText: context.locale.app_active_period_tile_title,
                accent: widget.canUpdateActivePeriod
                    ? null
                    : Theme.of(context).colorScheme.error,
                subtitleText: _group.periodDurationInMins > 0
                    ? context.locale.app_active_period_tile_subtitle(
                        _group.activePeriodStart.format(context),
                        _group.activePeriodEnd.format(context),
                      )
                    : context.locale.app_limit_status_not_set,
                content: ActivePeriodTileContent(
                  totalDuration: _group.periodDurationInMins.minutes,
                  startTime: _group.activePeriodStart,
                  endTime: _group.activePeriodEnd,
                  isModifiable: () {
                    if (!widget.canUpdateActivePeriod) {
                      context.showSnackAlert(
                          context.locale.invincible_mode_snack_alert);
                    }

                    return widget.canUpdateActivePeriod;
                  },
                  onTimeChanged: (start, end) {
                    _group = _group.copyWith(
                      activePeriodStart: start,
                      activePeriodEnd: end,
                      periodDurationInMins: end.difference(start).inMinutes,
                    );

                    setState(() {});
                  },
                ),
              ).sliver,

              /// Group timer
              DefaultHero(
                tag: HeroTags.restrictionGroupTimerTileTag(_group.id),
                child: DefaultListTile(
                  position: ItemPosition.bottom,
                  leadingIcon: FluentIcons.timer_20_regular,
                  titleText: context.locale.restriction_group_timer_tile_title,
                  accent: widget.canUpdateTimer
                      ? null
                      : Theme.of(context).colorScheme.error,
                  subtitleText: _group.timerSec > 0
                      ? _group.timerSec.seconds
                          .toTimeFull(context, replaceCommaWithAnd: true)
                      : context.locale.app_limit_status_not_set,
                  onPressed: () {
                    if (!widget.canUpdateTimer) {
                      context.showSnackAlert(
                          context.locale.invincible_mode_snack_alert);
                      return;
                    }

                    showRestrictionGroupTimerPicker(
                      context: context,
                      groupName: _group.groupName,
                      initialTime: _group.timerSec,
                      heroTag: HeroTags.restrictionGroupTimerTileTag(_group.id),
                    ).then(
                      (timer) {
                        _group = _group.copyWith(timerSec: timer);
                        setState(() {});
                      },
                    );
                  },
                ),
              ).sliver,

              /// Distracting apps
              36.vSliverBox,
              SliverDistractingAppsList(
                isInsideModalSheet: false,
                distractingApps: _group.distractingApps,
                hiddenApps: alreadyGroupedApps,
                onSelectionChanged: (package, isSelected) {
                  if (!isSelected &&
                      (!widget.canUpdateTimer ||
                          !widget.canUpdateActivePeriod)) {
                    context.showSnackAlert(
                        context.locale.invincible_mode_snack_alert);
                    return;
                  }

                  _group = _group.copyWith(
                    distractingApps: isSelected
                        ? [..._group.distractingApps, package]
                        : [
                            ..._group.distractingApps.where((e) => e != package)
                          ],
                  );

                  setState(() {});
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  /// Update associated group ids for apps
  Future<void> _updateAssociatedApps(
    List<String> appPackages,
    int? groupId,
  ) async =>
      ref.read(appsRestrictionsProvider.notifier).updateAssociatedGroupId(
            appPackages: appPackages,
            groupId: groupId,
            removeIds: groupId == null,
          );

  void _createNewGroup() async {
    if (!_checkIfGroupIsValid()) return;

    /// Create new group and store it. The returned group is valid because,
    /// it point to valid id in the database
    final validDatabaseGroup =
        await ref.read(restrictionGroupsProvider.notifier).createNewGroup(
              groupName: _group.groupName,
              timerSec: _group.timerSec,
              activePeriodStart: _group.activePeriodStart,
              activePeriodEnd: _group.activePeriodEnd,
              periodDurationInMins: _group.periodDurationInMins,
              distractingApps: List.of(_group.distractingApps),
            );

    await _updateAssociatedApps(
      validDatabaseGroup.distractingApps,
      validDatabaseGroup.id,
    );

    _goBack();
  }

  void _updateCurrentGroup() async {
    if (!_checkIfGroupIsValid()) return;

    await ref
        .read(restrictionGroupsProvider.notifier)
        .updateGroup(group: _group);

    await _updateAssociatedApps(
      _group.distractingApps,
      _group.id,
    );

    _goBack();
  }

  void _deleteCurrentGroup() async {
    /// Return if cannot delete
    if (!widget.canUpdateTimer || !widget.canUpdateActivePeriod) {
      context.showSnackAlert(
        context.locale.invincible_mode_snack_alert,
      );
      return;
    }

    /// Confirm first
    final confirm = await showConfirmationDialog(
      context: context,
      heroTag: HeroTags.removeRestrictionGroupTag(_group.id),
      title: context.locale.remove_restriction_group_dialog_title,
      info:
          context.locale.remove_restriction_group_dialog_info(_group.groupName),
      icon: FluentIcons.delete_20_filled,
      positiveLabel: context.locale.dialog_button_remove,
    );

    if (!confirm) return;

    /// update associated apps and remove group
    await _updateAssociatedApps(_group.distractingApps, null);
    ref.read(restrictionGroupsProvider.notifier).removeGroup(group: _group);

    _goBack();
  }

  bool _checkIfGroupIsValid() {
    if (_group.distractingApps.isEmpty) {
      context
          .showSnackAlert(context.locale.minimum_distracting_apps_snack_alert);
      return false;
    }

    if (_group.timerSec <= 0 && _group.periodDurationInMins <= 0) {
      context.showSnackAlert(
          context.locale.restriction_group_invalid_limits_snack_alert);
      return false;
    }

    return true;
  }

  void _goBack() => (mounted) ? Navigator.of(context).maybePop() : {};
}
