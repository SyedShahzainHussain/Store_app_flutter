import 'package:flutter/material.dart';

import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/image/t_circular_image.dart';
import 'package:store/common/widgets/product_price/t_product_price_text.dart';
import 'package:store/common/widgets/texts/t_brand_verification.dart';
import 'package:store/common/widgets/texts/t_product_title.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/enum.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/helper/product_helper.dart';

class TProductMetaData extends StatelessWidget {
  final ProductModel productModel;
  const TProductMetaData({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    final salePercentage = ProductHelper.calculatedSalePercentage(
      productModel.price,
      productModel.salePrice,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! Price & Sale Price
        Row(
          children: [
            if (salePercentage != null)
              // ! Sale Tag
              TRoundedContainer(
                radius: TSized.md,
                padding: const EdgeInsets.symmetric(
                    horizontal: TSized.sm, vertical: TSized.xsm),
                backgroundColor: TColors.secondary.withOpacity(0.8),
                child: Text(
                  "$salePercentage%",
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
            if (productModel.productType == ProductType.single.toString() &&
                productModel.salePrice > 0)
              Text(
                productModel.price.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
            if (productModel.productType == ProductType.single.toString() &&
                productModel.salePrice > 0)
              const SizedBox(
                width: TSized.spacebetweenItem,
              ),
            TProductPriceText(
              price: ProductHelper.getProductsPrice(productModel),
              isLarge: true,
            )
          ],
        ),
        const SizedBox(
          height: TSized.spacebetweenItem,
        ),

        // ! Title
        TProductTitle(title: productModel.title),
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
              ProductHelper.getProductStockStatus(productModel.stock),
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
              image: productModel.brand != null
                  ? productModel.brand!.image
                  : TImageString.nikeIcon,
              width: 32,
              height: 32,
              overlayColor: isDark ? TColors.white : TColors.black,
              isNetworkImage: productModel.brand!.image!.isNotEmpty,
            ),
            TBrandTitleAndVerification(
              title:
                  productModel.brand != null ? productModel.brand!.name! : "",
              brandTextSize: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
