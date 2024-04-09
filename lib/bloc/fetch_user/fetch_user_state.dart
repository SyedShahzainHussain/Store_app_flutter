import 'package:equatable/equatable.dart';
import 'package:store/features/authentication/model/user_model.dart';

sealed class FetchUserState extends Equatable {}

class FetchUserInitial extends FetchUserState {
  @override
  List<Object?> get props => [];
}

class FetchUserLoaded extends FetchUserState {
  final UserModel user;

  FetchUserLoaded(this.user);

  @override
  List<Object?> get props => [user];

  
}

class FetchUserError extends FetchUserState {
  final String message;
  FetchUserError(this.message);
  @override
  List<Object?> get props => [message];
}
