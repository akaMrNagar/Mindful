/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/utils/app_constants.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/ui/transitions/hero_page_route.dart';
import 'package:mindful/ui/common/styled_text.dart';

/// Animates the hero widget to a alert dialog with input field to enter website url
///
/// Returns the entered text
Future<String?> showWebsiteInputDialog({
  required BuildContext context,
  required Object heroTag,
}) async {
  return await Navigator.of(context).push<String>(
    HeroPageRoute(
      builder: (context) => _InputFieldDialog(
        heroTag: heroTag,
        keyboardType: TextInputType.url,
        dialogIcon: FluentIcons.globe_search_20_filled,
        fieldIcon: FluentIcons.globe_20_regular,
        title: context.locale.add_website_dialog_title,
        fieldLabel: "Url",
        hintText: "example.com",
        helperText: context.locale.add_website_dialog_info,
        negativeBtnLabel: context.locale.dialog_button_cancel,
        positiveBtnLabel: context.locale.add_website_dialog_button_block,
      ),
    ),
  );
}

/// Animates the hero widget to a alert dialog with input field to enter user name
///
/// Returns the entered text
Future<String?> showUsernameInputDialog({
  required BuildContext context,
  required Object heroTag,
  required String initialText,
}) async {
  return await Navigator.of(context).push<String>(
    HeroPageRoute(
      builder: (context) => _InputFieldDialog(
        heroTag: heroTag,
        initialText: initialText,
        keyboardType: TextInputType.text,
        dialogIcon: FluentIcons.person_20_filled,
        fieldIcon: FluentIcons.person_20_regular,
        title: context.locale.username_dialog_title,
        fieldLabel: context.locale.username_dialog_title,
        hintText: AppConstants.defaultUsername,
        helperText: context.locale.username_dialog_info,
        negativeBtnLabel: context.locale.dialog_button_cancel,
        positiveBtnLabel: context.locale.username_dialog_button_apply,
      ),
    ),
  );
}

/// Animates the hero widget to a alert dialog with input field to enter group name
///
/// Returns the entered text
Future<String?> showGroupNameInputDialog({
  required BuildContext context,
  required Object heroTag,
  required String initialText,
}) async {
  return await Navigator.of(context).push<String>(
    HeroPageRoute(
      builder: (context) => _InputFieldDialog(
        heroTag: heroTag,
        initialText: initialText,
        keyboardType: TextInputType.text,
        dialogIcon: FluentIcons.tab_desktop_bottom_20_filled,
        fieldIcon: FluentIcons.tab_desktop_bottom_20_regular,
        title: context.locale.restriction_group_name_tile_title,
        fieldLabel: context.locale.restriction_group_name_tile_title,
        hintText: "Social Media, Entertainment, Games, etc",
        helperText: context.locale.restriction_group_name_picker_dialog_info,
        negativeBtnLabel: context.locale.dialog_button_cancel,
        positiveBtnLabel: context.locale.dialog_button_set,
      ),
    ),
  );
}

/// Animates the hero widget to a alert dialog with input field to notification schedule name
///
/// Returns the entered text
Future<String?> showNotificationScheduleNameDialog({
  required BuildContext context,
  required Object heroTag,
}) async {
  return await Navigator.of(context).push<String>(
    HeroPageRoute(
      builder: (context) => _InputFieldDialog(
        heroTag: heroTag,
        keyboardType: TextInputType.text,
        dialogIcon: FluentIcons.alert_snooze_20_filled,
        fieldIcon: FluentIcons.alert_snooze_20_regular,
        title: "Schedule name",
        fieldLabel: "Schedule name",
        hintText: "Morning, Noon, Work, etc",
        helperText:
            "Enter a name for the notification schedule to help identify it easily.",
        negativeBtnLabel: context.locale.dialog_button_cancel,
        positiveBtnLabel: context.locale.create_button,
      ),
    ),
  );
}

class _InputFieldDialog extends StatefulWidget {
  const _InputFieldDialog({
    required this.heroTag,
    required this.keyboardType,
    required this.dialogIcon,
    required this.fieldIcon,
    required this.title,
    required this.fieldLabel,
    required this.hintText,
    required this.helperText,
    required this.positiveBtnLabel,
    required this.negativeBtnLabel,
    this.initialText = "",
  });

  final Object heroTag;
  final TextInputType keyboardType;
  final IconData dialogIcon;
  final IconData fieldIcon;
  final String title;
  final String fieldLabel;
  final String hintText;
  final String helperText;
  final String initialText;

  final String positiveBtnLabel;
  final String negativeBtnLabel;

  @override
  State<_InputFieldDialog> createState() => _InputFieldDialogState();
}

class _InputFieldDialogState extends State<_InputFieldDialog> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController(
      text: widget.initialText,
    );

    Future.delayed(AppConstants.defaultAnimDuration * 2, () {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(48),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: DefaultHero(
            tag: widget.heroTag,
            child: AlertDialog(
              scrollable: true,
              icon: Icon(widget.dialogIcon),
              title: StyledText(widget.title, fontSize: 16),
              insetPadding: EdgeInsets.zero,
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    onSubmitted: (txt) => Navigator.maybePop(context, txt),
                    keyboardType: widget.keyboardType,
                    decoration: InputDecoration(
                      label: Text(widget.fieldLabel),
                      hintText: widget.hintText,
                      helperText: widget.helperText,
                      helperMaxLines: 10,
                      prefixIcon: Icon(widget.fieldIcon),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.maybePop(context),
                  child: Text(widget.negativeBtnLabel),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.maybePop(context, _controller.text),
                  child: Text(widget.positiveBtnLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
