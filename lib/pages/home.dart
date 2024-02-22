import 'package:flutter/material.dart';
import 'package:puzzlepro_app/Widgets/sudoku_list.dart';
import 'package:puzzlepro_app/models/sudoku.dart';
import 'package:puzzlepro_app/services/database.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,

    required this.useMaterial3,
    required this.handleBrightnessChange,
    required this.handleColorSelect,
  });


  final bool useMaterial3;
  final void Function(bool useLightMode) handleBrightnessChange;
  final void Function(int value) handleColorSelect;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    fetchSudokuList();
  }

  void deleteSudoku(int index) async {
    StorageHelper.deleteSudokuById(index);
    await fetchSudokuList();
  }

  fetchSudokuList() async {
    var list = await StorageHelper.loadAllSudoku();
    setState(() {
      sudokuList = list;
    });
  }

  Future<void> onRefresh() async {
    await fetchSudokuList();
    await Future.delayed(const Duration(seconds: 1));
  }

  Map<dynamic, Sudoku> sudokuList = {};

  @override
  Widget build(BuildContext context) {
    return SudokuListView(
        sudokuList: sudokuList, onDelete: deleteSudoku, onRefresh: onRefresh);
  }
}
