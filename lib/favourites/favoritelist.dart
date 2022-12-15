import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/favourite.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

class FavoritePagelist extends StatefulWidget {
  const FavoritePagelist({super.key});

  @override
  State<FavoritePagelist> createState() => _FavoritePagelistState();
}

class _FavoritePagelistState extends State<FavoritePagelist> {
  List<Audio> fsongs = [];

  @override
  void initState() {
    List<FavSongs> fasongs = favsongbox.values.toList();
    for (var item in fasongs) {
      fsongs.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
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
                          horizontal: width1 * 0.05, vertical: height1 * 0.02),
                      child: const Text(
                        'Favorite Songs',
                        style: TextStyle(
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
            height: 20,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: favsongbox.listenable(),
              builder: (context, Box<FavSongs> favsongs, child) {
                List<FavSongs> allDbSongs = favsongs.values.toList();
                //List<FavSongs> allfavSongs = favsongbox.values.toList();

                //----------------------------------------If songs are not there--------------------------------------------------
                if (favsongbox.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      heightFactor: 7.5,
                      child: Center(
                          child: Text(
                        'No Favorites',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                    ),
                  );
                }
                //----------------------------------------If the list is null--------------------------------------------------
                if (favsongbox == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // FavSongs favrsongs = allfavSongs[index];
                      return ListTile(
                        onTap: () {
                          player.open(
                              Playlist(
                                audios: fsongs,
                                startIndex: index,
                              ),
                              showNotification: true,
                              loopMode: LoopMode.playlist,
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplug);
                          setState(() {});
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MusicPlayScreen(
                                  index: index,
                                );
                              },
                            ),
                          );
                        },
                        leading: QueryArtworkWidget(
                          artworkFit: BoxFit.cover,
                          id: allDbSongs[index].id!,
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
                            allDbSongs[index].songname!,
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
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Remove from favorites"),
                                  content: const Text("Are You Sure ?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel")),
                                    TextButton(
                                        onPressed: () {
                                          fsongs.removeAt(index);

                                          // deleteSongFromList(favrsongs, index);
                                          favsongbox.deleteAt(index);
                                          log(player.playlist!.audios
                                              .toString());
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Remove"))
                                  ],
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,

                            // color: Color(Colors.white)
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: allDbSongs.length);
              },
            ),
          )
        ],
      )),
    );
  }

  removeFavorite(context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Song Removed From Favourite',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // deleteSongFromList(FavSongs values, int index) async {
  //   List<FavSongs> list = favsongbox.values.toList();
  //   bool isAlready =
  //       list.where((element) => element.id == values.id).isNotEmpty;
  //   if (isAlready == true) {
  //     favsongbox.deleteAt(index);
  //   }
  // }
}
//how to set bottom navigation bar in flutter?
