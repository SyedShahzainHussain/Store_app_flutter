import 'package:equatable/equatable.dart';

sealed class FetchUserEvent extends Equatable {}

class FetchUser extends FetchUserEvent {
  @override
  List<Object?> get props => [];
}
