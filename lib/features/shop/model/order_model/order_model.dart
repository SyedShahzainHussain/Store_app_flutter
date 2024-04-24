import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/features/personalizations/model/address_model/address_model.dart';
import 'package:store/features/shop/model/cart_item_model/cart_item_model.dart';
import 'package:store/utils/constants/enum.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? addressModel;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.userId = "",
    this.paymentMethod = "Paypal",
    this.addressModel,
    this.deliveryDate,
  });

  String get orderStatusText => status == OrderStatus.delivered
      ? "Delivered"
      : status == OrderStatus.shipped
          ? "Shipment on the way"
          : "Processing";

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "UserId": userId,
      "Status": status.toString(),
      "TotalAmount": totalAmount,
      "OrderDate": orderDate,
      "PaymentMethod": paymentMethod,
      "Address": addressModel!.toJson(),
      "DeliveryDate": deliveryDate,
      "Items": items.map((e) => e.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: data["Id"] as String,
      status:
          OrderStatus.values.firstWhere((e) => e.toString() == data["Status"]),
      totalAmount: data["TotalAmount"] as double,
      orderDate: (data["OrderDate"] as Timestamp).toDate(),
      userId: data["UserId"] as String,
      deliveryDate: data["DeliveryDate"] != null
          ? (data["DeliveryDate"] as Timestamp).toDate()
          : null,
      addressModel:
          AddressModel.fromJson(data["Address"] as Map<String, dynamic>),
      paymentMethod: data["PaymentMethod"] as String,
      items: (data["Items"] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
