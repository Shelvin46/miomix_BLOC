// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recentlyplayed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentPlayedAdapter extends TypeAdapter<RecentPlayed> {
  @override
  final int typeId = 1;

  @override
  RecentPlayed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentPlayed(
      songname: fields[0] as String?,
      artist: fields[1] as String?,
      duration: fields[2] as int?,
      songurl: fields[3] as String?,
      id: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentPlayed obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songurl)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentPlayedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
