part of 'favorite_listing_home_bloc.dart';

class FavoriteListingHomeState {
  List<FavSongs> favSongs;
  FavoriteListingHomeState({required this.favSongs});
}

class FavoriteListingHomeInitial extends FavoriteListingHomeState {
  FavoriteListingHomeInitial() : super(favSongs: []);
}
