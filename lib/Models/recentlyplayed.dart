import 'package:hive/hive.dart';
part 'recentlyplayed.g.dart';

@HiveType(typeId: 1)
class RecentPlayed {
  @HiveField(0)
  String? songname;

  @HiveField(1)
  String? artist;

  @HiveField(2)
  int? duration;

  @HiveField(3)
  String? songurl;

  @HiveField(4)
  int? id;

  RecentPlayed(
      {this.songname,
      this.artist,
      this.duration,
      this.songurl,
      required this.id});
}
