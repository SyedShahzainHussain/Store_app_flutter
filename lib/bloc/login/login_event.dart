sealed class LoginEvents {}

class LoginWithEmailAndPasswordEvent extends LoginEvents {
  String email, password;
  bool isRemember;
  LoginWithEmailAndPasswordEvent(this.email, this.password, this.isRemember);
}
