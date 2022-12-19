import 'package:flutter/material.dart';

class SudokGoAppBar {
  static AppBar create({required Function() backOnPressed, required BuildContext context,}) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.only(
          top: 5.0,
          left: 5.0,
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            fixedSize: const Size.square(
              70.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: backOnPressed,
          child: Text(
            '<',
            style: TextStyle(
              fontSize: 32.0,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ),
    );
  }

}
