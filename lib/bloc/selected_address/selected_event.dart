import 'package:store/features/personalizations/model/address_model/address_model.dart';

sealed class SelectedAddressEvent {}

class SeletectAddress extends SelectedAddressEvent {
  final AddressModel newAddressModel;
  SeletectAddress(this.newAddressModel);
}
