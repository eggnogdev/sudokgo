import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';

class GameCell extends StatelessWidget {
  const GameCell({super.key, required this.boxSize, required this.row, required this.col, required this.onPressed, required this.gameSession,});

  final double boxSize;

  final int row;
  final int col;

  final Function(int row, int col) onPressed;

  final GameSession gameSession;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<List<int>>>(
      valueListenable: gameSession.userSolution,
      builder: (context, value, _) {
        final bool locked = gameSession.puzzle[row * 9 + col] != '0';
        return GestureDetector(
          onTap: () {
            if (locked) return;
            onPressed(row, col);
          },
          child: Container(
            margin: const EdgeInsets.all(2.0),
            width: boxSize / 3 - 4,
            height: boxSize / 3 - 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: locked ? 
                Theme.of(context).colorScheme.primaryContainer :
                Theme.of(context).colorScheme.surface
            ),
            child: Center(
              child: Text(
                value[row][col] == 0 ? ' ' : '${value[row][col]}',
                style: TextStyle(
                  fontSize: calcFontSize(boxSize / 3 - 4),
                  color: locked ?
                    Theme.of(context).colorScheme.onPrimaryContainer :
                    Theme.of(context).colorScheme.onSurface
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  double calcFontSize(double cellSize) {
    return cellSize / 1.2;
  }
}
