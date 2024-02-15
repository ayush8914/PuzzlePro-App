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

  static Future<void> saveSudoku(Sudoku sudoku) async {
    if(sudokuBox == null){
      initializeHive();
    }
    if(sudokuBox!.isOpen == true) {
      final box = await Hive.openBox<Sudoku>(sudokuBoxName);
      await box.add(sudoku);
    }
  }

  static Future<List<Sudoku>> loadAllSudoku() async {
    if(sudokuBox == null){
      initializeHive();
    }
    if(sudokuBox!.isOpen == true) {
      final box = await Hive.openBox<Sudoku>(sudokuBoxName);
      return box.values.toList();
    }
    return List.empty();
  }
  static Future<void> deleteSudokuById(int index) async {
    if(sudokuBox == null){
      initializeHive();
    }
    if(sudokuBox!.isOpen == true) {
      final box = await Hive.openBox<Sudoku>(sudokuBoxName);
      await box.deleteAt(index);
    }
  }
}
