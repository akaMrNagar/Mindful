/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

extension ExtIterable on Iterable<dynamic> {
  /// Iterates over [this] and check if [other] contains any one of the element from [this]
  /// Returns TRUE if [other] contains any element of [this] otherwise false
  bool containsAnyOf(Iterable<dynamic> other) {
    for (final e in this) {
      if (other.contains(e)) return true;
    }
    return false;
  }
}
