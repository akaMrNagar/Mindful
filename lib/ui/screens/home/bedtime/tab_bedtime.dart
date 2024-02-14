import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/mindful_native_plugin.dart';
import 'package:mindful/ui/screens/home/bedtime/bedtime_card.dart';
import 'package:mindful/ui/screens/home/bedtime/bedtime_settings.dart';
import 'package:mindful/ui/widgets/custom_text.dart';

class TabBedtime extends StatelessWidget {
  const TabBedtime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        24.vBox(),
        const BedtimeCard(),
        4.vBox(),
        const SubtitleText(
          "Silence your phone, change screen to black and white at bedtime. Only alarms and important calls can reach you.",
        ),

        /// Settings
        24.vBox(),
        const BedtimeSettings(),
      ],
    );
  }
}
