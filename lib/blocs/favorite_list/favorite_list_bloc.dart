import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/favourite.dart';

part 'favorite_list_event.dart';
part 'favorite_list_state.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  FavoriteListBloc() : super(FavoriteListInitial()) {
    on<InitializeFav>((event, emit) {
      List<FavSongs> favSongs = favsongbox.values.toList();
      return emit(FavoriteListState(favsongs: favSongs));
    });
  }
}
