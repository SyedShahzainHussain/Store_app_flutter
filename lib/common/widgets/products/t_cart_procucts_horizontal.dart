import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/favourite_icon/favourite_icon.dart';

import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/common/widgets/product_price/t_product_price_text.dart';
import 'package:store/common/widgets/texts/t_brand_verification.dart';
import 'package:store/common/widgets/texts/t_product_title.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/features/shop/view/produt_detail/product_details.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/enum.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/helper/product_helper.dart';

class TProductCartHorizontal extends StatelessWidget {
  final ProductModel? productModel;
  const TProductCartHorizontal({super.key, this.productModel});

  @override
  Widget build(BuildContext context) {
    final networkImage = productModel?.thumbnail;
    final image =
        networkImage!.isNotEmpty ? networkImage : TImageString.product1;
    final salePercentage = ProductHelper.calculatedSalePercentage(
        productModel!.price, productModel!.salePrice);
    final dark = THelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        THelperFunction.navigatedToScreen(
            context,
            ProductDetails(
              productModel: productModel,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSized.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.softGrey,
        ),
        child: Row(
          children: [
            Row(
              children: [
                // ! Thumnail  WhishList Button Discount Tag
                TRoundedContainer(
                  height: 120,
                  padding: const EdgeInsets.all(TSized.md),
                  backgroundColor: dark ? TColors.dark : TColors.white,
                  child: Stack(
                    children: [
                      // ! Thumbnail Image

                      Center(
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: TRoundedImage(
                            imageUrl: image,
                            applyImageRadius: true,
                            isNetworkImage: networkImage.isNotEmpty,
                          ),
                        ),
                      ),
                      if (salePercentage != null)
                        // ! Sale Tag
                        Positioned(
                          top: 12,
                          child: TRoundedContainer(
                            radius: TSized.sm,
                            padding: const EdgeInsets.symmetric(
                                horizontal: TSized.sm, vertical: TSized.xsm),
                            backgroundColor: TColors.secondary.withOpacity(0.8),
                            child: Text(
                              "$salePercentage%",
                              style:
                                  Theme.of(context).textTheme.labelLarge!.apply(
                                        color: TColors.black,
                                      ),
                            ),
                          ),
                        ),
                      // ! create Icon
                      Positioned(
                        top: 0,
                        right: 0,
                        child: FavouriteIcon(productId: productModel!.id),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // ! Details
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(left: TSized.sm, top: TSized.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TProductTitle(
                          title: productModel?.title ?? "",
                          smallSize: true,
                        ),
                        const SizedBox(
                          height: TSized.spacebetweenItem / 2,
                        ),
                        TBrandTitleAndVerification(
                          title: productModel?.brand?.name ?? "",
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ! Price
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (productModel!.productType ==
                                      ProductType.single.toString() &&
                                  productModel!.salePrice > 0)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: TSized.sm),
                                  child: Text(
                                    productModel!.price.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .apply(
                                            decoration:
                                                TextDecoration.lineThrough),
                                  ),
                                ),
                              TProductPriceText(
                                  price: ProductHelper.getProductsPrice(
                                      productModel!)),
                            ],
                          ),
                        ),
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
      ),
    );
  }
}
