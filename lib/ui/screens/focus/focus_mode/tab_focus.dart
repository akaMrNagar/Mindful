import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/tags.dart';
import 'package:mindful/ui/common/default_dropdown_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/device_dnd_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';
import 'package:mindful/ui/permissions/dnd_permission.dart';
import 'package:mindful/ui/screens/home/bedtime/distracting_apps_list.dart';

class TabFocus extends ConsumerStatefulWidget {
  const TabFocus({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabFocusState();
}

class _TabFocusState extends ConsumerState<TabFocus> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// Appbar
            const SliverFlexibleAppBar(title: "Focus Mode"),

            /// Information
            const StyledText(
              "When you need time to focus, you can pause distracting apps and start do not disturb mode",
            ).sliver,

            const SliverContentTitle(title: "Configurations"),

            /// Session tag
            DefaultDropdownTile<String>(
              label: "Focus session",
              dialogIcon: FluentIcons.door_tag_20_filled,
              value: 'Study',
              onSelected: (e) {},
              items: ["Study", "Other"]
                  .map((e) => DefaultDropdownItem(label: e, value: e))
                  .toList(),
            ).sliver,

            /// Should start dnd
            DefaultListTile(
              switchValue: true,
              titleText: "Start DND mode",
              subtitleText:
                  "Enable Do Not Disturb Mode throughout the focus session.",
              onPressed: () {},
            ).sliver,

            /// Dnd permission warning
            const DndPermission(),

            /// Manage Dnd settings
            const DeviceDndTile().sliver,

            const DistractingAppsList()
          ],
        ),

        /// FAB
        Positioned(
          bottom: 12,
          right: 12,
          child: FloatingActionButton.extended(
            heroTag: AppTags.focusModeFABTag,
            label: const Text("Start Now"),
            icon: const Icon(FluentIcons.target_arrow_20_filled),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () => _startFocusSession(context),
          ),
        ),
      ],
    );
  }

  void _startFocusSession(BuildContext context) async {
    /// Check if already session is running then forward to active session screen
    if (context.mounted) {
      Navigator.of(context).pushNamed(AppRoutes.activeSessionScreen);
      return;
    }

    /// else
    final timerSeconds = await showFocusTimerPicker(
      context: context,
      heroTag: AppTags.focusModeFABTag,
    );

    await Future.delayed(250.ms);

    if (timerSeconds == null || !context.mounted) return;
  }
}
