

//  await showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay.now(),
//                       confirmText: "Set",
//                       helpText: "Select timer",
//                       builder: (BuildContext context, Widget? child) {
//                         return MediaQuery(
//                           data: MediaQuery.of(context)
//                               .copyWith(alwaysUse24HourFormat: false),
//                           child: TimePickerTheme(
//                             data: const TimePickerThemeData().copyWith(
//                               hourMinuteColor: MaterialStateColor.resolveWith(
//                                   (states) =>
//                                       states.contains(MaterialState.selected)
//                                           ? Colors.pink
//                                           : Colors.blueGrey.shade800),
//                             ),
//                             child: child ?? const SizedBox(),
//                           ),
//                         );
//                       },
//                     );