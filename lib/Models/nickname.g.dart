// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nickname.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class nickNameAdapter extends TypeAdapter<nickName> {
  @override
  final int typeId = 5;

  @override
  nickName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return nickName(
      name: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, nickName obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is nickNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
