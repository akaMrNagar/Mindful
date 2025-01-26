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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/ui/common/scaffold_shell.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';
import 'package:mindful/ui/screens/parental_controls/invincible_mode_settings.dart';

class ParentalControlsScreen extends ConsumerWidget {
  const ParentalControlsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    return const ScaffoldShell(
      items: [
        NavbarItem(
          icon: FluentIcons.arrow_flow_diagonal_up_right_12_filled,
          filledIcon: FluentIcons.arrow_flow_diagonal_up_right_12_filled,
          titleText: "Parental controls",
          sliverBody: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              InvincibleModeSettings(),
             

              SliverTabsBottomPadding(),
            ],
          ),
        )
      ],
    );
  }
}
