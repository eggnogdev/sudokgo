import 'package:hive_flutter/hive_flutter.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game extends HiveObject {
  @HiveField(0)
  late String puzzle;

  @HiveField(1)
  late List<List<int>> solution;

  @HiveField(2)
  late List<List<int>> userSolution;
}
