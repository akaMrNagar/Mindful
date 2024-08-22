import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/method_channel_service.dart';

final appVersionProvider = FutureProvider<String>((ref) async {
  return MethodChannelService.instance.getAppVersion();
});
