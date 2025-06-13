/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/utils/widget_utils.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/empty_list_indicator.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_shimmer_list.dart';
import 'package:mindful/ui/common/status_label.dart';
import 'package:mindful/ui/common/styled_text.dart';

final _crashLogsProvider = FutureProvider.autoDispose<List<CrashLog>>(
  (ref) async =>
      await DriftDbService.instance.driftDb.dynamicRecordsDao.fetchCrashLogs(),
);

class SliverCrashLogsList extends ConsumerWidget {
  const SliverCrashLogsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(_crashLogsProvider);

    return logs.hasValue
        ? logs.value!.isEmpty
            ? EmptyListIndicator(
                isHappy: true,
                info: context.locale.crash_logs_empty_list_hint,
              ).sliver
            : SliverList.builder(
                itemCount: logs.value?.length ?? 0,
                itemBuilder: (context, index) => DefaultExpandableListTile(
                  position: getItemPositionInList(
                    index,
                    logs.value?.length ?? 0,
                  ),
                  titleText:
                      logs.value?[index].timeStamp.dateTimeString(context),
                  subtitleText: logs.value?[index].error.trim(),
                  content: RoundedContainer(
                    borderRadius: getBorderRadiusFromPosition(ItemPosition.mid),
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Version label
                        StatusLabel(
                          label: logs.value?[index].appVersion ?? "",
                        ),

                        12.vBox,

                        /// Stacktrace
                        StyledText(
                          "${logs.value?[index].stackTrace.trim()}",
                        ),
                      ],
                    ),
                  ),
                ),
              )
        : const SliverShimmerList(includeSubtitle: true);
  }
}
