// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppDataAdapter extends TypeAdapter<AppData> {
  @override
  final int typeId = 0;

  @override
  AppData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppData()
      ..sudokuList = (fields[0] as List).cast<Sudoku>()
      ..themeDataModel = fields[1] as ThemeDataModel;
  }

  @override
  void write(BinaryWriter writer, AppData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sudokuList)
      ..writeByte(1)
      ..write(obj.themeDataModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
