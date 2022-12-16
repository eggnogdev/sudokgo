import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_board.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SafeArea(
        child: Center(child: GameBoard()),
      ),
    );
  }
}
