/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/services/method_channel_service.dart';
import 'package:mindful/models/device_info_model.dart';

/// A Riverpod future provider that manages [DeviceInfoModel].
final deviceInfoProvider = FutureProvider<DeviceInfoModel>((ref) async {
  return await MethodChannelService.instance.getDeviceInfo();
});
