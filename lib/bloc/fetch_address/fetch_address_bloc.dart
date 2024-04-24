import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_address/fetch_address_event.dart';
import 'package:store/bloc/fetch_address/fetch_address_state.dart';
import 'package:store/bloc/selected_address/selected_bloc.dart';
import 'package:store/data/repositories/address/address_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/personalizations/model/address_model/address_model.dart';
import 'package:store/utils/global_context/context_utils.dart';

class FetchAddressBloc extends Bloc<FetchAddressEvent, FetchAddressState> {
  AddressRepository addressRepository = AddressRepository();
  FetchAddressBloc() : super(const FetchAddressState()) {
    on<FetchAddress>(_fetchAddress);
  }
  Future<void> _fetchAddress(
      FetchAddress event, Emitter<FetchAddressState> emit) async {
    try {
      final List<AddressModel> addresses = await addressRepository.getAddress();
      final selectedAddress = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      emit(state.copyWith(
        addressList: List.from(addresses),
        status: Status.success,
        message: "Fetch Address Successfully",
      ));

      if (ContextUtility.context.mounted) {
        ContextUtility.context
            .read<SelectedAddressBloc>()
            .state
            .isAddressSeleted = selectedAddress;
      }
    } catch (e) {
      emit(state.copyWith(
        message: e.toString(),
        status: Status.failure,
        addressList: [],
      ));
    }
  }
}
