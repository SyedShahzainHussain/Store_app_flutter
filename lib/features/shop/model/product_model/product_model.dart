import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/features/shop/model/brand_model/brand_model.dart';
import 'package:store/features/shop/model/product_attributes/product_attributes.dart';
import 'package:store/features/shop/model/product_variation/product_variation.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? time;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  String productType;
  List<ProductAttributeModel>? productAttributeModel;
  List<ProductVariationModel>? productVariationModel;
  List<String>? images;

  ProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.title,
    required this.productType,
    required this.images,
    this.sku,
    this.brand,
    this.time,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.salePrice = 0.0,
    this.productAttributeModel,
    this.productVariationModel,
  });

  static ProductModel empty() => ProductModel(
      id: '',
      stock: 0,
      price: 0.0,
      thumbnail: '',
      title: '',
      productType: '',
      images: []);

  factory ProductModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documents) {
    if (documents.data() == null) return ProductModel.empty();
    final data = documents.data()!;
    return ProductModel(
      id: documents.id,
      time: data["Time"],
      stock: data["Stock"] ?? "",
      price: double.parse((data["Price"] ?? 0).toString()),
      thumbnail: data["Thumbnail"] ?? "",
      title: data["Title"] ?? "",
      productType: data["ProductType"] ?? "",
      categoryId: data["CategoryId"] ?? "",
      description: data["Description"] ?? "",
      sku: data["SKU"] ?? "",
      salePrice: double.parse((data["SalePrice"] ?? 0.0).toString()),
      isFeatured: data["IsFeatured"] ?? false,
      productAttributeModel: (data["ProductAttributes"] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariationModel: (data["ProductVariation"] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
      brand: BrandModel.fromJson(data["Brand"]),
      images: data["Images"] != null ? List<String>.from(data["Images"]) : [],
    );
  }
}
