import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/favourite.dart';
import 'package:miomix/Models/mostlyplayed.dart';
import 'package:miomix/Models/recentlyplayed.dart';
import 'package:miomix/Screens/splashscreen.dart';
import 'Models/allsonglist.dart';
import 'Models/playlistmpdel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();

  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname); //open the box for adding the songs
  runApp(const MyApp());
  Hive.registerAdapter(RecentPlayedAdapter());
  openrecentlyplayedDb(); //function for open the box recetly played

  Hive.registerAdapter(MostPlayedAdapter());
  openMostlyPlayedDb();

  Hive.registerAdapter(FavSongsAdapter());
  openFavouritePlayedDb();

  Hive.registerAdapter(PlaylistSongsAdapter());
  opendatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mio Mix',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}
//how to set widgetensuredbinding in flutter?
