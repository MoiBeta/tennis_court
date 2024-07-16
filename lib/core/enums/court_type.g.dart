// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourtTypeAdapter extends TypeAdapter<CourtType> {
  @override
  final int typeId = 4;

  @override
  CourtType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CourtType.a;
      case 1:
        return CourtType.b;
      case 2:
        return CourtType.c;
      default:
        return CourtType.a;
    }
  }

  @override
  void write(BinaryWriter writer, CourtType obj) {
    switch (obj) {
      case CourtType.a:
        writer.writeByte(0);
        break;
      case CourtType.b:
        writer.writeByte(1);
        break;
      case CourtType.c:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourtTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
