import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/bloc/login/login_event.dart';
import 'package:store/bloc/login/login_state.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/utils/network/network_manager.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  LoginBloc() : super(LoginInitial()) {
    on<LoginWithEmailAndPasswordEvent>(_loginWithEmailPassword);
  }
  Future<void> _loginWithEmailPassword(
      LoginWithEmailAndPasswordEvent events, Emitter<LoginState> emit) async {
    try {
      // ! initial loading
      emit(LoginLoading());
      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(LoginError(
            "Network Error! Please check your internet connection."));
        TFullScreenLoader.stopLoading();
        return;
      }

      if (events.isRemember) {
        GetStorage localStorage = GetStorage();
        localStorage.write("REMEMBER_ME_EMAIL", events.email.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", events.password.trim());
      }

      // ! Login user in firebase (sign in)
      await authenticationRepository.loginInWithEmailAndPassword(
          events.email.trim(), events.password.trim());

      TFullScreenLoader.stopLoading();
      emit(LoginSuccess());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      emit(LoginError(e.toString()));
    }
  }
}
