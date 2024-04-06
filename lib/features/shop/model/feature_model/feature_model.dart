import 'package:flutter/material.dart';
import 'package:store/common/widgets/brands/brands_porducts.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/helper/helper_function.dart';

class FeatureModel {
  String image;
  String title;
  String subTitle;
  Function(BuildContext)? onTap;

  FeatureModel(this.image, this.title, this.subTitle, this.onTap);
}

List<FeatureModel> featureBrands = [
  FeatureModel(TImageString.nikeIcon, "Nike", "256 Products", (context) {
    THelperFunction.navigatedToScreen(context, const BrandsProducts());
  }),
  FeatureModel(TImageString.adidasIcon, "Adidas", "355 Products", (context) {}),
  FeatureModel(TImageString.ikeaIcon, "Ikea", "142 Products", (context) {}),
  FeatureModel(TImageString.kenwoodIcon, "Kenwood", "321 Products", (context) {}),
];
