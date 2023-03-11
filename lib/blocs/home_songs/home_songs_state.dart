part of 'home_songs_bloc.dart';

class HomeSongsState {
  List<Audio> convertedAudios;
  List<Songs> dbSongs;
  HomeSongsState({required this.convertedAudios, required this.dbSongs});
}

class HomeSongsInitial extends HomeSongsState {
  HomeSongsInitial() : super(convertedAudios: [], dbSongs: []);
}
