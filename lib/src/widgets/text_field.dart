import 'package:flutter/material.dart';

class SudokGoTextField extends StatelessWidget {
  const SudokGoTextField({super.key, this.showSuffixButton = true, this.controller, this.suffixButtonOnPressed, this.title, this.suffixButtonIcon, this.obscureText, this.focusNode, this.titleIcon, this.subText, this.subTextIsError = false,});

  final bool showSuffixButton;  
  final TextEditingController? controller;
  final Function()? suffixButtonOnPressed;
  final String? title;
  final Widget? suffixButtonIcon;
  final bool? obscureText;
  final FocusNode? focusNode;
  final Widget? titleIcon;
  final String? subText;
  final bool subTextIsError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (title != null) Text(
              title!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(width: 10.0),
            if (titleIcon != null) titleIcon!,
          ],
        ),
        if (title != null) const SizedBox(height: 5.0),
        Stack(
          children: [
            TextField(
              focusNode: focusNode,
              obscureText: obscureText ?? false,
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: const SizedBox(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            if (showSuffixButton) Positioned(
              right: 0,
              bottom: 0,
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
                onPressed: suffixButtonOnPressed,
                child: suffixButtonIcon ?? const Text(
                  '>',
                  style: TextStyle(
                    fontSize: 48.0,
                  ),
                ),
              ),
            )
          ],
        ),
        if (subText != null) Text(
          subText!,
          style: TextStyle(
            color: subTextIsError ?
              Theme.of(context).colorScheme.error :
              Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );

  }
}
