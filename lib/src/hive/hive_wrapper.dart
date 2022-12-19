import 'package:hive/hive.dart';
import 'package:sudokgo/src/game_screen/game_difficulty.dart';
import 'package:sudokgo/src/hive/game.dart';

class HiveWrapper {
  static Box getUserBox() {
    return Hive.box('user');
  }

  static String? getDisplayName() {
    final box = getUserBox();
    return box.get('name');
  }

  static Future<void> setDisplayName(String name) async {
    final box = getUserBox();
    await box.put('name', name);
  }

  static Box getGamesBox() {
    return Hive.box('games');
  }

  static Game? getGame(GameDifficulty difficulty) {
    final box = getGamesBox();
    switch (difficulty) {
      case GameDifficulty.easy:
        return box.get('easy');
      case GameDifficulty.medium:
        return box.get('medium');
      case GameDifficulty.hard:
        return box.get('hard');
      default:
        return null;
    }
  }

  static Future<void> setGame(GameDifficulty difficulty, Game game) async {
    final box = getGamesBox();
    await box.put(difficulty.value, game);
  }
}
