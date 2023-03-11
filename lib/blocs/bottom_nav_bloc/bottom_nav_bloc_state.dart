part of 'bottom_nav_bloc_bloc.dart';

class BottomNavBlocState {
  int? count;
  BottomNavBlocState({required this.count});
}

class BottomNavBlocInitial extends BottomNavBlocState {
  BottomNavBlocInitial() : super(count: 0);
}
