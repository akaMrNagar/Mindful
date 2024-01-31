import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/ui/widgets/custom_text.dart';

/// Widget used to display two cards in row both for mobile and wifi usage respectively
class DataUsageInfoCard extends StatelessWidget {
  const DataUsageInfoCard(
      {super.key, required this.mobile, required this.wifi});

  final int mobile;
  final int wifi;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Expanded(
            child: UsageInfoCard(
              label: "Mobile",
              info: mobile.toData(),
              iconData: FluentIcons.cellular_data_1_20_filled,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: UsageInfoCard(
              label: "Wifi",
              info: wifi.toData(),
              iconData: FluentIcons.wifi_1_20_filled,
            ),
          ),
        ],
      ),
    );
  }
}

class UsageInfoCard extends StatelessWidget {
  const UsageInfoCard({
    super.key,
    required this.label,
    required this.info,
    required this.iconData,
  });

  final String label;
  final String info;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
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
    );
  }
}
