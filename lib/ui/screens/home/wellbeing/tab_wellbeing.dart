import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/providers/permissions_provider.dart';
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/list_tile_skeleton.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_flexible_appbar.dart';
import 'package:mindful/ui/common/sliver_flexible_header.dart';
import 'package:mindful/ui/common/stateful_text.dart';
import 'package:mindful/ui/common/switchable_list_tile.dart';
import 'package:mindful/ui/dialogs/input_field_dialog.dart';
import 'package:mindful/ui/common/permission_warning.dart';

class TabWellbeing extends ConsumerWidget {
  const TabWellbeing({super.key});

  void _onPressedFab(BuildContext context, WidgetRef ref) async {
    final url = await showInputWebsiteDialog(context);
    if (url == null || url.isEmpty) return;

    final host =
        await MethodChannelService.instance.parseUrl(url.toLowerCase());

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
      permissionProvider.select((value) => value.isAccessibilityServiceRunning),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              /// Appbar
              const SliverFlexibleAppBar(
                title: "Wellbeing",
                canCollapse: false,
              ),

              /// Information about bedtime
              const SliverFlexiblePinnedHeader(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: StatefulText(
                    "Silence your phone, change screen to black and white at bedtime. Only alarms and important calls can reach you.",
                    activeColor: Colors.grey,
                  ),
                ),
              ),

              PermissionWarning(
                title: "Accessibility permission",
                information:
                    "Granting accessibility permission allows Mindful to restrict access to short-form video content (e.g., Reels, Shorts) within social media apps and browsers. Additionally, it filters nsfw websites, promoting a more secure and focused online environment.",
                havePermission: isAccessibilityRunning,
                onTapAllow: ref
                    .read(permissionProvider.notifier)
                    .askAccessibilityPermission,
              ),

              /// Short content header
              const SliverFlexiblePinnedHeader(
                minHeight: 32,
                maxHeight: 48,
                alignment: Alignment.centerLeft,
                child: Text("Short content"),
              ),

              /// Quick actions
              SliverList.list(
                children: [
                  /// Block instagram reels
                  SwitchableListTile(
                    leading: Image.asset(
                      "assets/images/instaReels.png",
                      width: 32,
                    ),
                    enabled: isAccessibilityRunning,
                    titleText: "Block reels",
                    subTitleText: "Block reels on instagram",
                    value: wellBeing.blockInstaReels,
                    onPressed: ref
                        .read(wellBeingProvider.notifier)
                        .switchBlockInstaReels,
                  ),

                  /// Block youtube shorts
                  SwitchableListTile(
                    leading: Image.asset(
                      "assets/images/ytShorts.png",
                      width: 32,
                    ),
                    enabled: isAccessibilityRunning,
                    titleText: "Block shorts",
                    subTitleText: "Block shorts on youtube",
                    value: wellBeing.blockYtShorts,
                    onPressed: ref
                        .read(wellBeingProvider.notifier)
                        .switchBlockYtShorts,
                  ),

                  /// Block snapchat spotlight
                  SwitchableListTile(
                    leading: Image.asset(
                      "assets/images/snapSpotlight.png",
                      width: 32,
                    ),
                    enabled: isAccessibilityRunning,
                    titleText: "Block spotlight",
                    subTitleText: "Block spotlight on snapchat",
                    value: wellBeing.blockSnapSpotlight,
                    onPressed: ref
                        .read(wellBeingProvider.notifier)
                        .switchBlockSnapSpotlight,
                  ),

                  /// Block facebook reels
                  SwitchableListTile(
                    leading: Image.asset(
                      "assets/images/fbReels.png",
                      width: 32,
                    ),
                    enabled: isAccessibilityRunning,
                    titleText: "Block reels",
                    subTitleText: "Block reels on facebook",
                    value: wellBeing.blockFbReels,
                    onPressed:
                        ref.read(wellBeingProvider.notifier).switchBlockFbReels,
                  ),
                ],
              ),

              /// Adult content header
              const SliverFlexiblePinnedHeader(
                minHeight: 32,
                maxHeight: 48,
                alignment: Alignment.centerLeft,
                child: Text("Adult content"),
              ),

              /// Block NSFW websites
              SwitchableListTile(
                enabled: isAccessibilityRunning,
                leadingIcon: FluentIcons.slide_multiple_search_20_regular,
                titleText: "Block Nsfw",
                subTitleText:
                    "Block browsers from opening adult and porn websites",
                value: wellBeing.blockNsfwSites,
                onPressed:
                    ref.read(wellBeingProvider.notifier).switchBlockNsfwSites,
              ).toSliverBox(),

              /// Blocked websites header
              const SliverFlexiblePinnedHeader(
                minHeight: 32,
                maxHeight: 48,
                alignment: Alignment.centerLeft,
                child: Text("Blocked websites"),
              ),

              /// Distracting websites list
              wellBeing.blockedWebsites.isNotEmpty
                  ? SliverFixedExtentList.builder(
                      itemExtent: 40,
                      itemCount: wellBeing.blockedWebsites.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ListTileSkeleton(
                          leading: const RoundedContainer(width: 8, height: 8),
                          title: StatefulText(
                            wellBeing.blockedWebsites[index],
                            fontSize: 14,
                            activeColor: Theme.of(context).hintColor,
                          ),
                          trailing: IconButton(
                            iconSize: 16,
                            icon: const Icon(FluentIcons.dismiss_16_regular),
                            onPressed: () => ref
                                .read(wellBeingProvider.notifier)
                                .insertRemoveBlockedSite(
                                  wellBeing.blockedWebsites[index],
                                  false,
                                ),
                          ),
                        ),
                      ),
                    )
                  : SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        alignment: const Alignment(0, -0.5),
                        child: const StatefulText(
                          "Click on '+' icon to add distracting website which you wish to block.",
                          isActive: false,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

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
