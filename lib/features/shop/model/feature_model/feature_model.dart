import 'package:store/utils/constants/image_strings.dart';

class FeatureModel {
  String image;
  String title;
  String subTitle;
  Function()? onTap;

  FeatureModel(this.image, this.title, this.subTitle, this.onTap);
}

List<FeatureModel> featureBrands = [
  FeatureModel(TImageString.nikeIcon, "Nike", "256 Products", () {}),
  FeatureModel(TImageString.adidasIcon, "Adidas", "355 Products", () {}),
  FeatureModel(TImageString.ikeaIcon, "Ikea", "142 Products", () {}),
  FeatureModel(TImageString.kenwoodIcon, "Kenwood", "321 Products", () {}),
];
