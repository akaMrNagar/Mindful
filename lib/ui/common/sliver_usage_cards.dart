import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/segmented_icon_buttons.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverUsageCards extends StatelessWidget {
  /// Persistent pinned header containing segmented buttons to toggle between usage types
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
  final ValueChanged<int> onUsageTypeChanged;

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        /// Usage type selector
        SegmentedIconButtons(
          selected: usageType.index,
          onChange: onUsageTypeChanged,
          segments: const [
            FluentIcons.phone_screen_time_20_regular,
            FluentIcons.earth_20_regular,
          ],
        ),
        8.vBox,

        /// Usage info cards
        usageType == UsageType.screenUsage

            /// Screen usage card
            ? _buildUsageCard(
                context,
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
                        context,
                        icon: FluentIcons.cellular_data_1_20_filled,
                        title: "Mobile",
                        subtitle: mobileUsageInfo.toData(),
                      ),
                    ),
                    8.hBox,
                    Expanded(
                      child: _buildUsageCard(
                        context,
                        icon: FluentIcons.wifi_1_20_filled,
                        title: "Wifi",
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
      height: 64,
      isPrimary: true,
      leading: Icon(icon),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: StyledText(
          title,
          color: Theme.of(context).hintColor,
        ),
      ),
      subtitle: StyledText(subtitle, fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
