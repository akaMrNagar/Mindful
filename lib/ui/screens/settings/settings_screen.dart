import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/screens/settings/about/tab_about.dart';
import 'package:mindful/ui/screens/settings/appearance/tab_appearance.dart';
import 'package:mindful/ui/screens/settings/general/tab_general.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultNavbar(
        navbarItems: [
          NavbarItem(
            title: "Appearance",
            icon: FluentIcons.color_20_filled,
            body: TabAppearance(),
          ),
          NavbarItem(
            title: "General",
            icon: FluentIcons.window_dev_tools_20_regular,
            body: TabGeneral(),
          ),
          NavbarItem(
            title: "About",
            icon: FluentIcons.info_20_regular,
            body: TabAbout(),
          ),
        ],
      ),
    );
  }
}
