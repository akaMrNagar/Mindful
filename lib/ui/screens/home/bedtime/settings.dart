import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/ui/widgets/custom_list_tile.dart';
import 'package:mindful/ui/widgets/custom_text.dart';

class BedtimeSettings extends StatelessWidget {
  const BedtimeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText("Settings", size: 14),
        6.vBox(),
        CustomListTile(
          onPressed: () {},
          title:
              const TitleText("Enabled", size: 16, weight: FontWeight.normal),
          subTitle: const SubtitleText(
            "Enable or disable daily schedule task",
            size: 14,
          ),
          trailing: Switch(value: true, onChanged: (t) {}),
        ),
      ],
    );
  }
}
