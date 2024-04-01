import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/extensions/ext_num.dart';
// import 'package:mindful/providers/apps_provider.dart';

class BlockInternet extends ConsumerWidget {
  const BlockInternet({super.key});

  // void _toggleBlockApps(WidgetRef ref) =>
  //     ref.read(protectionProvider.notifier).toggleBlockApps();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final blockApps =
    //     ref.watch(protectionProvider.select((value) => value.blockApps));
    // final appsMap = ref.watch(appsProvider);

    // print("building whole");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Status
        // SwitchableListTile(
        //   value: blockApps,
        //   onPressed: () => _toggleBlockApps(ref),
        //   title: const TitleText("Status", weight: FontWeight.normal),
        //   subTitle: const SubtitleText("Enable or disable vpn"),
        // ),

        /// Info
        8.vBox(),
        const Text(
          "Silence your phone, change screen to black and white at bedtime. Only alarms and important calls can reach you.",
        ),

        24.vBox(),
        const Text("Locked apps"),
        6.vBox(),

        /// List of apps
        // appsMap.when(
        //   loading: () => const AsyncLoadingIndicator(),
        //   error: (e, st) => AsyncErrorIndicator(e, st),
        //   data: (apps) => ReorderableListView.builder(
        //     shrinkWrap: true,
        //     itemCount: apps.length,
        //     onReorder: (pre, now) {},
        //     itemBuilder: (context, index) => const SizedBox(),
        //   ),
        // ),
      ],
    );
  }
}
