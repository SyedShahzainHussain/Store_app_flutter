abstract class AuthenticationEvent {}

class CheckAuthentication extends AuthenticationEvent {}

class DeleteAccountEvent extends AuthenticationEvent {}

class DeleteReAuthenticatedEvent extends AuthenticationEvent {
  String email, password;
  DeleteReAuthenticatedEvent(this.email, this.password);
}
