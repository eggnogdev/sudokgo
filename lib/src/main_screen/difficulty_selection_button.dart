import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_difficulty.dart';

class DifficultySelectionButton extends StatelessWidget {
  const DifficultySelectionButton({
    super.key,
    required this.bestTime,
    required this.onPressed,
    required this.difficulty,
  });

  final String bestTime;
  final Function() onPressed;
  final GameDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.25,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: 10.0,
          shadowColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    difficulty.value,
                    style: const TextStyle(
                      fontSize: 28.0,
                    ),
                  ),
                  Text(
                    'best time: $bestTime',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              const Text(
                '>',
                style: TextStyle(
                  fontSize: 48.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
