import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'wellbeing_settings.g.dart';

@immutable
@collection
class WellBeingSettings {
  /// ID for isar database
  Id get id => 0;

  /// Allowed time for short content in seconds
  final int allowedShortContentTimeSec;

  /// Flag denoting if to block instagram reels or not
  final bool blockInstaReels;

  /// Flag denoting if to block youtube shorts or not
  final bool blockYtShorts;

  /// Flag denoting if to block snapchat spotlight or not
  final bool blockSnapSpotlight;

  /// Flag denoting if to block facebook reels or not
  final bool blockFbReels;

  /// Flag denoting if the nsfw or adult  websites are blocked or not
  /// i.e if accessibility service is filtering websites or not
  final bool blockNsfwSites;

  /// List of website hosts which are blocked.
  final List<String> blockedWebsites;

  /// Protection model used for determining distraction blocking
  /// like blocking short form content on different platforms and blocking websites
  const WellBeingSettings({
    this.allowedShortContentTimeSec = 8 * 60 * 60,
    this.blockInstaReels = false,
    this.blockYtShorts = false,
    this.blockSnapSpotlight = false,
    this.blockFbReels = false,
    this.blockNsfwSites = false,
    this.blockedWebsites = const [],
  });

  WellBeingSettings copyWith({
    int? allowedShortContentTimeSec,
    bool? blockInstaReels,
    bool? blockYtShorts,
    bool? blockSnapSpotlight,
    bool? blockFbReels,
    bool? blockNsfwSites,
    List<String>? blockedWebsites,
  }) {
    return WellBeingSettings(
      allowedShortContentTimeSec:
          allowedShortContentTimeSec ?? this.allowedShortContentTimeSec,
      blockInstaReels: blockInstaReels ?? this.blockInstaReels,
      blockYtShorts: blockYtShorts ?? this.blockYtShorts,
      blockSnapSpotlight: blockSnapSpotlight ?? this.blockSnapSpotlight,
      blockFbReels: blockFbReels ?? this.blockFbReels,
      blockNsfwSites: blockNsfwSites ?? this.blockNsfwSites,
      blockedWebsites: blockedWebsites ?? this.blockedWebsites,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allowedShortContentTimeSec': allowedShortContentTimeSec,
      'blockInstaReels': blockInstaReels,
      'blockYtShorts': blockYtShorts,
      'blockSnapSpotlight': blockSnapSpotlight,
      'blockFbReels': blockFbReels,
      'blockNsfwSites': blockNsfwSites,
      'blockedWebsites': blockedWebsites,
    };
  }

  String toJson() => json.encode(toMap());
}
