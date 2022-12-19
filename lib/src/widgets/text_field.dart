import 'package:flutter/material.dart';

class SudokGoTextField extends StatelessWidget {
  const SudokGoTextField({super.key, this.showEnterButton = true, this.controller, this.enterOnPressed,});

  final bool showEnterButton;  
  final TextEditingController? controller;
  final Function()? enterOnPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
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
        if (showEnterButton) Positioned(
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
            onPressed: enterOnPressed,
            child: const Text(
              '>',
              style: TextStyle(
                fontSize: 48.0,
              ),
            ),
          ),
        )
      ],
    );

  }
}
