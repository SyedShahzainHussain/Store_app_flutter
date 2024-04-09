sealed class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  String email;
  ForgotPasswordSuccess(this.email);

}

class ForgotPasswordError extends ForgotPasswordState {
  String message;
  ForgotPasswordError(this.message);
}
