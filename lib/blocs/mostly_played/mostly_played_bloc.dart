import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:meta/meta.dart';
import 'package:miomix/Models/dbfunction.dart';
import 'package:miomix/Models/mostlyplayed.dart';

part 'mostly_played_event.dart';
part 'mostly_played_state.dart';

class MostlyPlayedBloc extends Bloc<MostlyPlayedEvent, MostlyPlayedState> {
  MostlyPlayedBloc() : super(MostlyPlayedInitial()) {
    on<InitializeMost>((event, emit) {
      List<MostPlayed> mpSongs =
          mostlyplayedbox.values.toList().reversed.toList();
      return emit(MostlyPlayedState(mpSongs: mpSongs));
    });
  }
}
