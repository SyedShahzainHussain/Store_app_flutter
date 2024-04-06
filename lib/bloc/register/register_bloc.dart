import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/register/register_events.dart';
import 'package:store/bloc/register/register_state.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/data/repositories/user/user_repository.dart';
import 'package:store/features/authentication/model/user_model.dart';
import 'package:store/utils/network/network_manager.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

class RegisterBloc extends Bloc<RegisterationEvents, RegisterState> {
  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  UserRepository userRepository = UserRepository();
  RegisterBloc() : super(RegisterInitial()) {
    on<SignUpEvents>(_signupData);
  }

  // ! sign up data
  Future<void> _signupData(
      SignUpEvents events, Emitter<RegisterState> emit) async {
    try {
      // ! initial loading
      emit(RegisterInitialLoading());
      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(RegisterNetworkError());
        TFullScreenLoader.stopLoading();
        return;
      }

      // ! Register user in firebase  (sign up)
      final users = await authenticationRepository.signUpData(
          events.email.trim(), events.password.trim());

      // ! save user data to firestore
      final user = UserModel(
        id: users.user!.uid,
        userName: events.userName.trim(),
        firstName: events.firstName.trim(),
        lastName: events.lastName.trim(),
        email: events.email.trim(),
        phoneNumber: events.phoneNumber.trim(),
        profilePicture: "",
      );
      await userRepository.saveUserRecord(user);
      TFullScreenLoader.stopLoading();

      emit(RegisterDone(events.email.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      emit(RegisterError(e.toString()));
    }
  }
}
