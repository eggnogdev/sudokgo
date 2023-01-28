import 'package:flutter/material.dart';
import 'package:sudokgo/src/widgets/text_button.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({
    super.key,
    this.title = 'coming soon!',
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SudokGoTextButton(
          title: 'okay',
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 28.0,
        ),
      ),
    );
  }
}
