import 'package:flutter/material.dart';

void showSnackBar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 10.0,
      dismissDirection: DismissDirection.down,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.surface,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
