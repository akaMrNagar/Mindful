/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:math';

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
  int _launchLimit = 0;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialCount.toString();
    _launchLimit = widget.initialCount;
  }

  void _changeLimit(int direction) {
    setState(() {
      _launchLimit = max(
        0,
        (direction.isNegative ? (_launchLimit - 5) : (_launchLimit + 5)),
      );
    });
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
              title: StyledText(context.locale.app_launch_limit_tile_title, fontSize: 16),
              insetPadding: EdgeInsets.zero,
              content: Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StyledText(
                        context.locale.app_launch_limit_picker_dialog_info,
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
                              onPressed: () => _changeLimit(-1),
                            ),
                            StyledText(
                              _launchLimit.toString(),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            IconButton.filledTonal(
                              icon: const Icon(FluentIcons.add_20_filled),
                              onPressed: () => _changeLimit(1),
                            ),
                          ],
                        ),
                      ),
                      18.vBox,
                      FittedBox(
                        child: FilledButton.icon(
                          icon: const Icon(FluentIcons.arrow_reset_20_filled),
                          label: Text(context.locale.dialog_button_reset),
                          onPressed: () => Navigator.maybePop(
                            context,
                            0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.maybePop(context),
                  child: Text(context.locale.dialog_button_cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.maybePop(context, _launchLimit),
                  child: Text(context.locale.dialog_button_set),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
