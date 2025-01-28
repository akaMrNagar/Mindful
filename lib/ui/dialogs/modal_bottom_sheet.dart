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
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/ui/common/content_section_header.dart';
import 'package:mindful/ui/common/sliver_tabs_bottom_padding.dart';

/// Opens modal bottom sheet with the passed sliver body
Future<void> showDefaultBottomSheet({
  required BuildContext context,
  required Widget sliverBody,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 12),
  Widget? header,
  String? headerTitle,
}) async =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      sheetAnimationStyle: AnimationStyle(
        duration: AppConstants.defaultAnimDuration,
        curve: AppConstants.defaultCurve,
        reverseDuration: AppConstants.defaultAnimDuration,
        reverseCurve: AppConstants.defaultCurve.flipped,
      ),
      builder: (sheetContext) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: padding,
          child: Column(
            children: [
              /// Header
              headerTitle != null
                  ? ContentSectionHeader(
                      title: headerTitle,
                      padding: const EdgeInsets.only(bottom: 12),
                    )
                  : header ?? 0.vBox,

              /// Body
              Expanded(
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    sliverBody,
                    const SliverTabsBottomPadding(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
