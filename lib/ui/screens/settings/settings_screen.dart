import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/ui/common/default_nav_bar.dart';
import 'package:mindful/ui/screens/settings/about/tab_about.dart';
import 'package:mindful/ui/screens/settings/general/tab_general.dart';
import 'package:mindful/ui/screens/settings/advance/tab_advance.dart';
import 'package:mindful/ui/screens/settings/privacy/tab_privacy.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultNavbar(
        navbarItems: [
          NavbarItem(
            title: "General",
            icon: FluentIcons.color_20_filled,
            body: TabGeneral(),
          ),
          NavbarItem(
            title: "Advance",
            icon: FluentIcons.launcher_settings_24_filled,
            body: TabAdvance(),
          ),
          NavbarItem(
            title: "Privacy",
            icon: FluentIcons.shield_keyhole_20_filled,
            body: TabPrivacy(),
          ),
          NavbarItem(
            title: "About",
            icon: FluentIcons.info_20_filled,
            body: TabAbout(),
          ),
        ],
      ),
    );
  }
}
