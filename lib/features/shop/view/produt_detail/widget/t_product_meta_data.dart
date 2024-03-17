import 'package:flutter/material.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/image/t_circular_image.dart';
import 'package:store/common/widgets/product_price/t_product_price_text.dart';
import 'package:store/common/widgets/texts/t_brand_verification.dart';
import 'package:store/common/widgets/texts/t_product_title.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/enum.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! Price & Sale Price
        Row(
          children: [
            // ! Sale Tag
            TRoundedContainer(
              radius: TSized.md,
              padding: const EdgeInsets.symmetric(
                  horizontal: TSized.sm, vertical: TSized.xsm),
              backgroundColor: TColors.secondary.withOpacity(0.8),
              child: Text(
                "25%",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),

            const SizedBox(
              width: TSized.spacebetweenItem,
            ),
            // ! Price
            Text(
              "\$250",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(
              width: TSized.spacebetweenItem,
            ),
            const TProductPriceText(
              price: "175",
              isLarge: true,
            )
          ],
        ),
        const SizedBox(
          height: TSized.spacebetweenItem,
        ),

        // ! Title
        const TProductTitle(title: "Green Nike Sport Shoes"),
        const SizedBox(
          height: TSized.spacebetweenItem / 1.5,
        ),

        // ! Stock Status

        Row(
          children: [
            const TProductTitle(title: "Status"),
            const SizedBox(
              width: TSized.spacebetweenItem,
            ),
            Text(
              "In Stock",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(
          height: TSized.spacebetweenItem / 1.5,
        ),

        // ! Brands
        Row(
          children: [
            TCircularImage(
              image: TImageString.shoeImage,
              width: 32,
              height: 32,
              overlayColor: isDark ? TColors.white : TColors.black,
            ),
            const TBrandTitleAndVerification(
              title: "Nike",
              brandTextSize: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
