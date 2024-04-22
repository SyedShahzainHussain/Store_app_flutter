import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/personalizations/model/address_model/address_model.dart';

// ignore: must_be_immutable
class SelectedAddressState extends Equatable {
  AddressModel? isAddressSeleted = AddressModel.empty();
  final Status? status;
  final String message;
  SelectedAddressState(
      {this.status, this.message = "", this.isAddressSeleted});

  SelectedAddressState copyWith(
      {List<AddressModel>? addressList,
      Status? status,
      String? message,
      AddressModel? isAddressSeleted}) {
    return SelectedAddressState(
        status: status ?? this.status,
        message: message ?? this.message,
        isAddressSeleted: isAddressSeleted ?? this.isAddressSeleted);
  }

  @override
  List<Object?> get props => [status, message, isAddressSeleted];
}
