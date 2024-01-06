import 'package:hive/hive.dart';
part 'sudoku.g.dart';

@HiveType(typeId: 0)
class Sudoku{
  @HiveField(0)
  final List<List<int>> originalSudoku;

  @HiveField(1)
  final DateTime? createdAt;

  @HiveField(2)
  List<List<int>>? addedDigits;

  @HiveField(3)
  DateTime lastViewed;

  @HiveField(4)
  bool isComplete;

  @HiveField(5)
  bool isScanned;

  @HiveField(6)
  String difficulty;

  Sudoku(this.originalSudoku, this.isScanned, this.difficulty)
      : createdAt = DateTime.now(),
        lastViewed = DateTime.now(),
        addedDigits = List.generate(9, (index) => List<int>.filled(9, 0)),
        isComplete = false;


}