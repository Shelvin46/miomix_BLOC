import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miomix/Models/dbfunction.dart';

import '../Models/allsonglist.dart';
import '../Models/favourite.dart';

class AddtoFavourite extends StatefulWidget {
  int index;
  AddtoFavourite({super.key, required this.index});

  @override
  State<AddtoFavourite> createState() => _AddtoFavouriteState();
}

class _AddtoFavouriteState extends State<AddtoFavourite> {
  List<FavSongs> fav = [];
  bool favorited = false;
  final box = Songbox.getInstance();
  late List<Songs> dbsongs;
  @override
  void initState() {
    dbsongs = box.values.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fav = favsongbox.values.toList();
    return fav
            .where(
                (element) => element.songname == dbsongs[widget.index].songname)
            .isEmpty
        ? TextButton(
            onPressed: () {
              favsongbox.add(FavSongs(
                  songname: dbsongs[widget.index].songname,
                  artist: dbsongs[widget.index].artist,
                  duration: dbsongs[widget.index].duration,
                  songurl: dbsongs[widget.index].songurl,
                  id: dbsongs[widget.index].id));
              setState(() {});
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
                  const SnackBar(content: Text("Removed From Favourites")));
            },
            child: const Text("Remove From Favourites"));
  }
}
