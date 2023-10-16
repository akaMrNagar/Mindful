// import 'package:flutter/material.dart';
// import 'package:mindful/widgets/_common/custom_card.dart';

// class _Modes {
//   _Modes({
//     required this.mode,
//     required this.info,
//   });
//   final String mode;
//   final String info;
// }

// class FocusModes extends StatelessWidget {
//   const FocusModes({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final modes = _getAvailableModes();

//     return SizedBox(
//       height: 60,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: List.generate(
//           modes.length,
//           (index) => _Segment(
//             label: modes[index].mode,
//             warning: modes[index].mode,
//             index: index,
//           ),
//         ),
//       ),
//     );
//   }

//   List<_Modes> _getAvailableModes() {
//     return [
//       _Modes(
//         mode: "Normal",
//         info:
//             "Normal mode will allow you to make changes and whitelist apps and websites at any time.",
//       ),
//       _Modes(
//         mode: "Moderate",
//         info:
//             "Moderate mode will allow you to make changes and whitelist apps and websites at any time.",
//       ),
//       _Modes(
//         mode: "Strict",
//         info:
//             "Strict mode will allow you to make changes and whitelist apps and websites at any time.",
//       ),
//     ];
//   }
// }

// class _Segment extends StatelessWidget {
//   const _Segment({
//     required this.label,
//     required this.warning,
//     required this.index,
//   });

//   final String label;
//   final String warning;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     final isSelected = 1 == index;
//     return Expanded(
//       child: CustomCard(
//         // onPressed: () => mindfulAppController.updateSectedMode(index),
//         color: isSelected
//             ? Colors.grey.shade900
//             : Colors.grey.shade900.withOpacity(0.5),
//         borderRadius: BorderRadius.horizontal(
//           left: index == 0 ? const Radius.circular(16) : Radius.zero,
//           right: index == 2 ? const Radius.circular(16) : Radius.zero,
//         ),
//         applyBorder: isSelected ? true : false,
//         borderColor: Colors.grey.shade800.withOpacity(0.75),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             color: Theme.of(context)
//                 .textTheme
//                 .titleLarge
//                 ?.color
//                 ?.withOpacity(isSelected ? 1 : 0.4),
//           ),
//         ),
//       ),
//     );
//   }
// }
