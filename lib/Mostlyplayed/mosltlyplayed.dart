import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Screens/miniplayer.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Models/mostlyplayed.dart';

class MosltlyPlayedScreen extends StatefulWidget {
  const MosltlyPlayedScreen({super.key});

  @override
  State<MosltlyPlayedScreen> createState() => _MosltlyPlayedScreenState();
}

List<MostPlayed> finalmsongs = [];

class _MosltlyPlayedScreenState extends State<MosltlyPlayedScreen> {
  List<Audio> songs = [];
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  @override
  void initState() {
    print(finalmsongs);
    List<MostPlayed> songlist =
        mostlyplayedbox.values.toList().reversed.toList();
    log(songlist.toString());
    int i = 0;
    for (var item in songlist) {
      if (item.count > 3) {
        //here we take greator than 3 count values.
        finalmsongs.remove(item);
        //here i removed the the item before insertion
        finalmsongs.insert(i, item);
        i++;
      }
    }
    for (var items in finalmsongs) {
      //log(finalmsongs.toString());
      songs.add(
        Audio.file(
          items.songurl,
          metas: Metas(
            title: items.songname,
            artist: items.artist,
            id: items.id.toString(),
          ),
        ),
      );
      super.initState();
    }
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
                        child: const Text(
                          'Mostly Played',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: width1 * 0.2,
                      ),
                      IconButton(
                          onPressed: () {
                            AlertDialog(
                              title: const Text('Clear the Songs'),
                              content: const Text('Are You Sure ?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      mostlyplayedbox.clear();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Remove'))
                              ],
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: mostlyplayedbox.listenable(),
                builder: (context, Box<MostPlayed> datamsongs, _) {
                  // List<MostPlayed> msongs = datamsongs.values.toList();
                  if (finalmsongs.isNotEmpty) {
                    return ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: finalmsongs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 6, 0, 3),
                          child: ListTile(
                            onTap: () {
                              player.open(
                                  Playlist(
                                    audios: songs,
                                    startIndex: index,
                                  ),
                                  showNotification: true,
                                  headPhoneStrategy:
                                      HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                                  loopMode: LoopMode.playlist);
                              setState(() {});
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return MusicPlayScreen(
                                    index: index,
                                  );
                                },
                              ));
                            },
                            // onTap: (() {
                            //   print(player.getCurrentAudioTitle);

                            //   player.open(
                            //       Playlist(audios: songs, startIndex: index),
                            //       showNotification: true,
                            //       headPhoneStrategy:
                            //           HeadPhoneStrategy.pauseOnUnplug,
                            //       loopMode: LoopMode.playlist);
                            //   setState(() {
                            //     //playerVisibility = true;
                            //   });
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: ((context) => const MiniPlayer()),
                            //     ),
                            //   );
                            // }),
                            //----------------------------------------Displaying The Song Image--------------------------------------------------
                            leading: QueryArtworkWidget(
                              artworkFit: BoxFit.cover,
                              id: finalmsongs[index].id,
                              type: ArtworkType.AUDIO,
                              artworkQuality: FilterQuality.high,
                              size: 2000,
                              quality: 100,
                              artworkBorder: BorderRadius.circular(50),
                              nullArtworkWidget: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: Image.asset(
                                  'assets/images/studio.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: SingleChildScrollView(
                              child: Text(
                                finalmsongs[index].songname,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 13.43,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: (() {
                                // showModalBottomSheet(
                                //   backgroundColor: Colors.black,
                                //   shape: const RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.vertical(
                                //       top: Radius.circular(20),
                                //     ),
                                //   ),
                                //   context: context,
                                //   builder: ((context) {
                                //     return SizedBox(
                                //       height: 200,
                                //       child: Column(
                                //         children: const [
                                //           // AddToPlalistbutton(songindex: index),
                                //           SizedBox(
                                //             height: 10,
                                //           ),
                                //           // addToFavorite(
                                //           //   index: index,
                                //           // )
                                //           /* TextButton(
                                //         onPressed: () {},
                                //         child: const Text("Add to Favorites")) */
                                //         ],
                                //       ),
                                //     );
                                //   }
                                //   ),
                                // );
                              }),
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        heightFactor: 7.5,
                        child: Center(
                          child: Text(
                            '''Your most played songs will be listed here ''',
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ),
                    );
                  }
                },
                // builder: (context, Box<MostPlayed> datamsongs, child) =>
                // child: ListView.separated(
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         leading: const CircleAvatar(
                //           radius: 30,
                //           backgroundImage:
                //               AssetImage('assets/images/splash.jpg'),
                //         ),
                //         title: Text(
                //           'Music  $index',
                //           style: const TextStyle(
                //             color: Colors.white,
                //           ),
                //         ),
                //         trailing: GestureDetector(
                //           onTap: () {
                //             showModalBottomSheet(
                //               context: context,
                //               builder: (context) {
                //                 return Container(
                //                   width: width1 * 0.449,
                //                   height: height1 * 0.20,
                //                   color: Colors.black,
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       GestureDetector(
                //                         onTap: () {
                //                           Navigator.pop(context);
                //                           // addtoPlaylist();
                //                         },
                //                         child: const Text(
                //                           'Add to Playlist',
                //                           style: TextStyle(
                //                             color: Colors.white,
                //                             fontSize: 20,
                //                           ),
                //                         ),
                //                       ),
                //                       const SizedBox(
                //                         height: 25,
                //                       ),
                //                       GestureDetector(
                //                         onTap: () {
                //                           // favouriteAdd();
                //                           Navigator.pop(context);
                //                         },
                //                         child: const Text(
                //                           'Add to Favorites',
                //                           style: TextStyle(
                //                             color: Colors.white,
                //                             fontSize: 20,
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 );
                //               },
                //             );
                //           },
                //           child: const Icon(
                //             Icons.more_vert_outlined,
                //             color: Colors.white,

                //             // color: Color(Colors.white),
                //           ),
                //         ),
                //       );
                //     },
                //     separatorBuilder: (context, index) {
                //       return const Divider();
                //     },
                //     itemCount: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
