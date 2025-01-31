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

class CustomizeGlanceCards extends StatelessWidget {
  const CustomizeGlanceCards({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(FluentIcons.table_edit_20_filled),
      onPressed: () => context.showSnackAlert(
        "Glance tiles customization is coming soon...",
        icon: FluentIcons.info_20_filled,
      ),
    );
  }
}
