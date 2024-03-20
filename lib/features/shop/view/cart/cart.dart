import 'package:flutter/material.dart';
import 'package:store/features/shop/view/cart/widget/cart_tem.dart';
import 'package:store/features/shop/view/checkout/checkout.dart';

import 'package:store/utils/constants/size.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/utils/helper/helper_function.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(TSized.defaultSpace),
        child: ElevatedButton(
            onPressed: () {
              THelperFunction.navigatedToScreen(context, const CheckOutScreen());
            },
            child: const Text("Checkout \$256.0")),
      ),
      appBar: const CustomAppBar(
        title: Text("Cart"),
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
