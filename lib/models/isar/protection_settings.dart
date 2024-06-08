import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'protection_settings.g.dart';

/// Protection model used for determining the restriction on internet usage
/// like blocking app's internet and blocking websites
@immutable
@collection
class ProtectionSettings {
  /// ID for isar database
  Id get id => 0;

  /// Flag denoting if the internet blocker for apps is on or not
  /// i.e if vpn is filtering or not
  final bool appsInternetBlocker;

  /// Flag denoting if the website blocker is on or not
  /// i.e if accessibility service is filtering custom websites from [blockedWebsites] list or not
  final bool websitesBlocker;

  /// Flag denoting if the nsfw or adult  websites are blocked or not
  /// i.e if accessibility service is filtering websites or not
  final bool blockNsfwSites;

  /// List of packages name of apps whose internet is blocked
  final List<String> blockedApps;

  /// List of website hosts which are blocked.
  final List<String> blockedWebsites;

  /// Protection model used for determining the restriction on internet usage
  /// like blocking app's internet and blocking websites
  const ProtectionSettings({
    this.appsInternetBlocker = false,
    this.websitesBlocker = false,
    this.blockNsfwSites = false,
    this.blockedApps = const [],
    this.blockedWebsites = const [],
  });

  ProtectionSettings copyWith({
    bool? appsInternetBlocker,
    bool? websitesBlocker,
    bool? blockNsfwSites,
    List<String>? blockedApps,
    List<String>? blockedWebsites,
  }) {
    return ProtectionSettings(
      appsInternetBlocker: appsInternetBlocker ?? this.appsInternetBlocker,
      websitesBlocker: websitesBlocker ?? this.websitesBlocker,
      blockNsfwSites: blockNsfwSites ?? this.blockNsfwSites,
      blockedApps: blockedApps ?? this.blockedApps,
      blockedWebsites: blockedWebsites ?? this.blockedWebsites,
    );
  }
}
