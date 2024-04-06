abstract class RegisterationEvents {}

class SignUpEvents extends RegisterationEvents {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String password;

  SignUpEvents({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    required this.userName,
  });
}
