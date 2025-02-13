import 'package:flutter/material.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/ui/common/go_to_badge_icon.dart';

import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/change_logs/data/change_logs_data.dart';

class ChangeLogCard extends StatelessWidget {
  const ChangeLogCard({
    super.key,
    required this.position,
    required this.changeLog,
  });

  final ChangeLog changeLog;
  final ItemPosition position;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 4),
      borderRadius: getBorderRadiusFromPosition(position),
      onPressed:
          changeLog.onTap == null ? null : () => changeLog.onTap?.call(context),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Icon and label
              Row(
                children: [
                  Icon(
                    changeLog.icon,
                    size: 36,
                    color: Theme.of(context).colorScheme.secondary,
                  ),

                  12.hBox,

                  /// Label
                  Expanded(
                    child: StyledText(
                      changeLog.label,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),

              if (changeLog.bulletPoints.isNotEmpty) 12.vBox,

              /// Bullet points
              ...changeLog.bulletPoints
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          /// point
                          RoundedContainer(
                            height: 8,
                            width: 8,
                            color: Theme.of(context).hintColor,
                          ),
                          8.hBox,

                          /// text
                          Expanded(
                            child: StyledText(
                              e,
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList()
            ],
          ),

          /// Clickable icon
          if (changeLog.onTap != null) const GoToBadgeIcon(),
        ],
      ),
    );
  }
}
