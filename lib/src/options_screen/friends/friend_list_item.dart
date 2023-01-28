import 'package:flutter/material.dart';

class FriendListItem extends StatelessWidget {
  const FriendListItem({super.key, required this.displayName, required this.email, this.width, this.height, this.leftButtonText, required this.rightButtonText, this.leftButtonOnPressed, required this.rightButtonOnPressed, this.leftButtonIsPrimary = false, this.rightButtonIsPrimary = false, this.elevation,});

  final String displayName;
  final String email;
  final String? leftButtonText;
  final String rightButtonText;
  final Function()? leftButtonOnPressed;
  final Function() rightButtonOnPressed;
  final bool leftButtonIsPrimary;
  final bool rightButtonIsPrimary;
  final double? width;
  final double? height;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final primaryButtonStyle = TextButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
    final normalButtonStyle = TextButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: Theme.of(context).colorScheme.onSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );

    return Material(
      elevation: elevation ?? 0,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 28.0,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (leftButtonText != null ) TextButton(
                    onPressed: leftButtonOnPressed,
                    style: leftButtonIsPrimary ?
                      primaryButtonStyle :
                      normalButtonStyle,
                    child: Text(
                      leftButtonText!,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  TextButton(
                    onPressed: rightButtonOnPressed,
                    style: rightButtonIsPrimary ?
                      primaryButtonStyle :
                      normalButtonStyle,
                    child: Text(
                      rightButtonText,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
