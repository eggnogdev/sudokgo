import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_box.dart';
import 'package:sudokgo/src/game_screen/game_session.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key, required this.gameSession});

  final GameSession gameSession;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  @override
  void initState() {
    super.initState();

    final sudoku = SudokuGenerator(emptySquares: 27, uniqueSolution: true);

    widget.gameSession.puzzle = flattenPuzzleToString(sudoku.newSudoku);
    widget.gameSession.userSolution.value = List.of(sudoku.newSudoku);
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
                gameSession: widget.gameSession,
                cellOnPressed: (row, col) {
                  final String? value = widget.gameSession.selectedValue.value;

                  if (value == null) return;

                  if (value == 'X') {
                    updateUserSolution(row, col, 0);
                  } else {
                    updateUserSolution(row, col, int.parse(value));
                  }
                },
                cells: getBox(i * 3 + j),
                boardSize: size,
              )
            ],
          ),
        ],
      ),
    );
  }

  void updateUserSolution(
    int row,
    int col,
    int value,
  ) {
    final temp = List.of(widget.gameSession.userSolution.value);
    temp[row][col] = value;
    widget.gameSession.userSolution.value = temp;
  }

  List<List<List<int>>> getBox(int box) {
    List<List<List<int>>> res = [
      [[], [], [],],
      [[], [], [],],
      [[], [], [],],
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
        res[i][j] = [row, col];
      }
    }

    return res;
  }

  /// This function flattens the given unsolved puzzle to a string for no reason
  /// other than as described inside the class definition of [GameSession].
  /// Please take a look at that class if you would like an explanation to this
  /// insane functionality.
  String flattenPuzzleToString(List puzzle) {
    String res = '';

    final flattened = puzzle.expand((element) => element).toList();

    for (final element in flattened) {
      res += element.toString();
    }

    return res;
  }
  
}
