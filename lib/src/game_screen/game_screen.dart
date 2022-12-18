import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_board.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/game_screen/number_selector.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.gameSession});

  final GameSession gameSession;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GameBoard(
                gameSession: gameSession,
              ),
              NumberSelector(
                gameSession: gameSession,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
