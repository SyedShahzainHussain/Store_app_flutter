part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationEvent {}

class ChangeBottomIndexEvent extends BottomNavigationEvent {
  final int currentIndex;
  ChangeBottomIndexEvent(this.currentIndex);
}

class ChangeBottomIndexBackToZero extends BottomNavigationEvent {}
