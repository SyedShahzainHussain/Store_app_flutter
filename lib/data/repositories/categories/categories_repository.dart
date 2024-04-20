import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:store/data/exception/exception.dart';
import 'package:store/features/shop/model/banner_model/banner_model.dart';
import 'package:store/features/shop/model/brand_model/brand_model.dart';
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

  // ! Fetch All Feature Brands
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db
          .collection(
            "Brands",
          )
          .get();
      final list = snapshot.docs
          .map((documents) => BrandModel.fromDocument(documents))
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

  // ! Get Products based on the query
  Future<List<ProductModel>> fetchProductQuery(Query query) async {
    try {
      final snapshot = await query.get();
      final List<ProductModel> product = snapshot.docs
          .map((documents) => ProductModel.fromDocuments(documents))
          .toList();
      return product;
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

  // ! Get Products based on the brand Id
  Future<List<ProductModel>> getProductForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection("Products")
              .where("Brand.Id", isEqualTo: brandId)
              .get()
          : await _db
              .collection("Products")
              .where("Brand.Id", isEqualTo: brandId)
              .limit(limit)
              .get();
      final products = querySnapshot.docs
          .map((document) => ProductModel.fromDocuments(document))
          .toList();
      return products;
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

  // ! Future get brand Id from products collection based on the category Id
  Future<List<BrandModel>> getBrandBasedCategoryId({
    required String categoryId,
  }) async {
    try {
      final querySnapshot = await _db
          .collection("Products")
          .where("CategoryId", isEqualTo: categoryId)
          .get();

      List<String> brandIds = querySnapshot.docs
          .map((document) => (document["Brand"]["Id"] as String))
          .toList();

      if (brandIds.isEmpty) {
        // If there are no brand IDs, return an empty list immediately
        return [];
      }
      final brandQuery = await _db
          .collection("Brands")
          .where("Id", whereIn: brandIds)
          .limit(2)
          .get();

      List<BrandModel> brands =
          brandQuery.docs.map((docs) => BrandModel.fromDocument(docs)).toList();
      return brands;
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

  // ! get product of specific category
  Future<List<ProductModel>> getProductSpecifidCategory(
      {required String categoryId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection("Products")
              .where("CategoryId", isEqualTo: categoryId)
              .get()
          : await _db
              .collection("Products")
              .where("CategoryId", isEqualTo: categoryId)
              .limit(limit)
              .get();
      final products = querySnapshot.docs
          .map((document) => ProductModel.fromDocuments(document))
          .toList();
      if (products.isEmpty) {
        return [];
      }
      return products;
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

  // ! Get Products based on the query
  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productsId) async {
    try {
      final snapshot = await _db
          .collection("Products")
          .where(FieldPath.documentId, whereIn: productsId)
          .get();
      final List<ProductModel> product = snapshot.docs
          .map((documents) => ProductModel.fromSnapShot(documents))
          .toList();
      return product;
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

  // ! Get Sub Category
  Future<List<CategoryModel>> getSubCategory(String categoryId) async {
    try {
      final snapshot = await _db
          .collection("Categories")
          .where("ParentId", isEqualTo: categoryId)
          .get();
      final List<CategoryModel> product = snapshot.docs
          .map((documents) => CategoryModel.fromSnapShot(documents))
          .toList();
      return product;
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
