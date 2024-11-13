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

import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverUsageCards extends StatelessWidget {
  /// Sliver list containing segmented buttons to toggle between usage types
  /// and cards for displaying relevant selected usage like screen time, mobile and wifi usage
  const SliverUsageCards({
    super.key,
    required this.usageType,
    required this.screenUsageInfo,
    required this.wifiUsageInfo,
    required this.mobileUsageInfo,
    required this.onUsageTypeChanged,
  });

  final UsageType usageType;
  final int screenUsageInfo;
  final int wifiUsageInfo;
  final int mobileUsageInfo;
  final ValueChanged<UsageType> onUsageTypeChanged;

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        /// Usage type selector

        Align(
          alignment: Alignment.centerLeft,
          child: SegmentedButton<UsageType>(
            showSelectedIcon: false,
            selected: {usageType},
            onSelectionChanged: (set) => onUsageTypeChanged(set.first),
            style: const ButtonStyle().copyWith(
              visualDensity: VisualDensity.standard,
              foregroundColor: WidgetStatePropertyAll(
                Theme.of(context).iconTheme.color,
              ),
              padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
              side: WidgetStatePropertyAll(
                BorderSide(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
            segments: [
              ButtonSegment(
                icon: const Icon(FluentIcons.phone_screen_time_20_regular),
                label: Text(context.locale.screen_segment_label),
                value: UsageType.screenUsage,
              ),
              ButtonSegment(
                icon: const Icon(FluentIcons.earth_20_regular),
                label: Text(context.locale.data_segment_label),
                value: UsageType.networkUsage,
              ),
            ],
          ),
        ),

        /// Usage info cards
        SizedBox(
          height: 78,
          child: usageType == UsageType.screenUsage

              /// Screen usage card
              ? _buildUsageCard(
                  context,
                  icon: FluentIcons.phone_20_regular,
                  title: context.locale.screen_time_label,
                  subtitle: screenUsageInfo.seconds.toTimeFull(context),
                )

              /// Mobile and Wifi usage card
              : Row(
                  children: [
                    Expanded(
                      child: _buildUsageCard(
                        context,
                        icon: FluentIcons.cellular_data_1_20_filled,
                        title: context.locale.mobile_label,
                        subtitle: mobileUsageInfo.toData(),
                      ),
                    ),
                    8.hBox,
                    Expanded(
                      child: _buildUsageCard(
                        context,
                        icon: FluentIcons.wifi_1_20_filled,
                        title: context.locale.wifi_label,
                        subtitle: wifiUsageInfo.toData(),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildUsageCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return DefaultListTile(
      isPrimary: true,
      leading: Icon(icon),
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
    );
  }
}
