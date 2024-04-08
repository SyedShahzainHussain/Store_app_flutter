import 'package:store/utils/format/format_utility.dart';

class UserModel {
  String id, userName, firstName, lastName, email, phoneNumber, profilePicture;

  UserModel({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      "uuid": id,
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture
    };
  }

  // Helper function to get the full name
  String get fullName => '$firstName $lastName';

  // Helper function to format phone number
  String get formattedPhone => TFormatUtils.formattedPhoneNumber(phoneNumber);

  // static function to split full name into first and last name
  static List<String> nameParts(String fullName) => fullName.split(" ");

  // static function to generate a username from the full Name
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "ssh_$camelCaseUsername";
    return usernameWithPrefix;
  }
}
