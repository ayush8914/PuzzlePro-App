import 'package:flutter/material.dart';
import 'package:puzzlepro_app/models/sudoku.dart';
import 'package:puzzlepro_app/pages/sudoku_answer.dart';

class SudokuBoardWidget extends StatelessWidget {
  const SudokuBoardWidget(
      {super.key, required this.sudoku, required this.colorScheme});

  final ColorScheme colorScheme;
  final Sudoku sudoku;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      height: 350.0,
      child: CustomPaint(
        painter: LinesPainter(colorScheme),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9,
          ),
          itemCount:
              sudoku.originalSudoku.length * sudoku.originalSudoku[0].length,
          itemBuilder: (context, index) {
            int row = index ~/ 9;
            int col = index % 9;
            int originalCellValue = sudoku.originalSudoku[row][col];
            int addedDigitsCellValue = sudoku.addedDigits![row][col];

            return SudokuCell(
              originalValue: originalCellValue,
              addedDigitsValue: addedDigitsCellValue,
              colorScheme: colorScheme,
            );
          },
        ),
      ),
    );
  }
}
