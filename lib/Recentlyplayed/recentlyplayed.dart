import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/recentlyplayed.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:miomix/blocs/recently_played_bloc/recently_played_bloc_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  RecentlyPlayedScreen({super.key});
  List<Audio> convertAudio = [];

  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return BlocProvider.of<RecentlyPlayedBlocBloc>(context).add(Recently());
    });
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
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<RecentlyPlayedBlocBloc,
                        RecentlyPlayedBlocState>(
                      builder: (context, state) {
                        convertAudio.clear();
                        for (var item in state.reSongs) {
                          convertAudio.add(Audio.file(item.songurl!,
                              metas: Metas(
                                  title: item.songname,
                                  artist: item.artist,
                                  id: item.id.toString())));
                        }
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.reSongs.length,
                          itemBuilder: ((context, index) {
                            log(index.toString());
                            return ListTile(
                              onTap: () {
                                LoopMode loopMode =
                                    convertAudio.length == state.reSongs.length
                                        ? LoopMode.none
                                        : LoopMode.playlist;
                                player.open(
                                  Playlist(
                                    audios: convertAudio,
                                    startIndex: index,
                                  ),
                                  showNotification: true,
                                  loopMode: loopMode,
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => MusicPlayScreen(
                                          index: index,
                                        )),
                                  ),
                                );
                                log(index.toString());
                              },
                              leading: QueryArtworkWidget(
                                artworkFit: BoxFit.cover,
                                id: state.reSongs[index].id!,
                                type: ArtworkType.AUDIO,
                                artworkQuality: FilterQuality.high,
                                size: 2000,
                                quality: 100,
                                artworkBorder: BorderRadius.circular(50),
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  child: Image.asset(
                                    'assets/images/studio.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: SingleChildScrollView(
                                child: Text(
                                  state.reSongs[index].songname!,
                                  maxLines: 1,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontSize: 13.43,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            );
                          }),
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        );
                      },
                    )))
          ],
        ),
      ),
    );
  }

  playerOnTap() {
    List<RecentPlayed> dbsongs =
        recentlyplayedbox.values.toList().reversed.toList();
    for (var item in dbsongs) {
      convertAudio.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
  }
}
//how to set inkwell in flutter?

