import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/styles/shadow.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/container/t_rounded_image.dart';
import 'package:store/common/widgets/icons/t_circular_icons.dart';
import 'package:store/common/widgets/product_price/t_product_price_text.dart';
import 'package:store/common/widgets/texts/t_product_title.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class TProductCartVertical extends StatelessWidget {
  const TProductCartVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Container(
      width: 180,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [
          TShadowStyle.verticalProductShadow,
        ],
        borderRadius: BorderRadius.circular(TSized.productImageRadius),
        color: dark ? TColors.darkGrey : TColors.white,
      ),
      child: Column(
        children: [
          // ! Thumnail  WhishList Button Discount Tag
          TRoundedContainer(
            height: 180,
            padding: const EdgeInsets.all(TSized.md),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                // ! Thumbnail Image

                const TRoundedImage(
                  imageUrl: TImageString.product1,
                  applyImageRadius: true,
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
          const SizedBox(
            height: TSized.spacebetweenItem / 2,
          ),
          // ! Detail

          Padding(
            padding: const EdgeInsets.only(left: TSized.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TProductTitle(
                  title: "Green Nike Air Shoes",
                  smallSize: true,
                ),
                const SizedBox(
                  height: TSized.spacebetweenItem / 2,
                ),
                Row(
                  children: [
                    Text(
                      "Nike",
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      width: TSized.sm,
                    ),
                    const Icon(
                      Iconsax.verify5,
                      color: TColors.primary,
                      size: TSized.iconXsm,
                    )
                  ],
                ),
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
        ],
      ),
    );
  }
}
