import 'package:hive/hive.dart';
import 'package:miomix/Models/favourite.dart';
import 'package:miomix/Models/mostlyplayed.dart';
import 'package:miomix/Models/playlistmpdel.dart';
import 'package:miomix/Models/recentlyplayed.dart';

import 'nickname.dart';

late Box<RecentPlayed> recentlyplayedbox;
openrecentlyplayedDb() async {
  recentlyplayedbox = await Hive.openBox('recentlyplayed');
}

late Box<MostPlayed> mostlyplayedbox;
openMostlyPlayedDb() async {
  mostlyplayedbox = await Hive.openBox('mostlyplayed');
}

late Box<FavSongs> favsongbox;
openFavouritePlayedDb() async {
  favsongbox = await Hive.openBox('Favouritesongs');
}

late Box<nickName> nameBox;
openname() async {
  nameBox = await Hive.openBox<nickName>('name');
  nameBox.add(nickName(name: "User"));
}

late Box<PlaylistSongs> playlistbox;
opendatabase() async {
  playlistbox = await Hive.openBox<PlaylistSongs>('playlist');
}

updateRecentlyPlayed(RecentPlayed value, index) {
  List<RecentPlayed> list = recentlyplayedbox.values.toList();
  bool isAlready = list.where(
    (songs) {
      return songs.songname == value.songname;
      //here we check what we selected song is equal to the present song in the list
      //if it is empty there will be no same song present in the list
      //is Already comes to true
    },
  ).isEmpty;
  if (isAlready == true) {
    recentlyplayedbox.add(value);
  } else {
    int index = list.indexWhere((songs) => songs.songname == value.songname);
    recentlyplayedbox.deleteAt(index);
    recentlyplayedbox.add(value);
  }
}

updatePlayedSongCount(MostPlayed value, int index) {
  //List<MostPlayed> mlist = mostlyplayedbox.values.toList();k
  int count = value.count;
  //every time call the function the value count incemented in one by one
  value.count = count + 1;
  mostlyplayedbox.put(index, value);
}

// how to set mostly played songs in flutter?

