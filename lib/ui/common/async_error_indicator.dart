import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';

/// Global error widget for async providers
class AsyncErrorIndicator extends StatelessWidget {
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
            // FIXME: Copy stack trace and report to github
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
