import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';

class NumberSelectorOption extends StatefulWidget {
  const NumberSelectorOption({super.key, required this.onPressed, required this.text, required this.size, required this.gameSession,});

  final Function(String value, bool wasSelected) onPressed;
  final String text;
  final double size;
  final GameSession gameSession;

  @override
  State<NumberSelectorOption> createState() => _NumberSelectorOptionState();
}

class _NumberSelectorOptionState extends State<NumberSelectorOption> {
  bool selected = false;
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: widget.gameSession.selectedValue,
      builder: (context, value, _) {
        selected = value == widget.text;
        return GestureDetector(
          onTap: () {
            widget.onPressed(widget.text, selected);
          },
          child: Container(
            height: widget.size,
            width: widget.size,
            margin: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ?
                Theme.of(context).colorScheme.primary :
                Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: widget.size / 1.3,
                  color: selected ?
                    Theme.of(context).colorScheme.onPrimary :
                    Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
