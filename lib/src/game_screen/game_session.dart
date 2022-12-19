import 'package:flutter/material.dart';
import 'package:sudokgo/src/game_screen/game_difficulty.dart';
import 'package:sudokgo/src/hive/game.dart';

class GameSession extends ChangeNotifier{
  ValueNotifier<String?> selectedValue = ValueNotifier<String?>(null);
  ValueNotifier<List<List<int>>> userSolution = ValueNotifier<List<List<int>>>([]);
  Game? game;
  
  /// puzzle is only used to keep track of the original puzzle before the user
  /// added any numbers to it. it is stored as a string as this is the only way
  /// that I have found to fix some weird bug where changing the value stored in
  /// [userSolution] would also change the value stored in the puzzle here. No
  /// amount of copying Lists by using `List.of()` or `[...List]` was able to 
  /// solve this issue, only switching it to a string and storing it that way
  /// was effective immediately.
  String puzzle = '';

  static GameDifficulty? selectedDifficulty;
}
