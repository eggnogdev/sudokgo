import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_cell.dart';

class GameBox extends StatelessWidget {
  const GameBox({super.key, required this.cells, required this.boardSize,});

  final List<List<int>> cells;
  final double boardSize;
  final double margin = 3.80;

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
                text: '${cells[i][j]}',
                locked: cells[i][j] != 0,
                boxSize: boardSize / 3 - margin * 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
