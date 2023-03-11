import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/recentlyplayed.dart';

part 'recently_played_bloc_event.dart';
part 'recently_played_bloc_state.dart';

class RecentlyPlayedBlocBloc
    extends Bloc<RecentlyPlayedBlocEvent, RecentlyPlayedBlocState> {
  List<Audio> convertAudios = [];

  RecentlyPlayedBlocBloc() : super(RecentlyPlayedBlocInitial()) {
    on<Recently>((event, emit) {
      List<RecentPlayed> reSongs =
          recentlyplayedbox.values.toList().reversed.toList();
      return emit(
          RecentlyPlayedBlocState(convertedAudio: [], reSongs: reSongs));
    });
  }
}
