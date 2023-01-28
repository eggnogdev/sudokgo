import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String text,
  SnackBarAction? action,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  DismissDirection? dismissDirection,
  double? elevation,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: margin,
      padding: padding,
      action: action,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: elevation,
      dismissDirection: dismissDirection ?? DismissDirection.down,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.surface,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // if (prefix != null) prefix,
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontFamily: 'IndieFlower',
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    )
  );
}
