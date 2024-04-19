import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class AllProductState extends Equatable {
  final List<ProductModel> productModel;
  final List<ProductModel> sortedProduct;
  final String seletedSortOption;

  final Status status;
  final String message;

  const AllProductState(
      {this.status = Status.loading,
      this.productModel = const [],
      this.sortedProduct = const [],
      this.message = "",
      this.seletedSortOption = ""});

  AllProductState copyWith(
      {List<ProductModel>? productModel,
      Status? status,
      String? message,
      List<ProductModel>? sortedProduct,
      String? seletedSortOption}) {
    return AllProductState(
        productModel: productModel ?? this.productModel,
        status: status ?? this.status,
        sortedProduct: sortedProduct ?? this.sortedProduct,
        message: message ?? this.message,
        seletedSortOption: seletedSortOption ?? this.seletedSortOption);
  }

  @override
  List<Object?> get props => [productModel, status, message, sortedProduct,seletedSortOption];
}
