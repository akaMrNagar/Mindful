import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultNavbar(
        navbarItems: [
          NavbarItem(
            title: "Appearance",
            icon: FluentIcons.data_pie_24_filled,
            body: Container(color: Colors.green),
          ),
          NavbarItem(
            title: "Database",
            icon: FluentIcons.sleep_20_filled,
            body: Container(color: Colors.green),
          ),
          NavbarItem(
            title: "Service",
            icon: FluentIcons.target_arrow_20_filled,
            body: Container(color: Colors.green),
          ),
          NavbarItem(
            title: "About",
            icon: FluentIcons.brain_circuit_20_filled,
            body: Container(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
