import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/utils/extentions.dart';
import 'package:mindful/widgets/_common/custom_text.dart';
import 'package:mindful/widgets/_common/interactive_card.dart';

class DataUsageInfo extends StatelessWidget {
  const DataUsageInfo({super.key, required this.mobile, required this.wifi});

  final int mobile;
  final int wifi;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          _InfoTile(
            label: "Mobile",
            info: mobile.toData(),
            iconData: FluentIcons.cellular_data_1_20_filled,
          ),
          _InfoTile(
            label: "Wifi",
            info: wifi.toData(),
            iconData: FluentIcons.wifi_1_20_filled,
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile(
      {required this.label, required this.info, required this.iconData});

  final String label;
  final String info;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InteractiveCard(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        applyBorder: true,
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 12),
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
      ),
    );
  }
}
