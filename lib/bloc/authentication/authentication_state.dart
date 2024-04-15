abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class OnBoardAuthenticatedState extends AuthenticationState {}

class OnBoardUnAuthenticatedState extends AuthenticationState {}

class AuthenticatedVerified extends AuthenticationState {}

class UnAuthenticatedVerified extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  String message;
  AuthenticationError(this.message);
}

class DeleteAccountSuccess extends AuthenticationState {}

class DeleteAccountLoading extends AuthenticationState {}
