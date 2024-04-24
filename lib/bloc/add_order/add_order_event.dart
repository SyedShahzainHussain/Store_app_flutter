import 'package:store/features/shop/model/order_model/order_model.dart';

sealed class AddOrderEvent {}

class AddOrder extends AddOrderEvent {
  OrderModel orderModel;
  String userId;
  AddOrder(this.orderModel, this.userId);
}
