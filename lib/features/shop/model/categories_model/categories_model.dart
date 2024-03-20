import 'package:store/features/shop/view/subCategory/sub_category.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String image;
  String title;
  Function(BuildContext?)? onTap;

  CategoryModel(this.image, this.title, this.onTap);
}

List<CategoryModel> categories = [
  CategoryModel(TImageString.bowlingImage, "Bowling", (context) {
    THelperFunction.navigatedToScreen(context!, const SubCategory());
  }),
  CategoryModel(TImageString.shoeImage, "Shoe", (context) {}),
  CategoryModel(TImageString.cosmeticsImage, "Costemetic", (context) {}),
  CategoryModel(TImageString.dogImage, "Dog", (context) {}),
  CategoryModel(TImageString.tailorsImage, "Tailors", (context) {}),
  CategoryModel(TImageString.toyCarImage, "Toy", (context) {}),
];
