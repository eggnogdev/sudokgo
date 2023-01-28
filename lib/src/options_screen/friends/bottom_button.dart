import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.onPressed,
    this.width,
    this.height,
    required this.text,
    this.disabled = false,
  });

  final Function() onPressed;
  final double? width;
  final double? height;
  final String text;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width / 4,
      height: height ?? 50.0,
      child: RawMaterialButton(
        onPressed: disabled ? null : onPressed,
        fillColor: !disabled ? null : Theme.of(context).colorScheme.primary,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            color: !disabled
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
