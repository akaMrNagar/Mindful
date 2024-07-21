import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/ui/transitions/default_hero.dart';
import 'package:mindful/ui/transitions/hero_page_route.dart';
import 'package:mindful/ui/common/styled_text.dart';

Future<String?> showWebsiteInputDialog({
  required BuildContext context,
  required Object heroTag,
}) async {
  return await Navigator.of(context).push<String>(
    HeroPageRoute(
      builder: (context) => _InputFieldDialog(heroTag),
    ),
  );
}

class _InputFieldDialog extends StatelessWidget {
  const _InputFieldDialog(this.heroTag);

  final Object heroTag;

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
            icon: const Icon(FluentIcons.globe_search_20_regular),
            title: const StyledText("Distracting website"),
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                scrollPhysics: const AlwaysScrollableScrollPhysics(),
                controller: controller,
                onSubmitted: (txt) => Navigator.maybePop(context, txt),
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  label: const Text("Url"),
                  hintText: "example.com",
                  prefixIcon: const Icon(FluentIcons.globe_20_regular),
                  helperText: "Enter url of a website which you want to block",
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
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.maybePop(context, controller.text),
                child: const Text("Block"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
