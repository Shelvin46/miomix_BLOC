part of 'search_bloc_bloc.dart';

class SearchBlocState {
  List<Songs> dbSongs;
  List<Songs> searchResults;
  bool isNull;
  SearchBlocState(
      {required this.dbSongs,
      required this.searchResults,
      required this.isNull});
}

class SearchBlocInitial extends SearchBlocState {
  SearchBlocInitial() : super(dbSongs: [], searchResults: [], isNull: false);
}
