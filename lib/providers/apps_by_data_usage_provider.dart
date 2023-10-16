import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/apps_provider.dart';

final appsByDataUsageProvider =
    Provider.autoDispose.family<AsyncValue<List<AndroidApp>>, int>((ref, day) {
  return ref.watch(appsProvider).when(
        data: (data) => AsyncData(
          data.where((element) => element.dataUsageThisWeek[day] > 0).toList()
            ..sort(
              (a, b) =>
                  b.dataUsageThisWeek[day].compareTo(a.dataUsageThisWeek[day]),
            ),
        ),
        error: (e, st) => AsyncError(e, st),
        loading: () => const AsyncLoading(),
      );
});
