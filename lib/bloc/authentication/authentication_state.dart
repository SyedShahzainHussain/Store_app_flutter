abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class OnBoardAuthenticatedState extends AuthenticationState {}

class OnBoardUnAuthenticatedState extends AuthenticationState {}

class AuthenticatedVerified extends AuthenticationState {}

class UnAuthenticatedVerified extends AuthenticationState {}
