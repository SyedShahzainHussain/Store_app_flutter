sealed class AddOrderState {}

class AddOrdersInitialState extends AddOrderState {}

class AddOrdersLoadingState extends AddOrderState {}

class AddOrdersSuccessState extends AddOrderState {
  String? message;
  AddOrdersSuccessState({this.message});
}

class AddOrdersErrorState extends AddOrderState {
  String message;
  AddOrdersErrorState(this.message);
}
