import 'package:store/utils/constants/image_strings.dart';

class CategoryModel {
  String image;
  String title;
  Function()? onTap;

  CategoryModel(this.image, this.title,this.onTap);
}

List<CategoryModel> categories = [
  CategoryModel(TImageString.bowlingImage, "Bowling",(){}),
  CategoryModel(TImageString.shoeImage, "Shoe",(){}),
  CategoryModel(TImageString.cosmeticsImage, "Costemetic",(){}),
  CategoryModel(TImageString.dogImage, "Dog",(){}),
  CategoryModel(TImageString.tailorsImage, "Tailors",(){}),
  CategoryModel(TImageString.toyCarImage, "Toy",(){}),
];
