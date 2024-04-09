import 'package:bloc/bloc.dart';
import 'package:store/bloc/forgot_password/forgot_password_event.dart';
import 'package:store/bloc/forgot_password/forgot_password_state.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/utils/network/network_manager.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvents, ForgotPasswordState> {
  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>(_forgotPassword);
    on<ForgotPasswordResentEmailEvent>(_forgotPasswordResentEmail);
  }

  // ! forgot password
  _forgotPassword(
      ForgotPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    try {
      emit(ForgotPasswordLoading());
      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(ForgotPasswordError(
            "Network Error! Please check your internet connection."));
        TFullScreenLoader.stopLoading();
        return;
      }
      await authenticationRepository.forgotPasswordSendWithEmail(event.email);
      emit(ForgotPasswordSuccess(event.email));
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      emit(ForgotPasswordError(e.toString()));
    }
  }

  // ! reset forgot password
  _forgotPasswordResentEmail(ForgotPasswordResentEmailEvent event,
      Emitter<ForgotPasswordState> emit) async {
    try {
      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(ForgotPasswordError(
            "Network Error! Please check your internet connection."));
        TFullScreenLoader.stopLoading();
        return;
      }
      await authenticationRepository.forgotPasswordSendWithEmail(event.email);
      emit(ForgotPasswordSuccess(event.email));
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }
}
