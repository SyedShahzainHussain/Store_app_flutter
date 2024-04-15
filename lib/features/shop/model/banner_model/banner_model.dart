import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageUrl;
  final String targetScreen;
  final bool active;

  BannerModel(
      {required this.active,
      required this.imageUrl,
      required this.targetScreen});

  static BannerModel empty() =>
      BannerModel(active: false, imageUrl: "", targetScreen: "");

  factory BannerModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      return BannerModel(
        active: document['Active'] ?? false,
        imageUrl: document['ImageUrl'] ?? "",
        targetScreen: document["TargetScreen"] ?? "",
      );
    } else {
      return empty();
    }
  }
}
