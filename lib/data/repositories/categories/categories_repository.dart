import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:store/data/exception/exception.dart';
import 'package:store/features/shop/model/banner_model/banner_model.dart';
import 'package:store/features/shop/model/categories_model/categories_model.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class CategoriesRepository {
  final _db = FirebaseFirestore.instance;

  // ! Fetch All Categories
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

  // ! Fetch All Active Banners
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

  // ! Fetch All Feature Products
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db
          .collection(
            "Products",
          )
          .where("IsFeatured", isEqualTo: true)
          .limit(4)
          .get();
      final list = snapshot.docs
          .map((documents) => ProductModel.fromSnapShot(documents))
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

 
  // ! Get All Images from products and Variations
 static List<String> getAllProductImage(ProductModel productModel) {
    Set<String> images = {};
    // load thumbnail images
    images.add(productModel.thumbnail);

    // Get All Images from the product Variation if not null.
    if (productModel.images != null) {
      images.addAll(productModel.images!);
    }

    if (productModel.productVariationModel != null ||
        productModel.productVariationModel!.isNotEmpty) {
      images.addAll(productModel.productVariationModel!
          .map((variation) => variation.image));
    }
    return images.toList();
  }
}
