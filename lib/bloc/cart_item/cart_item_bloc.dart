import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_event.dart';
import 'package:store/bloc/cart_item/cart_item_state.dart';
import 'package:store/bloc/variation/variation_bloc.dart';
import 'package:store/bloc/variation/variation_events.dart';
import 'package:store/bloc/variation/variation_state.dart';
import 'package:store/features/shop/model/cart_item_model/cart_item_model.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/features/shop/model/product_variation/product_variation.dart';
import 'package:store/utils/constants/enum.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/local_storage/storage_utility.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  CartItemBloc() : super(CartItemState()) {
    on<AddItemToCart>(_addItemCart);
    on<IncrementProduct>(_addOneToCart);
    on<DecrementProduct>(_removeOneFromCart);
    on<AddProductCount>(_addProductCount);
    on<DeleteProductCount>(_deleteProductCount);
    on<UpdateProductCount>(_updateAlreadyAddedProductCount);
  }

  // ! add item in cart Bag
  Future<void> _addItemCart(
      AddItemToCart event, Emitter<CartItemState> emit) async {
    final variation = event.selectedVariation.selectedVariation ??
        ProductVariationModel.empty();
    // ! check productQuantity
    if (state.productQuantityInCart < 1) {
      THelperFunction.showToaster(message: "Selected Quantity");
      return;
    }
    // ! check selectionVariation
    if (event.productModel.productType == ProductType.variable.toString() &&
        variation.id.isEmpty) {
      THelperFunction.showToaster(message: "Selected Variation");
      return;
    }

    // ! Out of Status
    if (event.productModel.productType == ProductType.variable.toString()) {
      if (variation.stock < 1) {
        THelperFunction.showToaster(
            message: "Selected Variation is out of stock.");
        return;
      }
    } else {
      if (event.productModel.stock < 1) {
        THelperFunction.showToaster(
            message: "Selected Product is out of stock ");
        return;
      }
    }

    // ! Convert the product to a cartModel with the given quantity
    final selectedCartItems = convertCartItem(
      event.productModel,
      state.productQuantityInCart.toInt(),
      event.selectedVariation,
    );

    int index = state.cartItem.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItems.productId &&
        cartItem.variationId == selectedCartItems.variationId);

    // ! Create a new list of cart items with the updated quantity or adding a new item
    final updatedCartItems = List<CartItemModel>.from(state.cartItem);
    if (index >= 0) {
      // * This product is already added so we increase the quantity
      updatedCartItems[index].quantity = selectedCartItems.quantity;
    } else {
      // * Add the new product to the cart
      updatedCartItems.add(selectedCartItems);
    }

    emit(state.copyWith(cartItem: List.from(updatedCartItems)));
    // * update total amount and cartItem
    updateCartTotal(updatedCartItems, state.cartItem, emit);
    // * save cart item
    saveCartItem(updatedCartItems);
    THelperFunction.showToaster(
        message: "Your Product has been added to the Cart.");
  }

  // ! add one Item to Cart
  void _addOneToCart(IncrementProduct event, Emitter<CartItemState> emit) {
    final updatedCartItems = List<CartItemModel>.from(state.cartItem);
    int index = updatedCartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == event.cartItemModel.productId &&
          cartItem.variationId == event.cartItemModel.variationId,
    );

    if (index >= 0) {
      updatedCartItems[index].quantity += 1;
    } else {
      updatedCartItems.add(event.cartItemModel);
    }
    updateCartTotal(updatedCartItems, state.cartItem, emit);
    saveCartItem(updatedCartItems);
    emit(state.copyWith(cartItem: List.from(updatedCartItems)));
  }

  // ! remove one Item to Cart
  void _removeOneFromCart(
      DecrementProduct event, Emitter<CartItemState> emit) async {
    final updatedCartItems = List<CartItemModel>.from(state.cartItem);
    int index = updatedCartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == event.cartItemModel.productId &&
          cartItem.variationId == event.cartItemModel.variationId,
    );

    if (index >= 0) {
      if (updatedCartItems[index].quantity > 1) {
        updatedCartItems[index].quantity -= 1;
      } else {
        bool? confirmRemove =
            await removeFromCartDialog(index, emit, updatedCartItems);
        if (confirmRemove!) {
          updatedCartItems.removeAt(index);
        }
      }
    }
    updateCartTotal(updatedCartItems, state.cartItem, emit);
    saveCartItem(updatedCartItems);
    emit(state.copyWith(cartItem: List.from(updatedCartItems)));
  }

  // ! add Product Count
  void _addProductCount(AddProductCount event, Emitter<CartItemState> emit) {
    double newQuantity = state.productQuantityInCart + 1.0;
    emit(state.copyWith(productQuantityInCart: newQuantity));
  }

  // ! delete Product Count
  void _deleteProductCount(
      DeleteProductCount event, Emitter<CartItemState> emit) {
    if (state.productQuantityInCart > 0) {
      double newQuantity = state.productQuantityInCart - 1.0;
      emit(state.copyWith(productQuantityInCart: newQuantity));
    }
  }

  // ! Convert Product to CartItemModel
  CartItemModel convertCartItem(
      ProductModel product, int quantity, VariationState variationState) {
    if (product.productType == ProductType.single.toString()) {
      BlocProvider.of<VariationBloc>(ContextUtility.context)
          .add(ClearVariation());
    }
    final variation =
        variationState.selectedVariation ?? ProductVariationModel.empty();
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      quantity: quantity,
      price: price,
      brandName: product.brand != null ? product.brand!.name : "",
      image: isVariation ? variation.image : product.thumbnail,
      variationId: variation.id,
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  // ! getPrdouctQuantityCart
  int getProductQuantityInCart(String productId) {
    return state.cartItem
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
  }

  // ! getVariationQuantityCart
  int getVariationQuantityInCart(String productId, String variationId) {
    return state.cartItem
        .firstWhere(
          (item) =>
              item.productId == productId && item.variationId == variationId,
          orElse: () => CartItemModel.empty(),
        )
        .quantity;
  }

  // ! clearCart
  void clearCart() {
    state.copyWith(
      cartItem: [],
      noOfCartItem: 0,
      productQuantityInCart: 0.0,
      totalCartPrice: 0.0,
    );
  }

  // ! saveCartItemToLocalStorage
  saveCartItem(List<CartItemModel> cartItem) {
    final cartItemStrings = cartItem.map((e) => e.toJson()).toList();
    LocalStorage.instance().saveData("cartItems", cartItemStrings);
  }

  // ! updateCartTotal
  updateCartTotal(List<CartItemModel> cartItem, cartItemState,
      Emitter<CartItemState> emit) {
    double calculatedTotalPrice = 0.0;
    int calculatedNoItem = 0;

    for (var item in cartItem) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoItem += item.quantity;
    }
    emit(state.copyWith(
        noOfCartItem: calculatedNoItem, totalCartPrice: calculatedTotalPrice));
  }

  // ! show Dialog before completely removing
  Future<bool?> removeFromCartDialog(int index, Emitter<CartItemState> emit,
      List<CartItemModel> updatedCartItems) async {
    return await showDialog<bool>(
        context: ContextUtility.context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Removing Product"),
              content:
                  const Text("Are you sure you want to remove this product?"),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(ContextUtility.context, false);
                    },
                    child: const Text("Cancel")),
                OutlinedButton(
                    onPressed: () {
                      state.cartItem.removeAt(index);
                      Navigator.pop(context, true);
                    },
                    child: const Text("Remove"))
              ],
            ));
  }

  // ! Initiliazed already added Item Count in the cart.
  void _updateAlreadyAddedProductCount(
      UpdateProductCount event, Emitter<CartItemState> emit) {
    if (event.productModel.productType == ProductType.single.toString()) {
      emit(state.copyWith(
          productQuantityInCart:
              getProductQuantityInCart(event.productModel.id).toDouble()));
    } else {
      final variationId = event.selectedVariation.id;
      if (variationId.isNotEmpty) {
        emit(state.copyWith(
            productQuantityInCart:
                getVariationQuantityInCart(event.productModel.id, variationId)
                    .toDouble()));
      } else {
        emit(state.copyWith(productQuantityInCart: 0.0));
      }
    }
  }
}

// loadCartItems(List<CartItemModel> cartItem) {
//   final cartItemStrings =
//       LocalStorage.instance().readData<List<dynamic>>("cartItems");
//   if (cartItemStrings != null) {
//     cartItem.addAll(cartItemStrings
//         .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
//         .toList());
//     updateCartTotal(cartItem, cartItemState, emit);
//   }
// }
