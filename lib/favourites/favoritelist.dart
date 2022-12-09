import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/favourite.dart';

class FavoritePagelist extends StatefulWidget {
  FavoritePagelist({super.key});

  @override
  State<FavoritePagelist> createState() => _FavoritePagelistState();
}

class _FavoritePagelistState extends State<FavoritePagelist> {
  List<Audio> fsongs = [];
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
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
                return
              },
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/splash.jpg'),
                      ),
                      title: Text(
                        'Music  $index',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          removeFavorite(context);
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (context) {
                          //     return Container(
                          //       width: width1 * 0.449,
                          //       height: height1 * 0.10,
                          //       color: Colors.black,
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           GestureDetector(
                          //             onTap: () {
                          //               Navigator.pop(context);
                          //               removeFavorite(context);
                          //             },
                          //             child: const Text(
                          //               'Remove From Playlist',
                          //               style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize: 20,
                          //               ),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 25,
                          //           ),
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // );
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
                  itemCount: 15),
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
}
//how to set bottom navigation bar in flutter?
