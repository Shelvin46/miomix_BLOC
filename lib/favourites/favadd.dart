import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miomix/Models/dbfunction.dart';
import '../Models/allsonglist.dart';
import '../Models/favourite.dart';
import '../blocs/favorite_listing_home/favorite_listing_home_bloc.dart';

class AddtoFavourite extends StatelessWidget {
  int index;
  AddtoFavourite({super.key, required this.index}); //here pass the index

  List<FavSongs> fav = [];
  // bool favorited = false;
  final box = Songbox.getInstance();
  late List<Songs> dbsongs;

  @override
  Widget build(BuildContext context) {
    dbsongs = box.values.toList();
    //setState(() {});
    fav = favsongbox.values.toList();
    return fav
            .where((element) => element.id == dbsongs[index].id)
            .isEmpty //here we checking the fav songs list if any song matches to songs list song the song will never add/is it empty the index song will be added.
        ? TextButton(
            onPressed: () {
              favsongbox.add(
                FavSongs(
                    songname: dbsongs[index].songname,
                    artist: dbsongs[index].artist,
                    duration: dbsongs[index].duration,
                    songurl: dbsongs[index].songurl,
                    id: dbsongs[index].id),
              );
              BlocProvider.of<FavoriteListingHomeBloc>(context)
                  .add(FavoriteList());
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Favorites")));
            },
            child: const Text('Add to Favourite'))
        : TextButton(
            onPressed: () {
              int currentIndex =
                  fav.indexWhere((element) => element.id == dbsongs[index].id);
              favsongbox.deleteAt(currentIndex);
              BlocProvider.of<FavoriteListingHomeBloc>(context)
                  .add(FavoriteList());

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
