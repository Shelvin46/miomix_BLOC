part of 'adding_favorite_bloc.dart';

@immutable
abstract class AddingFavoriteEvent {}

class AddingOnpress extends AddingFavoriteEvent {}

class Initial extends AddingFavoriteEvent {}
