import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miomix/Models/allsonglist.dart';
import 'package:miomix/Screens/searchscreen.dart';

part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBlocBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBlocBloc() : super(SearchBlocInitial()) {
    on<InitializeSearch>((event, emit) {
      List<Songs> values = box.values.toList();
      return emit(
          SearchBlocState(dbSongs: values, searchResults: [], isNull: false));
    });
    on<UpdateSearch>((event, emit) {
      List<Songs> values = box.values.toList();
      List<Songs> filteredValue = values.where((element) {
        final songname = element.songname!.toLowerCase();
        // final course = element.course.toLowerCase();
        final query = event.query.toLowerCase();

        return songname.contains(query);
      }).toList();
      if (filteredValue.isEmpty) {
        return emit(
            SearchBlocState(dbSongs: [], searchResults: [], isNull: true));
      } else {
        return emit(SearchBlocState(
            dbSongs: [], searchResults: filteredValue, isNull: false));
      }
    });
  }
}
