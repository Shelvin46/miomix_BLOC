import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Screens/miniplayer.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Models/allsonglist.dart';
import '../Models/playlistmpdel.dart';

class Playlistscreen extends StatefulWidget {
  Playlistscreen({
    super.key,
    required this.allPlaylistSongs,
    required this.playlistindex,
    required this.playlistname,
  });
  List<Songs> allPlaylistSongs = [];
  int playlistindex;
  String playlistname;

  @override
  State<Playlistscreen> createState() => _PlaylistscreenState();
}

class _PlaylistscreenState extends State<Playlistscreen> {
  @override
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<Audio> plstsongs = [];
  @override
  void initState() {
    for (var song in widget.allPlaylistSongs) {
      plstsongs.add(Audio.file(song.songurl.toString(),
          metas: Metas(
              title: song.songname,
              artist: song.artist,
              id: song.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 63, 97),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width1 * 1,
              height: height1 * 0.10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.black26,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width1 * 0.05,
                            vertical: height1 * 0.02),
                        child: Text(
                          widget.playlistname,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            listView1(context)
          ],
        ),
      ),
    );
  }

  listView1(context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: playlistbox.listenable(),
        builder: (context, Box<PlaylistSongs> data, child) {
          List<PlaylistSongs> plsongs = playlistbox.values.toList();
          List<Songs>? songs = plsongs[widget.playlistindex]
              .playlistssongs; //? here taking which playlist and the songs
          //log(plsongs.toString());
          if (songs!.isEmpty) {
            return Align(
              heightFactor: 7.5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "No Songs Added",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            );
          }
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    log(plsongs.toString());
                    player.open(
                        Playlist(
                          audios: plstsongs,
                          startIndex: index,
                        ),
                        showNotification: true,
                        loopMode: LoopMode.playlist,
                        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MusicPlayScreen(index: index),
                    ));
                  },
                  leading: QueryArtworkWidget(
                    artworkFit: BoxFit.cover,
                    id: songs[index].id!,
                    type: ArtworkType.AUDIO,
                    artworkQuality: FilterQuality.high,
                    size: 2000,
                    quality: 100,
                    artworkBorder: BorderRadius.circular(50),
                    nullArtworkWidget: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(
                        'assets/images/studio.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: SingleChildScrollView(
                    child: Text(
                      songs[index].songname!,
                      maxLines: 1,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 13.43,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Delete Playlist"),
                            content: const Text("Are You Sure"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      plstsongs.removeAt(index);
                                      songs.removeWhere((element) =>
                                          element.id == songs[index].id);
                                      playlistbox.putAt(
                                        widget.playlistindex,
                                        PlaylistSongs(
                                          playlistname: widget.playlistname,
                                          playlistssongs: songs,
                                        ),
                                      );
                                    });

                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete"))
                            ],
                          );
                        },
                      );
                      //showAlertDialog(context);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,

                      // color: Color(Colors.white),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: songs.length);
        },
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        deleteSnackbar(context);
        Navigator.pop(context);
      },
    );
    Widget noButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('No'),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Music"),
      content: const Text("Are You Sure"),
      actions: [
        okButton,
        noButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deleteSnackbar(context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Deleted Sccessfully',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
//how to set alertdialog in flutter?
