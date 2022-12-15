import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:miomix/Models/dbfunction.dart';

import '../Models/allsonglist.dart';
import '../Models/playlistmpdel.dart';

class AddtoPlaylist2 extends StatefulWidget {
  int songIndex;
  AddtoPlaylist2({super.key, required this.songIndex});

  @override
  State<AddtoPlaylist2> createState() => _AddtoPlaylist2State();
}

class _AddtoPlaylist2State extends State<AddtoPlaylist2> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await playlistBottomSheet(context);
          //Navigator.pop(context);
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ));
  }

  Future<dynamic> playlistBottomSheet(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    //final width1 = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              color: Colors.black,
              height: 200,
              child: Column(
                children: [
                  Expanded(
                      child: ValueListenableBuilder(
                          valueListenable: playlistbox.listenable(),
                          builder: (context, Box<PlaylistSongs> data, child) {
                            List<PlaylistSongs> allplay = data.values.toList();
                            if (playlistbox.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              allplay[index].playlistname!,
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
                                              Box<Songs> box =
                                                  Hive.box('Songs');
                                              List<Songs> dbAllsongs =
                                                  box.values.toList();
                                              bool isAlreadyAdded = plnewsongs!
                                                  .any((element) =>
                                                      element.id ==
                                                      dbAllsongs[
                                                              widget.songIndex]
                                                          .id);

                                              if (!isAlreadyAdded) {
                                                plnewsongs.add(Songs(
                                                  songname: dbAllsongs[
                                                          widget.songIndex]
                                                      .songname,
                                                  artist: dbAllsongs[
                                                          widget.songIndex]
                                                      .artist,
                                                  duration: dbAllsongs[
                                                          widget.songIndex]
                                                      .duration,
                                                  songurl: dbAllsongs[
                                                          widget.songIndex]
                                                      .songurl,
                                                  id: dbAllsongs[
                                                          widget.songIndex]
                                                      .id,
                                                ));

                                                // playlistbox.putAt(
                                                //     index,
                                                //     PlaylistSongs(
                                                //         playlistname:
                                                //             allplay[index]
                                                //                 .playlistname,
                                                //         playlistssongs:
                                                //             plnewsongs));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.black,
                                                        content: Text(
                                                            '${dbAllsongs[widget.songIndex].songname}Added to ${allplay[index].playlistname}')));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.black,
                                                        content: Text(
                                                            '${dbAllsongs[widget.songIndex].songname} is already added')));
                                              }
                                              Navigator.pop(context);
                                            });
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox();
                                      },
                                      itemCount: allplay.length),
                                )
                              ],
                            );
                          }))
                ],
              ),
            );
          },
        );
      },
    );
  }
}
