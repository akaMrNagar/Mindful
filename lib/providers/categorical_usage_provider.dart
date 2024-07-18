import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/models/categorical_usage_model.dart';
import 'package:mindful/providers/apps_provider.dart';

final categoricalUsageProvider = Provider<CategoricalUsageModel>((ref) {
  final apps = ref.watch(appsProvider).value?.values;
  return apps == null
      ? const CategoricalUsageModel()
      : CategoricalUsageModel.fromApps(apps.toList());
});
