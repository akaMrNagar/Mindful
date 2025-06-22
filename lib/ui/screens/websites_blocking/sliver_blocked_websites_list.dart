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
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/providers/restrictions/web_restrictions_provider.dart';
import 'package:mindful/ui/common/empty_list_indicator.dart';
import 'package:mindful/ui/common/sliver_implicitly_animated_list.dart';
import 'package:mindful/ui/screens/websites_blocking/website_tile.dart';

class SliverBlockedWebsitesList extends ConsumerWidget {
  const SliverBlockedWebsitesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final websites = ref.watch(webRestrictionsProvider.select(
      (v) => v.values
    ));

    return websites.isNotEmpty
        ? SliverImplicitlyAnimatedList(
            itemExtent: 64,
            items: websites.toList(),
            keyBuilder: (item) => item.host,
            itemBuilder: (context, i, item, position) => WebsiteTile(
              websitehost: item.host,
              isRemovable: !item.isNsfw,
              position: position,
            ),
          )
        : EmptyListIndicator(
            info: context.locale.blocked_websites_empty_list_hint,
          ).sliver;
  }
}
