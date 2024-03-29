import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/components/persistent_header.dart';
import 'package:mindful/ui/common/components/rounded_container.dart';
import 'package:mindful/ui/common/components/segmented_icon_buttons.dart';
import 'package:mindful/ui/common/custom_text.dart';

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
    return SliverPersistentHeader(
      pinned: true,
      delegate: PersistentHeader(
        maxHeight: 120,
        minHeight: 120,
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
            usageType == UsageType.screenUsage

                /// Screen usage card
                ? _UsageInfoCard(
                    label: "Screen time",
                    icon: FluentIcons.phone_20_regular,
                    info: screenUsageInfo.seconds.toTimeFull(),
                  )

                /// Mobile and Wifi usage card
                : Row(
                    children: [
                      Expanded(
                        child: _UsageInfoCard(
                          label: "Mobile",
                          info: mobileUsageInfo.toData(),
                          icon: FluentIcons.cellular_data_1_20_filled,
                        ),
                      ),
                      12.hBox(),
                      Expanded(
                        child: _UsageInfoCard(
                          label: "Wifi",
                          info: wifiUsageInfo.toData(),
                          icon: FluentIcons.wifi_1_20_filled,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class _UsageInfoCard extends StatelessWidget {
  const _UsageInfoCard({
    Key? key,
    required this.label,
    required this.info,
    required this.icon,
  }) : super(key: key);

  final String label;
  final String info;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(icon),
          12.hBox(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubtitleText(label),
              TitleText(info),
            ],
          ),
        ],
      ),
    );
  }
}
