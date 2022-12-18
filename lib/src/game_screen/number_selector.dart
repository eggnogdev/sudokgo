import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/game_screen/number_selector_option.dart';

class NumberSelector extends StatelessWidget {
  const NumberSelector({super.key, required this.gameSession});

  final GameSession gameSession;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 1.75;
    final height = width / 2.5;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primaryContainer,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              for (int i = 1; i < 6; i++) NumberSelectorOption(
                gameSession: gameSession,
                size: height / 2 - 4,
                onPressed: onOptionPressed,
                text: '$i',
              ),
            ],
          ),
          Row(
            children: [
              for (int i = 6; i < 10; i++) NumberSelectorOption(
                gameSession: gameSession,
                size: height / 2 - 4,
                onPressed: onOptionPressed,
                text: '$i',
              ),
              NumberSelectorOption(
                gameSession: gameSession,
                size: height / 2 - 4,
                onPressed: onOptionPressed,
                text: 'X',
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  void onOptionPressed(String value, bool wasSelected) {
    if (wasSelected) {
      gameSession.selectedValue.value = null;
    } else {
      gameSession.selectedValue.value = value;
    }
  }
}
