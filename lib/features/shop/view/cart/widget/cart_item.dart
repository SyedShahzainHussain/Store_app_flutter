import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_event.dart';
import 'package:store/bloc/cart_item/cart_item_state.dart';
import 'package:store/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:store/common/widgets/product_cart/product_cart_add_delete_button.dart';
import 'package:store/common/widgets/product_cart/product_cart_item.dart';
import 'package:store/common/widgets/product_price/t_product_price_text.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';

import 'package:store/utils/loaders/loader_animation.dart';
import 'package:store/utils/routes/route_name.dart';

class CartListItem extends StatelessWidget {
  final bool isShowAddOrRemove;
  const CartListItem({super.key, this.isShowAddOrRemove = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemBloc, CartItemState>(
      builder: (context, state) {
        return state.cartItem.isEmpty
            ? Center(
                child: AnimationLoaderWidget(
                  text: context.localizations!.cartIsEmpty,
                  animation: TImageString.cartEmpty,
                  showAction: true,
                  actionText: context.localizations!.letFillIt,
                  onActionPressed: () {
                    context
                        .read<BottomNavigationBloc>()
                        .add(ChangeBottomIndexEvent(0));
                    THelperFunction.navigatedToScreenWithPop(
                        context, RouteName.bottomNavigationScreen);
                  },
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: TSized.spacebetweenItem,
                ),
                shrinkWrap: true,
                itemCount: state.cartItem.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CartItem(cartItem: state.cartItem[index]),
                      if (isShowAddOrRemove)
                        const SizedBox(
                          height: TSized.spacebetweenItem,
                        ),
                      if (isShowAddOrRemove)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 70,
                                ),
                                // ! Add Remove Buttons
                                ProductCartAddAndRemoveButton(
                                  quantity: state.cartItem[index].quantity,
                                  add: () {
                                    BlocProvider.of<CartItemBloc>(context)
                                        .add(IncrementProduct(
                                            state.cartItem[index]));
                                  },
                                  remove: () {
                                    BlocProvider.of<CartItemBloc>(context)
                                        .add(DecrementProduct(
                                            state.cartItem[index]));
                                  },
                                ),
                              ],
                            ),
                            // ! Product Total Price
                            TProductPriceText(
                                price: (state.cartItem[index].price *
                                        state.cartItem[index].quantity)
                                    .toStringAsFixed(1)),
                          ],
                        ),
                    ],
                  );
                },
              );
      },
    );
  }
}
