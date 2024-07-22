import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/constants.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverDonationCard extends StatelessWidget {
  const SliverDonationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(24),
      circularRadius: 24,
      child: Column(
        children: [
          StyledText(
            "Mindful is a Free and Open Source Software (FOSS) that took months of dedicated, restless work to develop. If you find this app helpful, please consider making a donation to support our efforts and ensure continued development. Your generosity will help us keep improving and maintaining Mindful for everyone.",
            fontSize: 14,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          12.vBox,
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              icon: const Icon(FluentIcons.heart_20_filled),
              label: const Text("Donate"),
              onPressed: () => MethodChannelService.instance
                  .launchUrl(AppConstants.donationUrl),
            ),
          )
        ],
      ),
    ).sliverBox;
  }
}
