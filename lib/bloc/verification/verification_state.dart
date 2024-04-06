part of 'verification_bloc.dart';

sealed class VerificationState {}

final class VerificationInitial extends VerificationState {}


class VerificationComplete extends VerificationState{}
class VerificationSent extends VerificationState{}


class VerificationError extends VerificationState {
  String message;
  VerificationError(this.message);
}
