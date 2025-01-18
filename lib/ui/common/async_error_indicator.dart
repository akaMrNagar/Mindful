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
import 'package:flutter/services.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

class AsyncErrorIndicator extends StatelessWidget {
  /// Global error widget for async providers
  const AsyncErrorIndicator(
    this.error,
    this.stackTrace, {
    super.key,
  });

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(18),
      circularRadius: 24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText(
            error.toString(),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          12.vBox,
          StyledText(
            stackTrace.toString(),
            fontSize: 12,
          ),
          24.vBox,
          ElevatedButton.icon(
            icon: const Icon(FluentIcons.bug_20_regular),
            label: const Text("Copy and report"),
            onPressed: () async {
              await Clipboard.setData(
                  ClipboardData(text: stackTrace.toString()));
              MethodChannelService.instance
                  .launchUrl(AppConstants.githubIssueDirectUrl);
            },
          )
        ],
      ),
    );
  }
}
