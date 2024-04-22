import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/features/personalizations/model/address_model/address_model.dart';

class AddressRepository {
  final _db = FirebaseFirestore.instance;

  Future<String> addAddress(AddressModel addressModel) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final currentAddress = await _db
          .collection("Users")
          .doc(userId)
          .collection("Address")
          .add(addressModel.toJson());
      return currentAddress.id;
    } catch (e) {
      throw "Something went wrong while saving address information. Try again later";
    }
  }

  Future<List<AddressModel>> getAddress() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      if (userId.isEmpty) throw "Unable to find user Information";
      final result =
          await _db.collection("Users").doc(userId).collection("Address").get();
      if (result.docs.isEmpty) {
        return [];
      }
      return result.docs.map((e) => AddressModel.fromDocument(e)).toList();
    } catch (e) {
      throw "Something went wrong while saving address information. Try again later";
    }
  }

  Future<void> updateSeletedAddressField(
      String addressId, bool selected) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      if (userId.isEmpty) throw "Unable to find user Information";
      await _db
          .collection("Users")
          .doc(userId)
          .collection("Address")
          .doc(addressId)
          .update({"SelectedAddress": selected});
    } catch (e) {
      throw "Something went wrong while saving address information. Try again later";
    }
  }
}
