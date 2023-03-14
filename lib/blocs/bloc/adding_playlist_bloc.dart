import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/playlistmpdel.dart';

part 'adding_playlist_event.dart';
part 'adding_playlist_state.dart';

class AddingPlaylistBloc
    extends Bloc<AddingPlaylistEvent, AddingPlaylistState> {
  AddingPlaylistBloc() : super(AddingPlaylistInitial()) {
    on<PlaylistBottom>((event, emit) {
      List<PlaylistSongs> values = playlistbox.values.toList();
      return emit(AddingPlaylistState(pSongs: values));
    });
  }
}
