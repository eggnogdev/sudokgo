class GameDifficulty {
  const GameDifficulty({required this.value});
  final String value;

  static const easy = GameDifficulty(value: 'easy');
  static const medium = GameDifficulty(value: 'medium');
  static const hard = GameDifficulty(value: 'hard');
}
