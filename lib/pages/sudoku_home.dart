import 'package:flutter/material.dart';
import '../models/sudoku.dart';
class SudokuHome extends StatefulWidget {
  final Sudoku sudoku;

  const SudokuHome({super.key, required this.sudoku });
  @override
  State<SudokuHome> createState() => _SudokuHomeState();
}

class _SudokuHomeState extends State<SudokuHome> {

  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;

  List<List<int>> originalSudoku = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9],
  ];

  List<List<int>> addedDigitsSudoku = [
    [5, 3, 0, 3, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text(
        "PuzzlePro",
        style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
    ),
    ),
    ),
    body: Center(
      child: SizedBox(
        width: 350.0,
        height: 350.0,
        child: CustomPaint(
          painter: LinesPainter(_colorScheme),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
            ),
            itemCount: originalSudoku.length * originalSudoku[0].length,
            itemBuilder: (context, index) {
              int row = index ~/ 9;
              int col = index % 9;
              int originalCellValue = originalSudoku[row][col];
              int addedDigitsCellValue = addedDigitsSudoku[row][col];

              return SudokuCell(
                originalValue: originalCellValue,
                addedDigitsValue: addedDigitsCellValue,
                colorScheme: _colorScheme,
                showBoldLineVertical: (col + 1) % 3 == 0 && col != 8,
                showBoldLineHorizontal: (row + 1) % 3 == 0 && row != 8,
              );
            },
          ),
        ),
      ),
    ),
    );
  }
}

class SudokuCell extends StatelessWidget {
  final ColorScheme colorScheme;
  final int originalValue;
  final int addedDigitsValue;
  final bool showBoldLineVertical;
  final bool showBoldLineHorizontal;

  const SudokuCell({
    Key? key,
    required this.originalValue,
    required this.addedDigitsValue,
    required this.colorScheme,
    required this.showBoldLineVertical,
    required this.showBoldLineHorizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: originalValue != 0 ? Colors.transparent : addedDigitsValue != 0 ? colorScheme.error.withOpacity(0.05) : colorScheme.primary.withOpacity(0.05)
      ),
      child: Center(
        child: Text(
          originalValue != 0 ? '$originalValue' : addedDigitsValue != 0 ? '$addedDigitsValue' : '',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: originalValue != 0 ? colorScheme.secondary : colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
class LinesPainter extends CustomPainter {
  final ColorScheme colorScheme;

  LinesPainter(this.colorScheme);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = colorScheme.primary
      ..strokeWidth = 0.25;
    final Paint paintBold = Paint()
      ..color = colorScheme.primary
      ..strokeWidth = 2.0;

    double x = size.width / 9.0;
    double spaceX = x;

    for (int i = 1; i < 9; i++) {
      if (i % 3 == 0) {
        canvas.drawLine(Offset(x - 1, 0), Offset(x - 1, size.height), paintBold);
      } else {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      }
      x += spaceX;
    }

    double y = size.height / 9.0;
    double spaceY = y;

    for (int i = 1; i < 9; i++) {
      if (i % 3 == 0) {
        canvas.drawLine(Offset(0, y - 1), Offset(size.width, y - 1), paintBold);
      } else {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      }
      y += spaceY;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

