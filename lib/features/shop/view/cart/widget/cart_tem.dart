import 'package:flutter/material.dart';
import 'package:store/common/widgets/product_cart/product_cart_add_delete_button.dart';
import 'package:store/common/widgets/product_cart/product_cart_item.dart';
import 'package:store/common/widgets/product_price/t_product_price_text.dart';
import 'package:store/utils/constants/size.dart';

class CartListItem extends StatelessWidget {
  final bool isShowAddOrRemove;
  const CartListItem({super.key, this.isShowAddOrRemove = true});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: TSized.spacebetweenItem,
      ),
      shrinkWrap: true,
      itemCount: 2,

      itemBuilder: (context, index) {
        return Column(
          children: [
            const CartItem(),
            if (isShowAddOrRemove)
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
            if (isShowAddOrRemove)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 70,
                      ),
                      // ! Add Remove Buttons
                      ProductCartAddAndRemoveButton(),
                    ],
                  ),
                  // ! Product Total Price
                  TProductPriceText(price: "256"),
                ],
              ),
          ],
        );
      },
    );
  }
}
