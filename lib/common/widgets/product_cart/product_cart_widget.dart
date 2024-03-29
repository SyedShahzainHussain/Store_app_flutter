import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/features/shop/view/cart/cart.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/helper/helper_function.dart';

class ProductCartWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? color;
  const ProductCartWidget({
    super.key,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: () {
              THelperFunction.navigatedToScreen(context, const CartScreen());
            },
            icon: Icon(
              Iconsax.shopping_bag,
              color: color,
            )),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: TColors.black, borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Text(
                "2",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.white, fontSizeFactor: 0.8),
              ),
            ),
          ),
        )
      ],
    );
  }
}
