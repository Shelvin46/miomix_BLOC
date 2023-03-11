import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/recentlyplayed.dart';
import 'package:miomix/Playlists/allbottomfav.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:miomix/blocs/home_songs/home_songs_bloc.dart';
import 'package:miomix/favourites/favadd.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Models/allsonglist.dart';
import '../Models/mostlyplayed.dart';
import '../blocs/recently_played_bloc/recently_played_bloc_bloc.dart';

class AllSongList extends StatelessWidget {
  AllSongList({super.key});
  List<Audio> convertAudio = [];

  late bool isplaying;

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeSongsBloc>(context).add(Initialize());
    });
    final height1 = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeSongsBloc, HomeSongsState>(
      builder: (context, state) {
        List<MostPlayed> mostoftimeplayed = mostlyplayedbox.values.toList();
        convertAudio.clear();
        for (var item in state.dbSongs) {
          convertAudio.add(Audio.file(item.songurl!,
              metas: Metas(
                  title: item.songname,
                  artist: item.artist,
                  id: item.id.toString())));
        }
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.dbSongs.length,
            itemBuilder: (context, index) {
              Songs songs = state.dbSongs[index];
              MostPlayed Mpsongs = mostoftimeplayed[index];
              log(Mpsongs.toString());

              RecentPlayed rsongs;
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 3),
                child: ListTile(
                  onTap: (() async {
                    //  await playerOnTap();
                    rsongs = RecentPlayed(
                      id: songs.id,
                      artist: songs.artist,
                      duration: songs.duration,
                      songname: songs.songname,
                      songurl: songs.songurl,
                    );

                    updateRecentlyPlayed(rsongs, index);
                    updatePlayedSongCount(Mpsongs, index);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      return BlocProvider.of<RecentlyPlayedBlocBloc>(context)
                          .add(Recently());
                    });

                    LoopMode loopMode =
                        convertAudio.length == state.dbSongs.length
                            ? LoopMode.none
                            : LoopMode.playlist;

                    audioPlayer.open(
                        Playlist(audios: convertAudio, startIndex: index),
                        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                        loopMode: loopMode);

                    // setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => MusicPlayScreen(
                              index: index,
                            )),
                      ),
                    );
                  }),
                  //----------------------------------------Displaying The Song Image--------------------------------------------------
                  leading: QueryArtworkWidget(
                    artworkFit: BoxFit.cover,
                    id: state.dbSongs[index].id!,
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
                      state.dbSongs[index].songname!,
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

                  //----------------------------------------Trailing Menu Pop UP--------------------------------------------------
                  trailing: IconButton(
                    onPressed: (() {
                      // setState(() {});
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
                            height: 150 /* height * 0.13 */,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height1 * 0.05,
                                ),
                                AddtoPlaylist1(songIndex: index),
                                SizedBox(
                                  height: height1 * 0.011,
                                ),
                                AddtoFavourite(index: index),
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
                ),
              );
            });
      },
    );
  }
}

//   playerOnTap() {
//     List<Songs> dbsongs = box.values.toList();
//   }
// }
