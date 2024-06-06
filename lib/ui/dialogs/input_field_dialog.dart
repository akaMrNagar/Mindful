// ignore_for_file: unused_element

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/ui/common/hero_page_route.dart';
import 'package:mindful/ui/common/stateful_text.dart';

Future<String?> showInputWebsiteDialog(BuildContext context) async {
  return await Navigator.of(context).push<String>(
    HeroPageRoute(
      builder: (context) => const _InputFieldDialog(
        icon: FluentIcons.globe_search_20_regular,
        heroTag: 'InputWebsiteDialog',
        title: "Distracting website",
        inputLabel: 'Url',
        inputHelperText: "Enter url of a website which you want to block",
        inputHint: "example.com",
        inputType: TextInputType.url,
        leading: Icon(FluentIcons.globe_20_regular),
      ),
    ),
  );
}

class _InputFieldDialog extends StatelessWidget {
  const _InputFieldDialog({
    required this.icon,
    required this.title,
    required this.heroTag,
    required this.inputLabel,
    required this.inputHint,
    required this.inputHelperText,
    required this.inputType,
    this.leading,
    this.trailing,
  });

  final String title;
  final Object heroTag;
  final String inputLabel;
  final String inputHint;
  final String inputHelperText;
  final TextInputType inputType;
  final IconData icon;
  final Widget? trailing;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return FractionallySizedBox(
      widthFactor: 1,
      child: SingleChildScrollView(
        child: Hero(
          tag: heroTag,
          child: AlertDialog(
            icon: Icon(icon),
            title: StatefulText(title),
            content: TextField(
              // autofocus: true,
              scrollPhysics: const AlwaysScrollableScrollPhysics(),
              controller: controller,
              onSubmitted: (txt) => Navigator.maybePop(context, txt),
              keyboardType: inputType,
              decoration: InputDecoration(
                label: Text(inputLabel),
                hintText: inputHint,
                prefixIcon: leading,
                helperText: inputHelperText,
                helperMaxLines: 3,
                suffixIcon: trailing,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.maybePop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.maybePop(context, controller.text),
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
