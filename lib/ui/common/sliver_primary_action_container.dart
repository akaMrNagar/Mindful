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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverPrimaryActionContainer extends StatelessWidget {
  /// [RoundedContainer] with primary accent and a CTA button
  const SliverPrimaryActionContainer({
    super.key,
    required this.isVisible,
    required this.title,
    required this.information,
    required this.icon,
    this.margin = EdgeInsets.zero,
    this.positiveBtn,
    this.negativeBtn,
  });

  final bool isVisible;
  final String title;
  final String information;
  final EdgeInsets margin;
  final IconData icon;
  final Widget? positiveBtn;
  final Widget? negativeBtn;

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedPaintExtent(
      duration: 500.ms,
      curve: Curves.easeOutExpo,
      child: SliverVisibility(
        visible: isVisible,
        sliver: RoundedContainer(
          circularRadius: 24,
          padding: const EdgeInsets.all(16),
          margin: margin,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon),

                6.vBox,

                /// title
                StyledText(
                  title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),

                2.vBox,

                ///  info
                StyledText(
                  information,
                  fontSize: 12,
                ),

                12.vBox,

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    negativeBtn ?? 0.vBox,
                    const Spacer(),
                    positiveBtn ?? 0.vBox,
                  ],
                ),
              ],
            ),
          ),
        ).sliver,
      ),
    );
  }
}
