part of 'recently_played_bloc_bloc.dart';

class RecentlyPlayedBlocState {
  List<Audio>? convertedAudio;
  List<RecentPlayed> reSongs;
  RecentlyPlayedBlocState(
      {required this.convertedAudio, required this.reSongs});
}

class RecentlyPlayedBlocInitial extends RecentlyPlayedBlocState {
  RecentlyPlayedBlocInitial() : super(convertedAudio: [], reSongs: []);
}
