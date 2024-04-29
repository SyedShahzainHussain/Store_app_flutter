import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const BottomNavigationState()) {
    on<ChangeBottomIndexEvent>(_changeBottomIndex);
    on<ChangeBottomIndexBackToZero>(_changeBottomIndexBackToZero);
  }

  _changeBottomIndex(
      ChangeBottomIndexEvent event, Emitter<BottomNavigationState> emit) {
    int currentIndex = state.currentIndex;
    currentIndex = event.currentIndex;
    emit(state.copyWith(currentIndex: currentIndex));
  }

  _changeBottomIndexBackToZero(
      ChangeBottomIndexBackToZero event, Emitter<BottomNavigationState> emit) {
    int currentIndex = state.currentIndex;
    currentIndex = 0;
    emit(state.copyWith(currentIndex: currentIndex));
  }
}
