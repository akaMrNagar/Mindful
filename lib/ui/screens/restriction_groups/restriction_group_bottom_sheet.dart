import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_duration.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/core/extensions/ext_widget.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/rounded_container.dart';
import 'package:mindful/ui/common/sliver_distracting_apps_list.dart';
import 'package:mindful/ui/common/styled_text.dart';
import 'package:mindful/ui/dialogs/timer_picker_dialog.dart';

Future<RestrictionGroup?> showCreateUpdateRestrictionGroupSheet({
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
    _controller.text = widget.group?.groupName ?? "Social";
    _timerSec = widget.group?.timerSec ?? 0;
    _selectedApps = widget.group?.distractingApps.toList() ?? [];
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
                context.locale.restriction_group_heading,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ).leftCentered,
            ),

            TextField(
              scrollPhysics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              onSubmitted: (txt) => Navigator.maybePop(context, txt),
              decoration: InputDecoration(
                label: Text(context.locale.restriction_group_label_tile_title),
                hintText: "Social Media, Entertainment, Games, etc",
                prefixIcon: const Icon(FluentIcons.pen_20_regular),
                helperMaxLines: 3,
                border: InputBorder.none,
              ),
            ),

            DefaultListTile(
              color: Colors.transparent,
              leadingIcon: FluentIcons.timer_20_regular,
              titleText: context.locale.restriction_group_timer_tile_title,
              subtitleText: _timerSec.seconds
                  .toTimeFull(context, replaceCommaWithAnd: true),
              onPressed: () => showRestrictionGroupTimerPicker(
                context: context,
                initialTime: _timerSec,
                heroTag: "",
              ).then((v) => setState(() => _timerSec = v ?? _timerSec)),
            ),

            8.vBox,

            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverDistractingAppsList(
                    distractingApps: _selectedApps,
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
                    child: Text(context.locale.dialog_button_cancel),
                  ),
                  FilledButton(
                    onPressed: _selectedApps.isEmpty || _timerSec <= 0
                        ? null
                        : () => Navigator.pop(
                              context,
                              RestrictionGroup(
                                id: widget.group?.id ?? -1,
                                groupName: _controller.text,
                                timerSec: _timerSec,
                                distractingApps: _selectedApps,
                              ),
                            ),
                    child: Text(
                      widget.group == null
                          ? context.locale.create_button
                          : context.locale.update_button,
                    ),
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
