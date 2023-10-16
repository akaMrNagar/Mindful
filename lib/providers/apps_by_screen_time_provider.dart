import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/android_app.dart';
import 'package:mindful/providers/apps_provider.dart';

final appsByScreenTimeProvider =
    Provider.autoDispose.family<AsyncValue<List<AndroidApp>>, int>((ref, day) {
  return ref.watch(appsProvider).when(
        data: (data) => AsyncData(
          /// apps used more than 0 second
          data.where((element) => element.screenTimeThisWeek[day] > 0).toList()
            ..sort(
              (a, b) => b.screenTimeThisWeek[day]
                  .compareTo(a.screenTimeThisWeek[day]),
            ),
        ),
        error: (e, st) => AsyncError(e, st),
        loading: () => const AsyncLoading(),
      );
});
