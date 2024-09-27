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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/providers/app_version_provider.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class SliverFlexibleAppBar extends ConsumerWidget {
  /// Pre-configured default app bar used globally
  const SliverFlexibleAppBar({
    super.key,
    required this.title,
  });

  final String title;

  void _showBetaDialog(BuildContext context, String version) async {
    final reportIssue = await showConfirmationDialog(
      context: context,
      heroTag: HeroTags.betaWarningTag,
      icon: FluentIcons.warning_20_filled,
      positiveLabel: context.locale.development_dialog_button_report_issue,
      negativeLabel: context.locale.development_dialog_button_close,
      title: version,
      info: context.locale.development_dialog_info,
    );

    if (reportIssue) {
      await MethodChannelService.instance
          .launchUrl(AppConstants.githubFeedbackSectionUrl);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appVersion = ref.read(appVersionProvider).value ?? "v0.0.0";

    return SliverAppBar(
      toolbarHeight: 0,
      // expandedHeight: 96, // without beta tag
      expandedHeight: 120,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// Title
              StyledText(
                title,
                maxLines: 1,
                fontSize: 32,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.fade,
              ),

              /// Beta tag
              DefaultHero(
                tag: HeroTags.betaWarningTag,
                child: Semantics(
                  excludeSemantics: true,
                  child: RoundedContainer(
                    width: 48,
                    height: 24,
                    circularRadius: 8,
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () => _showBetaDialog(context, appVersion),
                    child: StyledText(
                      appVersion.contains('DEBUG') ? "DEBUG" : "DEV",
                      color: Theme.of(context).colorScheme.onPrimary,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
              12.vBox
            ],
          ),
        ),
      ),
    );
  }
}
