import 'package:flutter/material.dart';

class GameCell extends StatelessWidget {
  const GameCell({super.key, required this.text, required this.locked, required this.boxSize,});

  final String text;
  final bool locked;
  final double boxSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      width: boxSize / 3 - 4,
      height: boxSize / 3 - 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: locked ? 
          Theme.of(context).colorScheme.primaryContainer :
          Theme.of(context).colorScheme.surface
      ),
      child: Center(
        child: Text(
          text == '0' ? ' ' : text,
          style: TextStyle(
            fontSize: calcFontSize(boxSize / 3 - 4),
            color: locked ?
              Theme.of(context).colorScheme.onPrimaryContainer :
              Theme.of(context).colorScheme.onSurface
          ),
        ),
      ),
    );
  }

  double calcFontSize(double cellSize) {
    return cellSize / 1.2;
  }
}
