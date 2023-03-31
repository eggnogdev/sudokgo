import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/game_screen/game_board.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/game_screen/number_selector.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/online/online_status.dart';
import 'package:sudokgo/src/widgets/sudokgo_app_bar.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.gameSession});

  final GameSession gameSession;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backOnPressed(context);
        return false;
      },
      child: Scaffold(
        appBar: SudokGoAppBar.create(
          title: const Text(''),
          backOnPressed: () async {
            backOnPressed(context);
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
      throw Exception(
          'Game stored in current gameSession object is null (SHOULD NEVER HAPPEN).');
    }

    gameSession.game!.userSolution = gameSession.userSolution.value.cast<List<int>>();

    await HiveWrapper.setGame(
      GameSession.selectedDifficulty!,
      gameSession.game!,
    );
  }

  void backOnPressed(BuildContext context) async {
    if (OnlineStatus.online.value) {
      SudokGoApi.endAllComp();
    } else {
      await saveGame();
    }
    GameSession.selectedDifficulty = null;
    GoRouter.of(context).go('/');
  }
}
