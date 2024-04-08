import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/data/repositories/user/user_repository.dart';
import 'package:store/features/authentication/model/user_model.dart';

class ProviderRepository {
  // ! Save User Record from any Registration provider
  Future<void> saveUserData(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        // ! Convert name to first and last name
        final nameParts =
            UserModel.nameParts(userCredential.user?.displayName ?? "");
        final userName =
            UserModel.generateUsername(userCredential.user?.displayName ?? "");

        // ! Map data

        final user = UserModel(
          id: userCredential.user?.uid ?? "",
          userName: userName,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "",
          email: userCredential.user!.email ?? "",
          phoneNumber: userCredential.user?.phoneNumber ?? "",
          profilePicture: userCredential.user?.phoneNumber ?? "",
        );

        // ! Save User
        UserRepository userRepository = UserRepository();
        await userRepository.saveUserRecord(user);
      }
    } catch (_) {
      throw "Data not saved \n Something went wrong while saving your information. You can re-save your data in your Profile.";
    }
  }
}
