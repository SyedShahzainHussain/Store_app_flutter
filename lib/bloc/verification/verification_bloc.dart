import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  VerificationBloc() : super(VerificationInitial()) {
    on<SendEmailVerificationEvent>(_sendemailVerification);
    on<SendEmailVerificationIntial>(_setTimerForAutoRedirect);
    on<CheckEmailVerifiedEvent>(_checkEmailVerificationStatus);
  }

  // ! Send email verification link to email
  Future<void> _sendemailVerification(SendEmailVerificationEvent events,
      Emitter<VerificationState> emit) async {
    try {
      await authenticationRepository.sendEmailVerification();
      emit(VerificationSent());
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
  }

  // ! Timer to automatically redirect to succes screen
  Future<void> _setTimerForAutoRedirect(SendEmailVerificationIntial events,
      Emitter<VerificationState> emit) async {
    await authenticationRepository.sendEmailVerification();
    emit(VerificationSent());

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
      }
    });
  }

  // ! Manually check if
  Future<void> _checkEmailVerificationStatus(
      CheckEmailVerifiedEvent event, Emitter<VerificationState> emit) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      emit(VerificationComplete());
    } else {
      emit(VerificationError(
        "Please Verify Your Account!",
      ));
    }
  }
}
