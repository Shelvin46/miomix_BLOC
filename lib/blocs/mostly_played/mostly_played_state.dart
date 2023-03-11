part of 'mostly_played_bloc.dart';

class MostlyPlayedState {
  List<MostPlayed> mpSongs;
  MostlyPlayedState({required this.mpSongs});
}

class MostlyPlayedInitial extends MostlyPlayedState {
  MostlyPlayedInitial() : super(mpSongs: []);
}
