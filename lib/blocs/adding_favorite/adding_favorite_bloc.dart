import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'adding_favorite_event.dart';
part 'adding_favorite_state.dart';

class AddingFavoriteBloc
    extends Bloc<AddingFavoriteEvent, AddingFavoriteState> {
  AddingFavoriteBloc() : super(AddingFavoriteInitial()) {
    on<AddingOnpress>((event, emit) {
      return emit(AddingFavoriteState(addingORremoving: true));
    });
    on<Initial>((event, emit) {
      return emit(AddingFavoriteState(addingORremoving: false));
    });
  }
}
