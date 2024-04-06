import 'package:flutter/material.dart';
import 'package:store/common/widgets/brands/t_brand_showcase.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/common/widgets/products/t_cart_products_vertical.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSized.defaultSpace),
            child: Column(
              children: [
                // ! Brands
                TBrandShowCase(image: [
                  brandWidget(TImageString.shoeImage, context),
                  brandWidget(TImageString.bowlingImage, context),
                  brandWidget(TImageString.clothIcon, context)
                ]),
                TSectionHeading(
                  title: "You might like",
                  onPressed: () {},
                ),
                const SizedBox(
                  height: TSized.spacebetweenItem,
                ),

                // ! Products
                GridLayout(
                  itemBuilder: (_, index) => const TProductCartVertical(),
                  itemCount: 4,
                )
              ],
            ),
          ),
        ]);
  }
}

Expanded brandWidget(String image, BuildContext context) {
  return Expanded(
    child: TRoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(TSized.md),
      margin: const EdgeInsets.only(right: TSized.sm),
      backgroundColor: THelperFunction.isDarkMode(context)
          ? TColors.darkerGrey
          : TColors.light,
      child: Image(
        fit: BoxFit.contain,
        image: AssetImage(image),
      ),
    ),
  );
}
