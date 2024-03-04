import 'package:flutter/material.dart';

@immutable
class InternetProtectionInfo {
  final bool blockApps;
  final bool blockWebsites;
  final List<String> blockedApps;
  final List<String> blockedWebsites;

  const InternetProtectionInfo({
    this.blockApps = false,
    this.blockWebsites = false,
    this.blockedApps = const [],
    this.blockedWebsites = const [],
  });

  InternetProtectionInfo copyWith({
    bool? blockApps,
    bool? blockWebsites,
    List<String>? blockedApps,
    List<String>? blockedWebsites,
  }) {
    return InternetProtectionInfo(
      blockApps: blockApps ?? this.blockApps,
      blockWebsites: blockWebsites ?? this.blockWebsites,
      blockedApps: blockedApps ?? this.blockedApps,
      blockedWebsites: blockedWebsites ?? this.blockedWebsites,
    );
  }
}
