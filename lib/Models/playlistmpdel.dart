import 'package:hive/hive.dart';
import 'package:miomix/Models/allsonglist.dart';
part 'playlistmpdel.g.dart';

@HiveType(typeId: 4)
class PlaylistSongs {
  @HiveField(0)
  String? playlistname;
  @HiveField(1)
  List<Songs>? playlistssongs;
  PlaylistSongs({required this.playlistname, required this.playlistssongs});
}
