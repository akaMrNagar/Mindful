import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/device_dnd_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/permissions/dnd_permission.dart';
import 'package:mindful/ui/screens/home/bedtime/distracting_apps_list.dart';

class FocusSetup extends StatelessWidget {
  const FocusSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// Appbar
        const SliverFlexibleAppBar(title: "Focus Mode"),

        ///
        const StyledText(
          "When you need time to focus, you can pause distracting apps and start do not disturb mode",
        ).sliver,

        const SliverContentTitle(title: "Customizations"),

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
    );
  }
}
