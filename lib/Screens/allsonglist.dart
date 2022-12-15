import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/favourite.dart';
import 'package:miomix/Playlists/allbottomfav.dart';
import 'package:miomix/Screens/playscreen.dart';
import 'package:miomix/favourites/favadd.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Models/allsonglist.dart';
import '../Models/mostlyplayed.dart';
import '../Models/recentlyplayed.dart';

class AllSongList extends StatefulWidget {
  const AllSongList({super.key});

  @override
  State<AllSongList> createState() => _AllSongListState();
}

class _AllSongListState extends State<AllSongList> {
  late bool isplaying;
  late bool playerVisibility;
  final box = Songbox.getInstance();
  List<Audio> convertAudios = [];
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  // List<MostPlayed> msongs =[];
  // msongs=MostPlayed(songname: , songurl: songurl, duration: duration, artist: artist, count: count, id: id)
//
  @override
  void initState() {
    List<Songs> dbSongs = box.values.toList();
    // creating object of Songs list

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

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<Box<Songs>>(
      valueListenable: box.listenable(),
      builder: (context, Box<Songs> data, child) {
        List<Songs> alls = data.values.toList();

        // MostPlayed msongs;
        // msongs = MostPlayed(
        //     songname: msongs.songname,
        //     songurl: msongs.songurl,
        //     duration: msongs.duration,
        //     artist: msongs.artist,
        //     count: msongs.count,
        //     id: msongs.id);

        // List<MostPlayed> allmostplayedsongs = mostlyplayedbox.values.toList();
        //here  assign all the songs
        List<MostPlayed> mostoftimeplayed = mostlyplayedbox.values.toList();

        if (alls.isEmpty) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: alls.length,
            itemBuilder: (context, index) {
              Songs songs = alls[index];
              MostPlayed MPsongs = mostoftimeplayed[index];
              RecentPlayed rsongs;
              //FavSongs fsongs;

              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 3),
                child: ListTile(
                  onTap: (() {
                    rsongs = RecentPlayed(
                        songname: songs.songname,
                        artist: songs.artist,
                        id: songs.id,
                        duration: songs.duration,
                        songurl: songs.songurl);
                    // updatePlayedSongCount(rsongs, index);
                    updateRecentlyPlayed(rsongs, index);
                    updatePlayedSongCount(MPsongs, index);

                    audioPlayer.open(
                        Playlist(audios: convertAudios, startIndex: index),
                        // showNotification: musicNotif,
                        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                        loopMode: LoopMode.playlist);
                    setState(() {});
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
                    id: songs.id!,
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
                      songs.songname!,
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
                      setState(() {});
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
//how to set favourite songlist in music player app using flutter?





