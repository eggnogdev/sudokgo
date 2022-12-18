import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_cell.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';

class GameBox extends StatelessWidget {
  const GameBox({super.key, required this.cells, required this.boardSize, required this.cellOnPressed, required this.gameSession,});

  final List<List<List<int>>> cells;
  final double boardSize;
  final double margin = 3.80;

  final Function(int row, int col) cellOnPressed;

  final GameSession gameSession;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boardSize / 3 - margin * 2,
      height: boardSize / 3 - margin * 2,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        children: [
          for (int i = 0; i < 3; i++) Row(
            children: [
              for (int j = 0; j < 3; j++) GameCell(
                gameSession: gameSession,
                boxSize: boardSize / 3 - margin * 2,
                row: cells[i][j][0],
                col: cells[i][j][1],
                onPressed: cellOnPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
