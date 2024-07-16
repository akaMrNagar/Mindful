import 'package:flutter/material.dart';
import 'package:mindful/ui/page_routes/hero_page_route.dart';
import 'package:mindful/ui/common/styled_text.dart';

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required Object heroTag,
  required String title,
  required String info,
  required IconData icon,
  required String positiveLabel,
  String negativeLabel = "Cancel",
}) async {
  return await Navigator.of(context).push<bool>(
        HeroPageRoute(
          builder: (context) => _ConfirmationDialog(
            heroTag: heroTag,
            title: title,
            info: info,
            icon: icon,
            positiveLabel: positiveLabel,
            negativeLabel: negativeLabel,
          ),
        ),
      ) ??
      false;
}

class _ConfirmationDialog extends StatelessWidget {
  const _ConfirmationDialog({
    required this.heroTag,
    required this.title,
    required this.info,
    required this.icon,
    required this.positiveLabel,
    required this.negativeLabel,
  });

  final Object heroTag;
  final String title;
  final String info;
  final IconData icon;
  final String positiveLabel;
  final String negativeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(48),
      alignment: Alignment.center,
      child: Hero(
        tag: heroTag,
        child: SingleChildScrollView(
          child: AlertDialog(
            icon: Icon(icon),
            title: StyledText(title, fontSize: 16),
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: StyledText(info),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.maybePop(context, false),
                child: Text(negativeLabel),
              ),
              FilledButton.tonal(
                onPressed: () => Navigator.maybePop(context, true),
                child: Text(positiveLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
