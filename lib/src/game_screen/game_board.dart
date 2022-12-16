import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_box.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late List<List<int>> puzzle;
  late List<List<int>> solution;

  @override
  void initState() {
    super.initState();

    final sudoku = SudokuGenerator(emptySquares: 27, uniqueSolution: true);
    puzzle = sudoku.newSudoku;
    solution = sudoku.newSudokuSolved;
  }
  
  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width / 1.1;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primaryContainer,
            blurRadius: 5.0,
          ),
        ],
      ),
      width: size,
      height: size,
      child: Column(
        children: [
          for (int i = 0; i < 3; i++) Row(
            children: [
              for (int j = 0; j < 3; j++) GameBox(
                cells: getBox(i * 3 + j, puzzle),
                boardSize: size,
              )
            ],
          ),
        ],
      ),
    );
  }

  List<List<int>> getBox(int box, List<List<int>> puzzle) {
    List<List<int>> res = [
      [0, 0, 0,],
      [0, 0, 0,],
      [0, 0, 0,],
    ];

    late int rowMin;
    late int rowMax;

    late int colMin;
    late int colMax;

    if (box < 3) {
      rowMin = 0;
      rowMax = 3;
    } else if (box < 6) {
      rowMin = 3;
      rowMax = 6;
    } else if (box < 9) {
      rowMin = 6;
      rowMax = 9;
    }

    if (box % 3 == 0) {
      colMin = 0;
      colMax = 3;
    } else if (box % 3 == 1) {
      colMin = 3;
      colMax = 6;
    } else if (box % 3 == 2) {
      colMin = 6;
      colMax = 9;
    }

    int i = 0;
    for (int row = rowMin; row < rowMax; row++, i++) {
      int j = 0;
      for (int col = colMin; col < colMax; col++, j++) {
        res[i][j] = puzzle[row][col];
      }
    }

    return res;
  }
}
