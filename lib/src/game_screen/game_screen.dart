import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/game_screen/game_board.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/game_screen/number_selector.dart';
import 'package:sudokgo/src/hive/game.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/widgets/sudokgo_app_bar.dart';

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
        appBar: SudokGoAppBar.create(
          backOnPressed: () async {
            await saveGame();
            GameSession.selectedDifficulty = null;
            GoRouter.of(context).go('/');
          },
          context: context,
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
