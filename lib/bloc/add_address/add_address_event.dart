import 'package:store/features/personalizations/model/address_model/address_model.dart';

sealed class AddAddressEvent {}

class AddAddress extends AddAddressEvent {
  final AddressModel addressModel;
  AddAddress(this.addressModel);
}
