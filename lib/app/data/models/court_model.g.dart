// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourtModelAdapter extends TypeAdapter<CourtModel> {
  @override
  final int typeId = 2;

  @override
  CourtModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourtModel(
      id: fields[0] as String,
      name: fields[1] as String,
      picture: fields[2] as Uint8List,
      address: fields[3] as String,
      lendPrice: fields[4] as int,
      type: fields[5] as CourtType,
    );
  }

  @override
  void write(BinaryWriter writer, CourtModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.picture)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.lendPrice)
      ..writeByte(5)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourtModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
