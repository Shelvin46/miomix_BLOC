import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miomix/Models/allsonglist.dart';
import 'package:miomix/Screens/searchscreen.dart';

part 'home_songs_event.dart';
part 'home_songs_state.dart';

class HomeSongsBloc extends Bloc<HomeSongsEvent, HomeSongsState> {
  List<Audio> convertAudios = [];
  List<Songs> dbSongs = box.values.toList();
  HomeSongsBloc() : super(HomeSongsInitial()) {
    on<Initialize>((event, emit) {
      List<Audio> convertedSongs = convertSongs();
      return emit(
          HomeSongsState(convertedAudios: convertedSongs, dbSongs: dbSongs));
    });
  }

  List<Audio> convertSongs() {
    for (var element in dbSongs) {
      convertAudios.add(Audio.file(
        element.songurl!,
        metas: Metas(
          title: element.songname,
          artist: element.artist,
          id: element.id.toString(),
        ),
      ));
    }
    return convertAudios;
  }
}
