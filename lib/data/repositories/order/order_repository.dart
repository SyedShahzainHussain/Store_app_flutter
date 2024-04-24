import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/features/shop/model/order_model/order_model.dart';

class OrderRepository {
  final _db = FirebaseFirestore.instance;

  Future<void> addOrder(OrderModel orderModel, String userId) async {
    try {
      await _db
          .collection("Users")
          .doc(userId)
          .collection("Orders")
          .add(orderModel.toJson());
    } catch (e) {
      throw "Something went wrong while saving order information. Try again later";
    }
  }

  Future<List<OrderModel>> fetchOrders() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      if (userId.isEmpty) {
        throw "Unable to find user information. Try again in few minutes";
      }

      final result =
          await _db.collection("Users").doc(userId).collection("Orders").get();
      return result.docs.map((e) => OrderModel.fromSnapShot(e)).toList();
    } catch (e) {
      throw "Something went wrong while saving order information. Try again later";
    }
  }
}
