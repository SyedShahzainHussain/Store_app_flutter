import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/personalizations/model/address_model/address_model.dart';

class FetchAddressState extends Equatable {
  final List<AddressModel> addressList;
  final Status status;
  final String message;
  const FetchAddressState({
    this.addressList = const [],
    this.status = Status.loading,
    this.message = "",
  });

  FetchAddressState copyWith({
    List<AddressModel>? addressList,
    Status? status,
    String? message,
  }) {
    return FetchAddressState(
      addressList: addressList ?? this.addressList,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        addressList,
        status,
        message,
      ];
}
