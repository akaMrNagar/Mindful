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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/enums/item_position.dart';

import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/models/usage_model.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/default_segmented_button.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverUsageCards extends StatelessWidget {
  /// Sliver list containing segmented buttons to toggle between usage types
  /// and cards for displaying relevant selected usage like screen time, mobile and wifi usage
  const SliverUsageCards({
    super.key,
    required this.usage,
    required this.usageType,
    required this.onUsageTypeChanged,
  });

  final UsageModel usage;
  final UsageType usageType;
  final ValueChanged<UsageType> onUsageTypeChanged;

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        /// Usage type selector
        DefaultSegmentedButton<UsageType>(
          selected: usageType,
          onChanged: (value) => onUsageTypeChanged(value),
          segments: [
            SegmentItem(
              icon: FluentIcons.phone_screen_time_20_regular,
              filledIcon: FluentIcons.phone_screen_time_20_filled,
              label: context.locale.screen_segment_label,
              value: UsageType.screenUsage,
            ),
            SegmentItem(
              icon: FluentIcons.earth_20_regular,
              filledIcon: FluentIcons.earth_20_filled,
              label: context.locale.data_segment_label,
              value: UsageType.networkUsage,
            ),
          ],
        ).leftCentered,

        /// Usage info cards
        usageType == UsageType.screenUsage

            /// Screen usage card
            ? _buildUsageCard(
                context,
                position: ItemPosition.none,
                icon: FluentIcons.phone_20_regular,
                title: context.locale.screen_time_label,
                subtitle: usage.screenTime.seconds.toTimeFull(context),
              )

            /// Mobile and Wifi usage card
            : Row(
                children: [
                  Expanded(
                    child: _buildUsageCard(
                      context,
                      position: ItemPosition.left,
                      icon: FluentIcons.cellular_data_1_20_filled,
                      title: context.locale.mobile_label,
                      subtitle: usage.mobileData.toData(),
                    ),
                  ),
                  4.hBox,
                  Expanded(
                    child: _buildUsageCard(
                      context,
                      position: ItemPosition.right,
                      icon: FluentIcons.wifi_1_20_filled,
                      title: context.locale.wifi_label,
                      subtitle: usage.wifiData.toData(),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _buildUsageCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required ItemPosition position,
  }) {
    return DefaultListTile(
      isPrimary: true,
      margin: const EdgeInsets.only(top: 2),
      leading: Icon(icon),
      position: position,
      title: StyledText(
        title,
        color: Theme.of(context).hintColor,
        fontSize: 14,
      ),
      subtitle: Skeleton.leaf(
        child: FittedBox(
          child: StyledText(
            subtitle,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ).animate().scale(
          begin: const Offset(0.97, 0.97),
          end: const Offset(1, 1),
          curve: AppConstants.defaultCurve,
          duration: AppConstants.defaultAnimDuration * 1.5,
        );
  }
}
