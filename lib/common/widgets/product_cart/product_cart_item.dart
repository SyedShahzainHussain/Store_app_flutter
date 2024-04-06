import 'package:flutter/material.dart';
import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/common/widgets/texts/t_brand_verification.dart';
import 'package:store/common/widgets/texts/t_product_title.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/constants/size.dart';
class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ! Image
        TRoundedImage(
          imageUrl: TImageString.product1,
          width: 60,
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
              const TBrandTitleAndVerification(title: "Nike"),
              const Flexible(
                child: TProductTitle(
                  title: "Block Sports shoe",
                  maxLines: 1,
                ),
              ),
    
              // ! Attributes
    
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Color ",
                      style:
                          Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: "Green ",
                      style:
                          Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: "Size ",
                      style:
                          Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: "UK 08 ",
                      style:
                          Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
