part of 'on_board_controller_bloc.dart';

sealed class OnBoardControllerEvent {}

class OnBoardControllerPageChange extends OnBoardControllerEvent {
  int index;
  OnBoardControllerPageChange(this.index);
}

class OnBoardControllerSkipPage extends OnBoardControllerEvent {}

class OnBoardControllerNextPage extends OnBoardControllerEvent {}
