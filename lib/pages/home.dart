import 'package:flutter/material.dart';
import 'package:puzzlepro_app/Widgets/sudoku_list.dart';
import 'package:puzzlepro_app/Widgets/sudoku_widget.dart';
import 'package:puzzlepro_app/Data/constants.dart';
import 'package:puzzlepro_app/models/sudoku.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.useLightMode,
    required this.useMaterial3,
    required this.handleBrightnessChange,
    required this.handleColorSelect,
    required this.setTitle,
  });

  final bool useLightMode;
  final bool useMaterial3;
  final void Function(bool useLightMode) handleBrightnessChange;
  final void Function(int value) handleColorSelect;
  final void Function(String newTitle) setTitle;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {


  final List<Sudoku> sudokuList = [Sudoku([[0]], false, "Hard"),Sudoku([[0]], false, "Hard"),Sudoku([[0]], false, "Hard"),Sudoku([[0]], false, "Hard"),Sudoku([[0]], false, "Hard")];

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

      return SudokuListView(sudokuList: sudokuList);
  }
}
