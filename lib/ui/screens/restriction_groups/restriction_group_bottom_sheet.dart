import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/core/utils/utils.dart';
import 'package:mindful/providers/packages_by_screen_usage_provider.dart';
import 'package:mindful/ui/common/animated_apps_list.dart';
import 'package:mindful/ui/common/application_icon.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';

Future<RestrictionGroup?> showEditInsertRestrictionGroupSheet({
  required BuildContext context,
  RestrictionGroup? group,
}) async =>
    await showModalBottomSheet<RestrictionGroup?>(
      context: context,
      scrollControlDisabledMaxHeightRatio: 0.9,
      builder: (sheetContext) => _RestrictionGroupBottomSheet(group: group),
    );

class _RestrictionGroupBottomSheet extends StatefulWidget {
  const _RestrictionGroupBottomSheet({this.group});

  final RestrictionGroup? group;

  @override
  State<_RestrictionGroupBottomSheet> createState() =>
      _RestrictionGroupBottomSheetState();
}

class _RestrictionGroupBottomSheetState
    extends State<_RestrictionGroupBottomSheet> {
  final _controller = TextEditingController();
  List<String> _selectedApps = [];
  int _timerSec = 0;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.group?.groupName ?? "Games";
    _timerSec = widget.group?.timerSec ?? 0;
    _selectedApps = widget.group?.distractingApps ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
        child: Column(
          children: [
            6.vBox,
            // Handle
            RoundedContainer(
              height: 6,
              width: 48,
              color: Theme.of(context).disabledColor,
            ).centered,
            24.vBox,

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: StyledText(
                "Restriction Group",
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ).leftCentered,
            ),

            TextField(
              scrollPhysics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              onSubmitted: (txt) => Navigator.maybePop(context, txt),
              decoration: const InputDecoration(
                label: Text("Label"),
                hintText: "Social Media, Entertainment, Games, etc",
                prefixIcon: Icon(FluentIcons.pen_20_regular),
                helperMaxLines: 3,
                border: InputBorder.none,
              ),
            ),

            DefaultListTile(
              leadingIcon: FluentIcons.timer_20_regular,
              titleText: "Group timer",
              subtitleText: _timerSec.seconds
                  .toTimeFull(context, replaceCommaWithAnd: true),
              onPressed: () => showRestrictionGroupTimerPicker(
                context: context,
                initialTime: _timerSec,
                heroTag: "aljkfnajlfb",
              ).then((v) => setState(() => _timerSec = v ?? _timerSec)),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: StyledText(
                "Included apps",
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ).leftCentered,
            ),

            Expanded(
              child: CustomScrollView(
                slivers: [
                  RestrictionGroupAppsList(
                    selectedApps: _selectedApps,
                    onSelectionChanged: (package, isSelected) {
                      isSelected
                          ? _selectedApps.add(package)
                          : _selectedApps.remove(package);

                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: Navigator.of(context).maybePop,
                    child: const Text("Cancel"),
                  ),
                  FilledButton(
                    onPressed: _selectedApps.isEmpty || _timerSec <= 0
                        ? null
                        : () => Navigator.pop(
                              context,
                              widget.group != null
                                  ? widget.group!.copyWith(
                                      groupName: _controller.text,
                                      timerSec: _timerSec,
                                      distractingApps: _selectedApps,
                                    )
                                  : RestrictionGroup(
                                      id: -1,
                                      groupName: _controller.text,
                                      timerSec: _timerSec,
                                      distractingApps: _selectedApps,
                                    ),
                            ),
                    child: Text(widget.group == null ? "Create" : "Update"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestrictionGroupAppsList extends ConsumerWidget {
  const RestrictionGroupAppsList({
    super.key,
    required this.selectedApps,
    required this.onSelectionChanged,
  });

  final List<String> selectedApps;
  final void Function(String package, bool isSelected) onSelectionChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = (selectedDoW: todayOfWeek, includeAll: true);
    final allApps = ref.watch(packagesByScreenUsageProvider(args));

    return AnimatedAppsList(
      itemExtent: 56,
      separatorTitle: context.locale.select_more_apps_heading,
      appPackages: [
        /// Selected apps which are installed
        ...selectedApps.where((e) => allApps.value!.contains(e)),

        /// Will act as a separator
        if (selectedApps.isNotEmpty) ...[""],

        /// Unselected apps which are installed
        ...allApps.value!.where((e) => !selectedApps.contains(e)),
      ],
      itemBuilder: (context, app) {
        final isSelected = selectedApps.contains(app.packageName);
        return DefaultListTile(
          isSelected: app.isImpSysApp ? null : isSelected,
          leading: ApplicationIcon(
            app: app,
            isGrayedOut: isSelected,
            size: 16,
          ),
          titleText: app.name,
          onPressed: () {
            /// If app is important system app
            if (app.isImpSysApp) {
              context.showSnackAlert(
                context.locale.imp_distracting_apps_snack_alert,
              );
              return;
            }

            onSelectionChanged(app.packageName, !isSelected);
          },
        );
      },
    );
  }
}
