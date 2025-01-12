import 'package:flutter_riverpod/flutter_riverpod.dart';

final appsLaunchCountProvider = FutureProvider<Map<String, int>>((ref) async {
  return Future.value({});
});
