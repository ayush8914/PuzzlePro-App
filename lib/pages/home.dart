import 'package:flutter/material.dart';
import 'package:puzzlepro_app/Widgets/sudoku_widget.dart';
import 'package:puzzlepro_app/constants.dart';
import 'package:puzzlepro_app/models/sudoku.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.useLightMode,
    required this.useMaterial3,
    required this.colorSelected,
    required this.handleBrightnessChange,
    required this.handleColorSelect,
  });

  final bool useLightMode;
  final bool useMaterial3;
  final ColorSeed colorSelected;
  final void Function(bool useLightMode) handleBrightnessChange;
  final void Function(int value) handleColorSelect;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int screenIndex = ScreenSelected.home.value;
  bool controllerInitialized = false;
  bool showMediumSizeLayout = false;
  bool showLargeSizeLayout = false;

  void handleScreenChanged(int screenSelected) {
    setState(() {
      screenIndex = screenSelected;
    });
  }

  // Widget setScreen(ScreenSelected screenSelected) {
  //   // switch (screenSelected) {
  //   //   case ScreenSelected.home:
  //       return Expanded(
  //         child: HomeScreen();
  //       );
  //     // case ScreenSelected.scanner:
  //     //   return const ColorPalettesScreen();
  //     // case ScreenSelected.generator:
  //     //   return const TypographyScreen();
  //     // case ScreenSelected.setting:
  //     //   return const ElevationScreen();
  //   // }
  // }

  @override
  void didChangeDependencies() {
    //for making app responsive according to device

    super.didChangeDependencies();
    final double width = MediaQuery.of(context).size.width;
    if (width > mediumWidthBreakpoint) {
      if (width > largeWidthBreakpoint) {
        showMediumSizeLayout = false;
        showLargeSizeLayout = true;
      } else {
        showMediumSizeLayout = true;
        showLargeSizeLayout = false;
      }
    } else {
      showMediumSizeLayout = false;
      showLargeSizeLayout = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    var bottomNavigationBarItems = const <Widget>[
      NavigationDestination(
        icon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(Icons.qr_code_scanner_rounded),
        label: 'Scan',
      ),
      NavigationDestination(
        icon: Icon(Icons.add_box_rounded),
        label: 'Generate',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings_rounded),
        label: 'Settings',
      ),
    ];
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("PuzzlePro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0,),),
      ),
      body: SudokuWidget(sudoku:  Sudoku([[0]], true, "Hard"), onSelected: () => print("hello"),  ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            screenIndex = index;
          });
        },
        destinations: bottomNavigationBarItems,
        selectedIndex: screenIndex,
      ),
    );
  }
}
