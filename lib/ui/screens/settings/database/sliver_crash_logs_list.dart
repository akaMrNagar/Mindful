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
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_date_time.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/services/drift_db_service.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_shimmer_list.dart';
import 'package:mindful/ui/common/status_label.dart';
import 'package:mindful/ui/common/styled_text.dart';

class SliverCrashLogsList extends StatelessWidget {
  const SliverCrashLogsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CrashLog>>(
      future:
          DriftDbService.instance.driftDb.dynamicRecordsDao.fetchCrashLogs(),
      builder: (context, data) => data.hasData
          ? SliverList.builder(
              itemCount: data.data?.length ?? 0,
              itemBuilder: (context, index) => DefaultExpandableListTile(
                position: getItemPositionInList(
                  index,
                  data.data?.length ?? 0,
                ),
                titleText: data.data?[index].timeStamp.dateTimeString(context),
                subtitleText: data.data?[index].error.trim(),
                content: RoundedContainer(
                  borderRadius: getBorderRadiusFromPosition(ItemPosition.mid),
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Version label
                      StatusLabel(
                        label: data.data?[index].appVersion ?? "",
                      ),

                      12.vBox,

                      /// Stacktrace
                      StyledText(
                        "${data.data?[index].stackTrace.trim()}",
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const SliverShimmerList(includeSubtitle: true),
    );
  }
}
