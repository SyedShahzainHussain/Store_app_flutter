part of 'bottom_navigation_bloc.dart';

@immutable
class BottomNavigationState extends Equatable {
  final int currentIndex;
  const BottomNavigationState({this.currentIndex = 0});

  BottomNavigationState copyWith({int? currentIndex}) {
    return BottomNavigationState(
        currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [currentIndex];
}
