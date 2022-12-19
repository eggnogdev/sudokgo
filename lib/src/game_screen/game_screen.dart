import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/game_screen/game_board.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/game_screen/number_selector.dart';
import 'package:sudokgo/src/hive/game.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.gameSession});

  final GameSession gameSession;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await saveGame();
        GameSession.selectedDifficulty = null;
        GoRouter.of(context).go('/');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: Padding(
            padding: const EdgeInsets.only(
              top: 5.0,
              left: 5.0,
            ),
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
              onPressed: () async {
                await saveGame();
                GameSession.selectedDifficulty = null;
                GoRouter.of(context).go('/');
              },
              child: Text(
                '<',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
        ),
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
                const SizedBox(),
                NumberSelector(
                  gameSession: gameSession,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveGame() async {
    if (gameSession.game == null) {
      throw Exception('Game stored in current gameSession object is null (SHOULD NEVER HAPPEN).');
    }

    gameSession.game!.userSolution = gameSession.userSolution.value;

    await HiveWrapper.setGame(
      GameSession.selectedDifficulty!,
      gameSession.game!,
    );
  }  
}
