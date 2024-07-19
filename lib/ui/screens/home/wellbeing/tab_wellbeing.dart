import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/settings_provider.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/common/sliver_permission_warning.dart';
import 'package:mindful/ui/permissions/accessibility_permission.dart';
import 'package:mindful/ui/screens/home/wellbeing/shorts_timer_chart.dart';
import 'package:mindful/ui/screens/home/wellbeing/website_tile.dart';

class TabWellBeing extends ConsumerStatefulWidget {
  const TabWellBeing({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabWellBeingState();
}

class _TabWellBeingState extends ConsumerState<TabWellBeing> {
  int _shortsScreenTimeSec = 0;

  @override
  void initState() {
    super.initState();
    MethodChannelService.instance
        .getShortsScreenTimeSec()
        .then((timeSec) => setState(() => _shortsScreenTimeSec = timeSec));
  }

  @override
  Widget build(BuildContext context) {
    final wellBeing = ref.watch(wellBeingProvider);

    final haveAccessibilityPermission = ref.watch(
      permissionProvider.select((value) => value.haveAccessibilityPermission),
    );

    final isInvincibleModeOn = ref.watch(
      settingsProvider.select((v) => v.isInvincibleModeOn),
    );

    final remainingTimeSec = max(
      0,
      (wellBeing.allowedShortContentTimeSec - _shortsScreenTimeSec),
    );

    final canModifyShortsSetting = haveAccessibilityPermission &&
        (!isInvincibleModeOn || (isInvincibleModeOn && remainingTimeSec > 0));

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// Appbar
              const SliverFlexibleAppBar(title: "Wellbeing"),

              /// Information about bedtime
              const StyledText(
                "Silence your phone, start dnd change screen to black and white at bedtime. Only alarms and important calls can reach you.",
              ).toSliverBox(),

              const AccessibilityPermission(),

              if (haveAccessibilityPermission)
                SliverPermissionWarning(
                  havePermission: canModifyShortsSetting,
                  margin: const EdgeInsets.only(top: 12),
                  title: "Invincible mode",
                  information:
                      "You have exhausted the daily short content quota time. Due to invincible mode, modifications to settings related to short content are not allowed.",
                ),

              /// Short content header
              const SliverContentTitle(title: "Short content"),

              /// Short usage progress bar
              ShortsTimerChart(
                isModifiable: canModifyShortsSetting,
                allowedTimeSec: max(wellBeing.allowedShortContentTimeSec, 1),
                remainingTimeSec: remainingTimeSec,
              ).toSliverBox(),

              /// Quick actions
              SliverList.list(
                children: [
                  /// Block instagram reels
                  DefaultListTile(
                    leading: Image.asset(
                      "assets/images/instaReels.png",
                      width: 32,
                    ),
                    enabled: canModifyShortsSetting,
                    titleText: "Block reels",
                    subtitleText: "Restrict reels on instagram",
                    switchValue: wellBeing.blockInstaReels,
                    onPressed: ref
                        .read(wellBeingProvider.notifier)
                        .switchBlockInstaReels,
                  ),

                  /// Block youtube shorts
                  DefaultListTile(
                    leading: Image.asset(
                      "assets/images/ytShorts.png",
                      width: 32,
                    ),
                    enabled: canModifyShortsSetting,
                    titleText: "Block shorts",
                    subtitleText: "Restrict shorts on youtube",
                    switchValue: wellBeing.blockYtShorts,
                    onPressed: ref
                        .read(wellBeingProvider.notifier)
                        .switchBlockYtShorts,
                  ),

                  /// Block snapchat spotlight
                  DefaultListTile(
                    leading: Image.asset(
                      "assets/images/snapSpotlight.png",
                      width: 32,
                    ),
                    enabled: canModifyShortsSetting,
                    titleText: "Block spotlight",
                    subtitleText: "Restrict spotlight on snapchat",
                    switchValue: wellBeing.blockSnapSpotlight,
                    onPressed: ref
                        .read(wellBeingProvider.notifier)
                        .switchBlockSnapSpotlight,
                  ),

                  /// Block facebook reels
                  DefaultListTile(
                    leading: Image.asset(
                      "assets/images/fbReels.png",
                      width: 32,
                    ),
                    enabled: canModifyShortsSetting,
                    titleText: "Block reels",
                    subtitleText: "Restrict reels on facebook",
                    switchValue: wellBeing.blockFbReels,
                    onPressed:
                        ref.read(wellBeingProvider.notifier).switchBlockFbReels,
                  ),
                ],
              ),

              /// Adult content header
              const SliverContentTitle(title: "Adult content"),

              /// Block NSFW websites
              DefaultListTile(
                enabled: haveAccessibilityPermission,
                leadingIcon: FluentIcons.slide_multiple_search_20_regular,
                titleText: "Block Nsfw",
                subtitleText:
                    "Restrict browsers from opening adult and porn websites",
                switchValue: wellBeing.blockNsfwSites,
                onPressed:
                    ref.read(wellBeingProvider.notifier).switchBlockNsfwSites,
              ).toSliverBox(),

              /// Blocked websites header
              const SliverContentTitle(title: "Blocked websites"),

              /// Distracting websites list
              wellBeing.blockedWebsites.isNotEmpty
                  ? SliverFixedExtentList.builder(
                      itemExtent: 40,
                      itemCount: wellBeing.blockedWebsites.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: WebsiteTile(
                          websitehost: wellBeing.blockedWebsites[index],
                        ),
                      ),
                    )
                  : Container(
                      height: 300,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      alignment: const Alignment(0, 0),
                      child: const StyledText(
                        "Click on '+' icon to add distracting website which you wish to block.",
                        isSubtitle: false,
                        textAlign: TextAlign.center,
                      ),
                    ).toSliverBox(),

              180.vSliverBox(),
            ],
          ),

          /// Add more distracting websites button
          if (haveAccessibilityPermission)
            Positioned(
              bottom: 32,
              right: 24,
              child: FloatingActionButton(
                heroTag: 'addWebsiteFAB',
                onPressed: () => _onPressedFab(context, ref),
                child: const Icon(FluentIcons.add_20_filled),
              ),
            )
        ],
      ),
    );
  }

  void _onPressedFab(BuildContext context, WidgetRef ref) async {
    final url = await showInputWebsiteDialog(context);
    if (url == null || url.isEmpty) return;

    final host =
        await MethodChannelService.instance.parseHostFromUrl(url.toLowerCase());

    if (host.isNotEmpty && host.contains('.') && !host.contains(' ')) {
      /// Check if url is already blocked
      if (ref.read(wellBeingProvider).blockedWebsites.contains(host)) {
        await MethodChannelService.instance.showToast("Url already added");
        return;
      }

      /// Add to blocked sites list
      ref.read(wellBeingProvider.notifier).insertRemoveBlockedSite(host, true);
    } else {
      await MethodChannelService.instance
          .showToast("Invalid url! cannot parse host name");
    }
  }
}
