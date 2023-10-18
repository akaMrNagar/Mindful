import 'package:flutter/material.dart';

class TimerPicker extends StatelessWidget {
  const TimerPicker({
    super.key,
    required this.initialTime,
    this.is24Hour = true,
  });

  final bool is24Hour;
  final TimeOfDay initialTime;

  @override
  Widget build(BuildContext context) {
    return TimePickerDialog(
      initialTime: initialTime,
    );
  }
}
