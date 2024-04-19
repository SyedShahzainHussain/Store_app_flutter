import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String? id;
  String? image;
  String? name;
  int? productCount;
  bool? isFeatured;

  BrandModel({
    this.id,
    this.image,
    this.name,
    this.isFeatured,
    this.productCount,
  });

  toJson() {
    return {
      "Id": id,
      "Name": name,
      "Image": image,
      "ProductsCount": productCount,
      "IsFeatured": isFeatured,
    };
  }

  static BrandModel empty() => BrandModel(
      id: "", image: "", isFeatured: false, name: "", productCount: 0);

  factory BrandModel.fromJson(Map<String, dynamic> documents) {
    final data = documents;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data["Id"] ?? "",
      image: data["Image"] ?? "",
      isFeatured: data["IsFeatured"] ?? false,
      name: data["Name"] ?? "",
      productCount: (data["ProductsCount"] != null)
          ? int.parse((data["ProductsCount"] ?? 0).toString())
          : 0,
    );
  }
  factory BrandModel.fromDocument(QueryDocumentSnapshot<Object> documents) {
    final data = documents;
    return BrandModel(
      id: data["Id"] ?? "",
      image: data["Image"] ?? "",
      isFeatured: data["IsFeatured"] ?? false,
      name: data["Name"] ?? "",
      productCount: (data["ProductsCount"] != null)
          ? int.parse((data["ProductsCount"] ?? 0).toString())
          : 0,
    );
  }
  @override
  toString() {
    return "Id: $id Name: $name Image: $image ProductsCount: $productCount IsFeatured: $isFeatured";
  }
}
