import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/online/online_status.dart';
import 'package:sudokgo/src/widgets/text_button.dart';

class WinDialog extends StatelessWidget {
  const WinDialog({super.key, required this.winnerName,});

  final String winnerName;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!OnlineStatus.online.value) {
          await HiveWrapper.setGame(GameSession.selectedDifficulty!, null);
        } else {
          await SudokGoApi.endAllComp();
        }
        GoRouter.of(context).go('/');
        return true;
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$winnerName won!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 28.0,
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          SudokGoTextButton(
            title: 'home',
            onPressed: () async {
              if (!OnlineStatus.online.value) {
                await HiveWrapper.setGame(GameSession.selectedDifficulty!, null);
              } else {
                await SudokGoApi.endAllComp();
              }
              GoRouter.of(context).go('/');
            },
          ),
        ],
      ),
    );
  }
}
