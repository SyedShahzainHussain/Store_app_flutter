import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:store/data/exception/exception.dart';
import 'package:store/features/shop/model/banner_model/banner_model.dart';
import 'package:store/features/shop/model/categories_model/categories_model.dart';

class CategoriesRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final list = snapshot.docs
          .map((documents) => CategoryModel.fromSnapShot(documents))
          .toList();
      return list;
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).messages;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message!;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message!;
    } on FormatException catch (e) {
      throw SFormatException(e.message);
    } catch (e) {
      throw "SomeThing went wrong. Please try again.";
    }
  }

  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _db
          .collection(
            "Banners",
          )
          .where("Active", isEqualTo: true)
          .get();
      final list = snapshot.docs
          .map((documents) => BannerModel.fromJson(documents))
          .toList();
      return list;
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).messages;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message!;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message!;
    } on FormatException catch (e) {
      throw SFormatException(e.message);
    } catch (e) {
      throw "SomeThing went wrong. Please try again.";
    }
  }
}
