import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/bloc/authentication/authentication_events.dart';
import 'package:store/bloc/authentication/authentication_state.dart';

import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/features/personalizations/view/profile/re_auth_login_form.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/local_storage/storage_utility.dart';
import 'package:store/utils/network/network_manager.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<CheckAuthentication>(_checkAuthentication);
    on<DeleteAccountEvent>(_deleteAccount);
    on<DeleteReAuthenticatedEvent>(_reAuthenticatedEmailAndPassword);
  }

  // ! check Authentication
  _checkAuthentication(
      CheckAuthentication event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInitialState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (user.emailVerified) {
          await LocalStorage.init(user.uid);
          if (ContextUtility.context.mounted) {
          }
          emit(AuthenticatedVerified());
        } else {
          emit(UnAuthenticatedVerified());
        }
      } else {
        // ! variable
        final deviceStorage = GetStorage();
        await authenticationRepository.onReady();
        final isFirstTime = await deviceStorage.read("IsFirstTime");

        if (isFirstTime) {
          emit(OnBoardUnAuthenticatedState());
        } else {
          emit(OnBoardAuthenticatedState());
        }
      }
    } catch (e) {
      emit(OnBoardUnAuthenticatedState());
    }
  }

  // ! delete account
  _deleteAccount(
      DeleteAccountEvent event, Emitter<AuthenticationState> emit) async {
    try {
      // ! initial loading
      emit(DeleteAccountLoading());
      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(AuthenticationError(
            "Network Error! Please check your internet connection."));
        TFullScreenLoader.stopLoading();
        return;
      }
      // ! First Re-authenticated user
      final auth = FirebaseAuth.instance;
      final provider =
          auth.currentUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // ! Re verify Auth Email
        if (provider == 'google.com') {
          await authenticationRepository.googleSignIn();
          await authenticationRepository.deleteAccount();
          TFullScreenLoader.stopLoading();
          emit(DeleteAccountSuccess());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          if (ContextUtility.context.mounted) {
            THelperFunction.navigatedToScreen(
                ContextUtility.context, const ReAuthLoginForm());
          }
        }
      } else {
        TFullScreenLoader.stopLoading();
        emit(AuthenticationError("Error Occured"));
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      emit(AuthenticationError(e.toString()));
    }
  }

  // ! re-authenticated before deleting
  Future<void> _reAuthenticatedEmailAndPassword(
      DeleteReAuthenticatedEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      // ! initial loading
      emit(DeleteAccountLoading());
      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(AuthenticationError(
            "Network Error! Please check your internet connection."));
        TFullScreenLoader.stopLoading();
        return;
      }
      await authenticationRepository.reAuthenticatedUserWithEmailAndPassword(
          event.email, event.password);
      await authenticationRepository.deleteAccount();
      TFullScreenLoader.stopLoading();
      emit(DeleteAccountSuccess());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      emit(AuthenticationError(e.toString()));
    }
  }
}
