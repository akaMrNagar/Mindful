import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/providers/restriction_groups_provider.dart';
import 'package:mindful/ui/screens/restriction_groups/restriction_group_bottom_sheet.dart';

class CreateRestrictionGroupFab extends ConsumerWidget {
  const CreateRestrictionGroupFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      // heroTag: HeroTags.focusModeFABTag,
      label: const Text("Create Group"),
      icon: const Icon(FluentIcons.tab_add_20_filled),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      onPressed: () async {
        final group =
            await showEditInsertRestrictionGroupSheet(context: context);

        if (group == null) return;

        /// Create new group
        ref.read(restrictionGroupsProvider.notifier).createNewGroup(
              groupName: group.groupName,
              timerSec: group.timerSec,
              distractingApps: group.distractingApps,
            );

        /// Update associated group ids for apps
      },
    );
  }
}
