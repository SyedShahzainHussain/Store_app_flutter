import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/icons/t_circular_icons.dart';
import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/common/widgets/product_price/t_product_price_text.dart';
import 'package:store/common/widgets/texts/t_brand_verification.dart';
import 'package:store/common/widgets/texts/t_product_title.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class TProductCartHorizontal extends StatelessWidget {
  const TProductCartHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        // boxShadow: [
        //   TShadowStyle.verticalProductShadow,
        // ],
        borderRadius: BorderRadius.circular(TSized.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.softGrey,
      ),
      child: Row(
        children: [
          // ! Thumnail  WhishList Button Discount Tag
          TRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSized.md),
            backgroundColor: dark ? TColors.dark : TColors.white,
            child: Stack(
              children: [
                // ! Thumbnail Image

                const SizedBox(
                  height: 120,
                  width: 120,
                  child: TRoundedImage(
                    imageUrl: TImageString.product1,
                    applyImageRadius: true,
                  ),
                ),
                // ! Sale Tag
                Positioned(
                  top: 12,
                  child: TRoundedContainer(
                    radius: TSized.sm,
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSized.sm, vertical: TSized.xsm),
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    child: Text(
                      "25%",
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                            color: TColors.black,
                          ),
                    ),
                  ),
                ),
                // ! create Icon
                const Positioned(
                  top: 0,
                  right: 0,
                  child: TCircularIcons(
                    icon: Iconsax.heart5,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),

          // ! Details

          SizedBox(
            width: 152,
            child: Padding(
              padding: const EdgeInsets.only(left: TSized.sm, top: TSized.sm),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitle(
                        title: "Green Nike Air Sleves Shirt",
                        smallSize: true,
                      ),
                      SizedBox(
                        height: TSized.spacebetweenItem / 2,
                      ),
                      TBrandTitleAndVerification(
                        title: "Nike",
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ! Price
                      const TProductPriceText(price: "35.5"),
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSized.cardRadiusMd),
                            bottomRight:
                                Radius.circular(TSized.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          width: TSized.iconLg * 1.2,
                          height: TSized.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: TColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
