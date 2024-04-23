import 'package:equatable/equatable.dart';
import 'package:store/features/shop/model/cart_item_model/cart_item_model.dart';

// ignore: must_be_immutable
class CartItemState extends Equatable {
  final int noOfCartItem;
  final double totalCartPrice;
  double productQuantityInCart;
  final List<CartItemModel> cartItem;

  CartItemState({
    this.noOfCartItem = 0,
    this.productQuantityInCart = 0.0,
    this.totalCartPrice = 0,
    this.cartItem = const [],
  });

  CartItemState copyWith({
    int? noOfCartItem,
    double? totalCartPrice,
    double? productQuantityInCart,
    List<CartItemModel>? cartItem,
  }) {
    return CartItemState(
      noOfCartItem: noOfCartItem ?? this.noOfCartItem,
      productQuantityInCart:
          productQuantityInCart ?? this.productQuantityInCart,
      totalCartPrice: totalCartPrice ?? this.totalCartPrice,
      cartItem: cartItem ?? this.cartItem,
    );
  }

  @override
  List<Object?> get props => [
        noOfCartItem,
        productQuantityInCart,
        totalCartPrice,
        cartItem,
      ];
}
