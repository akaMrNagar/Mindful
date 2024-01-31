import 'package:flutter/material.dart';

extension ExtNum on num {
  /// Creates a horizontal sizedBox widget with given width
  Widget hBox() => SizedBox(width: toDouble());

  /// Creates a vertical sizedBox widget with given height
  Widget vBox() => SizedBox(height: toDouble());
}
