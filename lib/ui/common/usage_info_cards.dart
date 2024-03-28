import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/ui/common/components/rounded_container.dart';
import 'package:mindful/ui/common/custom_text.dart';

/// Widget used to display two cards in row both for mobile and wifi usage respectively
class NetworkUsageInfoCard extends StatelessWidget {
  const NetworkUsageInfoCard(
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
              icon: FluentIcons.cellular_data_1_20_filled,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: UsageInfoCard(
              label: "Wifi",
              info: wifi.toData(),
              icon: FluentIcons.wifi_1_20_filled,
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
    required this.icon,
    this.height = 64,
  });

  final String label;
  final String info;
  final IconData icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(icon),
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
