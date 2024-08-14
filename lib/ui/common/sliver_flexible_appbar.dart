import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/confirmation_dialog.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

class SliverFlexibleAppBar extends StatelessWidget {
  /// Pre-configured default app bar used globally
  const SliverFlexibleAppBar({
    super.key,
    required this.title,
  });

  final String title;

  void _showBetaDialog(BuildContext context) async {
    final reportIssue = await showConfirmationDialog(
      context: context,
      heroTag: HeroTags.betaWarningTag,
      icon: FluentIcons.warning_20_filled,
      positiveLabel: "Report Issue",
      negativeLabel: "Close",
      title: "Beta ${AppConstants.mindfulAppVersion}",
      info:
          "This is a beta version of Mindful and may have bugs or incomplete features. Please share any feedback to help us improve.\n\nThank you!",
    );

    if (reportIssue) {
      await MethodChannelService.instance
          .launchUrl(AppConstants.githubIssueUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: RoundedContainer(
                  width: 48,
                  height: 24,
                  circularRadius: 8,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => _showBetaDialog(context),
                  child: StyledText(
                    "BETA",
                    color: Theme.of(context).colorScheme.onPrimary,
                    overflow: TextOverflow.fade,
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
