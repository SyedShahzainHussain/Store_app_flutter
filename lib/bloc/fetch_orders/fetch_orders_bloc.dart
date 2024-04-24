import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_orders/fetch_orders_event.dart';
import 'package:store/bloc/fetch_orders/fetch_orders_state.dart';
import 'package:store/data/repositories/order/order_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/order_model/order_model.dart';

class FetchOrderBloc extends Bloc<FetchOrderEvent, FetchOrderState> {
  OrderRepository orderRepository = OrderRepository();
  List<OrderModel> orderList = [];
  FetchOrderBloc() : super(const FetchOrderState()) {
    on<FetchOrder>(_fetchOrder);
  }

  _fetchOrder(FetchOrder event, Emitter<FetchOrderState> emit) async {
    try {
      
      // ! get all categories
      orderList = await orderRepository.fetchOrders();

      emit(
        state.copyWith(
            orderList: List.from(orderList),
            status: Status.success,
            message: "Orders Fetch Successfully"),
      );
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
        orderList: [],
      ));
    }
  }
}
