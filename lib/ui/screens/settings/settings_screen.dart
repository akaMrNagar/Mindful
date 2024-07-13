import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/screens/settings/about/tab_about.dart';
import 'package:mindful/ui/screens/settings/appearance/tab_appearance.dart';
import 'package:mindful/ui/screens/settings/database/tab_database.dart';
import 'package:mindful/ui/screens/settings/service/tab_service.dart';

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
            title: "Database",
            icon: FluentIcons.database_multiple_20_filled,
            body: TabDatabase(),
          ),
          NavbarItem(
            title: "Service",
            icon: FluentIcons.server_multiple_20_filled,
            body: TabService(),
          ),
          NavbarItem(
            title: "About",
            icon: FluentIcons.person_info_20_filled,
            body: TabAbout(),
          ),
        ],
      ),
    );
  }
}
