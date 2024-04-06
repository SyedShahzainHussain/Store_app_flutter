import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitialLoading extends RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterError extends RegisterState {
  final String error;
  RegisterError(this.error);
  @override
  List<Object?> get props => [error];
}

class RegisterNetworkError extends RegisterState {}

class RegisterDone extends RegisterState {
  final String email;
   RegisterDone(this.email);
}
