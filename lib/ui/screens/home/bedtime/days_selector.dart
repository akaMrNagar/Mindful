import 'package:flutter/material.dart';
import 'package:mindful/core/utils/strings.dart';

class DaysSelector extends StatefulWidget {
  const DaysSelector({super.key});

  @override
  State<DaysSelector> createState() => _DaysSelectorState();
}

class _DaysSelectorState extends State<DaysSelector> {
  List<int> daysState = [0, 1, 0, 1, 1, 1, 0];

  void _onToggle(int index) {
    setState(() {
      daysState[index] = daysState[index] == 1 ? 0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        7,
        (index) => daysState[index] == 1
            ? IconButton.outlined(
                onPressed: () => _onToggle(index),
                icon: Text(AppStrings.daysShort[index]),
              )
            : IconButton(
                onPressed: () => _onToggle(index),
                icon: Text(AppStrings.daysShort[index]),
              ),
      ).toList(),
    );
  }
}
