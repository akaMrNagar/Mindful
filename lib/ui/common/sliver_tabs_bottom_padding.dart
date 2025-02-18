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
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverTabsBottomPadding extends StatelessWidget {
  /// Padded "Made with ♥️ in 🇮🇳" text
  const SliverTabsBottomPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 140, bottom: 240),
      child: Center(
        child: Column(
          children: [
            /// Made with
            const StyledText(
              "Made with ♥️ in 🇮🇳",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),

            6.vBox,

            /// Socials
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Github
                RoundedContainer(
                  padding: const EdgeInsets.all(6),
                  child: const Icon(FluentIcons.code_circle_20_filled),
                  onPressed: () => MethodChannelService.instance
                      .launchUrl(AppConstants.githubUrl),
                ),
                4.hBox,

                /// Email
                RoundedContainer(
                  padding: const EdgeInsets.all(6),
                  child: const Icon(FluentIcons.mail_read_20_filled),
                  onPressed: () => MethodChannelService.instance
                      .launchUrl(AppConstants.supportEmailUrl),
                ),
                4.hBox,

                /// Instagram
                RoundedContainer(
                  padding: const EdgeInsets.all(6),
                  child: const Icon(FluentIcons.chat_multiple_20_filled),
                  onPressed: () => MethodChannelService.instance
                      .launchUrl(AppConstants.instagramUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    ).sliver;
  }
}
