import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/add_address/add_address_event.dart';
import 'package:store/bloc/add_address/add_address_state.dart';
import 'package:store/bloc/selected_address/selected_bloc.dart';
import 'package:store/data/repositories/address/address_repository.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/network/network_manager.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddressRepository addressRepository = AddressRepository();
  AddAddressBloc() : super(AddAddressInitialState()) {
    on<AddAddress>(_addAddress);
  }

  Future<void> _addAddress(
      AddAddress events, Emitter<AddAddressState> emit) async {
    try {
      // ! Initial Loading
      emit(AddAddressLoadingState());
      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(AddAddressErrorState(
            "Network Error! Please check your internet connection."));
        TFullScreenLoader.stopLoading();
        return;
      }

      final data = await addressRepository.addAddress(events.addressModel);
      if (ContextUtility.context.mounted) {
        ContextUtility.context
            .read<SelectedAddressBloc>()
            .state
            .isAddressSeleted!
            .id = data;
      }
      TFullScreenLoader.stopLoading();
      emit(AddAddressSuccessState());
    } catch (e) {
      emit(AddAddressErrorState(e.toString()));
    }
  }
}
