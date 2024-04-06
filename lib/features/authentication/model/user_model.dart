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
}
