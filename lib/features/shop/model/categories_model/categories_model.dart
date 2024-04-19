import 'package:cloud_firestore/cloud_firestore.dart';
class CategoryModel {
  String id, name, image, parentId;
  bool isFeatured;
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  // ! Empty Helper Function
  static CategoryModel empty() => CategoryModel(
        id: "",
        name: "",
        image: "",
        isFeatured: false, 
        parentId: "",
      );

  // ! Map Json oriented document snapshot from firebase to usermodel
  factory CategoryModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data["Name"]??"",
        image: data["Image"]??"",
        isFeatured: data["IsFeatured"] ?? false,
        parentId: data["ParentId"] ?? "",
      );
    } else {
      return empty();
    }
  }
}
