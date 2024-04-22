import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/selected_address/selected_event.dart';
import 'package:store/bloc/selected_address/selected_state.dart';
import 'package:store/data/repositories/address/address_repository.dart';
import 'package:store/data/status/status.dart';

class SelectedAddressBloc
    extends Bloc<SelectedAddressEvent, SelectedAddressState> {
  AddressRepository addressRepository = AddressRepository();
  SelectedAddressBloc() : super(SelectedAddressState()) {
    on<SeletectAddress>(_seletedAddress);
  }

  Future<void> _seletedAddress(
      SeletectAddress event, Emitter<SelectedAddressState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      if (state.isAddressSeleted!.id!.isNotEmpty) {
        await addressRepository.updateSeletedAddressField(
            state.isAddressSeleted!.id!, false);
      }
      event.newAddressModel.selectedAddress = true;

      await addressRepository.updateSeletedAddressField(
          event.newAddressModel.id!, true);

      emit(state.copyWith(
          isAddressSeleted: event.newAddressModel, status: Status.success));
    } catch (e) {
      emit(state.copyWith(message: "Error in Seletection "));
    }
  }
}
