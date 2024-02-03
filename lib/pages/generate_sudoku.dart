import 'package:flutter/material.dart';
import 'package:sudoku_dart/sudoku_dart.dart';

const hardnessLevels = ["easy", "medium", "hard", "very-hard"];

class SudokuGeneratorPage extends StatefulWidget {
  const SudokuGeneratorPage({super.key});

  @override
  State<SudokuGeneratorPage> createState() => _SudokuGeneratorPageState();
}

class _SudokuGeneratorPageState extends State<SudokuGeneratorPage> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _generatorCard()),
        ],
      ),
    );
  }

  Widget _menu(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          onPressed: () {
          },
          icon: const Icon(Icons.restart_alt_rounded),
          label: const Text("Try Again"),
        ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: ElevatedButton.icon(
              onPressed: () {
              },
              icon: const Icon(Icons.check_rounded),
              label: const Text("Save and start"),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: FloatingActionButton(
            heroTag: "save button",
            onPressed: () {
            },
            backgroundColor: _colorScheme.onSecondary,
            tooltip: 'Save',
            child: const Icon(Icons.check_rounded, color: Colors.green),
          ),
        )
      ],
    );
  }

  Widget _generatorCard() {
    return Center(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
            child: Text(
              'SudokuGenerator by PuzzlePro',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 90.0),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(330, 80), // Set the button size
            ),
            // icon: const Icon(
            //   Icons.camera_alt,
            //   size: 30,
            // ),
            child: const Text(
              'Easy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(330, 80), // Set the button size
            ),
            // icon: const Icon(
            //   Icons.camera_alt,
            //   size: 30,
            // ),
            child: const Text(
              'Medium',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(330, 80), // Set the button size
            ),
            // icon: const Icon(
            //   Icons.camera_alt,
            //   size: 30,
            // ),
            child: const Text(
              'Hard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(330, 80), // Set the button size
            ),
            // icon: const Icon(
            //   Icons.camera_alt,
            //   size: 30,
            // ),
            child: const Text(
              'Very-Hard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ));
  }
  generatorSudoku(int index){
    Sudoku.generate(Level.values[index]);
  }
}
