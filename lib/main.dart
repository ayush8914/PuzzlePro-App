import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:puzzlepro_app/Data/constants.dart';
import 'package:puzzlepro_app/pages/home.dart';
import 'package:puzzlepro_app/pages/sudoku_home.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int screenIndex = ScreenSelected.home.value;
  bool controllerInitialized = false;
  bool showMediumSizeLayout = false;
  bool showLargeSizeLayout = false;

  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.teal;
  ColorScheme? colorScheme = const ColorScheme.highContrastDark();

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = ColorSeed.values[value];
    });
  }

  void handleScreenChanged(int screenSelected) {
    setState(() {
      screenIndex = screenSelected;
    });
  }

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
  Widget build(BuildContext context) {
    String title = "PuzzlePro";

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

    void setTitle(String newTitle) {
      setState(() {
        title = newTitle;
      });
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: themeMode,
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
            colorSchemeSeed: colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              surfaceTintColor: Colors.transparent,
            )),
        darkTheme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(),
            colorSchemeSeed: colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              surfaceTintColor: Colors.transparent,
            )),
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
              ),
            ),
          ),
          // body: const SudokuHome(),
          body: Home(
            useLightMode: useLightMode,
            useMaterial3: useMaterial3,
            handleBrightnessChange: handleBrightnessChange,
            handleColorSelect: handleColorSelect,
            setTitle: setTitle,
          ),
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                screenIndex = index;
              });
            },
            destinations: bottomNavigationBarItems,
            selectedIndex: screenIndex,
          ),
        ));
  }
}
