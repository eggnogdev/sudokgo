import 'package:flutter/material.dart';

class SudokGoTextButton extends StatelessWidget {
  const SudokGoTextButton({
    super.key,
    required this.title,
    this.usePrimaryScheme = true,
    required this.onPressed,
  });

  final String title;
  final bool usePrimaryScheme;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: usePrimaryScheme
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        foregroundColor: usePrimaryScheme
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: usePrimaryScheme
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSecondary,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
