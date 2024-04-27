import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/cart_item/cart_item_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_event.dart';
import 'package:store/bloc/cart_item/cart_item_state.dart';
import 'package:store/bloc/variation/variation_bloc.dart';
import 'package:store/bloc/variation/variation_state.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/features/shop/view/produt_detail/product_details.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/enum.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class ProductCartAddToCart extends StatelessWidget {
  final ProductModel productModel;
  const ProductCartAddToCart({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final localization = Localizations.localeOf(context);
    return BlocBuilder<VariationBloc, VariationState>(
      builder: (context, variation) {
        return BlocBuilder<CartItemBloc, CartItemState>(
          builder: (context, state) {
            final productQuantityCount =
                BlocProvider.of<CartItemBloc>(context).getProductQuantityInCart(
              productModel.id,
            );
            return InkWell(
              onTap: () {
                if (productModel.productType == ProductType.single.toString()) {
                  final cartItem =
                      BlocProvider.of<CartItemBloc>(context).convertCartItem(
                    productModel,
                    1,
                  );

                  BlocProvider.of<CartItemBloc>(context)
                      .add(IncrementProduct(cartItem));
                } else {
                  THelperFunction.navigatedToScreen(
                      context,
                      ProductDetails(
                        productModel: productModel,
                      ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      productQuantityCount > 0 ? TColors.primary : TColors.dark,
                  borderRadius: BorderRadius.only(
                    topLeft: localization.languageCode == "en"
                        ? const Radius.circular(TSized.cardRadiusMd)
                        : Radius.zero,
                    bottomRight: localization.languageCode == "en"
                        ? const Radius.circular(TSized.productImageRadius)
                        : Radius.zero,
                    topRight: localization.languageCode == "en"
                        ? Radius.zero
                        : const Radius.circular(TSized.cardRadiusMd),
                    bottomLeft: localization.languageCode == "en"
                        ? Radius.zero
                        : const Radius.circular(TSized.productImageRadius),
                  ),
                ),
                child: SizedBox(
                  width: TSized.iconLg * 1.2,
                  height: TSized.iconLg * 1.2,
                  child: Center(
                    child: productQuantityCount > 0
                        ? Text(
                            productQuantityCount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: Colors.white),
                          )
                        : const Icon(
                            Iconsax.add,
                            color: TColors.white,
                          ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
