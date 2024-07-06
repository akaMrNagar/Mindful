import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/segmented_icon_buttons.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:mindful/ui/common/stateful_text.dart';

class UsageCardsSliver extends StatelessWidget {
  /// Persistent pinned header containing segmented buttons to toggle between usage types
  /// and cards for displaying relevant selected usage like screen time, mobile and wifi usage
  const UsageCardsSliver({
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
  final ValueChanged<int> onUsageTypeChanged;

  @override
  Widget build(BuildContext context) {
    return SliverFlexiblePinnedHeader(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Usage type selector
          SegmentedIconButton(
            selected: usageType.index,
            onChange: onUsageTypeChanged,
            segments: const [
              FluentIcons.phone_screen_time_20_regular,
              FluentIcons.earth_20_regular,
            ],
          ),
          8.vBox(),

          /// Usage info cards
          AnimatedSwitcher(
            duration: 250.ms,
            switchInCurve: Curves.ease,
            switchOutCurve: Curves.ease,
            child: usageType == UsageType.screenUsage

                /// Screen usage card
                ? _buildUsageCard(
                    icon: FluentIcons.phone_20_regular,
                    title: "Screen time",
                    subtitle: screenUsageInfo.seconds.toTimeFull(),
                  )

                /// Mobile and Wifi usage card
                : SizedBox(
                    height: 64,
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildUsageCard(
                            icon: FluentIcons.cellular_data_1_20_filled,
                            title: "Mobile",
                            subtitle: mobileUsageInfo.toData(),
                          ),
                        ),
                        8.hBox(),
                        Expanded(
                          child: _buildUsageCard(
                            icon: FluentIcons.wifi_1_20_filled,
                            title: "Wifi",
                            subtitle: wifiUsageInfo.toData(),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return RoundedContainer(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTileSkeleton(
        leading: Icon(icon),
        title: StatefulText(title),
        subtitle: StatefulText(
          subtitle,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
