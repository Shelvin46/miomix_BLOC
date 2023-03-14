part of 'adding_playlist_bloc.dart';

class AddingPlaylistState {
  List<PlaylistSongs> pSongs;
  AddingPlaylistState({required this.pSongs});
}

class AddingPlaylistInitial extends AddingPlaylistState {
  AddingPlaylistInitial() : super(pSongs: []);
}
