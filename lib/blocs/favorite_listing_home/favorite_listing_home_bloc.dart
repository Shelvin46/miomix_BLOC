import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/favourite.dart';

part 'favorite_listing_home_event.dart';
part 'favorite_listing_home_state.dart';

class FavoriteListingHomeBloc
    extends Bloc<FavoriteListingHomeEvent, FavoriteListingHomeState> {
  FavoriteListingHomeBloc() : super(FavoriteListingHomeInitial()) {
    on<FavoriteList>((event, emit) {
      List<FavSongs> favSongs = favsongbox.values.toList();
      return emit(FavoriteListingHomeState(favSongs: favSongs));
    });
  }
}
