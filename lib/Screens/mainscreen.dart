// ignore_for_file: avoid_types_as_parameter_names

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:miomix/Models/allsonglist.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/mostlyplayed.dart';
import 'package:miomix/Models/recentlyplayed.dart';
import 'package:miomix/Mostlyplayed/mosltlyplayed.dart';
import 'package:miomix/Recentlyplayed/recentlyplayed.dart';
import 'package:miomix/Screens/allsonglist.dart';
import 'package:miomix/Screens/miniplayer.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:miomix/Settingscreen/settingscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

// import 'package:audioplayers/audio_cache.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late bool playerVisibility;
  final box = Songbox.getInstance(); //contains copy of all songs
  List<Audio> convertAudios =
      []; // this object used for convering the audios in the package of asset audio player

  @override
  void initState() {
    List<Songs> dbSongs = box.values.toList(); // creating object of Songs list

    for (var item in dbSongs) {
      // here converting audios using the package of assrt audio player
      convertAudios.add(
        Audio.file(
          item.songurl!,
          metas: Metas(
            title: item.songname,
            artist: item.artist,
            id: item.id.toString(),
          ),
        ),
      );
    }
    setState(() {});
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: const MiniPlayer(),
      // bottomSheet: miniPlayer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Text('Good Morning Shelvin !!'),
          ),
          backgroundColor: const Color.fromARGB(255, 4, 45, 79),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SetttingScreen();
                      },
                    ),
                  );
                },
                child: const Icon(
                  Icons.settings,
                ),
              ),
            ),
          ],
          // shape: const RoundedRectangleBorder(),
        ),
      ),
      // <-------------------------------------------------------------App bar--------------------------------------------------------------------------------------------------------->
      body: Container(
        // height: height * .096,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //<-----------------------------------------------------------Background image----------------------------------------------------------------------------------------------------------------------->
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          width1 * 0.0100, 0, 0, height1 * 0.00010),
                      child: const Text(
                        '     Your Dashboard',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MosltlyPlayedScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: width1 * 0.449,
                      height: height1 * 0.10,

                      // ignore: sort_child_properties_last
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            width1 * 0.0100, 0, 0, height1 * 0.0100),
                        child: const Center(
                          child: Text(
                            'Mostly Played',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),

                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 28, 97, 150),
                          borderRadius: BorderRadius.circular(15)
                          // image: DecorationImage(
                          //   image: AssetImage('assets/images/splash.jpg'),
                          //   fit: BoxFit.fill,
                          // ),
                          ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const RecentlyPlayedScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: width1 * 0.449,
                      height: height1 * 0.10,
                      // ignore: sort_child_properties_last
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            width1 * 0.0100, 0, 0, height1 * 0.0100),
                        child: const Center(
                          child: Text(
                            'Recently Played',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),

                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 28, 97, 150),
                          borderRadius: BorderRadius.circular(15)
                          // image: DecorationImage(
                          //   image: AssetImage('assets/images/splash.jpg'),
                          //   fit: BoxFit.fill,
                          // ),
                          ),
                    ),
                  ),
                ],
              ),
              //<----------------------------------------------------------------Mostly Played & Recently Played------------------------------------------------------------------------------------------>
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        width1 * 0.0100, 0, 0, height1 * 0.00010),
                    child: const Text(
                      '     Your Favourites',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ],
              ),
              favoritesHomeListing(),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        width1 * 0.0100, 0, 0, height1 * 0.00010),
                    child: const Text(
                      '     Your Songs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const AllSongList(),
              // listView(),
              //miniPlayer()
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  favoritesHomeListing() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.0188, height * 0.0106, 0, 0),
      child: SizedBox(
        height: 200,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10),
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, height * 0.0106, 0, 0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: const FlutterLogo(
                            size: 140,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Music",
                      maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.0317,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              );
            }),
            separatorBuilder: ((context, index) {
              return SizedBox(
                width: width * 0.024,
              );
            }),
            itemCount: 10),
      ),
    );
  }
  //<-------------------------------------------------------------------------Favorite songs---------------------------------------------------------------------------------------------------------------------->

  // listView() {
  //   final height1 = MediaQuery.of(context).size.height;
  //   final width1 = MediaQuery.of(context).size.width;
  //   return ValueListenableBuilder(
  //       valueListenable: Songbox.getInstance().listenable(),
  //       builder: (context, Box<Songs> data, child) {
  //         List<Songs> alls = data.values.toList();
  //         //here  assign all the songs
  //         List<MostPlayed> mostoftimeplayed = mostlyplayedbox.values.toList();

  //         if (alls.isEmpty) {
  //           return const CircularProgressIndicator();
  //         }
  //         return ListView.separated(
  //             physics: const NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             scrollDirection: Axis.vertical,
  //             itemBuilder: (context, index) {
  //               Songs songs = alls[
  //                   index]; // assigning the each song index into a variable.
  //               MostPlayed msongs = mostoftimeplayed[index];
  //               RecentPlayed rsongs;
  //               return ListTile(
  //                 onTap: (() {
  //                   // msongs = MostPlayed(
  //                   //     // here rsong variable containing song with song name and all requireed parameter.
  //                   //     songname: songs.songname,
  //                   //     artist: songs.artist,
  //                   //     id: songs.id,
  //                   //     duration: songs.duration,
  //                   //     songurl: songs.songurl
  //                   //     count: songs.count,);
  //                   rsongs = RecentPlayed(
  //                       // here rsong variable containing song with song name and all requireed parameter.
  //                       songname: songs.songname,
  //                       artist: songs.artist,
  //                       id: songs.id,
  //                       duration: songs.duration,
  //                       songurl: songs.songurl);
  //                   updateRecentlyPlayed(rsongs, index);
  //                   updateMostlyPlayed(msongs, index);
  //                   // updateMostlyPlayed(msongs, index);

  //                   audioPlayer.open(
  //                     // here open the song for playing it contain all audios and start with corresponding index
  //                     Playlist(
  //                       audios: convertAudios,
  //                       startIndex: index,
  //                     ),
  //                     headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
  //                     loopMode: LoopMode.playlist,
  //                   );
  //                   Navigator.of(context).push(MaterialPageRoute(
  //                     builder: (context) {
  //                       return const MusicPlayScreen();
  //                     },
  //                   ));
  //                 }),
  //                 leading: QueryArtworkWidget(
  //                   id: songs.id!,
  //                   type: ArtworkType.AUDIO,
  //                   artworkQuality: FilterQuality.high,
  //                   size: 2000,
  //                   quality: 100,
  //                   artworkFit: BoxFit.cover,
  //                   artworkBorder: BorderRadius.circular(50),
  //                   nullArtworkWidget: const CircleAvatar(
  //                     radius: 30,
  //                     backgroundImage: AssetImage('assets/images/studio.png'),
  //                   ),
  //                 ),
  //                 title: Text(
  //                   songs.songname!,
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: const TextStyle(
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 trailing: GestureDetector(
  //                   onTap: () {
  //                     showModalBottomSheet(
  //                       context: context,
  //                       builder: (context) {
  //                         return Container(
  //                           width: width1 * 0.449,
  //                           height: height1 * 0.20,
  //                           color: Colors.black,
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               GestureDetector(
  //                                 onTap: () {
  //                                   Navigator.pop(context);
  //                                   addtoPlaylist();
  //                                 },
  //                                 child: const Text(
  //                                   'Add to Playlist',
  //                                   style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 20,
  //                                   ),
  //                                 ),
  //                               ),
  //                               const SizedBox(
  //                                 height: 25,
  //                               ),
  //                               GestureDetector(
  //                                 onTap: () {
  //                                   favouriteAdd();
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: const Text(
  //                                   'Add to Favorites',
  //                                   style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 20,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         );
  //                       },
  //                     );
  //                   },
  //                   child: const Icon(
  //                     Icons.more_vert_outlined,
  //                     color: Colors.white,

  //                     // color: Color(Colors.white),
  //                   ),
  //                 ),
  //               );
  //             },
  //             separatorBuilder: (context, index) {
  //               return const Divider();
  //             },
  //             itemCount: alls.length);
  //       });
  // }

  //<------------------------------------------------------------------------Listing Songs-------------------------------------------------------------------------------------------------------------------->

  addtoPlaylist() async {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: width1 * 0.449,
          height: height1 * 0.30,
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.only(top: height1 * 0.01),
                  child: const Text(
                    'Your Playlist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    // shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            SnackbarMessage();
                            Navigator.pop(context);
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://media.istockphoto.com/id/685111998/photo/young-girl-dancing-to-the-music.jpg?b=1&s=612x612&w=0&k=20&c=hzH3S5_9l_P-ZfpGwyz5OQp1QsSfEJor48jObUfUnBU='),
                          ),
                        ),
                        title: Text(
                          'Playlist $index',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: 5),
              )
            ],
          ),
        );
      },
    );
  }
  //<-----------------------------------------------------------------------song added into playlist -------------------------------------------------------------------------------------------------------------------------->

  // ignore: non_constant_identifier_names
  SnackbarMessage() {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Song Added into the Playlist',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  favouriteAdd() {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Song Added into Favorites',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
//how to apply mediaquery in container?
