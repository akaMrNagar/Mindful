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
import 'package:intl/intl.dart';

class AppConstants {
  // Custom packages
  static const removedAppPackage = "com.android.removed";
  static const tetheringAppPackage = "com.android.tethering";

  /// Urls
  static const githubUrl = "https://github.com/akaMrNagar/Mindful/";
  static const supportEmailUrl = "mailto:help.lasthopedevs@gmail.com";
  static const privacyPolicyUrl = "https://bemindful.vercel.app/privacy";
  static const faqsUrl = "https://bemindful.vercel.app/#faqs";

  static const githubIssueDirectUrl =
      "https://github.com/akaMrNagar/Mindful/issues/new?template=bug_report.md";

  static const githubSuggestionDirectUrl =
      "https://github.com/akaMrNagar/Mindful/issues/new?template=feature_request.md";

  static const githubDonationSectionUrl =
      "https://github.com/akaMrNagar/Mindful/blob/main/README.md#donate-";

  static const githubFeedbackSectionUrl =
      "https://github.com/akaMrNagar/Mindful/blob/main/README.md#feedback-and-support";

  /// Returns localized list of days in a week in short
  ///  e.g., ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
  static List<String> daysShort(BuildContext context) {
    List<String> shortDays = [];
    for (int i = 1; i <= 7; i++) {
      String shortDay =
          DateFormat.E(Localizations.localeOf(context).languageCode)
              .format(DateTime(0, 1, 1 + i));
      shortDays.add(shortDay);
    }

    return shortDays;
  }
}
