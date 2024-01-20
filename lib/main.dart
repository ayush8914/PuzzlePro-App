import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:puzzlepro_app/Data/constants.dart';
import 'package:puzzlepro_app/pages/home.dart';

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

  @override
  Widget build(BuildContext context) {
    String title = "PuzzlePro";

    void setTitle(String newTitle){
      setState(() {
        title = newTitle;
      });
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: Home(
        useLightMode: useLightMode,
        useMaterial3: useMaterial3,
        handleBrightnessChange: handleBrightnessChange,
        handleColorSelect: handleColorSelect,
        setTitle: setTitle,
      ),
    );
  }
}
