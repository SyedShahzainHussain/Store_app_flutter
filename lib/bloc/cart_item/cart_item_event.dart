import 'package:equatable/equatable.dart';
import 'package:store/bloc/variation/variation_state.dart';
import 'package:store/features/shop/model/cart_item_model/cart_item_model.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/features/shop/model/product_variation/product_variation.dart';

sealed class CartItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddItemToCart extends CartItemEvent {
  final ProductModel productModel;
  final VariationState selectedVariation;
  AddItemToCart(this.productModel, this.selectedVariation);
  @override
  List<Object?> get props => [productModel];
}

class IncrementProduct extends CartItemEvent {
  final CartItemModel cartItemModel;
  IncrementProduct(this.cartItemModel);
  @override
  List<Object?> get props => [cartItemModel];
}

class DecrementProduct extends CartItemEvent {
  final CartItemModel cartItemModel;
  DecrementProduct(this.cartItemModel);
  @override
  List<Object?> get props => [cartItemModel];
}

class UpdateProductCount extends CartItemEvent {
  final ProductModel productModel;
  final ProductVariationModel selectedVariation;
  UpdateProductCount(this.productModel, this.selectedVariation);
}

class AddProductCount extends CartItemEvent {
  AddProductCount();
}

class DeleteProductCount extends CartItemEvent {
  DeleteProductCount();
}
