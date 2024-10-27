/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/config/app_routes.dart';
import 'package:mindful/core/enums/usage_type.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_int.dart';
import 'package:mindful/core/utils/hero_tags.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/apps_restrictions_provider.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/screens/app_dashboard/app_internet_switcher.dart';
import 'package:mindful/ui/screens/app_dashboard/app_timer_picker.dart';
import 'package:mindful/ui/transitions/default_hero.dart';

/// List tile used for displaying app usage info based on the bool [selectedUsageType]
class ApplicationTile extends ConsumerWidget {
  const ApplicationTile({
    super.key,
    required this.app,
    required this.selectedUsageType,
    required this.selectedDoW,
  });

  final AndroidApp app;
  final UsageType selectedUsageType;
  final int selectedDoW;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Watch restriction info for the package
    final restrictionInfo =
        ref.watch(appsRestrictionsProvider.select((e) => e[app.packageName]));

    final appTimer = restrictionInfo?.timerSec ?? 0;
    final isPurged =
        appTimer > 0 && appTimer <= app.screenTimeThisWeek[todayOfWeek];

    return DefaultHero(
      tag: HeroTags.applicationTileTag(app.packageName),
      child: DefaultListTile(
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.appDashboardScreen,
            arguments: (
              app: app,
              selectedUsageType: selectedUsageType,
              selectedDoW: selectedDoW,
            ),
          );
        },

        /// App icon
        leading: ApplicationIcon(app: app, isGrayedOut: isPurged),

        /// App Name
        titleText: app.name,

        /// App's Screen Time OR Data Usage
        subtitle: StyledText(
          selectedUsageType == UsageType.networkUsage
              ? app.networkUsageThisWeek[selectedDoW].toData()
              : app.screenTimeThisWeek[selectedDoW].seconds.toTimeFull(context),
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),

        /// Timer picker button
        trailing: app.isImpSysApp
            ? null
            : selectedUsageType == UsageType.screenUsage
                ? AppTimerPicker(app: app, isIconButton: true)
                : AppInternetSwitcher(app: app, isIconButton: true),
      ),
    );
  }
}
