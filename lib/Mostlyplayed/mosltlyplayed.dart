import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:miomix/blocs/mostly_played/mostly_played_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Models/mostlyplayed.dart';

class MosltlyPlayedScreen extends StatelessWidget {
  MosltlyPlayedScreen({super.key});

  List<MostPlayed> finalmsongs = [];

  List<Audio> convertedAudio = [];
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return BlocProvider.of<MostlyPlayedBloc>(context).add(InitializeMost());
    });
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 23, 63, 97),
        body: SafeArea(
            child: Column(children: [
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
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: BlocBuilder<MostlyPlayedBloc, MostlyPlayedState>(
            builder: (context, state) {
              int i = 0;
              convertedAudio.clear();
              if (state.mpSongs.length == 0) {
                return Center(
                  child: Text("No Songs"),
                );
              }
              for (var element in state.mpSongs) {
                if (element.count > 3) {
                  finalmsongs.remove(element);
                  finalmsongs.insert(i, element);
                  i++;
                }
              }
              for (var element in finalmsongs) {
                convertedAudio.add(Audio.file(element.songurl,
                    metas: Metas(
                      title: element.songname,
                      artist: element.artist,
                      id: element.id.toString(),
                    )));
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: finalmsongs.reversed.length,
                itemBuilder: (context, index) {
                  
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 3),
                    child: ListTile(
                      onTap: () {
                        player.open(
                            Playlist(
                              audios: convertedAudio,
                              startIndex: index,
                            ),
                            showNotification: true,
                            headPhoneStrategy:
                                HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                            loopMode: LoopMode.playlist);

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MusicPlayScreen(
                              index: index,
                            );
                          },
                        ));
                      },

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
                    ),
                  );
                },
              );
            },
          ))
        ])));
  }
}
