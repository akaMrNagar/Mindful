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
import 'package:mindful/providers/wellbeing_provider.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/screens/home/wellbeing/website_tile.dart';

class SliverBlockedWebsitesList extends ConsumerWidget {
  const SliverBlockedWebsitesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockedWebsites =
        ref.watch(wellBeingProvider.select((v) => v.distractingSites));

    return blockedWebsites.isNotEmpty
        ? SliverFixedExtentList.builder(
            itemExtent: 40,
            itemCount: blockedWebsites.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: WebsiteTile(
                websitehost: blockedWebsites[index],
              ),
            ),
          )
        : Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            alignment: const Alignment(0, 0),
            child: Semantics(
              excludeSemantics: true,
              child: StyledText(
                context.locale.blocked_websites_empty_list_hint,
                isSubtitle: false,
                textAlign: TextAlign.center,
              ),
            ),
          ).sliver;
  }
}
