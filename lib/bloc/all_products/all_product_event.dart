import 'package:store/features/shop/model/product_model/product_model.dart';

sealed class AllProductsEvents {}

class GetAllProduct extends AllProductsEvents {}

class SortProducts extends AllProductsEvents {
  final String? sortOption;
  final List<ProductModel> productModel;
  SortProducts(this.sortOption, this.productModel);
}
