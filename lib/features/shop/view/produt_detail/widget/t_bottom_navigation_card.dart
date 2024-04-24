import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/cart_item/cart_item_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_event.dart';
import 'package:store/bloc/cart_item/cart_item_state.dart';
import 'package:store/bloc/variation/variation_bloc.dart';
import 'package:store/bloc/variation/variation_state.dart';
import 'package:store/common/widgets/icons/t_circular_icons.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/features/shop/model/product_variation/product_variation.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class TBottomNavigationCard extends StatelessWidget {
  final ProductModel productModel;
  const TBottomNavigationCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return BlocBuilder<VariationBloc, VariationState>(
      builder: (context, variation) {
        BlocProvider.of<CartItemBloc>(context).add(UpdateProductCount(
          productModel,
          variation.selectedVariation ?? ProductVariationModel.empty(),
        ));
        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: TSized.defaultSpace,
              vertical: TSized.defaultSpace / 2),
          decoration: BoxDecoration(
            color: dark ? TColors.darkerGrey : TColors.light,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(TSized.cardRadiusLg),
              topRight: Radius.circular(TSized.cardRadiusLg),
            ),
          ),
          child: BlocBuilder<CartItemBloc, CartItemState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TCircularIcons(
                        icon: Iconsax.minus,
                        backgroundColor: TColors.darkGrey,
                        width: 40,
                        height: 40,
                        color: TColors.white,
                        onPressed: () {
                          state.productQuantityInCart < 1
                              ? null
                              : BlocProvider.of<CartItemBloc>(context)
                                  .add(DeleteProductCount());
                        },
                      ),
                      const SizedBox(
                        width: TSized.spacebetweenItem,
                      ),
                      Text(
                        state.productQuantityInCart.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        width: TSized.spacebetweenItem,
                      ),
                      TCircularIcons(
                          icon: Iconsax.add,
                          backgroundColor: TColors.black,
                          width: 40,
                          height: 40,
                          color: TColors.white,
                          onPressed: () {
                            BlocProvider.of<CartItemBloc>(context)
                                .add(AddProductCount());
                          }),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: state.productQuantityInCart < 1
                        ? null
                        : () {
                            context
                                .read<CartItemBloc>()
                                .add(AddItemToCart(productModel, variation));
                          },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(TSized.md),
                        backgroundColor: TColors.black,
                        side: const BorderSide(color: TColors.black)),
                    child: const Text("Add to Cart"),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
