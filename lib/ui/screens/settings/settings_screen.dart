/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/ui/common/default_scaffold.dart';
import 'package:mindful/ui/screens/settings/about/tab_about.dart';
import 'package:mindful/ui/screens/settings/general/tab_general.dart';
import 'package:mindful/ui/screens/settings/advance/tab_advance.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      navbarItems: [
        NavbarItem(
          title: context.locale.general_tab_title,
          icon: FluentIcons.color_20_filled,
          body: const TabGeneral(),
        ),
        NavbarItem(
          title: context.locale.advance_tab_title,
          icon: FluentIcons.launcher_settings_24_filled,
          body: const TabAdvance(),
        ),
        NavbarItem(
          title: context.locale.about_tab_title,
          icon: FluentIcons.info_20_filled,
          body: const TabAbout(),
        ),
      ],
    );
  }
}
