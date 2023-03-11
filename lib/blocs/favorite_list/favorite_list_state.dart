part of 'favorite_list_bloc.dart';

class FavoriteListState {
  List<FavSongs> favsongs;
  FavoriteListState({required this.favsongs});
}

class FavoriteListInitial extends FavoriteListState {
  FavoriteListInitial() : super(favsongs: []);
}
