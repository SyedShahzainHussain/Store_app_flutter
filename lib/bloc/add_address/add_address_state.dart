sealed class AddAddressState {}

class AddAddressInitialState extends AddAddressState {}

class AddAddressLoadingState extends AddAddressState {}

class AddAddressSuccessState extends AddAddressState {
  String? message;
  AddAddressSuccessState({this.message});
}

class AddAddressErrorState extends AddAddressState {
  String message;
  AddAddressErrorState(this.message);
}
