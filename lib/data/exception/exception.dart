class AppException implements Exception {
  final String? message;
  AppException([this.message]);

  @override
  String toString() {
    return "$message";
  }
}

class SFirebaseAuthException extends AppException {
  SFirebaseAuthException([super.message]);

  String get messages {
    switch (message) {
      case "email-already-in-use":
        return "The email address is already registered. Please use a different email.";
      case "invalid-email":
        return "The email address provided is invalid. Please enter a valid email.";
      case "weak-password":
        return "The password is to weak. Please choose a stronger password";
      case "user-disabled":
        return "This user account has been disabled. Please contact support for assistance.";
      case "user-not-found":
        return "Invalid login details. User not found.";
      case "wrong-password":
        return "Incorrect password. Please check your password and try again.";
      case "invalid-verification-code":
        return "Invalid verification code. Please enter a valid code.";
      case "invalid-verification-id":
        return "Invalid verification ID. Please request a new verification code";
      case "quota-exceeded":
        return "Quota exceeded. Please try again later.";
      case "email-already-exists":
        return "The email address already exists. Please use a different email";

      case "provider-already-linked":
        return "The account is already link with another provider.";
      case "requires-recent-login":
        return "This operation is sensitive and requires recent authentication. Please log in again";
      default:
        return message!;
    }
  }
}

class SFirebaseException extends AppException {
  SFirebaseException([super.message]);
}

class SFormatException extends AppException {
  SFormatException([super.message]);
}

class SPlatformException extends AppException {
  SPlatformException([super.message]);
}

class DatabaseAlreadyOpenException extends AppException {
  DatabaseAlreadyOpenException([super.message]);
}

class DatabaseExceptionMessage extends AppException {
  DatabaseExceptionMessage([super.message]);
}
class DatabaseIsNotOpen extends AppException {
  DatabaseIsNotOpen([super.message]);
}
