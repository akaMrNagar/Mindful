import 'package:flutter/material.dart';
import 'package:mindful/ui/widgets/custom_text.dart';

class BedtimeSettings extends StatelessWidget {
  const BedtimeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleText("Settings"),
      ],
    );
  }
}
