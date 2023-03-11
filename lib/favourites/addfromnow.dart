import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/favourite.dart';
import 'package:miomix/blocs/adding_favorite/adding_favorite_bloc.dart';
import 'package:miomix/blocs/favorite_listing_home/favorite_listing_home_bloc.dart';
import 'package:miomix/favourites/favoritelist.dart';
import '../Models/allsonglist.dart';

class AddFavNowScreen extends StatelessWidget {
  int index;
  AddFavNowScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AddingFavoriteBloc>(context).add(Initial());
    });

    List<FavSongs> fasongs = [];
    final box = Songbox.getInstance();
    List<Songs> dbsongs = box.values.toList();
    fasongs = favsongbox.values.toList();
    return fasongs
            .where((element) => element.songname == dbsongs[index].songname)
            //here we checking the index song is equal to favourite song list
            .isEmpty
        ? BlocBuilder<AddingFavoriteBloc, AddingFavoriteState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    favsongbox.add(
                      FavSongs(
                        songname: dbsongs[index].songname,
                        artist: dbsongs[index].artist,
                        duration: dbsongs[index].duration,
                        songurl: dbsongs[index].songurl,
                        id: dbsongs[index].id,
                      ),
                    );
                    BlocProvider.of<AddingFavoriteBloc>(context)
                        .add(AddingOnpress());
                    BlocProvider.of<FavoriteListingHomeBloc>(context)
                        .add(FavoriteList());
                    //    setState(() {});
                    //Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added to Favorites")));
                  },
                  icon: state.addingORremoving == false
                      ? const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 35,
                        )
                      : const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 35,
                        ));
            },
          )
        : BlocBuilder<AddingFavoriteBloc, AddingFavoriteState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    int currentIndex = fasongs.indexWhere(
                        (element) => element.id == dbsongs[index].id);
                    //player.playlist!.audios.clear();
                    player.playlist!.audios.removeAt(currentIndex);
                    favsongbox.deleteAt(currentIndex);
                    BlocProvider.of<AddingFavoriteBloc>(context)
                        .add(AddingOnpress());
                    BlocProvider.of<FavoriteListingHomeBloc>(context)
                        .add(FavoriteList());
                    // log(currentIndex.toString());
                    //  setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Removed From Favorites")));
                  },
                  icon: state.addingORremoving == false
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 35,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 35,
                        ));
            },
          );
  }
}
