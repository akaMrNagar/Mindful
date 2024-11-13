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
import 'package:mindful/ui/common/styled_text.dart';

class ContentSectionHeader extends StatelessWidget {
  /// Global title text with primary accent mainly used as a header for different sections in a list of widgets
  const ContentSectionHeader({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.only(top: 18, bottom: 12),
    this.alignment = Alignment.centerLeft,
  });

  final String title;
  final EdgeInsets padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: alignment,
      child: StyledText(
        title,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
