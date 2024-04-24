import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/add_order/add_order_event.dart';
import 'package:store/bloc/add_order/add_order_state.dart';
import 'package:store/bloc/cart_item/cart_item_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_event.dart';
import 'package:store/data/repositories/order/order_repository.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/network/network_manager.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

class AddOrderBloc extends Bloc<AddOrderEvent, AddOrderState> {
  OrderRepository orderRepository = OrderRepository();
  AddOrderBloc() : super(AddOrdersInitialState()) {
    on<AddOrder>(_addOrder);
  }

  Future<void> _addOrder(AddOrder event, Emitter<AddOrderState> emit) async {
    try {
      // ! Initial Loading
      emit(AddOrdersLoadingState());
      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(AddOrdersErrorState(
            "Network Error! Please check your internet connection."));
        TFullScreenLoader.stopLoading();
        return;
      }
      await orderRepository.addOrder(event.orderModel, event.userId);

      TFullScreenLoader.stopLoading();
      if (ContextUtility.context.mounted) {
        BlocProvider.of<CartItemBloc>(ContextUtility.context).add(ClearCart());
      }
      emit(AddOrdersSuccessState(message: "Fetch Orders Successfully"));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      emit(AddOrdersErrorState(e.toString()));
    }
  }
}
