import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/favourites/favhome.dart';

import '../Models/allsonglist.dart';
import '../Models/favourite.dart';

class AddtoFavourite extends StatefulWidget {
  int index;
  AddtoFavourite({super.key, required this.index}); //here pass the index

  @override
  State<AddtoFavourite> createState() => _AddtoFavouriteState();
}

class _AddtoFavouriteState extends State<AddtoFavourite> {
  List<FavSongs> fav = [];
  // bool favorited = false;
  final box = Songbox.getInstance();
  late List<Songs> dbsongs;
  @override
  void initState() {
    dbsongs = box.values.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    fav = favsongbox.values.toList();
    return fav
            .where((element) => element.id == dbsongs[widget.index].id)
            .isEmpty //here we checking the fav songs list if any song matches to songs list song the song will never add/is it empty the index song will be added.
        ? TextButton(
            onPressed: () {
              favsongbox.add(
                FavSongs(
                    songname: dbsongs[widget.index].songname,
                    artist: dbsongs[widget.index].artist,
                    duration: dbsongs[widget.index].duration,
                    songurl: dbsongs[widget.index].songurl,
                    id: dbsongs[widget.index].id),
              );
              // favosongs = convertAudio();
              //convertAudio();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Favorites")));
            },
            child: const Text('Add to Favourite'))
        : TextButton(
            onPressed: () {
              int currentIndex = fav.indexWhere(
                  (element) => element.id == dbsongs[widget.index].id);
              favsongbox.deleteAt(currentIndex);
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Removed From Favourites"),
                ),
              );
            },
            child: const Text("Remove From Favourites"));
  }
}


// convertAudio() {
//   for (var item in favousongs) {
//     favosongs.add(Audio.file(item.songurl.toString(),
//         metas: Metas(
//           artist: item.artist,
//           title: item.songname,
//           id: item.id.toString(),
//         )));
//   }
//   return favosongs;
// }
