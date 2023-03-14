import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miomix/Models/allsonglist.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/playlistmpdel.dart';

part 'playlist_songs_event.dart';
part 'playlist_songs_state.dart';

class PlaylistSongsBloc extends Bloc<PlaylistSongsEvent, PlaylistSongsState> {
  PlaylistSongsBloc() : super(PlaylistSongsInitial()) {
    on<PlaylistSongsInitialP>((event, emit) {
      List<PlaylistSongs> values = playlistbox.values.toList();
      return emit(PlaylistSongsState(values: values));
    });
  }
}
