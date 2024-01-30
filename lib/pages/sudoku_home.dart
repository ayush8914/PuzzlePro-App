import 'package:flutter/material.dart';
import '../models/sudoku.dart';

class SudokuHome extends StatefulWidget {
  final Sudoku sudoku;

  const SudokuHome({super.key, required this.sudoku});

  @override
  State<SudokuHome> createState() => _SudokuHomeState();
}

class _SudokuHomeState extends State<SudokuHome> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
  final List<int> currentSelectedCell = [10, 10];

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

  void setAddedDigit(int digit) {
    if (currentSelectedCell[0] > 9) {
      return;
    }
    setState(() {
      addedDigitsSudoku[currentSelectedCell[0]][currentSelectedCell[1]] = digit;
    });
  }

  @override
  Widget build(BuildContext context) {
    originalSudoku = widget.sudoku.originalSudoku;
    if(widget.sudoku.addedDigits != null){
      addedDigitsSudoku = widget.sudoku.addedDigits!;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PuzzlePro",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle popup menu actions here
              if (value == "share") {
                // Handle share action
              } else if (value == "delete") {
                // Handle delete action
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: "share",
                  child: Text("Share"),
                ),
                const PopupMenuItem<String>(
                  value: "delete",
                  child: Text("Delete"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "Some details here",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle check answer button
                  },
                  child: Text(
                    "Check Answer",
                    style: TextStyle(
                        color: false
                            ? _colorScheme.primary
                            : _colorScheme.secondary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
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
                    isSelected: (currentSelectedCell[0] == row &&
                        currentSelectedCell[1] == col),
                    onTap: () {
                      setState(() {
                        currentSelectedCell[0] = row;
                        currentSelectedCell[1] = col;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          DigitRow1(
              colorScheme: _colorScheme,
              onPressed: (digit) => {setAddedDigit(digit)}),
          const SizedBox(
            height: 8.0,
          ),
          DigitRow2(
              colorScheme: _colorScheme,
              onPressed: (digit) => {setAddedDigit(digit)}),
          const SizedBox(
            height: 20.0,
          ),
          // Bottom buttons
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle save progress button
                    },
                    child: const Icon(Icons.save_as_rounded),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle reset sudoku button
                    },
                    child: const Icon(Icons.restart_alt_rounded),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle calculate answer button
                    },
                    child: const Icon(Icons.calculate_rounded),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle validate sudoku button
                    },
                    child: const Icon(Icons.lightbulb_outline_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class SudokuCell extends StatelessWidget {
  final ColorScheme colorScheme;
  final int originalValue;
  final int addedDigitsValue;
  final Function() onTap;
  final bool isSelected;

  const SudokuCell({
    super.key,
    required this.originalValue,
    required this.addedDigitsValue,
    required this.colorScheme,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: colorScheme.primary, width: 2.0)
                : Border.all(color: Colors.transparent),
            color: originalValue != 0
                ? Colors.transparent
                : addedDigitsValue != 0
                    ? colorScheme.error.withOpacity(0.05)
                    : colorScheme.primary.withOpacity(0.05)),
        child: Center(
          child: Text(
            originalValue != 0
                ? '$originalValue'
                : addedDigitsValue != 0
                    ? '$addedDigitsValue'
                    : '',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: originalValue != 0
                  ? colorScheme.secondary
                  : colorScheme.primary,
            ),
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
        canvas.drawLine(
            Offset(x - 1, 0), Offset(x - 1, size.height), paintBold);
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

class DigitRow1 extends StatelessWidget {
  final ColorScheme colorScheme;
  final void Function(int digit) onPressed;
  static const List<int> digits = [1, 2, 3, 4, 5];

  const DigitRow1(
      {super.key, required this.colorScheme, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int digit in digits)
          InputButton(
              colorScheme: colorScheme,
              onPressed: () => onPressed(digit),
              child: Text("$digit")),
      ],
    );
  }
}

class DigitRow2 extends StatelessWidget {
  final ColorScheme colorScheme;
  final void Function(int digit) onPressed;
  static const List<int> digits = [6, 7, 8, 9];

  const DigitRow2(
      {super.key, required this.colorScheme, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int digit in digits)
          InputButton(
              colorScheme: colorScheme,
              onPressed: () => onPressed(digit),
              child: Text("$digit")),
        InputButton(
            colorScheme: colorScheme,
            onPressed: () => print("clear click"),
            child: const Icon(Icons.backspace_rounded))
      ],
    );
  }
}

class InputButton extends StatelessWidget {
  final ColorScheme colorScheme;
  final Widget child;
  final void Function() onPressed;

  const InputButton({
    super.key,
    required this.colorScheme,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          width: 100.0,
          height: 50.0,
          child: ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                    fontSize: 25.0,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w700),
              ),
            ),
            onPressed: () {
              onPressed();
            },
            child: child,
          ),
        ),
      ),
    );
  }
}
