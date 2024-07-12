import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/screens/settings/appearance/tab_appearance.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultNavbar(
        navbarItems: [
          const NavbarItem(
            title: "Appearance",
            icon: FluentIcons.color_20_filled,
            body: TabAppearance(),
          ),
          NavbarItem(
            title: "Database",
            icon: FluentIcons.database_multiple_20_filled,
            body: Container(color: Colors.green),
          ),
          NavbarItem(
            title: "Service",
            icon: FluentIcons.server_multiple_20_filled,
            body: Container(color: Colors.green),
          ),
          NavbarItem(
            title: "About",
            icon: FluentIcons.person_info_20_filled,
            body: Container(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
