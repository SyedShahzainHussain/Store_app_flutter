import 'package:flutter/material.dart';
import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/common/widgets/texts/t_brand_verification.dart';
import 'package:store/common/widgets/texts/t_product_title.dart';
import 'package:store/features/shop/model/cart_item_model/cart_item_model.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/constants/size.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;
  const CartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ! Image
        TRoundedImage(
          imageUrl: cartItem.image ?? TImageString.product1,
          width: 60,
          isNetworkImage: cartItem.image!.isNotEmpty,
          height: 60,
          padding: const EdgeInsets.all(TSized.xsm),
          backgroundColor: THelperFunction.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        const SizedBox(
          width: TSized.spacebetweenItem,
        ),
        // ! Title , Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleAndVerification(title: cartItem.brandName ?? ""),
              Flexible(
                child: TProductTitle(
                  title: cartItem.title,
                  maxLines: 1,
                ),
              ),

              // ! Attributes

              Text.rich(
                TextSpan(
                    children: (cartItem.selectedVariation ?? {})
                        .entries
                        .map((e) => TextSpan(children: [
                              TextSpan(
                                text: " ${e.key}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: " ${e.value}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ]))
                        .toList()),
              )
            ],
          ),
        )
      ],
    );
  }
}
