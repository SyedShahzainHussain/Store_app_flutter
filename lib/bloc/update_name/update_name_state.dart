sealed class UpdateNameState {}

class UpdateNameInitial extends UpdateNameState {}

class UpdateNameSuccess extends UpdateNameState {}

class UpdateNameLoading extends UpdateNameState {}

class UpdateNameFailed extends UpdateNameState {
  String message;
  UpdateNameFailed(this.message);
}
