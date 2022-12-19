import 'package:flutter/material.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({super.key, this.title = 'coming soon!',});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Text(
            'okay',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
