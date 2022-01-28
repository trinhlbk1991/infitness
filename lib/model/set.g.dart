// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SetAdapter extends TypeAdapter<Set> {
  @override
  final int typeId = 2;

  @override
  Set read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Set(
      exercises: (fields[0] as List).cast<Exercise>(),
      repeat: fields[1] as int,
      index: fields[2] as int,
      name: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Set obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.exercises)
      ..writeByte(1)
      ..write(obj.repeat)
      ..writeByte(2)
      ..write(obj.index)
      ..writeByte(3)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
