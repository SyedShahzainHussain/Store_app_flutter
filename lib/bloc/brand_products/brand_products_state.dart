import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class BrandProductsState extends Equatable {
  final List<ProductModel> brandProducts;
  final Status status;
  final String message;

  const BrandProductsState({
    this.brandProducts = const [],
    this.status = Status.loading,
    this.message = "",
  });

  BrandProductsState copyWith({
    List<ProductModel>? brandProducts,
    Status? status,
    String? message,
  }) {
    return BrandProductsState(
      brandProducts: brandProducts ?? this.brandProducts,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [brandProducts, status, message];
}
