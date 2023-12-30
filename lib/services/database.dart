import 'package:hive_flutter/hive_flutter.dart';
import 'package:puzzlepro_app/models/sudoku.dart';

class StorageHelper {
  static const String boxName = 'sudokuBox';

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SudokuAdapter());
    await Hive.openBox<Sudoku>(boxName);
  }

  static Future<void> saveSudoku(Sudoku sudoku) async {
    final box = await Hive.openBox<Sudoku>(boxName);
    await box.add(sudoku);
  }

  static Future<List<Sudoku>> loadAllSudoku() async {
    final box = await Hive.openBox<Sudoku>(boxName);
    return box.values.toList();
  }
}
