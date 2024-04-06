import 'package:flutter/services.dart';
import 'package:store/data/exception/exception.dart';
import 'package:store/features/authentication/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  // ! Funtion to save user to firestore
  Future<void> saveUserRecord(UserModel userModel) async {
    try {
      await _db.collection("Users").doc(userModel.id).set(userModel.toJson());
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message!;
    } on FormatException catch (e) {
      throw SFormatException(e.message);
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message!;
    } catch (e) {
      throw "SomeThing went wrong. Please try again";
    }
  }
}
