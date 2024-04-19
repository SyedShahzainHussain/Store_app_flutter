import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class FavouriteState extends Equatable {
  final Map<String, dynamic> favourite;
  final List<ProductModel> whishListProducts;
  final Status status;
  final String message;
  const FavouriteState(
      {this.favourite = const {},
      this.whishListProducts = const [],
      this.status = Status.loading,
      this.message = ""});

  FavouriteState copyWith(
      {Map<String, dynamic>? favourite,
      List<ProductModel>? whishListProducts,
      Status? status,
      String? message}) {
    return FavouriteState(
        favourite: favourite ?? this.favourite,
        whishListProducts: whishListProducts ?? this.whishListProducts,
        message: message ?? this.message,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [favourite, whishListProducts, status, message];
}
