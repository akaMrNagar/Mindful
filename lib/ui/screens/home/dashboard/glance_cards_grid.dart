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
import 'package:mindful/ui/screens/home/dashboard/glance_cards/data_mobile_glance.dart';
import 'package:mindful/ui/screens/home/dashboard/glance_cards/data_total_glance.dart';
import 'package:mindful/ui/screens/home/dashboard/glance_cards/data_wifi_glance.dart';
import 'package:mindful/ui/screens/home/dashboard/glance_cards/focus_lifetime_glance.dart';
import 'package:mindful/ui/screens/home/dashboard/glance_cards/focus_monthly_glance.dart';
import 'package:mindful/ui/screens/home/dashboard/glance_cards/focus_weekly_glance.dart';

class GlanceCardsGrid extends StatelessWidget {
  const GlanceCardsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.width / 184,
      padding: const EdgeInsets.only(top: 4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        DataTotalGlance(),
        DataMobileGlance(),
        DataWifiGlance(),
        FocusWeeklyGlance(),
        FocusMonthlyGlance(),
        FocusLifetimeGlance(),
      ],
    );
  }
}
