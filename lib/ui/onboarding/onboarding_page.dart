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
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/styled_text.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.imgArtPath,
    required this.title,
    required this.description,
    this.bottomPadding = 148,
  });

  final String imgArtPath;
  final String title;
  final String description;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          0.vBox,

          /// Illustration
          AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              imgArtPath,
              fit: BoxFit.contain,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              StyledText(
                title,
                fontSize: 32,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                color: Theme.of(context).colorScheme.primary,
              ),
              4.vBox,

              /// Description
              StyledText(
                description,
                fontSize: 16,
                color: Theme.of(context).hintColor,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
