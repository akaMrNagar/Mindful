import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/sliver_content_title.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/common/sliver_permission_warning.dart';
import 'package:mindful/ui/screens/home/wellbeing/website_tile.dart';

class TabWellbeing extends ConsumerWidget {
  const TabWellbeing({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wellBeing = ref.watch(wellBeingProvider);
    final isAccessibilityRunning = ref.watch(
      permissionProvider.select((value) => value.haveAccessibilityPermission),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              /// Appbar
              const SliverFlexibleAppBar(title: "Wellbeing"),

              /// Information about bedtime
              const StyledText(
                "Silence your phone, start dnd change screen to black and white at bedtime. Only alarms and important calls can reach you.",
              ).toSliverBox(),

              if (!isAccessibilityRunning) 12.vSliverBox(),

              SliverPermissionWarning(
                title: "Accessibility",
                information:
                    "Granting accessibility permission allows Mindful to restrict access to short-form video content (e.g., Reels, Shorts) within social media apps and browsers. Additionally, it filters inappropriate websites, promoting a more secure and focused online environment.",
                havePermission: isAccessibilityRunning,
                onTapAllow: ref
                    .read(permissionProvider.notifier)
                    .askAccessibilityPermission,
              ),

              /// Short content header
              const SliverContentTitle(title: "Short content"),

              /// Quick actions
              SliverList.list(
                children: [
                  /// Block instagram reels
                  DefaultListTile(
                    leading: Image.asset(
                      "assets/images/instaReels.png",
                      width: 32,
                    ),
                    enabled: isAccessibilityRunning,
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
                    enabled: isAccessibilityRunning,
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
                    enabled: isAccessibilityRunning,
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
                    enabled: isAccessibilityRunning,
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
                enabled: isAccessibilityRunning,
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
          if (isAccessibilityRunning)
            Positioned(
              bottom: 64,
              right: 24,
              child: FloatingActionButton(
                heroTag: 'InputWebsiteDialog',
                onPressed: () => _onPressedFab(context, ref),
                child: const Icon(FluentIcons.add_20_filled),
              ),
            )
        ],
      ),
    );
  }
}
