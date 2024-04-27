import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_state.dart';
import 'package:store/features/shop/view/cart/widget/cart_item.dart';
import 'package:store/features/shop/view/checkout/checkout.dart';

import 'package:store/utils/constants/size.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BlocBuilder<CartItemBloc, CartItemState>(
        builder: (context, state) {
          return state.cartItem.isEmpty
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.all(TSized.defaultSpace),
                  child: ElevatedButton(
                      onPressed: () {
                        THelperFunction.navigatedToScreen(
                            context, const CheckOutScreen());
                      },
                      child: Text("Checkout \$${state.totalCartPrice}")),
                );
        },
      ),
      appBar: CustomAppBar(
        title: Text(context.localizations!.cart),
        showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.only(
          left: TSized.defaultSpace,
          right: TSized.defaultSpace,
          top: TSized.defaultSpace,
          bottom: TSized.xsm,
        ),
        child: CartListItem(),
      ),
    );
  }
}
