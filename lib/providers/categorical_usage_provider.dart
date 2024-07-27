import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/categorical_usage_model.dart';
import 'package:mindful/providers/apps_provider.dart';

/// A Riverpod provider that calculates and provides categorical usage data based on the available app data.
final categoricalUsageProvider = Provider<CategoricalUsageModel>((ref) {
  return ref.watch(appsProvider).when(
    data: (data) => CategoricalUsageModel.fromApps(data.values.toList()),
    error: (e, st) => const CategoricalUsageModel(),
    loading: () => const CategoricalUsageModel(),
  );
});
