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
import 'package:mindful/ui/common/rounded_container.dart';

/// Opens modal bottom sheet with the passed sliver body
Future<void> showDefaultBottomSheet({
  required BuildContext context,
  required Widget sliverBody,
  double heightFactor = 0.85,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 12),
}) async =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) => FractionallySizedBox(
          heightFactor: heightFactor,
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Handle
                RoundedContainer(
                  height: 8,
                  width: 48,
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  color: Theme.of(context).hintColor,
                ),

                /// Body
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      sliverBody,
                      96.vSliverBox,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
