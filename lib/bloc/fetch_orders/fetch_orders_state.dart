import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/order_model/order_model.dart';

class FetchOrderState extends Equatable {
  final List<OrderModel> orderList;

  final Status status;
  final String message;

  const FetchOrderState({
    this.orderList = const [],
    this.status = Status.loading,
    this.message = "",
  });

  FetchOrderState copyWith({
    List<OrderModel>? orderList,
    Status? status,
    String? message,
  }) {
    return FetchOrderState(
      orderList: orderList ?? this.orderList,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [orderList, status, message];
}
