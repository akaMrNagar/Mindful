import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'wellbeing_settings.g.dart';

/// Protection model used for determining the restriction on internet usage
/// like blocking app's internet and blocking websites
@immutable
@collection
class WellbeingSettings {
  /// ID for isar database
  Id get id => 0;

  /// Flag denoting if the internet blocker for apps is on or not
  /// i.e if vpn is filtering or not
  @ignore
  final bool isInternetBlockerOn;

  /// Flag denoting if the distractions blocker is on or not
  /// i.e if accessibility service is running or not
  @ignore
  final bool isDistractionBlockerOn;

  /// Flag denoting if the nsfw or adult  websites are blocked or not
  /// i.e if accessibility service is filtering websites or not
  final bool blockNsfwSites;

  /// Flag denoting if the short content like on instagram, youtube, facebook,
  ///  and snapchat are blocked or not
  final bool blockShortContent;

  /// List of packages name of apps whose internet is blocked
  final List<String> blockedApps;

  /// List of website hosts which are blocked.
  final List<String> blockedWebsites;

  /// Protection model used for determining the restriction on internet usage
  /// like blocking app's internet and blocking websites
  const WellbeingSettings({
    this.isInternetBlockerOn = false,
    this.isDistractionBlockerOn = false,
    this.blockNsfwSites = false,
    this.blockShortContent = false,
    this.blockedApps = const [],
    this.blockedWebsites = const [],
  });

  WellbeingSettings copyWith({
    bool? isInternetBlockerOn,
    bool? isDistractionBlockerOn,
    bool? blockNsfwSites,
    bool? blockShortContent,
    List<String>? blockedApps,
    List<String>? blockedWebsites,
  }) {
    return WellbeingSettings(
      isInternetBlockerOn: isInternetBlockerOn ?? this.isInternetBlockerOn,
      isDistractionBlockerOn:
          isDistractionBlockerOn ?? this.isDistractionBlockerOn,
      blockNsfwSites: blockNsfwSites ?? this.blockNsfwSites,
      blockShortContent: blockShortContent ?? this.blockShortContent,
      blockedApps: blockedApps ?? this.blockedApps,
      blockedWebsites: blockedWebsites ?? this.blockedWebsites,
    );
  }
}
