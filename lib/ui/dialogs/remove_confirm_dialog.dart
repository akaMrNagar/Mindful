import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mindful/ui/common/hero_page_route.dart';
import 'package:mindful/ui/common/styled_text.dart';

Future<bool> showRemoveConfirmDialog({
  required BuildContext context,
  required String title,
  required String info,
}) async {
  return await Navigator.of(context).push<bool>(
        HeroPageRoute(
          builder: (context) => _RemoveConfirmDialog(
            heroTag: 'RemoveConfirmDialog',
            title: title,
            info: info,
          ),
        ),
      ) ??
      false;
}

class _RemoveConfirmDialog extends StatelessWidget {
  const _RemoveConfirmDialog({
    required this.heroTag,
    required this.title,
    required this.info,
  });

  final String title;
  final Object heroTag;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(48),
      alignment: Alignment.center,
      child: Hero(
        tag: heroTag,
        child: SingleChildScrollView(
          child: AlertDialog(
            icon: const Icon(FluentIcons.delete_dismiss_20_regular),
            title: StyledText(title, fontSize: 16),
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: StyledText(info),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.maybePop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.maybePop(context, true),
                child: const Text("Remove"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
