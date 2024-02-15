import 'package:hive/hive.dart';
import 'package:puzzlepro_app/models/sudoku.dart';
import 'package:puzzlepro_app/models/themeData.dart';

part 'AppData.g.dart';

@HiveType(typeId: 0)
class AppData {
  @HiveField(0)
  List<Sudoku> sudokuList;

  @HiveField(1)
  ThemeDataModel themeDataModel;

  AppData()
      : sudokuList = List.empty(),
        themeDataModel = ThemeDataModel();
}
