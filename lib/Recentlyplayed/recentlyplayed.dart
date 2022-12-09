import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/recentlyplayed.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  List<Audio> resongconvert = [];
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  @override
  void initState() {
    List<RecentPlayed> rdbsongs =
        recentlyplayedbox.values.toList().reversed.toList();
    for (var item in rdbsongs) {
      resongconvert.add(
        Audio.file(
          item.songurl!,
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          ),
        ),
      );
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
                        child: const Text(
                          'Recently Played',
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
                valueListenable: recentlyplayedbox.listenable(),
                builder: (context, Box<RecentPlayed> resongs, child) {
                  // final height = MediaQuery.of(context).size.height;
                  List<RecentPlayed> rsongs =
                      resongs.values.toList().reversed.toList();

                  if (rsongs.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        heightFactor: 7.5,
                        child: Center(
                          child: Text(
                            "You haven't played anything ! Try playing something.",
                            style: GoogleFonts.montserrat(
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: rsongs.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          onTap: () {
                            //    final rsong = RecentPlayed(
                            // songname: rsongs[index].songname,
                            // artist: rsongs[index].artist,
                            // duration: rsongs[index].duration,
                            // songurl: rsongs[index].songurl,
                            // id: rsongs[index].id);

                            // updatePlayedSongCount(msongs, index);
                            //updateRecentPlayed(rsong, index); */
                            player.open(
                              Playlist(
                                audios: resongconvert,
                                startIndex: index,
                              ),
                              showNotification: true,
                              loopMode: LoopMode.playlist,
                            );
                            setState(() {});
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const MusicPlayScreen()),
                              ),
                            );
                          },
                          leading: QueryArtworkWidget(
                            artworkFit: BoxFit.cover,
                            id: rsongs[index].id!,
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
                              rsongs[index].songname!,
                              maxLines: 1,
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
                              showModalBottomSheet(
                                backgroundColor: Colors.black,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                context: context,
                                builder: ((context) {
                                  return SizedBox(
                                    height: 130,
                                    child: Column(
                                      children: const [
                                        // AddToPlalistbutton(songindex: index),

                                        // addToFavorite(
                                        //   index: index,
                                        // )
                                      ],
                                    ),
                                  );
                                }),
                              );
                            }),
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
