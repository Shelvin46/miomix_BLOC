part of 'playlist_songs_bloc.dart';

class PlaylistSongsState {
  List<PlaylistSongs> values;
  PlaylistSongsState({required this.values});
}

class PlaylistSongsInitial extends PlaylistSongsState {
  PlaylistSongsInitial() : super(values: []);
}
