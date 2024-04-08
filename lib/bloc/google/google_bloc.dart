import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/google/google_events.dart';
import 'package:store/bloc/google/google_state.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/data/repositories/provider/provider_repository.dart';
import 'package:store/utils/network/network_manager.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvents, GoogleAuthState> {
  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  ProviderRepository providerRepository = ProviderRepository();
  GoogleAuthBloc() : super(GoogleAuthInitial()) {
    on<GoogleAuthLoginEvents>(_signInWithGoogle);
  }
  Future<void> _signInWithGoogle(
      GoogleAuthEvents events, Emitter<GoogleAuthState> emit) async {
    try {
      emit(GoogleAuthLoading());
      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(GoogleAuthError(
            "Network Error! Please check your internet connection."));
        TFullScreenLoader.stopLoading();
        return;
      }
      // ! Login user with google sign in
      final users = await authenticationRepository.googleSignIn();

      // ! Save User
      await providerRepository.saveUserData(users);
      TFullScreenLoader.stopLoading();
      emit(GoogleAuthSuccess());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      emit(GoogleAuthError(e.toString()));
    }
  }
}
