import 'package:hive_flutter/hive_flutter.dart';
import 'package:puzzlepro_app/models/sudoku.dart';

class StorageHelper {
  static const String sudokuBoxName = 'sudokuBox';
  static Box<Sudoku>? sudokuBox;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SudokuAdapter());
    sudokuBox = await Hive.openBox<Sudoku>(sudokuBoxName);
  }

  static Future<int> saveSudoku(Sudoku sudoku) async {
    if (sudokuBox == null) {
      initializeHive();
    }
    if (sudokuBox!.isOpen == true) {
      final box = await Hive.openBox<Sudoku>(sudokuBoxName);
      return await box.add(sudoku);
    }
    return 0;
  }

  static Future<void> updateSudoku(Sudoku sudoku, dynamic index) async {
    if (sudokuBox == null) {
      initializeHive();
    }
    if (sudokuBox!.isOpen == true) {
      final box = await Hive.openBox<Sudoku>(sudokuBoxName);
      await box.put(index, sudoku);
    }
  }

  static Future<Sudoku?> getSudokuByIndex(dynamic index) async {
    if (sudokuBox == null) {
      initializeHive();
    }
    if (sudokuBox!.isOpen == true) {
      final box = await Hive.openBox<Sudoku>(sudokuBoxName);
      return box.get(index);
    }
    return null;
  }

  static Future<Map<dynamic, Sudoku>> loadAllSudoku() async {
    if (sudokuBox == null) {
      initializeHive();
    }
    if (sudokuBox!.isOpen == true) {
      final box = await Hive.openBox<Sudoku>(sudokuBoxName);
      return box.toMap();
    }
    return {};
  }

  static Future<void> deleteSudokuById(dynamic index) async {
    if (sudokuBox == null) {
      initializeHive();
    }
    if (sudokuBox!.isOpen == true) {
      final box = await Hive.openBox<Sudoku>(sudokuBoxName);
      await box.delete(index);
    }
  }
}
