// ignore_for_file: camel_case_types, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Screens/bottomnav.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Models/allsonglist.dart';
import '../Models/mostlyplayed.dart';
// late Box<Songs> dbSongs;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final audioQuery = OnAudioQuery();
final box = Songbox
    .getInstance(); //this is the copy of songbox it contain all songs of Songs class.

List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];

// late Box<Songs> dbsongs;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    requestStoragePermission();
    goto();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 63, 97),
      body: SafeArea(
        child: Center(
          child: CircleAvatar(
            radius: 120,
            backgroundImage: AssetImage("assets/images/studio.png"),
          ),
        ),
      ),
    );
  }

  requestStoragePermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    //here we checking the permission status if it is false we need to request to access our internal storage musics
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();

      fetchSongs = await audioQuery.querySongs();
      //here we fetching the songs from our internal storage
      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
          //here we add all songs into database.
        }
      }
      for (var element in allSongs) {
        mostlyplayedbox.add(
          MostPlayed(
            songname: element.title,
            songurl: element.uri!,
            duration: element.duration!,
            artist: element.artist!,
            count: 0,
            id: element.id,
          ),
        );
      }

      allSongs.forEach((element) {
        box.add(
          Songs(
            songname: element.title,
            artist: element.artist,
            duration: element.duration,
            id: element.id,
            songurl: element.uri,

            //here each songs are added into the database
          ),
        );
      });
    }
  }

  goto() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (contxt) => const BottomScreen()));
  }
}
//how to fetch music from internal storage? in flutter?














