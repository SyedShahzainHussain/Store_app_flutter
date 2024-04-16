import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class FetchProductsState extends Equatable {
  final List<ProductModel> products;

  final Status status;
  final String message;

  const FetchProductsState(
      {this.message = "",
      this.products = const [],
      this.status = Status.loading});

  FetchProductsState copyWith({
    Status? status,
    String? message,
    List<ProductModel>? products,
  }) {
    return FetchProductsState(
      message: message ?? this.message,
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, message, products];
}
