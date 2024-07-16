// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTypeAdapter extends TypeAdapter<UserType> {
  @override
  final int typeId = 1;

  @override
  UserType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserType.customer;
      case 1:
        return UserType.instructor;
      default:
        return UserType.customer;
    }
  }

  @override
  void write(BinaryWriter writer, UserType obj) {
    switch (obj) {
      case UserType.customer:
        writer.writeByte(0);
        break;
      case UserType.instructor:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
