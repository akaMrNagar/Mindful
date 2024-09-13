/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverTabsBottomPadding extends StatelessWidget {
  /// Padded "Made with ♥️ in 🇮🇳" text
  const SliverTabsBottomPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 128),
      child: Center(
        child: StyledText(
          "Made with ♥️ in 🇮🇳",
          fontSize: 14,
        ),
      ),
    ).sliver;
  }
}
