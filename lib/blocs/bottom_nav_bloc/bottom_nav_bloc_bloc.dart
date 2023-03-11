import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_bloc_event.dart';
part 'bottom_nav_bloc_state.dart';

class BottomNavBlocBloc extends Bloc<BottomNavBlocEvent, BottomNavBlocState> {
  BottomNavBlocBloc() : super(BottomNavBlocInitial()) {
    on<FirstScreen>((event, emit) {
      return emit(BottomNavBlocState(count: 0));
    });
    on<SecondScreen>((event, emit) {
      return emit(BottomNavBlocState(count: 1));
    });
    on<ThirdScreen>((event, emit) {
      return emit(BottomNavBlocState(count: 2));
    });
  }
}
