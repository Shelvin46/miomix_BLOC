import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:miomix/blocs/favorite_listing_home/favorite_listing_home_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavHomeList extends StatelessWidget {
  FavHomeList({
    super.key,
  });

  List<Audio> favosongs = [];
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return BlocProvider.of<FavoriteListingHomeBloc>(context)
          .add(FavoriteList());
    });

    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
        ),
        BlocBuilder<FavoriteListingHomeBloc, FavoriteListingHomeState>(
          builder: (context, state) {
            favosongs.clear();
            for (var element in state.favSongs) {
              favosongs.add(
                Audio.file(
                  element.songurl.toString(),
                  metas: Metas(
                    artist: element.artist,
                    title: element.songname,
                    id: element.id.toString(),
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width1 * 0.0100, 0, 0, height1 * 0.00010),
                        child: const Text(
                          ' Your Favourites',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    /*  height: height * 0.224, */
                    height: 220,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(19),
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: GestureDetector(
                            onTap: (() {
                              //log(favosongs.toString());
                              player.open(
                                  Playlist(
                                    audios: favosongs,
                                    startIndex: index,
                                  ),
                                  showNotification: true,
                                  headPhoneStrategy:
                                      HeadPhoneStrategy.pauseOnUnplug,
                                  loopMode: LoopMode.playlist);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => MusicPlayScreen(
                                        index: index,
                                      )),
                                ),
                              );
                            }),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0, height1 * 0.0106, 0, 0),
                                  child: QueryArtworkWidget(
                                    artworkHeight: width1 * 0.306,
                                    artworkWidth: width1 * 0.306,
                                    artworkFit: BoxFit.cover,
                                    id: state.favSongs[index].id!,
                                    type: ArtworkType.AUDIO,
                                    artworkQuality: FilterQuality.high,
                                    size: 2000,
                                    quality: 100,
                                    artworkBorder: BorderRadius.circular(8),
                                    nullArtworkWidget: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      child: Image.asset(
                                        'assets/images/studio.png',
                                        height: width1 * 0.306,
                                        width: width1 * 0.306,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 18,
                                  width: width1 * .28,
                                  child: Marquee(
                                    blankSpace: 20,
                                    velocity: 20,
                                    text: state.favSongs[index].songname!,
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                      separatorBuilder: ((context, index) {
                        return SizedBox(
                          width: width1 * 0.024,
                        );
                      }),
                      itemCount: state.favSongs.length,
                    ),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
