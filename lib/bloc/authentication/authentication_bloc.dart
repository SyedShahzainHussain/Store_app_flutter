import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/bloc/authentication/authentication_events.dart';
import 'package:store/bloc/authentication/authentication_state.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<CheckAuthentication>(_checkAuthentication);
  }
  _checkAuthentication(
      CheckAuthentication event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInitialState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (user.emailVerified) {
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
}
