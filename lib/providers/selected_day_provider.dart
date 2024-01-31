import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/utils/utils.dart';

final selectedDayProvider = StateProvider.autoDispose<int>((ref) => dayOfWeek);
