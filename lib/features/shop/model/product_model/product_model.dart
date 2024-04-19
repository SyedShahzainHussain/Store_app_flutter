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
        images: [],
        productAttributeModel: [],
        productVariationModel: [],
        categoryId: "",
        description: "",
        brand: BrandModel.empty(),
        isFeatured: false,
        salePrice: 0.0,
        sku: "",
        time: null,
      );

  factory ProductModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documents) {
    if (documents.data() == null) return ProductModel.empty();
    final data = documents.data()!;
    return ProductModel(
      id: documents.id,
      time: data["Time"] ?? DateTime.now(),
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
      productAttributeModel: (data["ProductAttributes"] != null)
          ? (data["ProductAttributes"] as List<dynamic>)
              .map((e) => ProductAttributeModel.fromJson(e))
              .toList()
          : [],
      productVariationModel: (data["ProductVariation"] != null)
          ? (data["ProductVariation"] as List<dynamic>)
              .map((e) => ProductVariationModel.fromJson(e))
              .toList()
          : [],
      brand: (data["Brand"] != null)
          ? BrandModel.fromJson(data["Brand"])
          : BrandModel.empty(),
      images: data["Images"] != null ? List<String>.from(data["Images"]) : [],
    );
  }
  factory ProductModel.fromDocuments(QueryDocumentSnapshot<Object?> documents) {
    final data = documents.data() as Map<String, dynamic>;
    return ProductModel(
      id: documents.id,
      time: data["Time"] ?? DateTime.now(),
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
      productAttributeModel: (data["ProductAttributes"] != null)
          ? (data["ProductAttributes"] as List<dynamic>)
              .map((e) => ProductAttributeModel.fromJson(e))
              .toList()
          : [],
      productVariationModel: (data["ProductVariation"] != null)
          ? (data["ProductVariation"] as List<dynamic>)
              .map((e) => ProductVariationModel.fromJson(e))
              .toList()
          : [],
      brand: (data["Brand"] != null)
          ? BrandModel.fromJson(data["Brand"])
          : BrandModel.empty(),
      images: data["Images"] != null ? List<String>.from(data["Images"]) : [],
    );
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, title: $title, stock: $stock, price: $price, salePrice: $salePrice, thumbnail: $thumbnail, productType: $productType, isFeatured: $isFeatured, brand: ${brand?.toString()}, description: $description, categoryId: $categoryId, sku: $sku, time: $time, productAttributes: ${productAttributeModel?.toString()}, productVariations: ${productVariationModel?.toString()}, images: $images}';
  }
}
