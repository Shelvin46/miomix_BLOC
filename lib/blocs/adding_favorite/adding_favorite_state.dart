part of 'adding_favorite_bloc.dart';

class AddingFavoriteState {
  bool addingORremoving;
  AddingFavoriteState({required this.addingORremoving});
}

class AddingFavoriteInitial extends AddingFavoriteState {
  AddingFavoriteInitial() : super(addingORremoving: false);
}
