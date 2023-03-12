part of 'search_bloc_bloc.dart';

@immutable
abstract class SearchBlocEvent {}

class InitializeSearch extends SearchBlocEvent {}

class UpdateSearch extends SearchBlocEvent {
  String query;
  UpdateSearch({required this.query});
}
