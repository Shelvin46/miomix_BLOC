import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/favourite.dart';
import 'package:miomix/favourites/favoritelist.dart';
import '../Models/allsonglist.dart';

class AddFavNowScreen extends StatefulWidget {
  int index;
  AddFavNowScreen({super.key, required this.index});

  @override
  State<AddFavNowScreen> createState() => _AddFavNowScreenState();
}

class _AddFavNowScreenState extends State<AddFavNowScreen> {
  List<FavSongs> fsongs = [];
  final box = Songbox.getInstance();
  late List<Songs> dbsongs;
  @override
  void initState() {
    dbsongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fsongs = favsongbox.values.toList();
    return fsongs
            .where(
                (element) => element.songname == dbsongs[widget.index].songname)
            //here we checking the index song is equal to favourite song list
            .isEmpty
        ? IconButton(
            onPressed: () {
              // log(favsongbox.toString());
              favsongbox.add(
                FavSongs(
                  songname: dbsongs[widget.index].songname,
                  artist: dbsongs[widget.index].artist,
                  duration: dbsongs[widget.index].duration,
                  songurl: dbsongs[widget.index].songurl,
                  id: dbsongs[widget.index].id,
                ),
              );
              setState(() {});
              //Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Favorites")));
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 35,
            ),
          )
        : IconButton(
            onPressed: () {
              int currentIndex = fsongs.indexWhere(
                  (element) => element.id == dbsongs[widget.index].id);
              player.playlist!.audios.removeAt(currentIndex);
              log(currentIndex.toString());
              favsongbox.deleteAt(currentIndex);
              setState(() {});
              // Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Removed From Favorites")));
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 35,
            ));
  }
}
