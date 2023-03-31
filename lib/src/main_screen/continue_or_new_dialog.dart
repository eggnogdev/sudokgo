import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/widgets/text_button.dart';

class ContinueOrNewDialog extends StatelessWidget {
  const ContinueOrNewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text(
        'looks like you\'re still playing',
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        SudokGoTextButton(
          title: 'continue',
          onPressed: () {
            GoRouter.of(context).go('/game');
          },
        ),
        SudokGoTextButton(
          title: 'new game',
          onPressed: () async {
            await HiveWrapper.setGame(GameSession.selectedDifficulty!, null);
            GoRouter.of(context).go('/game');
          },
          usePrimaryScheme: false,
        )
      ],
    );
  }
}
