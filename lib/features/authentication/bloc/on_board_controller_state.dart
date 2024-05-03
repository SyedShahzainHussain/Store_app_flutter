part of 'on_board_controller_bloc.dart';

class OnBoardControllerState extends Equatable {
  final int currentPage;
  const OnBoardControllerState({this.currentPage = 0});
  OnBoardControllerState copyWith({int? currentPage}) {
    return OnBoardControllerState(currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object?> get props => [currentPage];
}
