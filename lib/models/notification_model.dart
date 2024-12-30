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

@immutable
class NotificationModel {
  final String packageName;
  final String titleText;
  final String contentText;
  final DateTime timeStamp;

  const NotificationModel({
    required this.packageName,
    required this.titleText,
    required this.contentText,
    required this.timeStamp,
  });

  NotificationModel copyWith({
    String? packageName,
    String? titleText,
    String? contentText,
    DateTime? timeStamp,
  }) {
    return NotificationModel(
      packageName: packageName ?? this.packageName,
      titleText: titleText ?? this.titleText,
      contentText: contentText ?? this.contentText,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  factory NotificationModel.fromMap(Map<dynamic, dynamic> map) {
    return NotificationModel(
      packageName: map['packageName'] ?? '',
      titleText: map['titleText'] ?? '',
      contentText: map['contentText'] ?? '',
      timeStamp: DateTime.fromMillisecondsSinceEpoch(map['timeStamp'] ?? 0),
    );
  }
}
