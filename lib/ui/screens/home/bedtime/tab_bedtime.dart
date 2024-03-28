import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/flexible_appbar.dart';
import 'package:mindful/ui/common/persistent_header.dart';
import 'package:mindful/ui/screens/home/bedtime/bedtime_card.dart';
import 'package:mindful/ui/screens/home/bedtime/bedtime_settings.dart';
import 'package:mindful/ui/common/custom_text.dart';

class TabBedtime extends StatelessWidget {
  const TabBedtime({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 12),
      child: CustomScrollView(
        slivers: [
          /// Appbar
          const FlexibleAppBar(title: "Bedtime"),
          const SubtitleText(
            "Silence your phone, change screen to black and white at bedtime. Only alarms and important calls can reach you.",
          ).toSliverBox(),

          12.vSliverBox(),
          const BedtimeCard(),

          /// Settings
          24.vSliverBox(),
          SliverPersistentHeader(
            pinned: true,
            delegate: PersistentHeader(
              minHeight: 32,
              maxHeight: 56,
              alignment: Alignment.centerLeft,
              child: Text(
                "Settings",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          const BedtimeSettings().toSliverBox(),
        ],
      ),
    );
  }
}
