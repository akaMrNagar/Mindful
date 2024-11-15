import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/providers/restriction_groups_provider.dart';
import 'package:mindful/ui/screens/restriction_groups/restriction_group_bottom_sheet.dart';

class CreateRestrictionGroupFab extends ConsumerWidget {
  const CreateRestrictionGroupFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      label: Text(context.locale.create_group_fab_button),
      icon: const Icon(FluentIcons.tab_add_20_filled),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      onPressed: () async {
        /// Group with invalid ID -1
        final placeholderGroup = await showCreateUpdateRestrictionGroupSheet(
          context: context,
        );

        if (placeholderGroup == null) return;

        /// Create new group and store it. The returned group is valid because,
        /// it point to valid id in the database
        final validDatabaseGroup =
            await ref.read(restrictionGroupsProvider.notifier).createNewGroup(
                  groupName: placeholderGroup.groupName,
                  timerSec: placeholderGroup.timerSec,
                  distractingApps: placeholderGroup.distractingApps,
                );

        /// Update associated group ids for apps
        ref.read(appsRestrictionsProvider.notifier).updateAssociatedGroupId(
              appPackages: validDatabaseGroup.distractingApps,
              groupId: validDatabaseGroup.id,
            );
      },
    );
  }
}
