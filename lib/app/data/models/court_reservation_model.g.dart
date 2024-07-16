// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court_reservation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourtReservationModelAdapter extends TypeAdapter<CourtReservationModel> {
  @override
  final int typeId = 3;

  @override
  CourtReservationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourtReservationModel(
      id: fields[0] as String,
      startingDateTime: fields[1] as DateTime,
      endingDateTime: fields[2] as DateTime,
      courtId: fields[3] as String,
      usedId: fields[4] as String,
      comment: fields[5] as String,
      price: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CourtReservationModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startingDateTime)
      ..writeByte(2)
      ..write(obj.endingDateTime)
      ..writeByte(3)
      ..write(obj.courtId)
      ..writeByte(4)
      ..write(obj.usedId)
      ..writeByte(5)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourtReservationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
