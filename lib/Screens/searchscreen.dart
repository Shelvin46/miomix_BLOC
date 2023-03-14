import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:miomix/Screens/splashscreen.dart';
import 'package:miomix/blocs/bloc/search_bloc_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Models/allsonglist.dart';
import '../debouncer/debouncer.dart';

final TextEditingController searchController = TextEditingController();
final box = Songbox.getInstance();
// late List<Songs> dbSongs;
AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
List<Audio> al = [];

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  List<Audio> convertSongs = [];
  late List<Songs> another;
  late List<Songs> compare;
  final _debouncer = Debouncer(milliseconds: 1 * 1000);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   void initState() {
//     dbSongs = box.values.toList();
//     for (var item in another) {
//       allSongs.add(
//         Audio.file(
//           item.songurl.toString(),
//           metas: Metas(
//             artist: item.artist,
//             title: item.songname,
//             id: item.id.toString(),
//           ),
//         ),
//       );
//     }
//     //convertAudio();
//     log(another.toString());
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return BlocProvider.of<SearchBlocBloc>(context).add(InitializeSearch());
    });
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      // bottomSheet: miniPlayer(context),
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
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  child: TextFormField(
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255))),
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: searchController,
                    onChanged: (value) async {
                      BlocProvider.of<SearchBlocBloc>(context)
                          .add(UpdateSearch(query: value));
                    },
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: const Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                      focusColor: Colors.white,
                      hintText: 'What do you want to listen to?',
                      hintStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(113, 158, 158, 158))),
                      filled: true,
                      fillColor: const Color.fromARGB(146, 50, 50, 50),
                    ),
                  ),
                )),
            Expanded(child: BlocBuilder<SearchBlocBloc, SearchBlocState>(
              builder: (context, state) {
                if (state.dbSongs.isEmpty) {
                  return const Center(
                    child: Text("No songs"),
                  );
                } else if (state.isNull == true) {
                  return const Center(
                    child: Text("No Songs"),
                  );
                } else if (state.searchResults.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.searchResults.length,
                      itemBuilder: ((context, index) {
                        convertSongs.clear();
                        for (var element in state.searchResults) {
                          convertSongs
                              .add(Audio.file(element.songurl.toString(),
                                  metas: Metas(
                                    artist: element.artist,
                                    title: element.songname,
                                    id: element.id.toString(),
                                  )));
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: ListTile(
                            onTap: () {
                              audioPlayer.open(
                                  Playlist(
                                      audios: convertSongs, startIndex: index),
                                  showNotification: true,
                                  headPhoneStrategy:
                                      HeadPhoneStrategy.pauseOnUnplug,
                                  loopMode: LoopMode.playlist);

                              // setState(() {});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      MusicPlayScreen(index: index)),
                                ),
                              );
                              final currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus &&
                                  currentFocus.focusedChild != null) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                            },
                            leading: QueryArtworkWidget(
                              artworkFit: BoxFit.cover,
                              id: state.searchResults[index].id!,
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
                                state.searchResults[index].songname!,
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 13.43,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.dbSongs.length,
                    itemBuilder: ((context, index) {
                      convertSongs.clear();
                      for (var element in state.dbSongs) {
                        convertSongs.add(Audio.file(element.songurl.toString(),
                            metas: Metas(
                              artist: element.artist,
                              title: element.songname,
                              id: element.id.toString(),
                            )));
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListTile(
                          onTap: () {
                            audioPlayer.open(
                                Playlist(
                                    audios: convertSongs, startIndex: index),
                                showNotification: true,
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplug,
                                loopMode: LoopMode.playlist);

                            // setState(() {});
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) =>
                                    MusicPlayScreen(index: index)),
                              ),
                            );
                            final currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          leading: QueryArtworkWidget(
                            artworkFit: BoxFit.cover,
                            id: state.dbSongs[index].id!,
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
                              state.dbSongs[index].songname!,
                              maxLines: 1,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 13.43,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
                //return searchHistory();
              },
            ))

            // listView(context)
          ],
        ),
      ),
    );
  }

  // searchHistory() {
  //   // convertSongs.clear();
  //   // for (var element in state.dbSongs) {
  //   //   convertSongs.add(Audio.file(element.songurl.toString(),
  //   //       metas: Metas(
  //   //           artist: element.artist,
  //   //           title: element.songname,
  //   //           id: element.id.toString())));
  //   // }
  //   return
  // }

  List<Songs> searchSongs(String query, List<Songs> songs) {
    return songs
        .where((song) =>
            song.songname!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // void updateList(String value, context) {
  //   another = compare
  //       .where((element) =>
  //           element.songname!.toLowerCase().contains(value.toLowerCase()))
  //       .toList();

  //   //allSongs.clear();
  //   for (var item in another) {
  //     convertSongs.add(
  //       Audio.file(
  //         item.songurl.toString(),
  //         metas: Metas(
  //           artist: item.artist,
  //           title: item.songname,
  //           id: item.id.toString(),
  //         ),
  //       ),
  //     );
  //   }
  // }
}
