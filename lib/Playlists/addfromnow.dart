import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/blocs/bloc/adding_playlist_bloc.dart';

import '../Models/allsonglist.dart';
import '../Models/playlistmpdel.dart';

class AddtoPlaylist2 extends StatelessWidget {
  int songIndex;
  AddtoPlaylist2({super.key, required this.songIndex});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return BlocProvider.of<AddingPlaylistBloc>(context).add(PlaylistBottom());
    });
    final height1 = MediaQuery.of(context).size.height;
    return IconButton(
        onPressed: () async {
          return showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: Colors.black,
                height: 200,
                child: Column(
                  children: [
                    Expanded(child:
                        BlocBuilder<AddingPlaylistBloc, AddingPlaylistState>(
                      builder: (context, state) {
                        if (playlistbox.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height1 * 0.09,
                                  ),
                                  Text(
                                    "Create a playlist to add",
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            SizedBox(height: height1 * 0.02),
                            Text(
                              'Your Playlist',
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22)),
                            ),
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        leading: const Icon(
                                          Icons.music_note,
                                          color: Colors.white,
                                        ),
                                        title: Text(
                                          state.pSongs[index].playlistname!,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        onTap: () {
                                          PlaylistSongs? plsongs =
                                              playlistbox.getAt(
                                                  index); //!here we taking the comming  index from our playlist box
                                          //log(plsongs.toString());
                                          List<Songs>? plnewsongs = plsongs!
                                              .playlistssongs; //! here we assiging the index field song from our songs list
                                          Box<Songs> box = Hive.box('Songs');
                                          List<Songs> dbAllsongs =
                                              box.values.toList();
                                          bool isAlreadyAdded = plnewsongs!.any(
                                              (element) =>
                                                  element.id ==
                                                  dbAllsongs[songIndex].id);

                                          if (!isAlreadyAdded) {
                                            plnewsongs.add(Songs(
                                              songname: dbAllsongs[songIndex]
                                                  .songname,
                                              artist:
                                                  dbAllsongs[songIndex].artist,
                                              duration: dbAllsongs[songIndex]
                                                  .duration,
                                              songurl:
                                                  dbAllsongs[songIndex].songurl,
                                              id: dbAllsongs[songIndex].id,
                                            ));
                                            playlistbox.putAt(
                                                index,
                                                PlaylistSongs(
                                                    playlistname: state
                                                        .pSongs[index]
                                                        .playlistname,
                                                    playlistssongs:
                                                        plnewsongs));

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Text(
                                                        '${dbAllsongs[songIndex].songname}Added to ${state.pSongs[index].playlistname}')));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Text(
                                                        '${dbAllsongs[songIndex].songname} is already added')));
                                          }
                                          Navigator.pop(context);
                                        });
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox();
                                  },
                                  itemCount: state.pSongs.length),
                            )
                          ],
                        );
                      },
                    ))
                  ],
                ),
              );
            },
          );
          //Navigator.pop(context);
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ));
  }

  //final height1 = MediaQuery.of(context).size.height;
  //final width1 = MediaQuery.of(context).size.width;

}
