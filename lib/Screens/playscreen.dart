import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:miomix/Models/allsonglist.dart';
import 'package:miomix/Playlists/addfromnow.dart';
import 'package:miomix/favourites/addfromnow.dart';
import 'package:miomix/favourites/favoritelist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter_lyric/lyrics_reader.dart';

// ignore: must_be_immutable
class MusicPlayScreen extends StatelessWidget {
  int index;
  MusicPlayScreen({super.key, required this.index});

  var lyricPadding = 40.0;

  var lyricUI = UINetease();

  var lyricModel = LyricsModelBuilder.create();

  bool onPress = false;

  bool isRepeat = false;

  bool isNext = false;

  late List<Songs> dbsongs = box.values.toList();

  final box = Songbox.getInstance();

  bool click = true;

  @override
  Widget build(BuildContext context) {
    // setState(() {});
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return player.builderCurrent(builder: (context, playing) {
      return Scaffold(
          backgroundColor: const Color.fromARGB(255, 23, 63, 97),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                width: width1 * 1.00,
                height: height1 * 0.10,
                color: Colors.black45,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        const SizedBox(
                          width: 75,
                        ),
                        const Text(
                          'Now Playing',
                          style: TextStyle(color: Colors.white, fontSize: 29),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  player.builderCurrent(builder: (context, playing) {
                    //setState(() {});
                    return AddFavNowScreen(
                        index: dbsongs.indexWhere((element) =>
                            element.songname ==
                            playing.audio.audio.metas.title));
                  }),
                  AddtoPlaylist2(songIndex: playing.index)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              onPress == false
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(
                          width1 * 0.0100, 0, 0, height1 * 0.00010),
                      child: SizedBox(
                          height: width1 * 0.7556,
                          width: width1 * 0.7556,
                          child: QueryArtworkWidget(
                            artworkFit: BoxFit.contain,
                            artworkBorder: BorderRadius.circular(8),
                            artworkHeight: width1 * 0.7556,
                            artworkWidth: width1 * 0.7556,
                            id: int.parse(playing.audio.audio.metas.id!),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/studio.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(
                          width1 * 0.0100, 0, 0, height1 * 0.00010),
                      child: PlayerBuilder.realtimePlayingInfos(
                        player: player,
                        builder: (context, realtimePlayingInfos) {
                          final duration =
                              realtimePlayingInfos.current!.audio.duration;
                          final position = realtimePlayingInfos.currentPosition;

                          return Container(
                            height: width1 * 0.7556,
                            width: width1 * 0.7556,
                            color: Colors.amber,
                            child: LyricsReader(
                              padding: EdgeInsets.symmetric(
                                  horizontal: lyricPadding),
                              model: lyricModel.getModel(),
                              position: position.inSeconds,
                              lyricUi: lyricUI,
                              emptyBuilder: () => Center(
                                child: Text(
                                  "No lyrics",
                                  style: lyricUI.getOtherMainTextStyle(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  children: [
                    SizedBox(height: height1 * .02),
                    SizedBox(
                      height: height1 * .03,
                      width: width1,
                      child: Marquee(
                        blankSpace: 20,
                        velocity: 20,
                        text: player.getCurrentAudioTitle,
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: height1 * .03,
                      width: width1 * .2,
                      child: Marquee(
                        blankSpace: 20,
                        velocity: 20,
                        text: player.getCurrentAudioArtist,
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: PlayerBuilder.realtimePlayingInfos(
                  player: player,
                  builder: (context, realtimePlayingInfos) {
                    final duration =
                        realtimePlayingInfos.current!.audio.duration;
                    final position = realtimePlayingInfos.currentPosition;
                    return ProgressBar(
                      progress: position,
                      total: duration,
                      timeLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      onSeek: (duration) {
                        player.seek(duration);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //<----------------------------Progress bar

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PlayerBuilder.isPlaying(
                    player: player,
                    builder: (context, isPlaying) {
                      return IconButton(
                          iconSize: 45,
                          icon: playing.index == 0
                              ? Icon(
                                  Icons.skip_previous,
                                  color: Colors.white.withOpacity(0.4),
                                  size: 45,
                                )
                              : const Icon(
                                  Icons.skip_previous,
                                  color: Colors.white,
                                  size: 45,
                                ),
                          onPressed: playing.index == 0
                              ? () {}
                              : () async {
                                  await player.previous();
                                  if (isPlaying == false) {
                                    player.pause();
                                    //setState(() {});
                                  }
                                });
                    },
                  ),
                  //<----------------------------------------------------------Previous Play
                  //<--------------------------------------------------------------------------Play or Pause
                  IconButton(
                    icon: const Icon(Icons.replay_10, color: Colors.white),
                    onPressed: () async {
                      player.seekBy(
                        const Duration(seconds: -10),
                      );
                    },
                  ),
                  //<------------------------------------------------------------------Seeking backward 10 Seconds
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: PlayerBuilder.isPlaying(
                        player: player,
                        builder: (context, isPlaying) {
                          return IconButton(
                            onPressed: () {
                              player.playOrPause();
                            },
                            icon: Icon(
                              isPlaying == true
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            iconSize: 50,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ),
                  //<--------------------------------------------------------------------------Play or Pause
                  IconButton(
                    icon: const Icon(Icons.forward_10, color: Colors.white),
                    onPressed: () async {
                      player.seekBy(
                        const Duration(seconds: 10),
                      );
                    },
                  ),
                  //<------------------------------------------------------------------------------Seeking forward 10 sec

                  PlayerBuilder.isPlaying(
                    player: player,
                    builder: (context, isPlaying) {
                      return IconButton(
                        iconSize: 45,
                        icon:
                            playing.index == playing.playlist.audios.length - 1
                                ? Icon(
                                    Icons.skip_next,
                                    color: Colors.white.withOpacity(0.4),
                                    size: 45,
                                  )
                                : const Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                        onPressed:
                            playing.index == playing.playlist.audios.length - 1
                                ? () {}
                                : () async {
                                    await player.next();
                                    if (isPlaying == false) {
                                      player.pause();
                                      // setState(() {});
                                    }
                                  },
                      );
                    },
                  )

                  //<--------------------------------------------------------------------------------Play Next
                ],
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (isRepeat) {
                              player.setLoopMode(LoopMode.none);
                              isRepeat = false;
                            } else {
                              player.setLoopMode(LoopMode.single);
                              isRepeat = true;
                            }
                          },
                          icon: isRepeat == true
                              ? const Icon(Icons.repeat, color: Colors.blue)
                              : const Icon(
                                  Icons.repeat,
                                  color: Colors.white,
                                ),
                        ),
                        IconButton(
                          onPressed: () {
                            // setState(() {});
                            player.toggleShuffle();
                          },
                          icon: player.isShuffling.value
                              ? const Icon(
                                  Icons.shuffle,
                                  color: Colors.blue,
                                )
                              : const Icon(
                                  Icons.shuffle,
                                  color: Colors.white,
                                ),
                        ),
                      ]))
            ]),
          ));
    });
  }

  favoriteAdded(context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Song Added into Favourite',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  playlistAdded(context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Song Added into Playlist',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
