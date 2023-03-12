import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/favourite.dart';
import 'package:miomix/Models/mostlyplayed.dart';
import 'package:miomix/Models/recentlyplayed.dart';
import 'package:miomix/Screens/splashscreen.dart';
import 'package:miomix/blocs/adding_favorite/adding_favorite_bloc.dart';
import 'package:miomix/blocs/bloc/search_bloc_bloc.dart';
import 'package:miomix/blocs/bottom_nav_bloc/bottom_nav_bloc_bloc.dart';
import 'package:miomix/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:miomix/blocs/favorite_listing_home/favorite_listing_home_bloc.dart';
import 'package:miomix/blocs/home_songs/home_songs_bloc.dart';
import 'package:miomix/blocs/mostly_played/mostly_played_bloc.dart';
import 'package:miomix/blocs/recently_played_bloc/recently_played_bloc_bloc.dart';
import 'Models/allsonglist.dart';
import 'Models/nickname.dart';
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
  Hive.registerAdapter(nickNameAdapter());
  openname();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return BottomNavBlocBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return HomeSongsBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return RecentlyPlayedBlocBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return MostlyPlayedBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return AddingFavoriteBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return FavoriteListingHomeBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return FavoriteListBloc();
          },
        ),
        BlocProvider(
          create: (context) {
            return SearchBlocBloc();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mio Mix',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
//how to set widgetensuredbinding in flutter?
