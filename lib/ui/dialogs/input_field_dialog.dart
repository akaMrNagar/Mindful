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
        title: "Distracting website",
        fieldLabel: "Url",
        hintText: "example.com",
        helperText: "Enter url of a website which you want to block.",
        negativeBtnLabel: "Cancel",
        positiveBtnLabel: "Block",
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
}) async {
  return await Navigator.of(context).push<String>(
    HeroPageRoute(
      builder: (context) => _InputFieldDialog(
        heroTag: heroTag,
        keyboardType: TextInputType.text,
        dialogIcon: FluentIcons.person_20_filled,
        fieldIcon: FluentIcons.person_20_regular,
        title: "Username",
        fieldLabel: "Username",
        hintText: "Hustler",
        helperText: "Enter your username which will be displayed on dashboard.",
        negativeBtnLabel: "Cancel",
        positiveBtnLabel: "Apply",
      ),
    ),
  );
}

class _InputFieldDialog extends StatelessWidget {
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
  });

  final Object heroTag;
  final TextInputType keyboardType;
  final IconData dialogIcon;
  final IconData fieldIcon;
  final String title;
  final String fieldLabel;
  final String hintText;
  final String helperText;
  final String positiveBtnLabel;
  final String negativeBtnLabel;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Container(
      margin: const EdgeInsets.all(48),
      alignment: Alignment.center,
      child: DefaultHero(
        tag: heroTag,
        child: SingleChildScrollView(
          child: AlertDialog(
            icon: Icon(dialogIcon),
            title: StyledText(title),
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                scrollPhysics: const AlwaysScrollableScrollPhysics(),
                controller: controller,
                onSubmitted: (txt) => Navigator.maybePop(context, txt),
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  label: Text(fieldLabel),
                  hintText: hintText,
                  prefixIcon: Icon(fieldIcon),
                  helperText: helperText,
                  helperMaxLines: 3,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.maybePop(context),
                child: Text(negativeBtnLabel),
              ),
              TextButton(
                onPressed: () => Navigator.maybePop(context, controller.text),
                child: Text(positiveBtnLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
