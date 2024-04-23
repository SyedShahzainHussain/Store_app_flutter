import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/cart_item/cart_item_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_state.dart';
import 'package:store/utils/constants/colors.dart';

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
            onPressed: onPressed,
            icon: Icon(
              Iconsax.shopping_bag,
              color: color,
            )),
        BlocBuilder<CartItemBloc, CartItemState>(
          builder: (context, state) {
            
            return Positioned(
              right: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                    color: TColors.black,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Text(
                    state.noOfCartItem.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: TColors.white, fontSizeFactor: 0.8),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
