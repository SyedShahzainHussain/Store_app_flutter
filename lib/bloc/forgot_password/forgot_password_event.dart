sealed class ForgotPasswordEvents {}

class ForgotPasswordEvent extends ForgotPasswordEvents {
  String email;
  ForgotPasswordEvent(this.email);
}

class ForgotPasswordResentEmailEvent extends ForgotPasswordEvents {
    String email;
  ForgotPasswordResentEmailEvent(this.email);
}
