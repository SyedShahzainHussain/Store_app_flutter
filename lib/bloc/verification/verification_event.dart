part of 'verification_bloc.dart';

sealed class VerificationEvent {}


class SendEmailVerificationIntial extends VerificationEvent{}

class SendEmailVerificationEvent extends VerificationEvent{}

class CheckEmailVerifiedEvent extends VerificationEvent{}
