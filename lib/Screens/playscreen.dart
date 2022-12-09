import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:miomix/Models/allsonglist.dart';
import 'package:miomix/Screens/splashscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayScreen extends StatefulWidget {
  const MusicPlayScreen({super.key});

  @override
  State<MusicPlayScreen> createState() => _MusicPlayScreenState();
}

class _MusicPlayScreenState extends State<MusicPlayScreen> {
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;
  // bool isplaying = false;
  bool isRepeat = false;
  bool isNext = false;
  late List<Songs> dbsongs;
  final box = Songbox.getInstance();
  bool click = true;
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  @override
  void initState() {
    setState(() {});

    dbsongs = box.values.toList();
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return player.builderCurrent(builder: (context, playing) {
      // here we need to build the screen what we played from assetaudioplayer
      return Scaffold(
          backgroundColor: const Color.fromARGB(255, 23, 63, 97),
          body: Column(children: [
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
                IconButton(
                    onPressed: () {
                      setState(
                        () {
                          click = !click;
                        },
                      );
                      // favoriteAdded(context);
                    },
                    icon: Icon(
                      (click == false) ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 35,
                    )),
                IconButton(
                  onPressed: () {
                    // playlistAdded(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width1 * 0.0100, 0, 0, height1 * 0.00010),
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
                  final duration = realtimePlayingInfos.current!.audio.duration;
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
                                  setState(() {});
                                }
                              }

                        // onPressed: () async {
                        //   await player.seekBy(const Duration(seconds: -10));
                        // },
                        // icon: const Icon(Icons.replay_10),
                        // color: Colors.white,
                        // iconSize: 30,
                        );
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
                            isPlaying == true ? Icons.pause : Icons.play_arrow,
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
                      icon: playing.index == playing.playlist.audios.length - 1
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
                                    setState(() {});
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
                            setState(() {});
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
                                )),
                      const SizedBox(
                        width: 45,
                      ),
                      const SizedBox(
                        width: 45,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {});
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
          ]));
      //       child: const Icon(
      //         Icons.skip_previous,
      //         color: Colors.white,
      //         size: 50,
      //       ),
      //     ),
      //     const Icon(
      //       Icons.forward_10,
      //       color: Colors.white,
      //       size: 35,
      //     ),
      //     GestureDetector(
      //       onTap: () {
      //         // onPlay();
      //       },
      //       child: const CircleAvatar(
      //         radius: 25,
      //         child: Icon(
      //           Icons.play_arrow,
      //           size: 30,
      //         ),
      //       ),
      //     ),
      //     const Icon(
      //       Icons.forward_10,
      //       color: Colors.white,
      //       size: 35,
      //     ),
      //     const Icon(
      //       Icons.skip_next,
      //       color: Colors.white,
      //       size: 50,
      //     ),
      //   ],
      // ),
      // const SizedBox(
      //   height: 20,
      // ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.fromLTRB(
      //           width1 * 0.09, 0, 0, height1 * 0.00010),
      //       child: const Icon(
      //         Icons.repeat,
      //         color: Colors.white,
      //         size: 35,
      //       ),
      //     ),
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: width1 * 0.09),
      //       child: Row(
      //         children: const [
      //           Icon(
      //             Icons.shuffle,
      //             color: Colors.white,
      //             size: 35,
      //           ),
      //         ],
      //       ),
      //     )
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

  // onPlay() async {
  //   AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  //   assetsAudioPlayer.open(
  //     Audio(
  //       "assets/images/Audio/01. Chammak Challo.mp3",
  //     ),
  //   );
  // }
}
//how to pass music from  a list to playing screen?
















