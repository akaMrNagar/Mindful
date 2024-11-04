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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/ui/transitions/hero_page_route.dart';
import 'package:mindful/ui/common/styled_text.dart';

/// Animates the hero widget to a alert dialog to set app launch limit count
///
/// Returns the entered count
Future<int?> showAppLaunchLimitDialog({
  required BuildContext context,
  required Object heroTag,
  required int initialCount,
}) async {
  return await Navigator.of(context).push<int>(
    HeroPageRoute(
      builder: (context) => _LaunchLimitDialog(
        heroTag: heroTag,
        initialCount: initialCount,
      ),
    ),
  );
}

class _LaunchLimitDialog extends StatefulWidget {
  const _LaunchLimitDialog({
    required this.heroTag,
    required this.initialCount,
  });

  final Object heroTag;
  final int initialCount;

  @override
  State<_LaunchLimitDialog> createState() => _LaunchLimitDialogState();
}

class _LaunchLimitDialogState extends State<_LaunchLimitDialog> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialCount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(48),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: DefaultHero(
            tag: widget.heroTag,
            child: AlertDialog(
              scrollable: true,
              icon: const Icon(FluentIcons.rocket_20_filled),
              title: const StyledText("Launch limit", fontSize: 16),
              insetPadding: EdgeInsets.zero,
              content: Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyledText(
                        context.locale.timer_picker_dialog_info,
                      ),
                      32.vBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton.filledTonal(
                              icon: const Icon(FluentIcons.subtract_20_filled),
                              onPressed: () {
                                print("oilla");
                              },
                            ),
                            StyledText(
                              widget.initialCount.toString(),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            IconButton.filledTonal(
                              icon: const Icon(FluentIcons.add_20_filled),
                              onPressed: () {
                                print("oilla");
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.maybePop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.maybePop(context, _controller.text),
                  child: Text("Set"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
